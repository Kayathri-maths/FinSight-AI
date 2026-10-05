import { Router } from "express";
import {
  getCurrentUser,
  login,
  register,
} from "../controllers/auth.controller";
import { authenticate } from "../middleware/auth.middleware";
// import { requirePermission } from "../middleware/rbac.middleware";

const router = Router();

router.post("/register", register);
router.post("/login", login);
router.get("/me", authenticate, getCurrentUser);
// router.get(
//   "/test-transaction-access",
//   authenticate,
//   requirePermission("transaction.read"),
//   (_req, res) => {
//     res.status(200).json({
//       success: true,
//       message: "You have transaction.read permission",
//     });
//   }
// );
export default router;