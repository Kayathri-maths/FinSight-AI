import { Request, Response } from "express";
import {
  createTransaction,
  getTransactionById,
  getTransactions,
} from "../services/transaction.service";

export const create = async (req: Request, res: Response) => {
  try {
    console.log("Create transaction request body:", req.body);
    const transaction = await createTransaction(req.body);

    return res.status(201).json({
      success: true,
      message: "Transaction created successfully",
      data: transaction,
    });
  } catch (error) {
    console.error("Create transaction error:", error);

    return res.status(500).json({
      success: false,
      message: "Failed to create transaction",
    });
  }
};

export const getById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;

    if (typeof id !== "string") {
      return res.status(400).json({
        success: false,
        message: "Invalid transaction ID",
      });
    }
    const transaction = await getTransactionById(id);

    if (!transaction) {
      return res.status(404).json({
        success: false,
        message: "Transaction not found",
      });
    }

    return res.status(200).json({
      success: true,
      data: transaction,
    });
  } catch (error) {
    console.error("Get transaction error:", error);

    return res.status(500).json({
      success: false,
      message: "Failed to fetch transaction",
    });
  }
};

export const getAll = async (_req: Request, res: Response) => {
  try {
    const transactions = await getTransactions();

    return res.status(200).json({
      success: true,
      count: transactions.length,
      data: transactions,
    });
  } catch (error) {
    console.error("Get transactions error:", error);

    return res.status(500).json({
      success: false,
      message: "Failed to fetch transactions",
    });
  }
};
