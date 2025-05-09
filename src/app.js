require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const prisma = require("./prismaclient");
const rootRouter = require("./routes"); 
require('./cron');

app.use(cors());
app.use(express.json());

app.use("/api", rootRouter); 

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
