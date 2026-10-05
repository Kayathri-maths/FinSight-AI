import {
  boolean,
  index,
  pgTable,
  text,
  timestamp,
  uuid,
  uniqueIndex,
  inet,
numeric,
varchar,
char
} from "drizzle-orm/pg-core";

export const roles = pgTable(
  "roles",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    name: text("name").notNull().unique(),
    description: text("description"),
    createdAt: timestamp("created_at", {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    nameIdx: uniqueIndex("roles_name_idx").on(table.name),
  })
);

export const permissions = pgTable(
  "permissions",
  {
    id: uuid("id").defaultRandom().primaryKey(),
    name: text("name").notNull().unique(),
    description: text("description"),
    createdAt: timestamp("created_at", {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    nameIdx: uniqueIndex("permissions_name_idx").on(table.name),
  })
);

export const users = pgTable(
  "users",
  {
    id: uuid("id").defaultRandom().primaryKey(),

    name: text("name").notNull(),

    email: text("email").notNull().unique(),

    passwordHash: text("password_hash").notNull(),

    roleId: uuid("role_id")
      .notNull()
      .references(() => roles.id, {
        onDelete: "restrict",
        onUpdate: "cascade",
      }),

    department: text("department"),

    isActive: boolean("is_active").default(true).notNull(),

    lastLoginAt: timestamp("last_login_at", {
      withTimezone: true,
    }),

    createdAt: timestamp("created_at", {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp("updated_at", {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    emailIdx: uniqueIndex("users_email_idx").on(table.email),
    roleIdx: index("idx_users_role_id").on(table.roleId),
    activeIdx: index("idx_users_is_active").on(table.isActive),
  })
);

export const rolePermissions = pgTable(
  "role_permissions",
  {
    roleId: uuid("role_id")
      .notNull()
      .references(() => roles.id, {
        onDelete: "cascade",
        onUpdate: "cascade",
      }),

    permissionId: uuid("permission_id")
      .notNull()
      .references(() => permissions.id, {
        onDelete: "cascade",
        onUpdate: "cascade",
      }),
  },
  (table) => ({
    rolePermissionIdx: index("idx_role_permissions_role_id").on(
      table.roleId
    ),

    permissionIdx: index("idx_role_permissions_permission_id").on(
      table.permissionId
    ),
  })
);

export const transactions = pgTable(
  "transactions",
  {
    id: uuid("id").defaultRandom().primaryKey(),

  transactionCode: varchar("transaction_code", { length: 40 }).notNull(),

    customerId: uuid("customer_id").notNull(),

    merchantId: uuid("merchant_id").notNull(),

    walletId: uuid("wallet_id"),

    amount: numeric("amount", {
      precision: 18,
      scale: 2,
    }).notNull(),

    currency: char("currency", {
      length: 3,
    })
      .notNull()
      .default("INR"),

    transactionType: varchar("transaction_type", {
      length: 30,
    }).notNull(),

    paymentMethod: varchar("payment_method", {
      length: 30,
    }).notNull(),

    status: varchar("status", {
      length: 30,
    }).notNull(),

    failureReason: text("failure_reason"),

    deviceId: varchar("device_id", {
      length: 255,
    }),

    isNewDevice: boolean("is_new_device")
      .notNull()
      .default(false),

    city: varchar("city", {
      length: 100,
    }),

    state: varchar("state", {
      length: 100,
    }),

    country: varchar("country", {
      length: 100,
    }).default("India"),

    isNewLocation: boolean("is_new_location")
      .notNull()
      .default(false),

    ipAddress: inet("ip_address"),

    channel: varchar("channel", {
      length: 30,
    }),

    transactionTime: timestamp("transaction_time", {
      withTimezone: true,
    })
      .notNull()
      .defaultNow(),

    createdAt: timestamp("created_at", {
      withTimezone: true,
    })
      .notNull()
      .defaultNow(),
  },
  (table) => ({
    customerIdx: index("idx_transactions_customer_id").on(
      table.customerId
    ),

    customerTimeIdx: index(
      "idx_transactions_customer_time"
    ).on(table.customerId, table.transactionTime),

    merchantIdx: index("idx_transactions_merchant_id").on(
      table.merchantId
    ),
  })
);