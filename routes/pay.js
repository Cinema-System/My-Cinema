var express = require("express");
var router = express.Router();

/* GET home page. */
//라우터의 get()함수를 이용해 request URL('/')에 대한 업무처리 로직 정의
router.get("/bank", function (req, res) {
  res.render("pay/bank", { title: "Express" });
});

router.get("/creditcard", function (req, res) {
  res.render("pay/creditcard", { title: "Express" });
});
router.get("/kakao", function (req, res) {
  res.render("pay/kakao", { title: "Express" });
});
router.get("/price", function (req, res) {
  res.render("pay/price", { title: "Express" });
});
router.get("/ticket", function (req, res) {
  res.render("pay/ticket", { title: "Express" });
});

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
