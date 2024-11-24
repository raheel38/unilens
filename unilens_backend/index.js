const app = require('./app');
const db = require('./config/db')
const UserModel = require('./model/user.model')
// Make server 
const port = 3000;

//router 
app.get('/',(req,res)=>{
    res.send("Hello world ^^ ")
})

app.listen(port,()=>{
    console.log(`Server is listening on Port http://localhost:${port}`);
})