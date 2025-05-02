const prisma = require("../prismaclient");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const login = async (req, res) => {
    try {
        const { email, password } = req.body;

        
        let user = await prisma.userAccount.findFirst({
            where: { usrAccEmail: email }
        });

        if (!user) {
            return res.status(404).json({ error: "User does not exist!" });
        }

       
        // if (!user.usrAccPassword.startsWith("$2")) {
           
        //     if (password !== user.usrAccPassword) {
        //         return res.status(400).json({ error: "Incorrect password!" });
        //     }

        //     const tempToken = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: "15m" });
        //     return res.status(302).json({ message: "Password reset required", redirect: "/reset-password", tempToken  });
        // }

       
        const isMatch = await bcrypt.compare(password, user.usrAccPassword);
        if (!isMatch) {
            return res.status(400).json({ error: "Incorrect username or password!" });
        }

        const token = jwt.sign({ userId: user.usrAccId, privilege: user.usrAccPrivilege }, process.env.JWT_SECRET, {
            expiresIn: "1h",
        });

       
        res.status(200).json({ message: "Login successful!", user, token });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const resetPassword = async (req, res) => {
    try {
        const { newPassword, confirmPassword } = req.body;
        const tempToken = req.headers.authorization?.split(" ")[1]; // Extract token from headers

        if (!tempToken) {
            return res.status(401).json({ error: "Unauthorized access. Token missing!" });
        }

        
        const decoded = jwt.verify(tempToken, process.env.JWT_SECRET);
        const email = decoded.email;
        
        if (!newPassword || !confirmPassword) {
            return res.status(400).json({ error: "Both password fields are required!" });
        }

        if (newPassword !== confirmPassword) {
            return res.status(400).json({ error: "Passwords do not match!" });
        }

        const user = await prisma.userAccount.findFirst({ where: { usrAccEmail : email } });

     
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await prisma.userAccount.update({
            where: { usrAccEmail:email },
            data: { usrAccPassword: hashedPassword,
                    usrAccUpdatedBy: user.empId,
             }  
        });


        res.status(200).json({ message: "Password updated successfully! You can now log in."});

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

module.exports = { login, resetPassword }; 
