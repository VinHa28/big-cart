import express from "express";
import routes from "./routes/index.js";
import cors from "cors";
const app = express();
// CORS
app.use(cors());
// Middleware
app.use(express.json());
// Routes
app.use("/api", routes);

app.get("/", (req, res) => {
  res.send("API is running...");
});

export default app;
