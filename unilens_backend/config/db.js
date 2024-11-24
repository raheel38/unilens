// Connecting to mongoDB
const mongoose = require('mongoose');
//connecting to database by passing the url of database connectivity 
const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/uniapp').on('open',()=>{
    console.log('MongoDB connected');
}).on('error',()=>{
    console.log('MongoDB connection error');
})

//export so that we can use in other files 
module.exports = connection;