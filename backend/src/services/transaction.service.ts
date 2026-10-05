import { desc, eq } from "drizzle-orm";
import db from "../db/index";
import { transactions } from "../db/schema";

interface CreateTransactionInput {
  customerId: string;
  merchantId: string;
  walletId?: string;
  amount: string;
  currency?: string;
  transactionType: string;
  paymentMethod: string;
  status?: string;
  failureReason?: string;
  deviceId?: string;
  isNewDevice?: boolean;
  city?: string;
  state?: string;
  country?: string;
  isNewLocation?: boolean;
  ipAddress?: string;
  channel?: string;
}

const generateTransactionCode = (): string => {
  const timestamp = Date.now().toString().slice(-6);
  return `TXN-${timestamp}`;
};

export const createTransaction = async (
  input: CreateTransactionInput
) => {
  const transactionCode = generateTransactionCode();

  const [transaction] = await db
    .insert(transactions)
    .values({
      transactionCode,
      customerId: input.customerId,
      merchantId: input.merchantId,
      walletId: input.walletId,
      amount: input.amount,
      currency: input.currency ?? "INR",
      transactionType: input.transactionType,
      paymentMethod: input.paymentMethod,
      status: input.status ?? "PENDING",
      failureReason: input.failureReason,
      deviceId: input.deviceId,
      isNewDevice: input.isNewDevice ?? false,
      city: input.city,
      state: input.state,
      country: input.country ?? "India",
      isNewLocation: input.isNewLocation ?? false,
      ipAddress: input.ipAddress,
      channel: input.channel,
    })
    .returning();

  return transaction;
};

export const getTransactionById = async (id: string) => {
  const [transaction] = await db
    .select()
    .from(transactions)
    .where(eq(transactions.id, id))
    .limit(1);

  return transaction ?? null;
};

export const getTransactions = async () => {
  return db
    .select()
    .from(transactions)
    .orderBy(desc(transactions.transactionTime));
};