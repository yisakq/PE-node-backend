const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: "mail.motiengineering.com",
  port: 587,
  secure: false, 
  auth: {
    user: process.env.MAILJET_APIKEY,
    pass: process.env.MAILJET_SECRETKEY,
  },
});

module.exports = transporter