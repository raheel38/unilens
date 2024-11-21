const axios = require('axios')
const cheerio = require('cheerio')
const express = require("express")
const cors = require('cors')


const app = express()
app.use(cors())
const PORT = 8000
const url = 'https://isss.khu.ac.kr/globalcenter/user/bbs/BMSR00040/list.do?menuNo=7900065'
// app.METHOD(PATH,HANDLER)

// app.get() //get data 
// app.post() //add 
// app.put() //edit
// app.delete() //delete data
app.get('/',function(req,res){
    res.json('This is my webscraper')
})
app.get('/results',(req,res)=>{
    axios(url)
    .then(response =>{
        const html = response.data
        const $ = cheerio.load(html)
        const articles = []
        $('.tal',html).each(function(){
            const title =  $(this).text()
            const url = $(this).find('a').attr('href')
            articles.push({
                title,
                url
            })
        })
        // console.log(articles)
        res.json(articles)
    }).catch(err => console.log(err))

})


app.listen(PORT,()=> console.log(`server running on PORT ${PORT}`))


