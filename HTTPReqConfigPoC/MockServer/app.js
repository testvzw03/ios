var express = require('express')
var app = express()
var bodyParser = require('body-parser')
var basicAuth = require('express-basic-auth')

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
// app.use(basicAuth({
//   users: { 'admin': 'pass' }
// }))

// app.use(basicAuth({authorizer:myAuthorizerFunction}))
//
// function myAuthorizerFunction() {
//   console.log('My Authorization Function called. '+Date())
//   return true
// }
app.all('/testBasicAuth', basicAuth({
  challenge:true,
  users: { 'admin': 'password' },
  unauthorizedResponse:unauthorizedResponse
}))

function unauthorizedResponse(req) {

  console.log("Test Auth Request failed. ");
}

app.get('/testBasicAuth', function(req, res) {

  res.type('application/json')
  console.log("Test Auth Request Successful. "+Date());
  res.status(200)
  res.send(JSON.stringify({statusCode:200,statusMessage:"Test Authentication successful"}))
})

app.get('/allOk', function (req, res) {
  res.type('application/json')
  console.log("All Ok Request received. "+Date());
  res.status(200)
  setTimeout(function(){
                  res.send(JSON.stringify({statusCode:200,statusMessage:"",a:1,b:2,c:'text'}))
                }, 2000)
})

app.get('/testauthorization', function (req, res) {

  res.type('application/json')

    console.log("Test Authorization Request received. "+Date());
    res.status(401)
    res.send(JSON.stringify({statusCode:400,statusMessage:"<Server Response> Unauthorized. Please login again."}))
})

app.get('/testbadrequest', function (req, res) {

  res.type('application/json')

    console.log("Test Bad Request received. "+Date());

    res.status(400)
    res.send(JSON.stringify({statusCode:400,statusMessage:"<Server Response> Unable to complete your requested operation. Bad request. Please try again."}))
})

app.get('/testget', function(req, res){

  res.type('application/json')

    console.log("Test Get Request received. "+Date());

    var queryStr = JSON.stringify(req.query)
    res.status(200)
    res.send(JSON.stringify({statusCode:400,statusMessage:"<Server Response>::"+queryStr}))
})

app.post('/testpost', function(req, res){

  res.type('application/json')

    console.log("<Server Response>::"+JSON.stringify(req.body))
    res.status(200)
    res.send(JSON.stringify({statusCode:400,statusMessage:"<Server Response>Post::"+JSON.stringify(req.body)}))
})

app.use(function (req, res, next) {
  console.log('Time: %d', Date.now());
  next();
});

app.listen(3000)
