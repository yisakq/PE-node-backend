-- DropForeignKey
ALTER TABLE "UserAccount" DROP CONSTRAINT "UserAccount_empId_fkey";

-- AlterTable
ALTER TABLE "UserAccount" ALTER COLUMN "empId" DROP NOT NULL,
ALTER COLUMN "usrAccUpdatedBy" DROP NOT NULL,
ALTER COLUMN "updatedAt" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "UserAccount" ADD CONSTRAINT "UserAccount_empId_fkey" FOREIGN KEY ("empId") REFERENCES "EmployeeRegistration"("empId") ON DELETE SET NULL ON UPDATE CASCADE;
