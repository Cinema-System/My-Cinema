var express = require("express");
var router = express.Router();

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

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
