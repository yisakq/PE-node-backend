-- AlterTable
ALTER TABLE "Criteria" ALTER COLUMN "criUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Department" ALTER COLUMN "deptUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Division" ALTER COLUMN "divisionUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "EmployeeRegistration" ALTER COLUMN "empUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Position" ALTER COLUMN "positionUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Questionary" ALTER COLUMN "queUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "RatingLevelHistory" ALTER COLUMN "rlUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;
