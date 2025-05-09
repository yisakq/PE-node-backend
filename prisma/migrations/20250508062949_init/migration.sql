-- CreateEnum
CREATE TYPE "UserPrivilege" AS ENUM ('SuperAdmin', 'SystemAdmin', 'Admin', 'User');

-- CreateEnum
CREATE TYPE "AbleToEdit" AS ENUM ('FormSent', 'FormCreated');

-- CreateEnum
CREATE TYPE "Approval" AS ENUM ('Agree', 'Disagree');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('Male', 'Female');

-- CreateEnum
CREATE TYPE "Region" AS ENUM ('All', 'Central_AA', 'Eastern_AA', 'Western_AA', 'Southern_AA', 'Northern_AA');

-- CreateEnum
CREATE TYPE "District" AS ENUM ('Western_District', 'Eastern_District', 'Southern_District', 'Northern_District');

-- CreateTable
CREATE TABLE "Department" (
    "deptId" SERIAL NOT NULL,
    "deptName" TEXT NOT NULL,
    "deptAbbreviation" TEXT,
    "deptIsActive" BOOLEAN NOT NULL DEFAULT true,
    "deptRemark" TEXT,
    "deptCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deptUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Department_pkey" PRIMARY KEY ("deptId")
);

-- CreateTable
CREATE TABLE "Division" (
    "divisionId" SERIAL NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionName" TEXT NOT NULL,
    "divisionAbbreviation" TEXT,
    "divisionIsActive" BOOLEAN NOT NULL DEFAULT true,
    "divisionRemark" TEXT,
    "divisionCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "divisionUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Division_pkey" PRIMARY KEY ("divisionId")
);

-- CreateTable
CREATE TABLE "Position" (
    "positionId" SERIAL NOT NULL,
    "divisionId" INTEGER NOT NULL,
    "positionName" TEXT NOT NULL,
    "positionIsActive" BOOLEAN NOT NULL DEFAULT true,
    "positionRemark" TEXT,
    "positionCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "positionUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Position_pkey" PRIMARY KEY ("positionId")
);

-- CreateTable
CREATE TABLE "UserAccount" (
    "usrAccId" SERIAL NOT NULL,
    "empId" INTEGER,
    "usrAccEmail" TEXT NOT NULL,
    "usrAccPassword" TEXT,
    "usrAccPrivilege" "UserPrivilege" NOT NULL,
    "usrAccIsActive" BOOLEAN NOT NULL DEFAULT true,
    "usrAccCreatedBy" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usrAccUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "UserAccount_pkey" PRIMARY KEY ("usrAccId")
);

-- CreateTable
CREATE TABLE "EmployeeRegistration" (
    "empId" SERIAL NOT NULL,
    "empUniqueId" INTEGER NOT NULL,
    "empFName" TEXT NOT NULL,
    "empMName" TEXT NOT NULL,
    "empLname" TEXT NOT NULL,
    "empGender" "Gender" NOT NULL,
    "empMobileNo" INTEGER NOT NULL,
    "empEmail" TEXT NOT NULL,
    "empLocation" TEXT NOT NULL,
    "empRegion" "Region",
    "empDistrict" "District",
    "cityId" INTEGER,
    "empGrade" INTEGER NOT NULL,
    "empLevel" INTEGER NOT NULL,
    "positionId" INTEGER NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionId" INTEGER NOT NULL,
    "empIsActive" BOOLEAN NOT NULL DEFAULT true,
    "dateOfEmployment" TIMESTAMP(3) NOT NULL,
    "empCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "empUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "EmployeeRegistration_pkey" PRIMARY KEY ("empId")
);

-- CreateTable
CREATE TABLE "CriteriaCategory" (
    "criCategoryId" SERIAL NOT NULL,
    "criYear" TIMESTAMP(3) NOT NULL,
    "deptId" INTEGER NOT NULL,
    "divisionId" INTEGER,
    "positionId" INTEGER,
    "criRegion" "Region",
    "criDistrict" "District",
    "criAbleToEdit" "AbleToEdit" NOT NULL,
    "criCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cityCityId" INTEGER,

    CONSTRAINT "CriteriaCategory_pkey" PRIMARY KEY ("criCategoryId")
);

-- CreateTable
CREATE TABLE "Criteria" (
    "criId" SERIAL NOT NULL,
    "criCategoryId" INTEGER NOT NULL,
    "criQuestion" TEXT NOT NULL,
    "criWeight" DECIMAL(65,30) NOT NULL,
    "criIsActive" BOOLEAN NOT NULL DEFAULT true,
    "criUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Criteria_pkey" PRIMARY KEY ("criId")
);

