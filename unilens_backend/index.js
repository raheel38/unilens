const app = require('./app');
const db = require('./config/db')
const UserModel = require('./model/user.model')
const PostModel = require('./model/post.model')
//const scrapeUrl = 'https://isss.khu.ac.kr/globalcenter/user/bbs/BMSR00040/list.do?menuNo=7900065'
// Make server 
//const app = express()
const port = 3000;
// cors is a middleware 
// app.use(cors())
// //scrapping the notice page code
// app.get('/results',(req,res)=>{
//     axios(scrapeUrl)
//     .then(response =>{
//         const html = response.data
//         const $ = cheerio.load(html)
//         const articles = []
//         $('.tal',html).each(function(){
//             const title =  $(this).text()
//             const url = $(this).find('a').attr('href')
//             articles.push({
//                 title,
//                 url
//             })
//         })
//         // console.log(articles)
//         res.json(articles)
//     }).catch(err => console.log(err))

// })

//router 
app.get('/',(req,res)=>{
    res.send("Hello world ^^ ")
})

app.listen(port,()=>{
    console.log(`Server is listening on Port http://localhost:${port}`);
})