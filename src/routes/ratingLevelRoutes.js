const express = require("express");
const { getRatingLevel, createRatingLevel, updateRatingLevel } = require("../controllers/ratingLevel");
const authMiddleware = require("../middlewares/authMiddleware");
const roleMiddleware = require("../middlewares/rolesMiddleware");

const ratingLevelRoutes = express.Router();

ratingLevelRoutes.get('/view', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getRatingLevel);
ratingLevelRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createRatingLevel);
ratingLevelRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateRatingLevel);

module.exports = ratingLevelRoutes;

