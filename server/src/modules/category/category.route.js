import { Router } from "express";
import {
  createCategory,
  getCategories,
  getCategoryById,
  updateCategory,
  deleteCategory,
  getCategoriesApp,
} from "./category.controller.js";

const router = Router();

router.post("/", createCategory);
router.get("/", getCategories);
router.get("/app", getCategoriesApp);
router.get("/:id", getCategoryById);
router.put("/:id", updateCategory);
router.delete("/:id", deleteCategory);

export default router;
