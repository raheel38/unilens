// Make use of expressJS to make router...
const express = require('express');
const body_parser = require('body-parser');
const userRouter = require('./routers/user.router')
const postRouter = require('./routers/post.router')

const app = express();

//use to check what in coming in the response body
app.use(body_parser.json());

app.use('/',userRouter);
app.use('/',postRouter);
module.exports = app;
