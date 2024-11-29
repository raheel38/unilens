const PostModel = require('../model/post.model')

class PostServices{

    // function to store data in the database 
    static async createPost(userId,title,desc){ // 3 parameters based on the post model schema 
        const createPost = new PostModel({userId,title,desc}); // Any data passed to createPost function will be stored in this object
        return await createPost.save() //data will get stored in mongoDB 

    }
    static async getPostData(userId){ // 3 parameters based on the post model schema 
        const postData = await PostModel.find({userId})
        return postData; //data will get stored in mongoDB 

    }
}
module.exports = PostServices