import { NextFunction, Response } from "express";
import { eq, and } from "drizzle-orm";

import db from "../db/index";
import { permissions, rolePermissions } from "../db/schema";
import { AuthenticatedRequest } from "./auth.middleware";

export const requirePermission = (permissionName: string) => {
  return async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction
  ): Promise<void> => {
    try {
      if (!req.user) {
        res.status(401).json({
          success: false,
          message: "Authentication required",
        });
        return;
      }

      const result = await db
        .select({
          permissionId: permissions.id,
        })
        .from(rolePermissions)
        .innerJoin(
          permissions,
          eq(rolePermissions.permissionId, permissions.id)
        )
        .where(
          and(
            eq(rolePermissions.roleId, req.user.roleId),
            eq(permissions.name, permissionName)
          )
        )
        .limit(1);

      if (result.length === 0) {
        res.status(403).json({
          success: false,
          message: "You do not have permission to perform this action",
        });
        return;
      }

      next();
    } catch (error) {
      console.error("Authorization error:", error);

      res.status(500).json({
        success: false,
        message: "Authorization check failed",
      });
    }
  };
};