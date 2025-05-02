/*
  Warnings:

  - The values [SUPERADMIN,ADMIN,USER] on the enum `UserPrivilege` will be removed. If these variants are still used in the database, this will fail.

*/
-- CreateEnum
CREATE TYPE "Approval" AS ENUM ('Agree', 'Disagree');

-- CreateEnum
CREATE TYPE "Visibility" AS ENUM ('Hide', 'Show');

-- AlterEnum
BEGIN;
CREATE TYPE "UserPrivilege_new" AS ENUM ('SuperAdmin', 'Admin', 'User');
ALTER TABLE "UserAccount" ALTER COLUMN "usrAccPrivilege" TYPE "UserPrivilege_new" USING ("usrAccPrivilege"::text::"UserPrivilege_new");
ALTER TYPE "UserPrivilege" RENAME TO "UserPrivilege_old";
ALTER TYPE "UserPrivilege_new" RENAME TO "UserPrivilege";
DROP TYPE "UserPrivilege_old";
COMMIT;

-- CreateTable
CREATE TABLE "EmployeeEvaluation" (
    "evaluationId" SERIAL NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionId" INTEGER NOT NULL,
    "positionId" INTEGER NOT NULL,
    "evaluatorId" INTEGER NOT NULL,
    "evaluatorPositionId" INTEGER NOT NULL,
    "evaluationPeriodFrom" TIMESTAMP(3) NOT NULL,
    "evaluationPeriodTo" TIMESTAMP(3) NOT NULL,
    "totalScore" DECIMAL(65,30) NOT NULL,
    "totalPercentage" DECIMAL(65,30) NOT NULL,
    "ratingLevel" DECIMAL(65,30) NOT NULL,
    "empComment" TEXT,
    "employeeApproval" "Approval",
    "empApprovedAt" TIMESTAMP(3),
    "supervisorApproval" "Approval",
    "supervisorApprovedAt" TIMESTAMP(3),
    "nextHigherApproval" "Approval",
    "nextHigherApprovedAt" TIMESTAMP(3),
    "hrComment" TEXT,
    "hrApproval" "Approval",
    "hrApprovedAt" TIMESTAMP(3),

    CONSTRAINT "EmployeeEvaluation_pkey" PRIMARY KEY ("evaluationId")
);

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_deptId_fkey" FOREIGN KEY ("deptId") REFERENCES "Department"("deptId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_divisionId_fkey" FOREIGN KEY ("divisionId") REFERENCES "Division"("divisionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("positionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_evaluatorPositionId_fkey" FOREIGN KEY ("evaluatorPositionId") REFERENCES "Position"("positionId") ON DELETE RESTRICT ON UPDATE CASCADE;
