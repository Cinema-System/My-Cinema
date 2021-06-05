//필요한 모듈 선언
var createError = require("http-errors");
// var http = require('http');
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var debug = require("debug")("mycinema:server");
var http = require("http");
// var oracledb = require('oracledb');
// var dbConfig = require('./conf/dbconfig');

// express 객체 생성
var app = express();

//라우팅 모듈 선언
var indexRouter = require("./routes/index");
var usersRouter = require("./routes/users");
var dbRouter = require("./routes/db");
var payRouter = require("./routes/pay");
var managerRouter = require("./routes/manager");
var bookRouter = require("./routes/book");
var mainRouter = require("./routes/main");

// view engine setup, express 서버 포트 설정
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

// request 요청 URL과 처리 로직을 선언한 router 모듈 매핑
// router 객체를 app 객체에 등록
app.use("/", indexRouter);
app.use("/main", mainRouter);
app.use("/users", usersRouter);
app.use("/pay", payRouter);
app.use("/manager", managerRouter);
app.use("/book", bookRouter);
app.use("/db", dbRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

var port = normalizePort(process.env.PORT || "3000");
app.set("port", port);
var server = http.createServer(app);

server.listen(port);
server.on("error", onError);
server.on("listening", onListening);
function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}
function onError(error) {
  if (error.syscall !== "listen") {
    throw error;
  }

  var bind = typeof port === "string" ? "Pipe " + port : "Port " + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case "EACCES":
      console.error(bind + " requires elevated privileges");
      process.exit(1);
      break;
    case "EADDRINUSE":
      console.error(bind + " is already in use");
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = server.address();
  var bind = typeof addr === "string" ? "pipe " + addr : "port " + addr.port;
  debug("Listening on " + bind);
}

console.log("server on! http://localhost:" + port);

module.exports = app;
