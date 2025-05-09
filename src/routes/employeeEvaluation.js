
const express = require("express");
const { getEvaluatorEvaluations, getEvaluateeEvaluations, getHREvaluations, createEvaluation, updateEvaluation } = require("../controllers/employeeEvaluation");
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/rolesMiddleware');

const evaluationRoutes = express.Router();

evaluationRoutes.get('/evaluator',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getEvaluatorEvaluations);
evaluationRoutes.get('/evaluatee',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getEvaluateeEvaluations);
evaluationRoutes.get('/hr',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getHREvaluations);
evaluationRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createEvaluation);
evaluationRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateEvaluation);


module.exports = evaluationRoutes;
