import { Router } from "express";
import { authenticate } from "../middleware/auth.middleware";
import { requirePermission } from "../middleware/rbac.middleware";
import { create, getAll, getById } from "../controllers/transaction.controller";

const router = Router();

router.use(authenticate);

router.post("/", requirePermission("transaction.investigate"), create);

router.get("/", requirePermission("transaction.read"), getAll);

router.get("/:id", requirePermission("transaction.read"), getById);

export default router;
