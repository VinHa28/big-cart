import express from "express";
import { fakeLogin, login, register } from "./auth.controller.js";

const router = express.Router();

router.post("/login", login);
router.get("/fake-login", fakeLogin);
router.post("/register", register);

export default router;
