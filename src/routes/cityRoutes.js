const express = require("express");
const { getCity, createCity, updateCity } = require("../controllers/city");
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/rolesMiddleware');

const cityRoutes = express.Router();

cityRoutes.get('/view',  authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), getCity);
cityRoutes.post('/create', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), createCity);
cityRoutes.put('/edit', authMiddleware, roleMiddleware(['Admin', 'SuperAdmin']), updateCity);


module.exports = cityRoutes;
