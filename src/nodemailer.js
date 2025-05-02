const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: "mail.motiengineering.com",
  port: 587,
  secure: false, 
  auth: {
    user: process.env.USERNAME,
    pass: process.env.PASSWORD,
  },
});

module.exports = transporter