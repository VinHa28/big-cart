import express from "express";
import { login } from "./auth.controller.js";
import { fakeLogin } from "./auth.controller.js";

const router = express.Router();

router.post("/login", login);
router.get("/fake-login", fakeLogin);

export default router;
