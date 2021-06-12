var express = require("express");
var router = express.Router();

/* GET home page. */
//라우터의 get()함수를 이용해 request URL('/')에 대한 업무처리 로직 정의
router.get("/seat", function (req, res) {
  res.render("book/seat");
});

router.get("/mvgoer", function (req, res) {
  res.render("book/mvgoer", { title: "Express" });
});

router.get("/cinema", function (req, res) {
  res.render("book/cinema", { title: "Express" });
});

router.get("/movieselect", function (req, res) {
  res.render("book/movieselect", { title: "Express" });
});

router.post("/movieselect", function (req, res) {
  res.render("book/movieselect", { title: "Express" });
});

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
