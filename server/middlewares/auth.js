const jwt=require("jsonwebtoken");
const User = require("../models/users");
const auth=async(req, res, next) => {
     try {
         const token=req.header('x-auth-token');
         if (!token){ return res.status(401).json({msg: 'Invalid No Auth Token ,Access denied'}); }
         const verified=jwt.verify(token,"passwordKey");
         if (!verified){return res.status(401).json({msg: 'Invalid ,Access denied'}); }

         req.user=verified.id;
         req.token=token;
         next();
      }
      catch(err){
      res.status(500).json({error: 'auth : '+ err.message});
      }
};

module.exports=auth;