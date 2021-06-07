var express = require("express");
var router = express.Router();

/* GET users listing. */
router.get("/", function (req, res, next) {
  res.send("respond with a resource");
});

/* GET home page. */
//라우터의 get()함수를 이용해 request URL('/')에 대한 업무처리 로직 정의
router.get("/edit", function (req, res) {
  res.render("user/edit", { title: "Express" });
});

router.get("/info", function (req, res) {
  res.render("user/info", { title: "Express" });
});
router.get("/mypage", function (req, res) {
  res.render("user/mypage", { title: "Express" });
});

router.get("/nonmember", function (req, res) {
  res.render("user/nonmember", { title: "Express" });
});
router.get("/paylist", function (req, res) {
  res.render("user/paylist", { title: "Express" });
});

router.get("/point", function (req, res) {
  res.render("user/point", { title: "Express" });
});

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
