const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken');

class UserService{
    //registerUser function
    static async registerUser(email,password){
        try {
            //object creation
            const createUser = new UserModel({email,password});
            //save the data to the database 
            return await createUser.save();

            
        } catch (error) {
            throw error;
        }

    }
    //verifying function to check if the email exist in the database 
    static async checkuser(email){
        try {
            return await UserModel.findOne({email});
            
        } catch (error) {
            throw error;
        }
    }
    static async generateToken(tokenData,secreteKey,jwt_expire){
        return jwt.sign(tokenData,secreteKey,{expiresIn:jwt_expire});

    }

}
module.exports = UserService;