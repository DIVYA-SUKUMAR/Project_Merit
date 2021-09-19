var express = require("express");
var app = express();
const { MongoClient,ObjectId } = require('mongodb');
var url = "mongodb://localhost:27017/";

var path = require("path");
const multer  = require('multer')

app.use(express.static('uploads'));

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, __dirname+'/uploads')
    },
    filename: function (req, file, cb) {
        console.log("file in filename function::",file)
        var fileext = path.extname(file.originalname);
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
      cb(null, file.fieldname + '-' + uniqueSuffix+fileext)
    }
})

const upload = multer({ storage: storage })

app.use(express.urlencoded({ extended: true }))
app.use(express.json());

app.set('view engine', 'pug');
app.set('views','./views');

app.get("/",function(req,res){
    res.send("Hello express")
})



app.post("/addStudent",upload.single("profilepic"),function(req,res){
    console.clear();
    console.log("req.file",req.file);    
    req.body.profilePic = req.file.filename;
    console.log("req.body",req.body);
    MongoClient.connect(url,function(err,conn){
        var db = conn.db("merit");
        db.collection("students").insertOne(req.body,function(err,data){
            res.send(data)
        })
    })
})

app.get("/viewall",function(req,res){
    MongoClient.connect(url,function(err,conn){
        var db = conn.db("merit");
        db.collection("students").find().toArray(function(err,data){
            console.log(data);
            res.send(data)
        })
    })
})

app.get("/deleteStudent/:id",function(req,res){
    MongoClient.connect(url,function(err,conn){
        var db = conn.db("merit");
        db.collection("students").deleteOne({_id:ObjectId(req.params.id)},
        function(err,data){
            res.send(data)
        })
    })
})


app.post("/addStudentWeight",function(req,res){
    MongoClient.connect(url,function(err,conn){
        console.log(req.body)
        var db = conn.db("merit");
        db.collection("students")
        .updateOne(
            {_id:ObjectId(req.body.id)},
            {
                $push:{
                    weightEntry:{
                        date:req.body.date,
                        weight:req.body.weight
                    }
                }
            },
            function(err,data){
                console.log(data)
                res.send(data)
            }
        )
    })
})

app.post("/updStudent",upload.single("profilepic"),function(req,res){
    MongoClient.connect(url,function(err,conn){
        req.body.profilePic = req.file.filename;
        console.log(req.body)
        var db = conn.db("merit");
        db.collection("students")
        .updateOne(
            {_id:ObjectId(req.body.id)},
            {
                $set:{
                        firstname:req.body.firstname,
                        lastname:req.body.lastname,
                        age:req.body.age,
                        profilepic:req.body.profilePic,
                    }
            },
            function(err,data){
                console.log(data)
                res.send(data)
            }
        )
    })
})


app.listen(8080,function(){console.log("App runnning on 8080")})