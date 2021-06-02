var express = require("express");
var oracledb = require("oracledb");
var dbConfig = require("../conf/dbconfig");
var router = express.Router();

// Oracle Auto Commit 설정
// autocommit : 데이터 변경 작업에 대한 SQL 자체가 바로 반영되는 것
oracledb.autoCommit = true;

// 데이터 조회 처리
router.post("/dbTestSelect", function (request, response) {
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

      let query = "select * " + "   from emp";

      connection.execute(query, [], function (err, result) {
        if (err) {
          console.error(err.message);
          doRelease(connection);
          return;
        }
        console.log(result.rows); // 데이터
        doRelease(connection, result.rows); // Connection 해제
      });
    }
  );

  // DB 연결 해제
  function doRelease(connection, rowList) {
    connection.release(function (err) {
      if (err) {
        console.error(err.message);
      }

      // DB종료까지 모두 완료되었을 시 응답 데이터 반환
      console.log("list size: " + rowList.length);

      response.send(rowList);
    });
  }
});

// 데이터 입력 처리
router.post("/dbTestInsert", function (request, response) {
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

      // PrepareStatement 구조
      let query =
        "INSERT INTO EMP( EMPNO ,ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) " +
        "VALUES( :EMPNO ,:ENAME, :JOB, :MGR, SYSDATE, :SAL, :COMM, :DEPTNO )";

      let binddata = [
        Number(request.body.empno),
        request.body.ename,
        request.body.job,
        request.body.mgr,
        Number(request.body.sal),
        Number(request.body.comm),
        Number(request.body.deptno),
      ];

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

      // DB종료까지 모두 완료되었을 시 응답 데이터 반환
      response.send("" + result);
    });
  }
});

//모듈에 등록해야 app.js에서 app.use 함수를 통해서 사용 가능
module.exports = router;