-- CreateTable
CREATE TABLE "Questionary" (
    "questionaryId" SERIAL NOT NULL,
    "question" TEXT NOT NULL,
    "queIsActive" BOOLEAN NOT NULL DEFAULT true,
    "queCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "queUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Questionary_pkey" PRIMARY KEY ("questionaryId")
);

-- CreateTable
CREATE TABLE "EmployeeEvaluation" (
    "evaluationId" SERIAL NOT NULL,
    "evaluatorId" INTEGER NOT NULL,
    "evaluateeId" INTEGER NOT NULL,
    "evaluationPeriodFrom" TIMESTAMP(3) NOT NULL,
    "evaluationPeriodTo" TIMESTAMP(3) NOT NULL,
    "totalScore" DECIMAL(65,30) NOT NULL,
    "totalPercentage" DECIMAL(65,30) NOT NULL,
    "rateLevel" TEXT NOT NULL,
    "rateRemark" TEXT NOT NULL,
    "empComment" TEXT,
    "hrComment" TEXT,
    "hrApproval" "Approval",
    "hrApprovedAt" TIMESTAMP(3),
    "finalizedByEvaluator" BOOLEAN NOT NULL DEFAULT false,
    "evaluateeAccepted" BOOLEAN,
    "sentWithoutFinalization" BOOLEAN,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "hrUpdatedBy" INTEGER,
    "hrUpatedAt" TIMESTAMP(3),

    CONSTRAINT "EmployeeEvaluation_pkey" PRIMARY KEY ("evaluationId")
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
    "rlPResultMin" DECIMAL(65,30) NOT NULL,
    "rlPResultMax" DECIMAL(65,30) NOT NULL,
    "rlWScoreMin" DECIMAL(65,30) NOT NULL,
    "rlWScoreMax" DECIMAL(65,30) NOT NULL,
    "rlRemarks" TEXT NOT NULL,
    "rlUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "RatingLevelHistory_pkey" PRIMARY KEY ("rlHistoryId")
);

-- CreateTable
CREATE TABLE "City" (
    "cityId" SERIAL NOT NULL,
    "cityName" TEXT NOT NULL,
    "cityRegion" "Region",
    "cityDistrict" "District",
    "cityIsActive" BOOLEAN NOT NULL DEFAULT true,
    "cityCreatedBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "cityUpdatedBy" INTEGER,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "City_pkey" PRIMARY KEY ("cityId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Department_deptName_key" ON "Department"("deptName");

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

-- CreateIndex
CREATE UNIQUE INDEX "City_cityName_key" ON "City"("cityName");

-- AddForeignKey
ALTER TABLE "Division" ADD CONSTRAINT "Division_deptId_fkey" FOREIGN KEY ("deptId") REFERENCES "Department"("deptId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_divisionId_fkey" FOREIGN KEY ("divisionId") REFERENCES "Division"("divisionId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAccount" ADD CONSTRAINT "UserAccount_empId_fkey" FOREIGN KEY ("empId") REFERENCES "EmployeeRegistration"("empId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeRegistration" ADD CONSTRAINT "EmployeeRegistration_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES "City"("cityId") ON DELETE SET NULL ON UPDATE CASCADE;

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
ALTER TABLE "CriteriaCategory" ADD CONSTRAINT "CriteriaCategory_cityCityId_fkey" FOREIGN KEY ("cityCityId") REFERENCES "City"("cityId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Criteria" ADD CONSTRAINT "Criteria_criCategoryId_fkey" FOREIGN KEY ("criCategoryId") REFERENCES "CriteriaCategory"("criCategoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_evaluatorId_fkey" FOREIGN KEY ("evaluatorId") REFERENCES "EmployeeRegistration"("empId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmployeeEvaluation" ADD CONSTRAINT "EmployeeEvaluation_evaluateeId_fkey" FOREIGN KEY ("evaluateeId") REFERENCES "EmployeeRegistration"("empId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CriteriaResponse" ADD CONSTRAINT "CriteriaResponse_criCategoryId_fkey" FOREIGN KEY ("criCategoryId") REFERENCES "CriteriaCategory"("criCategoryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QuestionaryResponse" ADD CONSTRAINT "QuestionaryResponse_questionaryId_fkey" FOREIGN KEY ("questionaryId") REFERENCES "Questionary"("questionaryId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RatingLevelHistory" ADD CONSTRAINT "RatingLevelHistory_rlId_fkey" FOREIGN KEY ("rlId") REFERENCES "RatingLevel"("rlId") ON DELETE RESTRICT ON UPDATE CASCADE;
