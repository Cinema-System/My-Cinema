// var express = require("express");
// var router = express.Router();
// var oracledb = require("oracledb");
// var dbConfig = require("../conf/dbconfig");

// router.get("/login", function (req, res) {
//   res.render("main/login", { title: "Login" });
// });

// router.get("/index", function (req, res) {
//   res.render("main/index", { title: "Login" });
// });

// router.get("/signup", function (req, res) {
//   res.render("main/signup", { username: "signUp" });
// });

// router.post("/login", function (req, res) {
//   // oracledb.getConnection(
//   //   {
//   //     user: dbConfig.user,
//   //     password: dbConfig.password,
//   //     connectString: dbConfig.connectString,
//   //   },
//   //   function (err, connection) {
//   //     if (err) {
//   //       console.error(err.message);
//   //       return;
//   //     }

//   //     let query = "SELECT USERID " + "   FROM USER";

//   //     connection.execute(query, [], function (err, result) {
//   //       if (err) {
//   //         console.error(err.message);
//   //         // doRelease(connection);
//   //         return;
//   //       }
//   //     });
//   //   }
//   // );
//   res.render("main/index", { title: "Login" });
// });

// router.post("/signup", function (req, res) {
//   // create: 회원 생성
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

//       let query =
//         "INSERT INTO USERS( USERID, USERCODE)" + " VALUES( :USERID, :USERCODE)";
//       // " INSERT INTO MEMBERS_INFO( MEMID, MEMPWD, MEMNAME, MEMEMAIL, MEMPHONE, MEMBIRTH, ISVERIFICATION, TOTALPOINT)" +
//       // " VALUES( :MEMID, :MEMPWD, :MEMNAME, :MEMEMAIL, :MEMPHONE, :MEMBIRTH, :ISVERIFICATION, :TOTALPOINT)";

//       let binddata = [req.body.userid, 1];

//       connection.execute(query, binddata, function (err, result) {
//         if (err) {
//           console.error(err.message);
//           doRelease(connection);
//           return;
//         }
//         console.log("user Row Insert: " + result.rowsAffected);

//         doRelease(connection, result.rowsAffected); // Connection 해제
//       });
//     }
//   );
//   //두개 테이블에 삽입이 안대네..
//   // oracledb.getConnection({
//   //   function(err, connection) {
//   //     let query =
//   //       "INSERT INTO MEMBERS_INFO( MEMPWD, MEMNAME, MEMMAIL, MEMPHONE, MEMBIRTH, ISVERIFICATION, TOTALPONUNINT, MEMID) VALUES( :MEMPWD, :MEMNAME, :MEMMAIL, :MEMPHONE, :MEMBIRTH, :ISVERIFICATION, :TOTALPONUNINT, :MEMID)";
//   //     // " INSERT INTO MEMBERS_INFO( USERID, MEMPWD, MEMNAME, MEMEMAIL, MEMPHONE, MEMBIRTH, 0, NULL) VALUES( :USERID, MEMPWD, MEMNAME, MEMEMAIL, MEMPHONE, MEMBIRTH, 0, NULL)";

//   //     let binddata = [
//   //       req.body.mempwd,
//   //       req.body.memname,
//   //       req.body.memmail,
//   //       req.body.memphone,
//   //       req.body.membirth,
//   //       0,
//   //       0,
//   //       req.body.userid,
//   //     ];
//   //     console.log(binddata);
//   //     connection.execute(query, binddata, function (err, result) {
//   //       if (err) {
//   //         console.error(err.message);
//   //         doRelease(connection);
//   //         return;
//   //       }
//   //       console.log("member Row Insert: " + result.rowsAffected);

//   //       doRelease(connection, result.rowsAffected); // Connection 해제
//   //     });
//   //   },
//   // });
//   // DB 연결 해제
//   function doRelease(connection, result) {
//     connection.release(function (err) {
//       if (err) {
//         console.error(err.message);
//       }
//     });
//   }
//   res.render("main/verification");
// });
// router.get("/verification", function (req, res) {
//   // oracledb.getConnection(
//   //   {
//   //     user: dbConfig.user,
//   //     password: dbConfig.password,
//   //     connectString: dbConfig.connectString,
//   //   },
//   //   function (err, connection) {
//   //     if (err) {
//   //       console.error(err.message);
//   //       return;
//   //     }

//   //     let query = "select mempwd memname " + "   from members_info";

//   //     connection.execute(query, [], function (err, result) {
//   //       if (err) {
//   //         console.error(err.message);
//   //         doRelease(connection);
//   //         return;
//   //       }
//   //       console.log(result.rows); // 데이터
//   //       doRelease(connection, result.rows); // Connection 해제
//   //     });
//   //   }
//   // );

//   // // DB 연결 해제
//   // function doRelease(connection, rowList) {
//   //   connection.release(function (err) {
//   //     if (err) {
//   //       console.error(err.message);
//   //     }

//   //     // DB종료까지 모두 완료되었을 시 응답 데이터 반환
//   //     console.log("list size: " + rowList.length);

//   //     response.send(rowList);
//   //   });
//   // }

//   res.render("main/verification", { title: "signUp" });
// });

// router.post("/verification_complete", function (req, res) {
//   res.render("main/verification_complete", { title: "signUp" });
// });

// router.get("/verification_complete", function (req, res) {
//   res.render("main/verification_complete", { title: "signUp" });
// });

// router.get("/nonsignup", function (req, res) {
//   res.render("main/nonsignup", { title: "signUp" });
// });

// router.get("/movieshow", function (req, res) {
//   res.render("main/movieshow", { title: "signUp" });
// });

// module.exports = router;
