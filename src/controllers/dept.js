const prisma = require("../prismaclient");

const getDepartment = async (req, res) => {
  try {
    const departments = await prisma.department.findMany({});

    res.status(200).json(departments);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const createDepartment = async (req, res) => {
    try {
      const { deptName, deptAbbreviation, deptRemark } = req.body;  

      const existingDepartment = await prisma.department.findFirst({
        where: { deptName }
    });

    if (existingDepartment) {
        return res.status(400).json({ error: "Department already exists!" });
    }

    const newDepartment = await prisma.department.create({
      data: {
        deptName,
        deptAbbreviation,
        deptRemark,
        deptIsActive: true,
        deptCreatedBy: req.user.userId,  
      },
    });

    res.status(201).json({message: "Department created successfully!", department: newDepartment});
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const updateDepartment = async (req, res) => {
    const { deptName, deptAbbreviation, deptRemark, deptIsActive, deptId } = req.body;
    try {
      const updatedDepartment = await prisma.department.update({
        where: { deptId: parseInt(deptId) },        
        data: {
          deptName,
          deptAbbreviation,
          deptRemark,
          deptIsActive,
          deptUpdatedBy: req.user.userId,  
        },
      });
  
      res.status(201).json(updatedDepartment);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

module.exports = { getDepartment, createDepartment, updateDepartment };
