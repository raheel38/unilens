//mongodb user database schema 
const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');

// Create user schema 
const {Schema} = mongoose;
const userSchema = new Schema({
    // Whatever we want in the user schema we have to defined it in here 
    email:{
        type:String,
        lowercase:true,
        required:true,
        unique:true
    },
    password:{
        type:String,
        required:true,
    }
});
//Schema Done 

//encypting password in db 
// When the user save the data to the database this function will be called 
//and password will be encryted 
userSchema.pre('save', async function(){
    try {
        var user = this;
        const salt = await(bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password,salt);

        user.password = hashpass;
    } catch (error) {
        throw error
        
    }   
});

// Calling the database to make the above schema in the database 
const UserModel = db.model('user',userSchema);

module.exports = UserModel;
