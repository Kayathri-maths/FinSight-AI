import { eq } from "drizzle-orm";
import db from "../db/index";
import { roles, users } from "../db/schema";
import { hashPassword,comparePassword } from "../utils/password";

interface RegisterInput {
  name: string;
  email: string;
  password: string;
}

export const registerUser = async ({
  name,
  email,
  password,
}: RegisterInput) => {
  const normalizedEmail = email.trim().toLowerCase();

  // Check whether the email already exists
  const existingUser = await db
    .select({
      id: users.id,
    })
    .from(users)
    .where(eq(users.email, normalizedEmail))
    .limit(1);

  if (existingUser.length > 0) {
    throw new Error("User with this email already exists");
  }

  // Get the default VIEWER role
  const defaultRole = await db
    .select({
      id: roles.id,
    })
    .from(roles)
    .where(eq(roles.name, "VIEWER"))
    .limit(1);

  if (defaultRole.length === 0) {
    throw new Error("Default user role not found");
  }

  // Hash password
  const passwordHash = await hashPassword(password);

  // Create user
  const [user] = await db
    .insert(users)
    .values({
      name: name.trim(),
      email: normalizedEmail,
      passwordHash,
      roleId: defaultRole[0].id,
    })
    .returning({
      id: users.id,
      name: users.name,
      email: users.email,
      roleId: users.roleId,
      isActive: users.isActive,
      createdAt: users.createdAt,
    });

  return user;
};

export const loginUser = async (
  email: string,
  password: string
) => {
  const normalizedEmail = email.trim().toLowerCase();

  const result = await db
    .select({
      id: users.id,
      name: users.name,
      email: users.email,
      passwordHash: users.passwordHash,
      roleId: users.roleId,
      isActive: users.isActive,
    })
    .from(users)
    .where(eq(users.email, normalizedEmail))
    .limit(1);

  if (result.length === 0) {
    throw new Error("Invalid email or password");
  }

  const user = result[0];

  if (!user.isActive) {
    throw new Error("User account is inactive");
  }

  const passwordMatches = await comparePassword(
    password,
    user.passwordHash
  );

  if (!passwordMatches) {
    throw new Error("Invalid email or password");
  }

  return {
    id: user.id,
    name: user.name,
    email: user.email,
    roleId: user.roleId,
  };
};