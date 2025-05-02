const express = require('express');
const authRoutes =require('./authRoutes');
const deptRoutes = require('./deptRoutes');
const createUserAccountRoutes = require('./createUserAccount');
const divisionRoutes = require('./divisionRoutes');
const positionRoutes = require('./positionRoutes');
const empRegistrationRoutes = require('./employeeRegistration');
const criteriaRoutes = require('./criteriaRoutes');
const ratingLevelRoutes = require('./ratingLevelRoutes');
const questionaryRoutes = require('./questionaryRoutes');
const cityRoutes = require('./cityRoutes');
const rootRouter = express.Router();

rootRouter.use('/auth', authRoutes)
rootRouter.use('/department', deptRoutes)
rootRouter.use('/create-user-account', createUserAccountRoutes)
rootRouter.use('/division', divisionRoutes)
rootRouter.use('/position', positionRoutes)
rootRouter.use('/employee-registration',empRegistrationRoutes)
rootRouter.use('/criteria', criteriaRoutes)
rootRouter.use('/rating-level', ratingLevelRoutes)
rootRouter.use('/questionary', questionaryRoutes)
rootRouter.use('/city', cityRoutes)


module.exports = rootRouter;
