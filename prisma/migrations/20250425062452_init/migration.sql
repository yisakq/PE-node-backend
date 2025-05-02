/*
  Warnings:

  - You are about to drop the column `cityId` on the `CriteriaCategory` table. All the data in the column will be lost.
  - You are about to drop the `_CityToEmployeeRegistration` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "CriteriaCategory" DROP CONSTRAINT "CriteriaCategory_cityId_fkey";

-- DropForeignKey
ALTER TABLE "_CityToEmployeeRegistration" DROP CONSTRAINT "_CityToEmployeeRegistration_A_fkey";

-- DropForeignKey
ALTER TABLE "_CityToEmployeeRegistration" DROP CONSTRAINT "_CityToEmployeeRegistration_B_fkey";

-- AlterTable
ALTER TABLE "Criteria" ALTER COLUMN "criIsActive" SET DEFAULT true;

-- AlterTable
ALTER TABLE "CriteriaCategory" DROP COLUMN "cityId",
ADD COLUMN     "cityCityId" INTEGER,
ADD COLUMN     "criDistrict" "District";

-- AlterTable
ALTER TABLE "Department" ALTER COLUMN "deptIsActive" SET DEFAULT true;

-- AlterTable
ALTER TABLE "Division" ALTER COLUMN "divisionIsActive" SET DEFAULT true;

-- AlterTable
ALTER TABLE "EmployeeRegistration" ADD COLUMN     "cityId" INTEGER,
ALTER COLUMN "empIsActive" SET DEFAULT true,
ALTER COLUMN "empDistrict" DROP NOT NULL,
ALTER COLUMN "empRegion" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Position" ALTER COLUMN "positionIsActive" SET DEFAULT true;

-- AlterTable
ALTER TABLE "Questionary" ALTER COLUMN "queIsActive" SET DEFAULT true;

-- AlterTable
ALTER TABLE "UserAccount" ALTER COLUMN "usrAccPassword" DROP NOT NULL,
ALTER COLUMN "usrAccIsActive" SET DEFAULT true;

-- DropTable
DROP TABLE "_CityToEmployeeRegistration";

-- AddForeignKey
ALTER TABLE "EmployeeRegistration" ADD CONSTRAINT "EmployeeRegistration_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("cityId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_cityCityId_fkey" FOREIGN KEY ("cityCityId") REFERENCES "City"("cityId") ON DELETE SET NULL ON UPDATE CASCADE;
