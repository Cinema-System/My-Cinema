var express = require("express");
var router = express.Router();

router.get("/login", function (req, res) {
  res.render("main/login", { title: "Login" });
});

router.get("/signup", function (req, res) {
  res.render("main/signup", { title: "signUp" });
});

router.get("/verification", function (req, res) {
  res.render("main/verification", { title: "signUp" });
});

router.get("/complete", function (req, res) {
  res.render("main/verification_complete", { title: "signUp" });
});

router.get("/nonsignup", function (req, res) {
  res.render("main/nonsignup", { title: "signUp" });
});

router.get("/movieshow", function (req, res) {
  res.render("main/movieshow", { title: "signUp" });
});

module.exports = router;
