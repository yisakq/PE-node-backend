const prisma = require("../prismaclient")

const getDivision = async (req, res) =>{

    try{
         const divisions = await prisma.division.findMany({})
         
         res.status(200).json(divisions)
    }
    catch(error){
         res.status(500).json({error: error.message})
    }
};

const createDivision = async (req, res) =>{
    try{
    const { deptId, divisionName, divisionRemark } = req.body;

    const existingDivision = await prisma.division.findFirst({
        where: { deptId }
    });

    if (existingDivision) {
        return res.status(400).json({ error: "Division already exists!" });
    }
    const newDivision = await prisma.division.create({
        data: {
            deptId,
            divisionName,
            divisionIsActive: true,
            divisionRemark,
            divisionCreatedBy: req.user.userId,
        }
    });

    res.status(201).json({ message: "Division created successfully!", division: newDivision });

} catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
}


}

const updateDivision = async (req, res) => {

    const { divisionId, divisionName, divisionRemark, divisionIsActive, } = req.body;  
    try {
      const updatedDivision = await prisma.division.update({
        where: { divisionId: parseInt(divisionId) },        
        data: {
          divisionName,
          divisionRemark,
          divisionIsActive,
          divisionUpdatedBy: req.user.userId,  
        },
      });
  
      res.status(201).json(updatedDivision);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

  module.exports = {getDivision, createDivision, updateDivision};