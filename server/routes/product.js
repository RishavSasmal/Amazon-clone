const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const Product  = require("../models/product");

productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
// create a get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
// create a post request to route to rate products
productRouter.post("/api/rate-product",auth, async (req, res) => {
try {
const{id,rating}=req.body;
let products = await Product.findById(id);

}catch (e) {
res.status(500).json({ error: err.message});
}

})

module.exports = productRouter;