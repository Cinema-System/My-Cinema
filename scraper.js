const axios = require("axios");
const cheerio = require("cheerio");

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
  console.log(mv_info.length);
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

  console.log(title + mv_info);
});
