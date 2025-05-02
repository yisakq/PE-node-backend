const prisma = require("../prismaclient");

const getQuestionary = async (req, res) => {
  const questionary = await prisma.questionary.findMany();
  res.json(questionary);
};

const createQuestionary = async (req, res) => {
  const { question } = req.body;
  const newQuestionary = await prisma.questionary.create({
    data: {
      question,
      queIsActive: true,
      queCreatedBy: req.user.userId,
    },
  });
  res.status(201).json({ message: "Questionary created successfully!", questionary: newQuestionary });
};

const updateQuestionary = async (req, res) => {
  const { question, queIsActive, questionaryId } = req.body;
  const updatedQuestionary = await prisma.questionary.update({
    where: { questionaryId: parseInt(questionaryId) },
    data: {
      question,
      queIsActive,
      queUpdatedBy: req.user.userId,
    },
  });
  res.status(201).json({ message: "Questionary updated successfully!", questionary: updatedQuestionary });
};


module.exports = { getQuestionary, createQuestionary, updateQuestionary };
