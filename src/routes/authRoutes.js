const express = require("express");
const { login, resetPassword } = require("../controllers/auth");

const authRoutes = express.Router();

authRoutes.post('/login', login);
authRoutes.put('/reset-password', resetPassword);

module.exports = authRoutes;
