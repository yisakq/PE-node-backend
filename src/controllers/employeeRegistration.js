const prisma = require("../prismaclient")

const getEmployee = async (req, res) =>{

    try{
         const employees = await prisma.employeeRegistration.findMany({})
         
         res.status(200).json(employees)
    }
    catch(error){
         res.status(500).json({error: error.message})
    }
};

const createEmployee = async (req, res) =>{
    try{
    const { empUniqueId, empFName, empMName, empLName, empMobileNo, empEmail, empLocation, empRegion, empDistrict, empCity, empGrade, empLevel, positionId, deptId, divisionId, empIsActive, dateOfEmployment, } = req.body;

    const existingEmployee = await prisma.employeeRegistration.findFirst({
        where: { empUniqueId }
    });

    if (existingEmployee) {
        return res.status(400).json({ error: "Employee already exists!" });
    }
    const newEmployee = await prisma.employeeRegistration.create({
        data: {
          empUniqueId, 
          empFName, 
          empMName, 
          empLName, 
          empMobileNo, 
          empEmail, 
          empLocation, 
          empRegion,
          empDistrict,
          empCity,
          empGrade, 
          empLevel, 
          positionId, 
          deptId, 
          divisionId, 
          empIsActive: true,
          dateOfEmployment,
          empCreatedBy: req.user.userId,
        }
    });

    res.status(201).json({ message: "Employee created successfully!", employee: newEmployee });

} catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
}


}

const updateEmployee = async (req, res) => {

    const {empId, empFName, empMName, empLName, empMobileNo, empEmail, empLocation, empRegion, empDistrict, empCity, empGrade, empLevel, positionId, deptId, divisionId, empIsActive, } = req.body;  
    try {
      const updatedEmployee = await prisma.division.update({
        where: { empId: parseInt(empId) },        
        data: {
          empId, 
          empFName, 
          empMName, 
          empLName, 
          empMobileNo, 
          empEmail, 
          empLocation,
          empRegion,
          empDistrict,
          empCity, 
          empGrade, 
          empLevel, 
          positionId, 
          deptId, 
          divisionId, 
          empIsActive,
          empUpdatedBy: req.user.userId,  
        },
      });
  
      res.status(201).json(updatedEmployee);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

  module.exports = {getEmployee, createEmployee, updateEmployee};