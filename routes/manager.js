var express = require("express");
var router = express.Router();
var oracledb = require("oracledb");
var dbConfig = require("../conf/dbconfig");

/* GET home page. */
//라우터의 get()함수를 이용해 request URL('/')에 대한 업무처리 로직 정의
router.get("/goerway", function (req, res) {
  res.render("manager/goerway", { title: "Express" });
});
router.get("/local", function (req, res) {
  res.render("manager/local", { title: "Express" });
});
router.get("/manage", function (req, res) {
  res.render("manager/manage", { title: "Express" });
});
router.get("/movie", function (req, res) {
  res.render("manager/movie", { title: "Express" });
});

router.get("/screenway", function (req, res) {
  res.render("manager/screenway", { title: "Express" });
});
router.get("/theater", function (req, res) {
  res.render("manager/theater", { title: "Express" });
});
router.get("/schedule", function (req, res) {
  res.render("manager/schedule", { title: "Express" });
});
router.get("/memchoice", function (req, res) {
  res.render("manager/memchoice", { title: "Express" });
});
// function getlocalcnt() {
//   oracledb.getConnection(
//     {
//       user: dbConfig.user,
//       password: dbConfig.password,
//       connectString: dbConfig.connectString,
//     },
//     function (err, connection) {
//       if (err) {
//         console.error(err.message);
//         return;
//       }

//       let query = "SELECT LOCALNO " + "   FROM LOCAL";

//       connection.execute(query, [], function (err, result) {
//         if (err) {
//           console.error(err.message);
//           // doRelease(connection);
//           return;
//         }
//         for (i = 0; i < result.rows.length; i++) {
//           resultint = result.rows[i][0].slice(-2) * 1;
//           if (localmax <= resultint) {
//             localmax = resultint;
//           }
//         }
//         console.log(localmax + "in");
//         // doRelease(connection, result.rows); // Connection 해제

//         console.log(localmax + "out");
//         localmax += "";
//         localmax = String("0" + localmax).slice(-2);
//         localcnt = localmax;
//         console.log(localmax + "out2");
//         console.log(localcnt + "out2");
//       });
//     }
//   );
// }

//주요한 문제 : insert execute를 먼저 실행하고 select를 실행하여 무결성 제약 조건 위반한대 자꾸 진짜 ㅡㅡ
router.post("/local", function (request, response) {
  const itemName = request.body.newItem;

  var localcnt = "00";
  var localmax = 0;
  var resultint = "";

  oracledb.getConnection(
    //접근정보 가져옴
    {
      user: dbConfig.user,
      password: dbConfig.password,
      connectString: dbConfig.connectString,
    },

    function (err, connection) {
      if (err) {
        console.error(err.message);
        return;
      }
      //지역번호 가져옴
      let selquery = "SELECT LOCALNO " + "   FROM LOCAL";

      connection.execute(selquery, [], function (err, result) {
        if (err) {
          console.error(err.message);
          // doRelease(connection);
          return;
        }
        // 컬럼 수만큼 돌면서 마지막 2자리 문자열을 숫자화 후 비교하여 최댓값을 localmax에 대입
        for (i = 0; i < result.rows.length; i++) {
          resultint = result.rows[i][0].slice(-2) * 1;
          if (localmax <= resultint) {
            localmax = resultint;
          }
        }
        // doRelease(connection, result.rows); // Connection 해제 <<오류남>>

        //0x xx등 2자리 수로 만들어준 다음 문자열화 시켜서 localcnt에 삽입
        localmax += "";
        localmax = String("0" + localmax).slice(-2);
        localcnt = localmax;
      });
      //localcnt 에서 숫자를 1 늘리고 문자열화 시켜서 삽임
      localcnt++;
      localcnt += "";
      localcnt = String("0" + localcnt).slice(-2);
      //삽입쿼리
      let insertquery =
        "INSERT INTO LOCAL(LOCALNO, LOCALNAME) " +
        "VALUES( :LOCALNO, :LOCALNAME)";
      //LOCAL 뒤에 2자리 숫자 붙혀서 item과 함께 삽입
      let binddata = ["LOCAL" + localcnt, itemName];
      // inclocalcnt();
      //insert
      connection.execute(insertquery, binddata, function (err, result) {
        if (err) {
          console.error(err.message);
          // doRelease(connection);
          return;
        }
        console.log("Row Insert: " + result.rowsAffected);
        // doRelease(connection, result.rowsAffected); // Connection 해제
      });
    }
  );
  response.render("manager/local");
  console.log(itemName);
});

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
