const express = require("express");
const {getDivision, createDivision, updateDivision} = require("../controllers/division");
const authMiddleware = require("../middlewares/authMiddleware");
const roleMiddleware = require("../middlewares/rolesMiddleware");

const divisionRoutes = express.Router();

divisionRoutes.get('/view', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getDivision);
divisionRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createDivision);
divisionRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateDivision);

module.exports = divisionRoutes;

