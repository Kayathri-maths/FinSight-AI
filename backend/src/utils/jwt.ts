import jwt from "jsonwebtoken";

interface TokenPayload {
  userId: string;
  roleId: string;
}

const getJwtSecret = (): string => {
  const secret = process.env.JWT_SECRET;

  if (!secret) {
    throw new Error("JWT_SECRET is not configured");
  }

  return secret;
};

export const generateAccessToken = ({
  userId,
  roleId,
}: TokenPayload): string => {
  return jwt.sign(
    {
      userId,
      roleId,
    },
    getJwtSecret(),
    {
      expiresIn: "1h",
    }
  );
};