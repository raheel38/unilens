const UserService = require('../services/user.services');



// Function that handles requests and response from the frontend
exports.register = async(req,res,next)=>{
    try {
        //request body
        const{email,password} = req.body;
        const successRes = await UserService.registerUser(email,password);

        //response back to the frontend using json 
        res.json({status:true, success: "User Registered Successfully!"})

        
    } catch (error) {
        throw error
        
    }
}