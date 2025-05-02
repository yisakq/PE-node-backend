-- CreateEnum
CREATE TYPE "UserPrivilege" AS ENUM ('SUPERADMIN', 'ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "AbleToEdit" AS ENUM ('FormSent', 'FormProcessed');

-- CreateTable
CREATE TABLE "Department" (
    "deptId" SERIAL NOT NULL,
    "deptName" TEXT NOT NULL,
    "deptIsActive" BOOLEAN NOT NULL,
    "deptRemark" TEXT,
    "deptCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deptUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Department_pkey" PRIMARY KEY ("deptId")
);

-- CreateTable
CREATE TABLE "Division" (
    "divisionId" SERIAL NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionName" TEXT NOT NULL,
    "divisionIsActive" BOOLEAN NOT NULL,
    "divisionRemark" TEXT,
    "divisionCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "divisionUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Division_pkey" PRIMARY KEY ("divisionId")
);

-- CreateTable
CREATE TABLE "Position" (
    "positionId" SERIAL NOT NULL,
    "divisionId" INTEGER NOT NULL,
    "positionName" TEXT NOT NULL,
    "positionIsActive" BOOLEAN NOT NULL,
    "positionRemark" TEXT,
    "positionCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "positionUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Position_pkey" PRIMARY KEY ("positionId")
);

-- CreateTable
CREATE TABLE "UserAccount" (
    "usrAccId" SERIAL NOT NULL,
    "empId" INTEGER NOT NULL,
    "usrAccEmail" TEXT NOT NULL,
    "usrAccPassword" TEXT NOT NULL,
    "usrAccPrivilege" "UserPrivilege" NOT NULL,
    "usrAccIsActive" BOOLEAN NOT NULL,
    "usrAccCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usrAccUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserAccount_pkey" PRIMARY KEY ("usrAccId")
);

-- CreateTable
CREATE TABLE "EmployeeRegistration" (
    "empId" SERIAL NOT NULL,
    "empUniqueId" INTEGER NOT NULL,
    "empFName" TEXT NOT NULL,
    "empMName" TEXT NOT NULL,
    "empLname" TEXT NOT NULL,
    "empGender" TEXT NOT NULL,
    "empMobileNo" INTEGER NOT NULL,
    "empEmail" TEXT NOT NULL,
    "empLocation" TEXT NOT NULL,
    "empGrade" INTEGER NOT NULL,
    "empLevel" INTEGER NOT NULL,
    "positionId" INTEGER NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionId" INTEGER NOT NULL,
    "empIsActive" BOOLEAN NOT NULL,
    "dateOfEmployment" TIMESTAMP(3) NOT NULL,
    "empCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "empUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EmployeeRegistration_pkey" PRIMARY KEY ("empId")
);

-- CreateTable
CREATE TABLE "CriteriaCategory" (
    "criCategoryId" SERIAL NOT NULL,
    "criYear" TIMESTAMP(3) NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionId" INTEGER,
    "positionId" INTEGER,
    "criAbleToEdit" "AbleToEdit" NOT NULL,
    "criCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CriteriaCategory_pkey" PRIMARY KEY ("criCategoryId")
);

-- CreateTable
CREATE TABLE "Criteria" (
    "criId" SERIAL NOT NULL,
    "criCategoryId" INTEGER NOT NULL,
    "criQuestion" TEXT NOT NULL,
    "criWeight" DECIMAL(65,30) NOT NULL,
    "criIsActive" BOOLEAN NOT NULL,
    "criUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Criteria_pkey" PRIMARY KEY ("criId")
);

-- CreateTable
CREATE TABLE "Questionary" (
    "questionaryId" SERIAL NOT NULL,
    "question" TEXT NOT NULL,
    "queIsActive" BOOLEAN NOT NULL,
    "queCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "queUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Questionary_pkey" PRIMARY KEY ("questionaryId")
);

-- CreateTable
CREATE TABLE "CriteriaResponse" (
    "CriResponseId" SERIAL NOT NULL,
    "criCategoryId" INTEGER NOT NULL,
    "evaluationId" INTEGER NOT NULL,
    "criEvaluationRate" DECIMAL(65,30) NOT NULL,
    "criWeightScore" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "CriteriaResponse_pkey" PRIMARY KEY ("CriResponseId")
);

-- CreateTable
CREATE TABLE "QuestionaryResponse" (
    "queResponseId" SERIAL NOT NULL,
    "evaluationId" INTEGER NOT NULL,
    "questionaryId" INTEGER NOT NULL,
    "questionaryResponse" TEXT NOT NULL,

    CONSTRAINT "QuestionaryResponse_pkey" PRIMARY KEY ("queResponseId")
);

-- CreateTable
CREATE TABLE "RatingLevel" (
    "rlId" SERIAL NOT NULL,
    "rlYear" TIMESTAMP(3) NOT NULL,
    "rlRemarks" TEXT,
    "rlCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "rlAbleToEdit" "AbleToEdit" NOT NULL,

    CONSTRAINT "RatingLevel_pkey" PRIMARY KEY ("rlId")
);

-- CreateTable
CREATE TABLE "RatingLevelHistory" (
    "rlHistoryId" SERIAL NOT NULL,
    "rlId" INTEGER NOT NULL,
    "rlName" TEXT NOT NULL,
    "rlPResult" TEXT NOT NULL,
    "rlWScore" TEXT NOT NULL,
    "rlRemarks" TEXT NOT NULL,
    "rlUpdatedBy" INTEGER NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RatingLevelHistory_pkey" PRIMARY KEY ("rlHistoryId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Department_deptName_key" ON "Department"("deptName");

-- CreateIndex
CREATE UNIQUE INDEX "Division_divisionName_key" ON "Division"("divisionName");

-- CreateIndex
CREATE UNIQUE INDEX "Position_positionName_key" ON "Position"("positionName");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccount_empId_key" ON "UserAccount"("empId");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccount_usrAccEmail_key" ON "UserAccount"("usrAccEmail");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeRegistration_empEmail_key" ON "EmployeeRegistration"("empEmail");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeRegistration_positionId_key" ON "EmployeeRegistration"("positionId");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeRegistration_deptId_key" ON "EmployeeRegistration"("deptId");

-- CreateIndex
CREATE UNIQUE INDEX "EmployeeRegistration_divisionId_key" ON "EmployeeRegistration"("divisionId");

-- CreateIndex
CREATE UNIQUE INDEX "CriteriaResponse_criCategoryId_key" ON "CriteriaResponse"("criCategoryId");

-- CreateIndex
CREATE UNIQUE INDEX "QuestionaryResponse_questionaryId_key" ON "QuestionaryResponse"("questionaryId");

-- AddForeignKey
ALTER TABLE "Division" ADD CONSTRAINT "Division_deptId_fkey" FOREIGN KEY ("deptId") REFERENCES "Department"("deptId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_divisionId_fkey" FOREIGN KEY ("divisionId") REFERENCES "Division"("divisionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAccount" ADD CONSTRAINT "UserAccount_empId_fkey" FOREIGN KEY ("empId") REFERENCES "EmployeeRegistration"("empId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRegistration" ADD CONSTRAINT "EmployeeRegistration_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("positionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRegistration" ADD CONSTRAINT "EmployeeRegistration_deptId_fkey" FOREIGN KEY ("deptId") REFERENCES "Department"("deptId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRegistration" ADD CONSTRAINT "EmployeeRegistration_divisionId_fkey" FOREIGN KEY ("divisionId") REFERENCES "Division"("divisionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_deptId_fkey" FOREIGN KEY ("deptId") REFERENCES "Department"("deptId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_divisionId_fkey" FOREIGN KEY ("divisionId") REFERENCES "Division"("divisionId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_positionId_fkey" FOREIGN KEY ("positionId") REFERENCES "Position"("positionId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Criteria" ADD CONSTRAINT "Criteria_criCategoryId_fkey" FOREIGN KEY ("criCategoryId") REFERENCES "CriteriaCategory"("criCategoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaResponse" ADD CONSTRAINT "CriteriaResponse_criCategoryId_fkey" FOREIGN KEY ("criCategoryId") REFERENCES "CriteriaCategory"("criCategoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionaryResponse" ADD CONSTRAINT "QuestionaryResponse_questionaryId_fkey" FOREIGN KEY ("questionaryId") REFERENCES "Questionary"("questionaryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RatingLevelHistory" ADD CONSTRAINT "RatingLevelHistory_rlId_fkey" FOREIGN KEY ("rlId") REFERENCES "RatingLevel"("rlId") ON DELETE RESTRICT ON UPDATE CASCADE;
