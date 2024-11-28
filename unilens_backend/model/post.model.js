// Creating mongoose schema 
//mongodb user database schema 
const mongoose = require('mongoose');
const UserModel = require('../model/user.model')
const db = require('../config/db');

// Create user schema 
const {Schema} = mongoose;
const postSchema = new Schema({
    // Whatever we want in the user schema we have to defined it in here 
    
    // We need the user Id to know which Id's post it is.
    userId:{
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    title:{
        type:String,
        required:true,

    },
    desc:{
        type:String,
        required:true,
    }
});
// Calling the database to make the above schema in the database 
const PostModel = db.model('post',postSchema);

module.exports = PostModel;