const express = require("express");
const {getCriteria, createCriteriaCategory, updateCriteriaCategory} = require("../controllers/criteria");
const authMiddleware = require("../middlewares/authMiddleware");
const roleMiddleware = require("../middlewares/rolesMiddleware");

const criteriaRoutes = express.Router();

criteriaRoutes.get('/view', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getCriteria);
criteriaRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createCriteriaCategory);
criteriaRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateCriteriaCategory);

module.exports = criteriaRoutes;

