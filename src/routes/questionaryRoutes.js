const express = require("express");
const { getQuestionary, createQuestionary, updateQuestionary } = require("../controllers/questionary");
const authMiddleware = require("../middlewares/authMiddleware");
const roleMiddleware = require("../middlewares/rolesMiddleware");

const questionaryRoutes = express.Router();

questionaryRoutes.get('/view', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getQuestionary);
questionaryRoutes.post("/", authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createQuestionary);
questionaryRoutes.put("/:questionaryId", authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateQuestionary);

module.exports = questionaryRoutes;