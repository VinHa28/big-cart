import { Router } from "express";
import {
  addToCart,
  clearItemFromCart,
  getCartByUserId,
  removeFromCart,
} from "./cart.controller.js";

const router = Router();

// POST: /api/cart/add
router.post("/add", addToCart);

// GET: /api/cart/:userId
router.get("/:userId", getCartByUserId);
router.post("/remove", removeFromCart);

// Xóa hoàn toàn sản phẩm đó
router.post("/clear-item", clearItemFromCart);

export default router;
