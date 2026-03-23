import { Router } from "express";
import categoryRoutes from "../modules/category/category.route.js";
import productRoutes from "../modules/product/product.route.js";
import userRoutes from "../modules/user/user.route.js";
import authRoutes from "../modules/auth/auth.route.js";
import orderRoutes from "../modules/order/order.route.js";
import cartRoutes from "../modules/cart/cart.route.js";
import adminRoutes from "../modules/admin/admin.route.js";

const router = Router();

// Category APIs
router.use("/categories", categoryRoutes);
router.use("/products", productRoutes);
router.use("/users", userRoutes);
router.use("/auth", authRoutes);
router.use("/orders", orderRoutes);
router.use("/cart", cartRoutes);
router.use("/admin", adminRoutes);

export default router;
