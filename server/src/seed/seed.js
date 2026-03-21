import dotenv from "dotenv";
import mongoose from "mongoose";
import connectDB from "../config/db.js";
import User from "../modules/user/user.model.js";
import Category from "../modules/category/category.model.js";
import Product from "../modules/product/product.model.js";

dotenv.config();

const seed = async () => {
  try {
    await connectDB();

    // Clear collections (safe for development)
    await User.deleteMany({});
    await Category.deleteMany({});
    await Product.deleteMany({});

    const user = await User.create({
      username: "mobile_user",
      email: "mobile_user@example.com",
      phone: "0123456789",
      role: "user",
    });

    const cat1 = await Category.create({ name: "Fruits", description: "Fresh fruits" });
    const cat2 = await Category.create({ name: "Vegetables", description: "Fresh vegetables" });

    const p1 = await Product.create({
      name: "Apple",
      description: "Red apple",
      price: 2,
      unit: "kg",
      stock: 100,
      category: cat1._id,
    });

    const p2 = await Product.create({
      name: "Banana",
      description: "Yellow banana",
      price: 1,
      unit: "kg",
      stock: 200,
      category: cat1._id,
    });

    const p3 = await Product.create({
      name: "Carrot",
      description: "Orange carrot",
      price: 1.5,
      unit: "kg",
      stock: 150,
      category: cat2._id,
    });

    console.log("Seed complete:", { user: user._id, products: [p1._id, p2._id, p3._id] });
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

seed();
