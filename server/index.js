//import from package
 const express=require('express');//similar to import 'package:express/express.dart'
 const mongoose=require('mongoose');

 //import from file
 const authRouter=require('./routes/auth');
 const adminRouter=require('./routes/admin');
 const productRouter=require('./routes/product');

  //init
  const PORT=3000;
  const app =express();
  const DB="mongodb+srv://rishav:Abcd%40123@cluster0.elknfsa.mongodb.net/?retryWrites=true&w=majority";

 //middleware
 //Client->middleware->SERVER->Client
 app.use(express.json());
 app.use(authRouter);
 app.use(adminRouter);
 app.use(productRouter);

//Connection
mongoose.connect(DB)
.then(()=>{console.log('Connection Successful');})
.catch((err)=>{
console.log(err)});

 app.listen(PORT,"0.0.0.0",()=>{
 console.log(`connected at port ${PORT}`+ PORT);
 });