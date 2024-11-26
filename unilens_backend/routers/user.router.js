// Create API
const router = require('express').Router();
const UserController = require('../controller/user.controller');
// Creating registration API 
router.post('/registration',UserController.register);
// Create login API
router.post('/login',UserController.login);
//uncomment when working on scrapping
//router.post('/results',UserController.results);

module.exports = router;