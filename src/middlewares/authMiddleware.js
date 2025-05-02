const jwt = require("jsonwebtoken");
require("dotenv").config();

const secretKey = process.env.JWT_SECRET;

const authMiddleware = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;

        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(401).json({
                message: "Unauthorized - No token provided",
                status: "failed",
                data: null,
            });
        }

        // Extract token from "Bearer <token>"
        const token = authHeader.split(" ")[1];

        // Verify token
        const decoded = jwt.verify(token, secretKey);

        // Attach user info to request object
        req.user = decoded;
        console.log(req.user)
        next(); // Continue to the next middleware/route handler
    } catch (error) {
        return res.status(403).json({
            message: "Forbidden - Invalid or expired token",
            status: "failed",
            data: null,
        });
    }
};

module.exports = authMiddleware;
