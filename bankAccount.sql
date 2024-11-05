CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,
  "userId" bigint NOT NULL,
  "balance" bigint NOT NULL,
  "currencyId" bigserial NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now()),
  "status" bool NOT NULL DEFAULT true
);

CREATE TABLE "currencies" (
  "id" bigserial PRIMARY KEY,
  "code" varchar(3) NOT NULL,
  "name" varchar(50) NOT NULL,
  "status" bool NOT NULL DEFAULT true
);

CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "documentNumber" varchar UNIQUE NOT NULL,
  "documentType" bigint,
  "username" varchar UNIQUE NOT NULL,
  "email" varchar NOT NULL,
  "name" varchar NOT NULL,
  "lastName" varchar NOT NULL,
  "address" varchar NOT NULL,
  "phone" varchar NOT NULL DEFAULT 0,
  "cellphone" varchar NOT NULL,
  "neighborhood" varchar NOT NULL,
  "countryId" bigint,
  "stateLocationId" bigint,
  "cityId" bigint,
  "genderId" bigint,
  "sexId" bigint,
  "status" bool NOT NULL DEFAULT true,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "documentTypes" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now()),
  "status" bool NOT NULL DEFAULT true
);

CREATE TABLE "genders" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "status" bool NOT NULL DEFAULT true,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "sex" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "status" bool NOT NULL DEFAULT true,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "countries" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "code" varchar NOT NULL,
  "lat" varchar NOT NULL,
  "long" varchar NOT NULL,
  "status" bool NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "states" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "code" varchar NOT NULL,
  "lat" varchar NOT NULL,
  "long" varchar NOT NULL,
  "status" bool NOT NULL,
  "countryId" bigint NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "cities" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "code" varchar NOT NULL,
  "lat" varchar NOT NULL,
  "long" varchar NOT NULL,
  "stateId" bigint NOT NULL,
  "status" bool NOT NULL DEFAULT true,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "entries" (
  "id" bigserial PRIMARY KEY,
  "accountId" bigint,
  "amount" bigint NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now()),
  "status" bool DEFAULT true
);

CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY,
  "fromAccountId" bigint,
  "toAccountId" bigint,
  "amount" bigint NOT NULL,
  "createdAt" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "accounts" ("userId");

CREATE INDEX ON "accounts" ("currencyId");

CREATE INDEX ON "accounts" ("status");

CREATE INDEX ON "currencies" ("name");

CREATE INDEX ON "currencies" ("status");

CREATE INDEX ON "users" ("name");

CREATE INDEX ON "users" ("lastName");

CREATE INDEX ON "users" ("documentNumber");

CREATE INDEX ON "users" ("username");

CREATE INDEX ON "users" ("countryId");

CREATE INDEX ON "users" ("stateLocationId");

CREATE INDEX ON "users" ("genderId");

CREATE INDEX ON "users" ("cityId");

CREATE INDEX ON "users" ("status");

CREATE INDEX ON "documentTypes" ("name");

CREATE INDEX ON "genders" ("name");

CREATE INDEX ON "sex" ("name");

CREATE INDEX ON "countries" ("name");

CREATE INDEX ON "states" ("name");

CREATE INDEX ON "cities" ("name");

CREATE INDEX ON "entries" ("accountId");

CREATE INDEX ON "entries" ("createdAt");

CREATE INDEX ON "transfers" ("fromAccountId");

CREATE INDEX ON "transfers" ("toAccountId");

CREATE INDEX ON "transfers" ("fromAccountId", "toAccountId");

CREATE INDEX ON "transfers" ("createdAt");

CREATE INDEX ON "states" ("countryId");

CREATE INDEX ON "cities" ("stateId");

COMMENT ON COLUMN "entries"."amount" IS 'can be positive or negative';

COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';

ALTER TABLE "accounts" ADD FOREIGN KEY ("userId") REFERENCES "users" ("id");

ALTER TABLE "accounts" ADD FOREIGN KEY ("currencyId") REFERENCES "currencies" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("documentType") REFERENCES "documentTypes" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("countryId") REFERENCES "countries" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("stateLocationId") REFERENCES "states" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("cityId") REFERENCES "cities" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("genderId") REFERENCES "genders" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("sexId") REFERENCES "sex" ("id");

ALTER TABLE "entries" ADD FOREIGN KEY ("accountId") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("fromAccountId") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("toAccountId") REFERENCES "accounts" ("id");

ALTER TABLE "states" ADD FOREIGN KEY ("countryId") REFERENCES "countries" ("id");

ALTER TABLE "cities" ADD FOREIGN KEY ("stateId") REFERENCES "states" ("id");



INSERT INTO "currencies" ("code", "name", "status") VALUES
('USD', 'Dólar estadounidense', true),
('EUR', 'Euro', true),
('JPY', 'Yen japonés', true),
('GBP', 'Libra esterlina', true),
('AUD', 'Dólar australiano', true),
('CAD', 'Dólar canadiense', true),
('CHF', 'Franco suizo', true),
('CNY', 'Yuan chino', true),
('SEK', 'Corona sueca', true),
('NZD', 'Dólar neozelandés', true),
('MXN', 'Peso mexicano', true),
('SGD', 'Dólar singapurense', true),
('HKD', 'Dólar de Hong Kong', true),
('NOK', 'Corona noruega', true),
('KRW', 'Won surcoreano', true),
('TRY', 'Lira turca', true),
('RUB', 'Rublo ruso', true),
('INR', 'Rupia india', true),
('BRL', 'Real brasileño', true),
('ZAR', 'Rand sudafricano', true),
('COP', 'Peso colombiano', true);  -- Colombia

