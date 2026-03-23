import { Router } from "express";
import {
  createUser,
  getUsers,
  getUserById,
  updateUser,
  deleteUser,
  addAddress,
  updateAddress,
  deleteAddress,
  setDefaultAddress,
  getAddresses,
} from "./user.controller.js";

const router = Router();

router.post("/", createUser);
router.get("/", getUsers);
router.get("/:id", getUserById);
router.put("/:id", updateUser);
router.delete("/:id", deleteUser);

router.post("/add-address", addAddress);
router.put("/update-address", updateAddress);
router.delete("/delete-address/:userId/:addressId", deleteAddress);
router.patch("/set-default-address", setDefaultAddress);
router.get("/address/:userId", getAddresses);

export default router;
