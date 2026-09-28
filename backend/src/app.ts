import express from "express";
import cors from "cors";
import pool from "./config/database";
import authRoutes from "./routes/auth.routes";

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);
app.get("/health", (_req, res) => {
  res.status(200).json({
    success: true,
    message: "FinSight AI backend is running",
  });
});

app.get("/health/db", async (_req, res) => {
  try {
    const result = await pool.query("SELECT NOW() AS current_time");

    res.status(200).json({
      success: true,
      message: "Database connection is working",
      database: "finsight",
      time: result.rows[0].current_time,
    });
  } catch (error) {
    console.error("Database connection error:", error);

    res.status(500).json({
      success: false,
      message: "Database connection failed",
    });
  }
});

export default app;