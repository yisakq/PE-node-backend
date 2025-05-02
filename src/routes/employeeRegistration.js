const express = require("express");
const { getEmployee, createEmployee, updateEmployee } = require("../controllers/employeeRegistration");
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/rolesMiddleware');

const empRegistrationRoutes = express.Router();

empRegistrationRoutes.get('/view',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getEmployee);
empRegistrationRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createEmployee);
empRegistrationRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateEmployee);


module.exports = empRegistrationRoutes;
