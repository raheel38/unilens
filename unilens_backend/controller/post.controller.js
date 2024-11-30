const PostServices = require('../services/post.services')

// controller function 
exports.createPost = async (req,res,next) =>{
    try {
        const{userId,title,desc} = req.body;

        //send the request to the post services 
        let post = await PostServices.createPost(userId,title,desc);

        // response back to frontend 
        res.json({status:true,success:post}) //success:post -> pass whatever data stored in database       
    } catch (error) {
        next(error)      
    }
}
exports.getUserPost = async (req,res,next) =>{
    try {
        const{userId} = req.body;
        //send the request to the post services 
        let post = await PostServices.getPostData(userId);
        // response back to frontend 
        res.json({status:true,success:post})    
    } catch (error) {
        next(error)  
    }
}
exports.deletePost = async (req,res,next) =>{
    try {
        const{id} = req.body;
        let deleted = await PostServices.deletePost(id);
        res.json({status:true,success:deleted})     
    } catch (error) {
        next(error)
        
    }
}