/*
  Warnings:

  - Changed the type of `empGender` on the `EmployeeRegistration` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('Male', 'Female');

-- AlterTable
ALTER TABLE "EmployeeRegistration" DROP COLUMN "empGender",
ADD COLUMN     "empGender" "Gender" NOT NULL;

-- DropEnum
DROP TYPE "Visibility";
