const UserModel = require('../model/user.model')

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

}
module.exports = UserService;