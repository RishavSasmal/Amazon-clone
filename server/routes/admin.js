const express = require('express');
const adminRouter=express.Router();
const admin=require("../middlewares/admin");
const Product=require("../models/product");


//Add Product
adminRouter.post('/admin/add-products',admin,async(req,res)=>{
try{
const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
}
catch(err){res.status(500).json({ error: err.message+'routeAdmin' });}
});

//Get Product
adminRouter.get('/admin/get-products',admin,async(req,res)=>{
try{
const product = await Product.find({});
res.json(product);
}
catch(err){
res.status(500).json({ error: err.message+'getrouteAdmin'});}
});

//Delete Product
adminRouter.post('/admin/delete-products',admin,async(req,res)=>{
try{
const {id}=req.body;
let product = await Product.findByIdAndDelete(id);
res.json(product);
}
catch(err){
res.status(500).json({ error: err.message+'delete ProductAdmin'});}
});

module.exports = adminRouter;