-- CreateEnum
CREATE TYPE "TenantRegisterMethod" AS ENUM ('ONE_CLICK', 'EMAIL_AND_PASSWORD', 'EMAIL_MAGIC', 'PHONE', 'PHONE_OTP');

-- CreateEnum
CREATE TYPE "TenantKYCType" AS ENUM ('FIRST_NAME', 'LAST_NAME', 'FULL_NAME', 'PHONE', 'PHONE_OTP', 'EMAIL_VERIFICATION', 'IDENTITY_CARD', 'PASSPORT');

-- CreateEnum
CREATE TYPE "SettingType" AS ENUM ('ORIGINAL', 'PLATFORM', 'TENANT');

-- CreateEnum
CREATE TYPE "GameProviderNatureType" AS ENUM ('DIRECT', 'AGGREGATOR');

-- CreateEnum
CREATE TYPE "CredentialType" AS ENUM ('ORIGINAL', 'PLATFORM', 'TENANT', 'GAME', 'PAYMENT');

-- CreateEnum
CREATE TYPE "GameProviderNature" AS ENUM ('AGGREGATOR', 'SUBORDINATE', 'DIRECT_LINE');

-- CreateEnum
CREATE TYPE "GameProviderType" AS ENUM ('QTECH', 'PRAGMATIC', 'AWC', 'FACHAI', 'NEXTSPIN', 'SBO', 'IGS', 'JOKER', 'PGSOFT', 'NT', 'REDTIGER', 'KINGMAKER', 'EVOLUTION', 'DREAM', 'HABANERO', 'MG', 'SPADEGAMING', 'PLAYSTAR', 'ROYALGCLUB', 'SPRIBE', 'SAGAMING', 'SIMPLEPLAY');

-- CreateEnum
CREATE TYPE "DomainType" AS ENUM ('ROOT', 'TENANT', 'AFFILIATE');

-- CreateEnum
CREATE TYPE "Currency" AS ENUM ('THB', 'MYR', 'USD', 'SGD', 'IDR');

-- CreateEnum
CREATE TYPE "AccountChannel" AS ENUM ('FIAT', 'CRYPTO', 'EWALLET');

-- CreateEnum
CREATE TYPE "AccountType" AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'BOTH');

-- CreateEnum
CREATE TYPE "PaymentGatewayProviderType" AS ENUM ('MANUAL', 'VADERPAY', 'BTCPAY', 'LINE', 'AMPAY', 'PIGSPIN');

-- CreateEnum
CREATE TYPE "WalletPurpose" AS ENUM ('MAIN', 'BONUS', 'REBATE');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "TransactionPurpose" AS ENUM ('BET', 'WIN', 'LOSS', 'ROLLBACK', 'ROLLBACK_BONUS', 'BONUS', 'BONUS_WITHDRAWAL', 'DEPOSIT', 'WITHDRAWAL', 'OFFRECORD_DEPOSIT', 'OFFRECORD_WITHDRAWAL', 'OFFRECORD_ADD_BONUS', 'OFFRECORD_REMOVE_BONUS', 'PROMOTION', 'REBATE');

-- CreateEnum
CREATE TYPE "LegacyContentType" AS ENUM ('POPUP', 'ANNOUNCEMENT', 'BANNER');

-- CreateEnum
CREATE TYPE "MaintenanceType" AS ENUM ('GAME_PROVIDER', 'GAME_CATEGORY', 'GAME', 'PAYMENT_PROVIDER', 'PAYMENT_CHANNEL', 'ACCOUNT');

-- CreateEnum
CREATE TYPE "GroupType" AS ENUM ('GROUP', 'TAG');

-- CreateEnum
CREATE TYPE "UserGroupType" AS ENUM ('AUTO', 'MANUAL');

-- CreateEnum
CREATE TYPE "PromotionType" AS ENUM ('PROMOTION', 'REBATE');

-- CreateEnum
CREATE TYPE "PromotionCycleUnit" AS ENUM ('HOUR', 'DAY', 'WEEK', 'MONTH');

