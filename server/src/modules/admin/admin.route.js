import express from "express";
import { getStats } from "./admin.controller.js";

const router = express.Router();

router.get("/stats", getStats);

export default router;
