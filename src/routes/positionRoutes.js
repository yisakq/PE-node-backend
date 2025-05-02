const express = require("express");
const {getPosition, createPosition, updatePosition} = require("../controllers/position");
const authMiddleware = require("../middlewares/authMiddleware");
const roleMiddleware = require("../middlewares/rolesMiddleware");

const positionRoutes = express.Router();

positionRoutes.get('/view', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getPosition);
positionRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createPosition);
positionRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updatePosition);

module.exports = positionRoutes;

