const express=require('express');
const bcryptjs=require('bcryptjs');
const User = require('../models/users');
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter=express.Router();

authRouter.post('/api/signup',async(req,res)=>{
try{
    const {name,email,password}=req.body;
    const existingUser=await User.findOne({email});
    if(existingUser){
       return res.status(400).json({msg:"user already exist"});
    };
   const hashedPassword=await bcryptjs.hash(password,8);
    let user=new User({email,name,password:hashedPassword});
    user=await user.save();
    res.json(user);
    }
catch(err)
       {
        res.status(500).json({error:err.message});
        }

});

authRouter.post('/api/signin',async(req,res)=>{
try{
  const {email,password}=req.body;
  const user=await User.findOne({email});
  if(!user){
          return res.status(400).json({msg:"user not found"});
       }
   const isMatch=await bcryptjs.compare(password,user.password);
   if(!isMatch){
   return res.status(400).json({msg:"invalid password"});
   }
   const token=jwt.sign({id:user._id},"passwordKey");
   res.json({token,...user._doc});
//   console.log("password key ; "+passwordKey);

  }
catch(err){
    res.status(500).json({error:'signin : ${err.message}'});
}
});

authRouter.post('/tokenIsValid',async(req,res)=>{
      try{
      const token= req.header('x-auth-token');
      if(!token){return res.json(false);}
      const verified= jwt.verify(token,"passwordKey");
      if(!verified){return res.json(false);}
      const user= await User.findById(verified.id);
      if(!user){return res.json(false);}
      res.json(true);

      }
      catch(err){
      res.status(500).json({error:'token ${err.message}'});
      }
});

authRouter.get('/',auth,async(req,res)=>{
const user=await User.findById(req.user);
res.json({...user._doc,token:req.token});
});

module.exports=authRouter;