const prisma = require("../prismaclient")

const getPosition = async(req, res) =>{
    try{
        const positions = await prisma.position.findMany({})
        res.status(200).json(positions)
    }

    catch(error){
        res.status(500).json({error: error.message})
    }
}

const createPosition = async(req, res) =>{
    try{
        const {divisionId, positionName, positionRemark} = req.body;

        const existingPosition = await prisma.position.findFirst({
            where : {positionName}
        });

        if(existingPosition){
            res.status(400).json({error: "Position already exists!"})
        }

        const newPosition = await prisma.position.create({
            data : {
                divisionId,
                positionName,
                positionIsActive: true,
                positionRemark,
                positionCreatedBy: req.user.userId,
            }
        })
        res.status(201).json({ message: "Position created successfully!", employee: newPosition });

    }

    catch(error){
        res.status(500).json({ error: error.message });
    }
    
}

const updatePosition = async(req, res) =>{
    const { positionId, positionName, positionRemark, positionIsActive, } = req.body;  
    try {
      const updatedPosition = await prisma.position.update({
        where: { positionId: parseInt(positionId) },        
        data: {
          positionName,
          positionRemark,
          positionIsActive,
          positionUpdatedBy: req.user.userId,  
        },
      });
  
      res.status(201).json(updatedPosition);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

  module.exports = {getPosition, createPosition, updatePosition};