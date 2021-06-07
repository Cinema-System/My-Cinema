const axios = require("axios");
const cheerio = require("cheerio");
const app = require("./app");
var dbRouter = require("./routes/db");
var oracledb = require("oracledb");
var dbConfig = require("./conf/dbconfig");
app.use("/db", dbRouter);

async function getHTML() {
  try {
    return await axios.get("https://movie.naver.com/movie/running/current.nhn");
  } catch (error) {
    console.error(error);
  }
}

// 영화 제목과 영화 정보가 함께 추출되지 않아서 후처리가 필요
getHTML().then((html) => {
  
  const $ = cheerio.load(html.data);
  var title = $(".tit").text(); // 영화 제목
  var mv_info = $(".info_txt1").text(); // 장르, 러닝타임, 개봉일, 감독, 배우 순으로 나옴
  title = dataAlign(title);
  mv_info = dataAlign(mv_info);
  title = title.titledivision(2);
  mv_info = mv_info.mvdivision();
  runtimeidx = [];
  for (i = 0; i < 10; i++) {
    len = mv_info[i].length;
    stop = 0;
    for (j = 0; j < len; j++) {
      if (mv_info[i][j].indexOf("분") != -1) {
        runtimeidx.push(mv_info[i][j].indexOf("분") );
        stop = 1;
      }
      stop = 0;
    }
  }

    directoridx = [];
    for (i = 0; i < 10; i++) {
      if (mv_info[i].indexOf("감독") != -1) {
        directoridx.push(mv_info[i].indexOf("감독") + 1);
      }
    }

    actoridx = [];
    for (i = 0; i < 10; i++) {
      if (mv_info[i].indexOf("출연") != -1) {
        actoridx.push(mv_info[i].indexOf("감독") + 1);
      }
    }
    for(i=0;i<10;i++){
    oracledb.getConnection(
      {
        user: dbConfig.user,//process.env.HR_USER,
      password: dbConfig.password,//process.env.HR_PASSWORD,
      connectString: dbConfig.connectString,//process.env.HR_CONNECTIONSTRING,
      },
      {
        mvno: dbConfig.mvno,
        mvname: dbConfig.mvname,
        mvdirector: dbConfig.mvdirector,
        // mvreleasedate: dbConfig.mvreleasedate,
        mvclass: dbConfig.mvclass,
        mvruntime: dbConfig.mvruntime,
        mvgenre: dbConfig.mvgenre,
        mvstory: dbConfig.mvstory,
        mvpreview: dbConfig.mvpreview,
        mvpost: dbConfig.mvpost,
      },
      function (err, connection) {
        if (err) {
          console.error(err.message);
          return;
        }

      // /PrepareStatement 구조
      //MVRELEASEDATE,
      let query =
        "INSERT INTO MOVIE(MVNO, MVNAME, MVRELEASEDATE, MVDIRECTOR, MVCLASS, MVRUNTIME, MVGENRE, MVSTORY, MVPREVIEW, MVPOST) "+
        "VALUES(:MVNO, :MVNAME, :MVRELEASEDATE, :MVDIRECTOR, :MVCLASS, :MVRUNTIME, :MVGENRE, :MVSTORY, :MVPREVIEW, :MVPOST);";

      let binddata = [
        "mv000",
        title[i][1],
        TO_DATE("2017-12-10 00:00:00"),
        mv_info[i][directoridx],
        NUMBER(title[i][0]),
        NUMBER(mv_info[i][runtimeidx]),
        mv_info[i][1],
        "더보기",
        "http://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg",
        "http://image.dongascience.com/Photo/2020/03/5bddba7b6574b95d37b6079c199d7101.jpg"
      ];

      connection.execute(query, binddata, function (err, result) {
        if (err) {
          console.error(err.message);
          doRelease(connection);
          return;
         }
         console.log("Row Insert: " + result.rowsAffected);

         doRelease(connection, result.rowsAffected); // Connection 해제
       });
     })
    }
  });

function dataAlign(item) {
  item = item.replace(/(\,|\r\n\t|\n|\r\t|\t|\|)/gm, "_");
  item = item.split(/_/g);
  item = item.filter(arrayspliting);
  return item;
}

function arrayspliting(item) {
  return item !== null && item !== undefined && item !== "" && item !== " ";
}

Array.prototype.mvdivision = function () {
  var arr = this;
  var tmp = [];
  var idx = 0;
  var cnt = arr.filter((element) => "개요" === element).length;
  for (var i = 0; i < cnt; i++) {
    idx = arr.indexOf("개요", 1);
    tmp.push(arr.splice(0, idx));
    if (idx == -1) {
      tmp.push(arr.splice(1, arr.length));
    }
  }
  return tmp;
};

Array.prototype.titledivision = function () {
  var arr = this;
  var tmp = [];
  var len = arr.length;
  var cnt = Math.floor(len / 2) + (Math.floor(len % 2) > 0 ? 1 : 0);
  for (var i = 0; i < cnt; i++) {
    if (arr[0].indexOf("관람") == -1) {
      arr.pop();
    } else {
      tmp.push(arr.splice(0, 2));
    }
  }
  return tmp;
};
