// Create API
const router = require('express').Router();
const PostController = require('../controller/post.controller')
// When the storePost API is called - send the data into post controller - createPost function 
router.post('/storePost',PostController.createPost)

module.exports = router