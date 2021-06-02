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
  // var mv_info = $(".info_txt1").text(); // 장르, 러닝타임, 개봉일, 감독, 배우 순으로 나옴
  title = title.replace(/(\r\n\t|\n|\r\t)/gm, "_");
  title = title.replace(/(\s*)/g, "");
  title = title.split(/_/g);
  title = title.filter(arrayspliting);
  title = title.division(2);
  console.log(title);
});

function arrayspliting(item) {
  return item !== null && item !== undefined && item !== "";
}
Array.prototype.division = function (n) {
  var arr = this;
  var len = arr.length;
  var cnt = Math.floor(len / n) + (Math.floor(len % n) > 0 ? 1 : 0);
  var tmp = [];
  for (var i = 0; i < cnt; i++) {
    tmp.push(arr.splice(0, n));
  }
  return tmp;
};
