const prisma = require("../prismaclient");

const getCity = async (req, res) => {
  try {
    const cities = await prisma.city.findMany({});

    res.status(200).json(cities);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const createCity = async (req, res) => {
    try {
      const { cityName, cityRegion, cityDistrict,  } = req.body;  

      const existingCity = await prisma.city.findFirst({
        where: { cityName }
    });

    if (existingCity) {   
        return res.status(400).json({ error: "City already exists!" });
    }

    const newCity = await prisma.city.create({
      data: {
        cityName,
        cityRegion,
        cityDistrict,
        cityIsActive: true,
        cityCreatedBy: req.user.userId,  
      },
    });

    res.status(201).json({message: "City created successfully!", city: newCity});
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const updateCity = async (req, res) => {
    const { cityName, cityRegion, cityDistrict, cityIsActive } = req.body;
    try {
      const updatedCity = await prisma.city.update({
        where: { cityId: parseInt(cityId) },        
        data: {
          cityName,
          cityRegion,
          cityDistrict,
          cityIsActive,
          cityUpdatedBy: req.user.userId,  
        },
      });
  
      res.status(201).json(updatedCity);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  };

module.exports = { getCity, createCity, updateCity };
