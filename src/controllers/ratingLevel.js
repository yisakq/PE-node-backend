const prisma = require("../prismaclient");

const getRatingLevel = async (req, res) => {
    try {
        const ratingLevels = await prisma.ratingLevel.findMany({
            include: {
                ratingLevelHistory: true
            }
        });
        res.status(200).json(ratingLevels);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const createRatingLevel = async (req, res) => {
    try {
        const { rlYear, rlRemarks, ratingLevelHistory } = req.body;

        const newRatingLevel = await prisma.ratingLevel.create({
            data: {
                rlYear: new Date(rlYear),
                rlRemarks,
                rlAbleToEdit: "FormCreated",
                rlCreatedBy: req.user.userId,

                ratingLevelHistory: {
                    create: ratingLevelHistory.map((rlh) => ({
                        rlId: rlh.rlId,
                        rlName: rlh.rlName,
                        rlPResultMin: rlh.rlPResultMin,
                        rlPResultMax: rlh.rlPResultMax,
                        rlWScoreMin: rlh.rlWScoreMin,
                        rlWScoreMax: rlh.rlWScoreMax,
                        rlRemarks: rlh.rlRemarks,
                    }))
                }
            },
            include: {
                ratingLevelHistory: true
            }
        });
        res.status(201).json(newRatingLevel);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const updateRatingLevel = async (req, res) => {
    try {
        const { rlId, ratingLevelHistory } = req.body;

        // First get the existing rating level to check its status
        const existingRatingLevel = await prisma.ratingLevel.findUnique({
            where: { rlId: parseInt(rlId) },
            include: { ratingLevelHistory: true }
        });

        // If rating level is in FormCreated state, only allow rating level history updates
        if (existingRatingLevel.rlAbleToEdit === "FormCreated") {
            const updatedRatingLevel = await prisma.ratingLevel.update({
                where: { rlId: parseInt(rlId) },
                data: {
                    ratingLevelHistory: {
                        update: ratingLevelHistory.map((rlh) => ({
                            where: { rlhId: rlh.rlhId },
                            data: {
                                rlName: rlh.rlName,
                                rlPResultMin: rlh.rlPResultMin,
                                rlPResultMax: rlh.rlPResultMax,
                                rlWScoreMin: rlh.rlWScoreMin,
                                rlWScoreMax: rlh.rlWScoreMax,
                                rlRemarks: rlh.rlRemarks,
                                rlUpdatedBy: req.user.userId,
                            },
                        })),
                    },
                },
                include: {
                    ratingLevelHistory: true
                }
            });
            return res.status(200).json(updatedRatingLevel);
        }

      return res.status(400).json({ error: "Rating level is not in editable state" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

module.exports = { getRatingLevel, createRatingLevel, updateRatingLevel };
