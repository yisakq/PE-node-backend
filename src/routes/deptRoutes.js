const express = require("express");
const { getDepartment, createDepartment, updateDepartment } = require("../controllers/dept");
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/rolesMiddleware');

const deptRoutes = express.Router();

deptRoutes.get('/view',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getDepartment);
deptRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createDepartment);
deptRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateDepartment);


module.exports = deptRoutes;
