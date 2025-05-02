const express = require("express");
const { createUserAccount } = require("../controllers/createUserAccount");
const authMiddleware = require('../middlewares/authMiddleware');
const roleMiddleware = require('../middlewares/rolesMiddleware');

const createUserAccountRoutes = express.Router();

createUserAccountRoutes.post('/create',  createUserAccount);


module.exports = createUserAccountRoutes;