-- CreateEnum
CREATE TYPE "PromotionRuleType" AS ENUM ('USER', 'GROUP', 'TAG', 'SIGNUP', 'LOGIN', 'NUMBER_OF_TRANSACTION', 'BET_AMOUNT', 'DEPOSIT_AMOUNT', 'GAME', 'GAME_CATEGORY', 'GAME_PROVIDER', 'DEPOSIT_ACCOUNT', 'DEPOSIT_GATEWAY');

-- CreateEnum
CREATE TYPE "PromotionRewardType" AS ENUM ('FIXED_MIN_DEPOSIT', 'PECENTAGE_OF_WALLET_BALANCE');

-- CreateEnum
CREATE TYPE "PromotionRewardBonusType" AS ENUM ('FIXED', 'PERCENTAGE');

-- CreateEnum
CREATE TYPE "PromotionLockWithdrawalType" AS ENUM ('WALLET_BALANCE', 'TURNOVER_AMOUNT', 'BONUS_AMOUNT', 'NO_LOCK');

-- CreateEnum
CREATE TYPE "UserPromotionStatus" AS ENUM ('COMPLETED', 'IN_PROGRESS', 'EXPIRED');

-- CreateTable
CREATE TABLE "Fingerprint" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "timestamp" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip" VARCHAR(60),
    "visitorId" TEXT,
    "meta" JSONB NOT NULL,
    "tenantId" TEXT,

    CONSTRAINT "Fingerprint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccessLog" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "service" VARCHAR(100) NOT NULL,
    "timestamp" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip" VARCHAR(60),
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AccessLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AlertLog" (
    "id" TEXT NOT NULL,
    "message" VARCHAR(300) NOT NULL,
    "severity" VARCHAR(8) NOT NULL,
    "timestamp" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" TEXT,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AlertLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Domain" (
    "id" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "siteId" TEXT NOT NULL,
    "verificationTxt" TEXT,
    "verifiedAt" TIMESTAMP(3),
    "domainUrl" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "isDefault" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Domain_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "message" VARCHAR(300),
    "userId" TEXT,
    "timestamp" TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "subject" VARCHAR(50),
    "identifier" TEXT,
    "new_value" JSON,
    "old_value" JSON,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "legacyMongoId" TEXT,
    "username" TEXT NOT NULL,
    "password" TEXT,
    "email" TEXT,
    "phoneNumber" TEXT,
    "firstName" TEXT,
    "lastName" TEXT,
    "metadata" JSONB,
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastLoggedInAt" TIMESTAMP(3),
    "deletedAt" TIMESTAMP(3),
    "roleId" TEXT NOT NULL,
    "depositDisabledStartAt" TIMESTAMP(3),
    "depositDisabledEndAt" TIMESTAMP(3),
    "withdrawalDisabledStartAt" TIMESTAMP(3),
    "withdrawalDisabledEndAt" TIMESTAMP(3),
    "loginDisabledStartAt" TIMESTAMP(3),
    "loginDisabledEndAt" TIMESTAMP(3),
    "promotionDisabledStartAt" TIMESTAMP(3),
    "promotionDisabledEndAt" TIMESTAMP(3),
    "maxDailyDepositLimit" INTEGER,
    "maxDailyDepositCount" INTEGER,
    "maxDailyWithdrawalLimit" INTEGER,
    "maxDailyWithdrawalCount" INTEGER,
    "currency" "Currency" NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PhoneOTP" (
    "id" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "userId" TEXT,
    "phoneVerifiedAt" TIMESTAMP(3),
    "phoneOtp" TEXT NOT NULL,
    "phoneOtpExpiry" TIMESTAMP(3),

    CONSTRAINT "PhoneOTP_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "abilities" JSONB NOT NULL DEFAULT '{}',
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserKYCMethodResponse" (
    "id" TEXT NOT NULL,
    "kycMethodId" TEXT NOT NULL,
    "response" JSONB NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "UserKYCMethodResponse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TenantKYCMethod" (
    "id" TEXT NOT NULL,
    "stage" INTEGER NOT NULL,
    "priority" INTEGER NOT NULL,
    "type" "TenantKYCType" NOT NULL,
    "tenantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TenantKYCMethod_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Tenant" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "legacyMongoId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "currencies" TEXT[],
    "defaultCurrency" TEXT,
    "languages" TEXT[],
    "defaultLanguage" TEXT,
    "registerMethods" "TenantRegisterMethod"[],

    CONSTRAINT "Tenant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Block" (
    "id" TEXT NOT NULL,
    "type" JSONB NOT NULL DEFAULT '{}',
    "content" TEXT NOT NULL,
    "meta" JSONB NOT NULL DEFAULT '{}',
    "priority" INTEGER,
    "tenantId" TEXT NOT NULL,
    "publishedAt" TIMESTAMP(3) NOT NULL,
    "expiredAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Block_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Game" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "isEnabledDefault" BOOLEAN NOT NULL,
    "hasFreebetSupport" BOOLEAN NOT NULL,
    "gameCategoryId" TEXT NOT NULL,
    "gameProviderId" TEXT NOT NULL,
    "attachmentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameSetting" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "SettingType" NOT NULL,
    "tenantId" TEXT,
    "gameId" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL,
    "isFeatured" BOOLEAN NOT NULL,
    "thumbnailId" TEXT,
    "featuringPriority" INTEGER,
    "metadata" JSONB,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameProvider" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "code" TEXT,
    "parentId" TEXT,
    "providerType" TEXT NOT NULL,
    "isEnabledDefault" BOOLEAN NOT NULL,
    "rootProviderType" "GameProviderType" NOT NULL,
    "providerNature" "GameProviderNature" NOT NULL,
    "thumbnailId" TEXT,
    "currencyPrecision" INTEGER NOT NULL DEFAULT 2,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameProvider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameProviderSetting" (
    "id" TEXT NOT NULL,
    "type" "SettingType" NOT NULL,
    "isActive" BOOLEAN NOT NULL,
    "isFeatured" BOOLEAN NOT NULL,
    "hasPriority" INTEGER,
    "hasRate" INTEGER NOT NULL,
    "clientEndpoint" TEXT,
    "metadata" JSONB DEFAULT '{}',
    "thumbnailId" TEXT,
    "gameProviderId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "credentialId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameProviderSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Credential" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "CredentialType" NOT NULL,
    "data" JSONB NOT NULL DEFAULT '{}',
    "clientEndpoint" TEXT,
    "key" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "isMasked" BOOLEAN NOT NULL DEFAULT false,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "isEnabledDefault" BOOLEAN NOT NULL DEFAULT true,
    "userId" TEXT,
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Credential_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameProviderPlayer" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "foreignUserId" TEXT NOT NULL,
    "currency" "Currency" NOT NULL,
    "providerType" "GameProviderType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameProviderPlayer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCategory" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "gameId" TEXT,
    "userId" TEXT,
    "tenantId" TEXT,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameCategorySetting" (
    "id" TEXT NOT NULL,
    "type" "SettingType" NOT NULL,
    "name" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL,
    "gameCategoryId" TEXT,
    "userId" TEXT,
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "GameCategorySetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bank" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "shortName" TEXT NOT NULL,
    "currencies" "Currency"[],
    "code" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Bank_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Site" (
    "id" TEXT NOT NULL,
    "seoTitle" TEXT NOT NULL,
    "seoDescription" TEXT,
    "attachmentId" TEXT,
    "seoKeywords" TEXT,
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Site_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Page" (
    "id" TEXT NOT NULL,
    "seoTitle" TEXT NOT NULL,
    "seoDescription" TEXT,
    "attachmentId" TEXT,
    "seoKeywords" TEXT,
    "permalink" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "publishedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "siteId" TEXT,
    "content" TEXT,

    CONSTRAINT "Page_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "id" TEXT NOT NULL,
    "currency" "Currency" NOT NULL,
    "accountChannel" "AccountChannel" NOT NULL,
    "accountType" "AccountType" NOT NULL,
    "name" TEXT,
    "isTenant" BOOLEAN NOT NULL DEFAULT false,
    "isPlayer" BOOLEAN NOT NULL DEFAULT false,
    "accountNumber" TEXT NOT NULL,
    "accountName" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "meta" JSONB NOT NULL DEFAULT '{}',
    "minAmount" INTEGER NOT NULL DEFAULT 0,
    "maxAmount" INTEGER NOT NULL DEFAULT 0,
    "bankId" TEXT,
    "userId" TEXT,
    "tenantId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentGateway" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "providerType" "PaymentGatewayProviderType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PaymentGateway_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentGatewaySetting" (
    "id" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "tenantId" TEXT NOT NULL,
    "paymentGatewayId" TEXT NOT NULL,
    "metadata" JSONB NOT NULL DEFAULT '{}',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "credentialId" TEXT NOT NULL,

    CONSTRAINT "PaymentGatewaySetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentGatewayChannel" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "paymentGatewayId" TEXT NOT NULL,
    "purpose" "AccountType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PaymentGatewayChannel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PaymentGatewayChannelSetting" (
    "id" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "tenantId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PaymentGatewayChannelSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Wallet" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "currency" "Currency" NOT NULL,
    "purpose" "WalletPurpose" NOT NULL,
    "balance" INTEGER NOT NULL DEFAULT 0,
    "pending" INTEGER NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "isLock" BOOLEAN NOT NULL DEFAULT false,
    "lockedTurnoverAmount" INTEGER NOT NULL DEFAULT 0,
    "lockedBonusAmount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Wallet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LegacyContent" (
    "id" TEXT NOT NULL,
    "type" "LegacyContentType" NOT NULL,
    "attachmentId" TEXT,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "href" TEXT,
    "priority" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "tenantId" TEXT NOT NULL,
    "publishedAt" TIMESTAMP(3),
    "expiredAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "LegacyContent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "currency" "Currency" NOT NULL,
    "status" "TransactionStatus",
    "purpose" "TransactionPurpose" NOT NULL,
    "note" TEXT,
    "meta" JSONB,
    "rollbackTransactionId" TEXT,
    "affiliateId" TEXT,
    "userId" TEXT NOT NULL,
    "walletId" TEXT NOT NULL,
    "externalTranId" TEXT,
    "gameId" TEXT,
    "roundId" TEXT,
    "paymentGateWayId" TEXT,
    "accountId" TEXT,
    "statusChangeOn" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "paymentGatewayChannelId" TEXT,
    "tenantId" TEXT NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "attachmentId" TEXT,
    "credentialId" TEXT,
    "userPromotionId" TEXT,
    "promotionId" TEXT,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "File" (
    "id" TEXT NOT NULL,
    "s3ObjectId" TEXT NOT NULL,
    "presignedUrl" TEXT,
    "presignedUrlExpiredAt" TIMESTAMP(3),
    "payload" JSONB NOT NULL DEFAULT '{}',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "name" TEXT,
    "content" TEXT,
    "attachmentId" TEXT,
    "public" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "File_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Maintenance" (
    "id" TEXT NOT NULL,
    "note" TEXT,
    "isActive" BOOLEAN NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3) NOT NULL,
    "gameId" TEXT,
    "gameProviderId" TEXT,
    "gameSettingId" TEXT,
    "tenantId" TEXT,
    "accountId" TEXT,
    "gameProviderSettingId" TEXT,
    "gameCategorySettingId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "Maintenance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerFavourite" (
    "id" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "gameProviderPlayerId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PlayerFavourite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "GroupType" NOT NULL,
    "rules" JSONB NOT NULL,
    "actions" JSONB NOT NULL,
    "automationPeriod" JSONB,
    "nextRunAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "promotionRewardId" TEXT,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserGroup" (
    "userId" TEXT NOT NULL,
    "groupId" TEXT NOT NULL,
    "type" "UserGroupType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "Promotion" (
    "id" TEXT NOT NULL,
    "type" "PromotionType" NOT NULL,
    "name" TEXT NOT NULL,
    "imageId" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "howToApply" TEXT NOT NULL,
    "terms" TEXT NOT NULL,
    "startAt" TIMESTAMP(3) NOT NULL,
    "endAt" TIMESTAMP(3),
    "endAfterNumOfCycle" INTEGER,
    "currentCycle" INTEGER,
    "currentCycleStartAt" TIMESTAMP(3),
    "currentCycleEndAt" TIMESTAMP(3),
    "totalClaimedAmount" INTEGER NOT NULL DEFAULT 0,
    "totalNumOfUserClaimed" INTEGER NOT NULL DEFAULT 0,
    "promotionCycleSettingId" TEXT,
    "promotionClaimSettingId" TEXT NOT NULL,
    "promotionLockWithdrawalSettingId" TEXT NOT NULL,
    "promotionForfeitSettingId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),
    "tenantId" TEXT NOT NULL,

    CONSTRAINT "Promotion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionCycleSetting" (
    "id" TEXT NOT NULL,
    "interval" INTEGER NOT NULL,
    "unit" "PromotionCycleUnit" NOT NULL,
    "time" TEXT,
    "day" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PromotionCycleSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionRule" (
    "id" TEXT NOT NULL,
    "type" "PromotionRuleType" NOT NULL,
    "dateFrom" TIMESTAMP(3),
    "dateTo" TIMESTAMP(3),
    "withinLastNumOfDays" INTEGER,
    "amount" INTEGER,
    "values" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "joinPromotionId" TEXT,
    "viewPromotionId" TEXT,
    "claimPromotionId" TEXT,

    CONSTRAINT "PromotionRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionAttachment" (
    "promotionId" TEXT NOT NULL,
    "attachmentId" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "PromotionReward" (
    "id" TEXT NOT NULL,
    "type" "PromotionRewardType" NOT NULL,
    "bonusType" "PromotionRewardBonusType" NOT NULL,
    "conditionValue" INTEGER NOT NULL,
    "bonusValue" INTEGER NOT NULL,
    "minPayoutAmt" INTEGER NOT NULL DEFAULT 0,
    "maxPayoutAmt" INTEGER NOT NULL,
    "targetRounds" INTEGER NOT NULL,
    "promotionId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PromotionReward_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionClaimSetting" (
    "id" TEXT NOT NULL,
    "maxClaimAmount" INTEGER NOT NULL,
    "endPromotionWhenMaxClaimAmountHit" BOOLEAN NOT NULL DEFAULT false,
    "maxNumOfPlayer" INTEGER,
    "endPromotionWhenMaxNumOfPlayerHit" BOOLEAN NOT NULL DEFAULT false,
    "maxClaimPerPlayer" INTEGER,
    "maxClaimPerIp" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PromotionClaimSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionLockWithdrawalSetting" (
    "id" TEXT NOT NULL,
    "type" "PromotionLockWithdrawalType" NOT NULL,
    "unlockOnCompletion" BOOLEAN NOT NULL DEFAULT false,
    "unlockOnPromotionExpire" BOOLEAN NOT NULL DEFAULT false,
    "unlockWhenPlayerBalanceFallsBelow" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PromotionLockWithdrawalSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PromotionForfeitSetting" (
    "id" TEXT NOT NULL,
    "requireApproval" BOOLEAN NOT NULL,
    "minWageringAmount" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PromotionForfeitSetting_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserPromotion" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "promotionId" TEXT NOT NULL,
    "promotionRewardId" TEXT,
    "status" "UserPromotionStatus" NOT NULL,
    "statusChangeAt" TIMESTAMP(3) NOT NULL,
    "ip" TEXT NOT NULL,
    "turnover" INTEGER NOT NULL,
    "targetTurnover" INTEGER NOT NULL,
    "rounds" INTEGER NOT NULL,
    "cycle" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAtDate" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserPromotion_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Fingerprint_timestamp_idx" ON "Fingerprint"("timestamp");

-- CreateIndex
CREATE INDEX "Fingerprint_userId_timestamp_idx" ON "Fingerprint"("userId", "timestamp");

-- CreateIndex
CREATE INDEX "AccessLog_timestamp_idx" ON "AccessLog"("timestamp");

-- CreateIndex
CREATE INDEX "AccessLog_userId_timestamp_idx" ON "AccessLog"("userId", "timestamp");

-- CreateIndex
CREATE INDEX "AlertLog_timestamp_idx" ON "AlertLog"("timestamp");

-- CreateIndex
CREATE INDEX "AlertLog_userId_timestamp_idx" ON "AlertLog"("userId", "timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "Domain_domainUrl_key" ON "Domain"("domainUrl");

-- CreateIndex
CREATE UNIQUE INDEX "Domain_tenantId_isDefault_key" ON "Domain"("tenantId", "isDefault");

-- CreateIndex
CREATE INDEX "AuditLog_timestamp_idx" ON "AuditLog"("timestamp");

-- CreateIndex
CREATE INDEX "AuditLog_userId_timestamp_idx" ON "AuditLog"("userId", "timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_tenantId_key" ON "User"("username", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_tenantId_key" ON "User"("email", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "User_phoneNumber_tenantId_key" ON "User"("phoneNumber", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Tenant_legacyMongoId_key" ON "Tenant"("legacyMongoId");

-- CreateIndex
CREATE UNIQUE INDEX "Game_code_key" ON "Game"("code");

-- CreateIndex
CREATE INDEX "Game_gameProviderId_code_idx" ON "Game"("gameProviderId", "code");

-- CreateIndex
CREATE INDEX "GameSetting_tenantId_gameId_idx" ON "GameSetting"("tenantId", "gameId");

-- CreateIndex
CREATE UNIQUE INDEX "GameSetting_tenantId_gameId_type_key" ON "GameSetting"("tenantId", "gameId", "type");

-- CreateIndex
CREATE INDEX "GameProvider_slug_parentId_idx" ON "GameProvider"("slug", "parentId");

-- CreateIndex
CREATE UNIQUE INDEX "GameProvider_slug_parentId_key" ON "GameProvider"("slug", "parentId");

-- CreateIndex
CREATE INDEX "GameProviderSetting_type_gameProviderId_tenantId_idx" ON "GameProviderSetting"("type", "gameProviderId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "GameProviderSetting_type_gameProviderId_tenantId_key" ON "GameProviderSetting"("type", "gameProviderId", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Credential_isDefault_name_tenantId_key" ON "Credential"("isDefault", "name", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Credential_isEnabledDefault_name_tenantId_key" ON "Credential"("isEnabledDefault", "name", "tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "GameProviderPlayer_userId_foreignUserId_providerType_key" ON "GameProviderPlayer"("userId", "foreignUserId", "providerType");

-- CreateIndex
CREATE UNIQUE INDEX "GameCategorySetting_tenantId_gameCategoryId_type_key" ON "GameCategorySetting"("tenantId", "gameCategoryId", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Bank_code_key" ON "Bank"("code");

-- CreateIndex
CREATE INDEX "Site_tenantId_idx" ON "Site"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Site_tenantId_key" ON "Site"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Page_tenantId_permalink_key" ON "Page"("tenantId", "permalink");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentGateway_providerType_key" ON "PaymentGateway"("providerType");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentGatewaySetting_tenantId_paymentGatewayId_key" ON "PaymentGatewaySetting"("tenantId", "paymentGatewayId");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentGatewayChannel_paymentGatewayId_name_purpose_key" ON "PaymentGatewayChannel"("paymentGatewayId", "name", "purpose");

-- CreateIndex
CREATE UNIQUE INDEX "PaymentGatewayChannelSetting_tenantId_channelId_key" ON "PaymentGatewayChannelSetting"("tenantId", "channelId");

-- CreateIndex
CREATE UNIQUE INDEX "Wallet_userId_currency_purpose_key" ON "Wallet"("userId", "currency", "purpose");

-- CreateIndex
CREATE INDEX "LegacyContent_tenantId_idx" ON "LegacyContent"("tenantId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_rollbackTransactionId_key" ON "Transaction"("rollbackTransactionId");

-- CreateIndex
CREATE UNIQUE INDEX "Transaction_userPromotionId_key" ON "Transaction"("userPromotionId");

-- CreateIndex
CREATE UNIQUE INDEX "UserGroup_userId_groupId_key" ON "UserGroup"("userId", "groupId");

-- CreateIndex
CREATE UNIQUE INDEX "Promotion_promotionCycleSettingId_key" ON "Promotion"("promotionCycleSettingId");

-- CreateIndex
CREATE UNIQUE INDEX "Promotion_promotionClaimSettingId_key" ON "Promotion"("promotionClaimSettingId");

-- CreateIndex
CREATE UNIQUE INDEX "Promotion_promotionLockWithdrawalSettingId_key" ON "Promotion"("promotionLockWithdrawalSettingId");

-- CreateIndex
CREATE UNIQUE INDEX "Promotion_promotionForfeitSettingId_key" ON "Promotion"("promotionForfeitSettingId");

-- CreateIndex
CREATE UNIQUE INDEX "PromotionAttachment_promotionId_attachmentId_key" ON "PromotionAttachment"("promotionId", "attachmentId");

-- AddForeignKey
ALTER TABLE "Fingerprint" ADD CONSTRAINT "Fingerprint_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Fingerprint" ADD CONSTRAINT "Fingerprint_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AccessLog" ADD CONSTRAINT "AccessLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AlertLog" ADD CONSTRAINT "AlertLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Domain" ADD CONSTRAINT "Domain_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Domain" ADD CONSTRAINT "Domain_siteId_fkey" FOREIGN KEY ("siteId") REFERENCES "Site"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AuditLog" ADD CONSTRAINT "AuditLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PhoneOTP" ADD CONSTRAINT "PhoneOTP_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Role" ADD CONSTRAINT "Role_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserKYCMethodResponse" ADD CONSTRAINT "UserKYCMethodResponse_kycMethodId_fkey" FOREIGN KEY ("kycMethodId") REFERENCES "TenantKYCMethod"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserKYCMethodResponse" ADD CONSTRAINT "UserKYCMethodResponse_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TenantKYCMethod" ADD CONSTRAINT "TenantKYCMethod_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Block" ADD CONSTRAINT "Block_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_gameCategoryId_fkey" FOREIGN KEY ("gameCategoryId") REFERENCES "GameCategory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_gameProviderId_fkey" FOREIGN KEY ("gameProviderId") REFERENCES "GameProvider"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Game" ADD CONSTRAINT "Game_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameSetting" ADD CONSTRAINT "GameSetting_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameSetting" ADD CONSTRAINT "GameSetting_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameSetting" ADD CONSTRAINT "GameSetting_thumbnailId_fkey" FOREIGN KEY ("thumbnailId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProvider" ADD CONSTRAINT "GameProvider_slug_parentId_fkey" FOREIGN KEY ("slug", "parentId") REFERENCES "GameProvider"("slug", "parentId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProvider" ADD CONSTRAINT "GameProvider_thumbnailId_fkey" FOREIGN KEY ("thumbnailId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProviderSetting" ADD CONSTRAINT "GameProviderSetting_thumbnailId_fkey" FOREIGN KEY ("thumbnailId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProviderSetting" ADD CONSTRAINT "GameProviderSetting_gameProviderId_fkey" FOREIGN KEY ("gameProviderId") REFERENCES "GameProvider"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProviderSetting" ADD CONSTRAINT "GameProviderSetting_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProviderSetting" ADD CONSTRAINT "GameProviderSetting_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "Credential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Credential" ADD CONSTRAINT "Credential_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Credential" ADD CONSTRAINT "Credential_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameProviderPlayer" ADD CONSTRAINT "GameProviderPlayer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCategory" ADD CONSTRAINT "GameCategory_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCategory" ADD CONSTRAINT "GameCategory_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCategorySetting" ADD CONSTRAINT "GameCategorySetting_gameCategoryId_fkey" FOREIGN KEY ("gameCategoryId") REFERENCES "GameCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCategorySetting" ADD CONSTRAINT "GameCategorySetting_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GameCategorySetting" ADD CONSTRAINT "GameCategorySetting_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Site" ADD CONSTRAINT "Site_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Site" ADD CONSTRAINT "Site_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Page" ADD CONSTRAINT "Page_siteId_fkey" FOREIGN KEY ("siteId") REFERENCES "Site"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_bankId_fkey" FOREIGN KEY ("bankId") REFERENCES "Bank"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewaySetting" ADD CONSTRAINT "PaymentGatewaySetting_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewaySetting" ADD CONSTRAINT "PaymentGatewaySetting_paymentGatewayId_fkey" FOREIGN KEY ("paymentGatewayId") REFERENCES "PaymentGateway"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewaySetting" ADD CONSTRAINT "PaymentGatewaySetting_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "Credential"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewayChannel" ADD CONSTRAINT "PaymentGatewayChannel_paymentGatewayId_fkey" FOREIGN KEY ("paymentGatewayId") REFERENCES "PaymentGateway"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewayChannelSetting" ADD CONSTRAINT "PaymentGatewayChannelSetting_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PaymentGatewayChannelSetting" ADD CONSTRAINT "PaymentGatewayChannelSetting_channelId_fkey" FOREIGN KEY ("channelId") REFERENCES "PaymentGatewayChannel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wallet" ADD CONSTRAINT "Wallet_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LegacyContent" ADD CONSTRAINT "LegacyContent_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LegacyContent" ADD CONSTRAINT "LegacyContent_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_paymentGatewayChannelId_fkey" FOREIGN KEY ("paymentGatewayChannelId") REFERENCES "PaymentGatewayChannel"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_paymentGateWayId_fkey" FOREIGN KEY ("paymentGateWayId") REFERENCES "PaymentGateway"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_rollbackTransactionId_fkey" FOREIGN KEY ("rollbackTransactionId") REFERENCES "Transaction"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES "Wallet"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_credentialId_fkey" FOREIGN KEY ("credentialId") REFERENCES "Credential"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_userPromotionId_fkey" FOREIGN KEY ("userPromotionId") REFERENCES "UserPromotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "Promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_gameProviderId_fkey" FOREIGN KEY ("gameProviderId") REFERENCES "GameProvider"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_gameSettingId_fkey" FOREIGN KEY ("gameSettingId") REFERENCES "GameSetting"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_gameProviderSettingId_fkey" FOREIGN KEY ("gameProviderSettingId") REFERENCES "GameProviderSetting"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Maintenance" ADD CONSTRAINT "Maintenance_gameCategorySettingId_fkey" FOREIGN KEY ("gameCategorySettingId") REFERENCES "GameCategorySetting"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerFavourite" ADD CONSTRAINT "PlayerFavourite_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerFavourite" ADD CONSTRAINT "PlayerFavourite_gameProviderPlayerId_fkey" FOREIGN KEY ("gameProviderPlayerId") REFERENCES "GameProviderPlayer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Group" ADD CONSTRAINT "Group_promotionRewardId_fkey" FOREIGN KEY ("promotionRewardId") REFERENCES "PromotionReward"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGroup" ADD CONSTRAINT "UserGroup_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGroup" ADD CONSTRAINT "UserGroup_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "File"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_promotionCycleSettingId_fkey" FOREIGN KEY ("promotionCycleSettingId") REFERENCES "PromotionCycleSetting"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_promotionClaimSettingId_fkey" FOREIGN KEY ("promotionClaimSettingId") REFERENCES "PromotionClaimSetting"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_promotionLockWithdrawalSettingId_fkey" FOREIGN KEY ("promotionLockWithdrawalSettingId") REFERENCES "PromotionLockWithdrawalSetting"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_promotionForfeitSettingId_fkey" FOREIGN KEY ("promotionForfeitSettingId") REFERENCES "PromotionForfeitSetting"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Promotion" ADD CONSTRAINT "Promotion_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES "Tenant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionRule" ADD CONSTRAINT "PromotionRule_joinPromotionId_fkey" FOREIGN KEY ("joinPromotionId") REFERENCES "Promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionRule" ADD CONSTRAINT "PromotionRule_viewPromotionId_fkey" FOREIGN KEY ("viewPromotionId") REFERENCES "Promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionRule" ADD CONSTRAINT "PromotionRule_claimPromotionId_fkey" FOREIGN KEY ("claimPromotionId") REFERENCES "Promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionAttachment" ADD CONSTRAINT "PromotionAttachment_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "Promotion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionAttachment" ADD CONSTRAINT "PromotionAttachment_attachmentId_fkey" FOREIGN KEY ("attachmentId") REFERENCES "File"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PromotionReward" ADD CONSTRAINT "PromotionReward_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "Promotion"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPromotion" ADD CONSTRAINT "UserPromotion_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPromotion" ADD CONSTRAINT "UserPromotion_promotionId_fkey" FOREIGN KEY ("promotionId") REFERENCES "Promotion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPromotion" ADD CONSTRAINT "UserPromotion_promotionRewardId_fkey" FOREIGN KEY ("promotionRewardId") REFERENCES "PromotionReward"("id") ON DELETE SET NULL ON UPDATE CASCADE;
