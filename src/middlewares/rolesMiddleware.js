const roleMiddleware = (allowedRoles) => {
    return (req, res, next) => {
      const user = req.user;  
  
      if (!user || !allowedRoles.includes(user.privilege)) {
        return res.status(403).json({
          message: "Forbidden - You do not have the required role to access this resource",
          status: "failed",
          data: null
        });
      }
  
      next();
    };
  };
  
  module.exports = roleMiddleware;
  