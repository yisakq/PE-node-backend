/*
  Warnings:

  - Added the required column `empDistrict` to the `EmployeeRegistration` table without a default value. This is not possible if the table is not empty.
  - Added the required column `empRegion` to the `EmployeeRegistration` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Region" AS ENUM ('Regional_AA', 'District');

-- CreateEnum
CREATE TYPE "Regional_AA" AS ENUM ('Central_AA', 'Eastern_AA', 'Western_AA', 'Southern_AA', 'Northern_AA');

-- CreateEnum
CREATE TYPE "District" AS ENUM ('Western_District', 'Eastern_District', 'Southern_District', 'Northern_District');

-- AlterTable
ALTER TABLE "CriteriaCategory" ADD COLUMN     "cityId" INTEGER,
ADD COLUMN     "criRegion" "Regional_AA";

-- AlterTable
ALTER TABLE "EmployeeRegistration" ADD COLUMN     "empDistrict" "District" NOT NULL,
ADD COLUMN     "empRegion" "Region" NOT NULL;

-- CreateTable
CREATE TABLE "City" (
    "cityId" SERIAL NOT NULL,
    "cityName" TEXT NOT NULL,
    "cityDistrict" "District" NOT NULL,
    "cityIsActive" BOOLEAN NOT NULL,
    "cityCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cityUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "City_pkey" PRIMARY KEY ("cityId")
);

-- CreateTable
CREATE TABLE "_CityToEmployeeRegistration" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_CityToEmployeeRegistration_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE UNIQUE INDEX "City_cityName_key" ON "City"("cityName");

-- CreateIndex
CREATE INDEX "_CityToEmployeeRegistration_B_index" ON "_CityToEmployeeRegistration"("B");

-- AddForeignKey
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("cityId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CityToEmployeeRegistration" ADD CONSTRAINT "_CityToEmployeeRegistration_A_fkey" FOREIGN KEY ("A") REFERENCES "City"("cityId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CityToEmployeeRegistration" ADD CONSTRAINT "_CityToEmployeeRegistration_B_fkey" FOREIGN KEY ("B") REFERENCES "EmployeeRegistration"("empId") ON DELETE CASCADE ON UPDATE CASCADE;
