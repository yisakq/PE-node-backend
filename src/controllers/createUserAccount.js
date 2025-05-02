const prisma = require("../prismaclient");
const transporter = require("../nodemailer")
const jwt = require("jsonwebtoken");
const createUserAccount = async (req, res) => {
    try {
        
        const {privilege, empId } = req.body;
      
       
        const employee = await prisma.employeeRegistration.findUnique({
            where: { empId },
            select: { empEmail: true },  
        });

        const existingUser = await prisma.userAccount.findFirst({
            where: {
                OR: [
                    { usrAccEmail: employee.empEmail },
                    { empId }  
                ]
            }
        });

        if (existingUser) {
            return res.status(400).json({ error: "User already exists!" });
        }

        
        const newUser = await prisma.userAccount.create({
            data: {
                usrAccEmail: employee.empEmail,
              //  usrAccPassword: password, 
                usrAccPrivilege: privilege,
                empId,
                usrAccIsActive: true,
              //  usrAccCreatedBy: req.user.userId 
            }
        });
        const tempToken = jwt.sign({  email: employee.empEmail }, process.env.JWT_SECRET, { expiresIn: "1h" });

        const resetLink = `http://localhost:5000/api/auth/reset-password?token=${tempToken}`;

        const mail = {
            from: '"Moti Engineering Plc" <yisak.mellion@motiengineering.com>',
            to: employee.empEmail,
            subject: 'Set up your password',
            html: `
              <p>Hello,</p>
              <p>Your account has been created. Click the link below to set your password:</p>
              <a href="${resetLink}">${resetLink}</a>
              <p>This link expires in 1 hour.</p>
            `
          };

          transporter.sendMail(mail, (err, info) => {
            if (err) {
              console.error('Failed to send password setup email:', err);
            } else {
              console.log('Password setup email sent:', info.response);
            }
          });
        // Return success response
        res.status(201).json({ message: "User account created successfully!", user: newUser });

    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Internal server error!" });
    }
};

module.exports = { createUserAccount };
