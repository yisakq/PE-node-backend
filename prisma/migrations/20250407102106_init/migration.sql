/*
  Warnings:

  - You are about to drop the column `rlPResult` on the `RatingLevelHistory` table. All the data in the column will be lost.
  - You are about to drop the column `rlWScore` on the `RatingLevelHistory` table. All the data in the column will be lost.
  - Added the required column `rlPResultMax` to the `RatingLevelHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rlPResultMin` to the `RatingLevelHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rlWScoreMax` to the `RatingLevelHistory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `rlWScoreMin` to the `RatingLevelHistory` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "RatingLevelHistory" DROP COLUMN "rlPResult",
DROP COLUMN "rlWScore",
ADD COLUMN     "rlPResultMax" DECIMAL(65,30) NOT NULL,
ADD COLUMN     "rlPResultMin" DECIMAL(65,30) NOT NULL,
ADD COLUMN     "rlWScoreMax" DECIMAL(65,30) NOT NULL,
ADD COLUMN     "rlWScoreMin" DECIMAL(65,30) NOT NULL;
