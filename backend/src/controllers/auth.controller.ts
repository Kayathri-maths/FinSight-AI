import { Request, Response } from "express";
import { loginUser, registerUser } from "../services/auth.service";
import { generateAccessToken } from "../utils/jwt";

export const register = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      res.status(400).json({
        success: false,
        message: "Name, email, and password are required",
      });
      return;
    }

    if (password.length < 8) {
      res.status(400).json({
        success: false,
        message: "Password must be at least 8 characters",
      });
      return;
    }

    const user = await registerUser({
      name,
      email,
      password,
    });

    res.status(201).json({
      success: true,
      message: "User registered successfully",
      data: {
        user,
      },
    });
  } catch (error) {
    console.error("Registration error:", error);

    const message =
      error instanceof Error ? error.message : "Registration failed";

    if (message === "User with this email already exists") {
      res.status(409).json({
        success: false,
        message,
      });
      return;
    }

    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

export const login = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      res.status(400).json({
        success: false,
        message: "Email and password are required",
      });
      return;
    }

    const user = await loginUser(email, password);

    const accessToken = generateAccessToken({
      userId: user.id,
      roleId: user.roleId,
    });

    res.status(200).json({
      success: true,
      message: "Login successful",
      data: {
        accessToken,
        user,
      },
    });
  } catch (error) {
    console.error("Login error:", error);

    const message =
      error instanceof Error ? error.message : "Login failed";

    if (
      message === "Invalid email or password" ||
      message === "User account is inactive"
    ) {
      res.status(401).json({
        success: false,
        message,
      });
      return;
    }

    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};