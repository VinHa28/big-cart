import { Router } from "express";
import {
  createOrder,
  getAllOrders,
  getUserOrders,
  updateOrderStatus,
} from "./order.controller.js";

const router = Router();

router.post("/create", createOrder); // Flutter: Đặt hàng
router.get("/user/:userId", getUserOrders); // Flutter: Lịch sử đơn hàng
router.get("/all", getAllOrders); // React Admin: Xem tất cả
router.put("/update-status", updateOrderStatus); // React Admin: Đổi trạng thái

export default router;
