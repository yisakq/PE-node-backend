/*
  Warnings:

  - The values [FormProcessed] on the enum `AbleToEdit` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "AbleToEdit_new" AS ENUM ('FormSent', 'FormCreated');
ALTER TABLE "CriteriaCategory" ALTER COLUMN "criAbleToEdit" TYPE "AbleToEdit_new" USING ("criAbleToEdit"::text::"AbleToEdit_new");
ALTER TABLE "RatingLevel" ALTER COLUMN "rlAbleToEdit" TYPE "AbleToEdit_new" USING ("rlAbleToEdit"::text::"AbleToEdit_new");
ALTER TYPE "AbleToEdit" RENAME TO "AbleToEdit_old";
ALTER TYPE "AbleToEdit_new" RENAME TO "AbleToEdit";
DROP TYPE "AbleToEdit_old";
COMMIT;
