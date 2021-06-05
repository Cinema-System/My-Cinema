var express = require("express");
var router = express.Router();

router.get("/login", function (req, res) {
  res.render("main/login", { title: "Login" });
});

router.get("/signup", function (req, res) {
  res.render("main/signup", { title: "signUp" });
});

module.exports = router;
