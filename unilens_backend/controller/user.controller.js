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
exports.login = async(req,res,next)=>{
    try {
        //request body
        const{email,password} = req.body;
        const user = await UserService.checkuser(email);
        if(!user){
            throw new Error('User dont exist');
        }
        const isMatch = await user.comparePassword(password);

        if(isMatch === false){
            throw new Error('Password Invalid');
        }
        //Inside JWT Token we are storing or user data 
        let tokenData = {_id:user._id,email:user.email};
        //encoding tokenData using JWT package in JWT format 
        const token = await UserService.generateToken(tokenData,"secreteKey",'1h')

        //responding back to flutter 
        res.status(200).json({status:true,token:token})


        
    } catch (error) {
        throw error
        
    }
}
// Web scrapping code 
// Info page web scrapping
// Made the API in router page 

// app.get('/results', (req, res) => {
//   const articles = [
//     { url: 'https://example.com/article1', title: 'Article 1' },
//     { url: 'https://example.com/article2', title: 'Article 2' },
//     // Add more articles as needed
//   ];
//   res.json(articles);
// });

// app.listen(PORT, () => {
//   console.log(`Server is running on http://localhost:${PORT}`);
// });