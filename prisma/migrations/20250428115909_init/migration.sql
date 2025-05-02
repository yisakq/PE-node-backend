/*
  Warnings:

  - The values [Regional_AA,District] on the enum `Region` will be removed. If these variants are still used in the database, this will fail.
  - The `criRegion` column on the `CriteriaCategory` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Region_new" AS ENUM ('All', 'Central_AA', 'Eastern_AA', 'Western_AA', 'Southern_AA', 'Northern_AA');
ALTER TABLE "EmployeeRegistration" ALTER COLUMN "empRegion" TYPE "Region_new" USING ("empRegion"::text::"Region_new");
ALTER TABLE "CriteriaCategory" ALTER COLUMN "criRegion" TYPE "Region_new" USING ("criRegion"::text::"Region_new");
ALTER TABLE "City" ALTER COLUMN "cityRegion" TYPE "Region_new" USING ("cityRegion"::text::"Region_new");
ALTER TYPE "Region" RENAME TO "Region_old";
ALTER TYPE "Region_new" RENAME TO "Region";
DROP TYPE "Region_old";
COMMIT;

-- AlterTable
ALTER TABLE "City" ADD COLUMN     "cityRegion" "Region",
ALTER COLUMN "cityDistrict" DROP NOT NULL;

-- AlterTable
ALTER TABLE "CriteriaCategory" DROP COLUMN "criRegion",
ADD COLUMN     "criRegion" "Region";

-- DropEnum
DROP TYPE "Regional_AA";
