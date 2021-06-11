var express = require("express");
var router = express.Router();

router.get("/login", function (req, res) {
  res.render("main/login", { title: "Login" });
});

router.get("/signup", function (req, res) {
  res.render("main/signup", { username: "signUp" });
});

router.post("/", async function (req, res) {
  // create: 회원 생성
    oracledb.getConnection(
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

      let query =
        "INSERT INTO LOCAL(LOCALNO, LOCALNAME) " +req.body.userid
        "VALUES( :LOCALNO, :LOCALNAME)";

      let binddata = ["LOCAL08", "다은마을"];

      connection.execute(query, binddata, function (err, result) {
        if (err) {
          console.error(err.message);
          doRelease(connection);
          return;
        }
        console.log("Row Insert: " + result.rowsAffected);

        doRelease(connection, result.rowsAffected); // Connection 해제
      });
    }
  );

  // DB 연결 해제
  function doRelease(connection, result) {
    connection.release(function (err) {
      if (err) {
        console.error(err.message);
      }
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
