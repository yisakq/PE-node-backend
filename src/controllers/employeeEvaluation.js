const prisma = require("../prismaclient");

const getEvaluatorEvaluations = async (req, res) => {
  try {
    const evaluations = await prisma.employeeEvaluation.findMany({
      where: {
        evaluatorId: req.user.userId,
        finalizedByEvaluator: false,
        sentWithoutFinalization: false,
      },
      include: {
        evaluatee: {
          select: {
            empFName: true,
            empMName: true,
            empLname: true,
            position: {
              select: {
                positionName: true,
              },
            },
          },
        },
      },
    });
    res.status(200).json(evaluations);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get evaluations for employees (evaluatees)
const getEvaluateeEvaluations = async (req, res) => {
  try {
    const evaluations = await prisma.employeeEvaluation.findMany({
      where: {
        evaluateeId: req.user.userId,
        finalizedByEvaluator: false,
        sentWithoutFinalization: false,
      },
      include: {
        evaluator: {
          select: {
            empFName: true,
            empMName: true,
            empLname: true,
            position: {
              select: {
                positionName: true,
              },
            },
          },
        },
      },
    });
    res.status(200).json(evaluations);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get evaluations for HR department
const getHREvaluations = async (req, res) => {
  try {
    const evaluations = await prisma.employeeEvaluation.findMany({
      where: {
        AND: [
          {
            OR: [
              { finalizedByEvaluator: true },
              { sentWithoutFinalization: true },
            ],
          },
          {
            hrApprovedBy: null,
          },
        ],
      },
      include: {
        evaluator: {
          select: {
            empFName: true,
            empMName: true,
            empLname: true,
            position: {
              select: {
                positionName: true,
              },
            },
          },
        },
        evaluatee: {
          select: {
            empFName: true,
            empMName: true,
            empLname: true,
            position: {
              select: {
                positionName: true,
              },
            },
          },
        },
      },
    });
    res.status(200).json(evaluations);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const createEvaluation = async (req, res) => {
  try {
    const { evaluateeId, evaluationPeriodFrom, evaluationPeriodTo, totalScore, totalPercentage, rateLevel, rateRemark, empTotalScore, criteriaResponses, questionaryResponses} = req.body;
    
    const newEvaluation = await prisma.employeeEvaluation.create({
      data: {
        evaluatorId: req.user.userId,
        evaluateeId,
        evaluationPeriodFrom,
        evaluationPeriodTo,
        totalScore,
        totalPercentage,
        rateLevel,
        rateRemark,
        empTotalScore,
        // Create criteria responses
        criteriaResponse: {
          create: criteriaResponses.map(response => ({
            criCategoryId: response.criCategoryId,
            criEvaluationRate: response.criEvaluationRate,
            criWeightScore: response.criWeightScore
          }))
        },
        // Create questionary responses
        questionaryResponse: {
          create: questionaryResponses.map(response => ({
            questionaryId: response.questionaryId,
            questionaryResponse: response.questionaryResponse
          }))
        }
      },
      include: {
        criteriaResponse: true,
        questionaryResponse: true
      }
    });
    res.status(201).json(newEvaluation);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const updateEvaluation = async (req, res) => {
  try {
    const { evaluationId, action, empComment, hrComment } = req.body;
    const userId = req.user.userId;

    // Get the current evaluation
    const evaluation = await prisma.employeeEvaluation.findUnique({
      where: { evaluationId: parseInt(evaluationId) },
    });

    if (!evaluation) {
      return res.status(404).json({ error: "Evaluation not found" });
    }

    let updateData = {};

    // Handle evaluatee's accept/reject
    if (evaluation.evaluateeId === userId) {
      if (action === "accept") {
        updateData = {
          evaluateeAccepted: true,
          empComment,
        };
      } else if (action === "reject") {
        updateData = {
          evaluateeAccepted: false,
        };
      }
    }
    // Handle evaluator's finalize
    else if (evaluation.evaluatorId === userId) {
      if (action === "finalize" && evaluation.evaluateeAccepted === true) {
        updateData = {
          finalizedByEvaluator: true,
        };
      }
    }
    // Handle HR update
    else if (req.user.usrAccPrivilege === "Admin") {
      // Assuming Admin is HR role
      if (action === "hr_review") {
        updateData = {
          hrComment,
          hrApprovedAt: new Date(),
          hrApprovedBy: userId,
        };
      }
    }

    const updatedEvaluation = await prisma.employeeEvaluation.update({
      where: { evaluationId: parseInt(evaluationId) },
      data: updateData,
    });

    res.status(200).json(updatedEvaluation);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const checkUnfinalizedEvaluations = async () => {
  try {
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

    // Find all evaluations that:
    // 1. Are not finalized (finalizedByEvaluator is false)
    // 2. Were created more than 7 days ago
    const unfinalizedEvaluations = await prisma.employeeEvaluation.findMany({
      where: {
        finalizedByEvaluator: false,
        createdAt: {
          lt: sevenDaysAgo,
        },
      },
    });

    // Update each unfinalized evaluation
    for (const evaluation of unfinalizedEvaluations) {
      await prisma.employeeEvaluation.update({
        where: { evaluationId: evaluation.evaluationId },
        data: {
          setWithoutFinalization: true,
        },
      });
    }

    console.log(
      `Checked ${unfinalizedEvaluations.length} unfinalized evaluations`
    );
  } catch (error) {
    console.error("Error checking unfinalized evaluations:", error);
  }
};

module.exports = {
  getEvaluatorEvaluations,
  getEvaluateeEvaluations,
  getHREvaluations,
  createEvaluation,
  updateEvaluation,
  checkUnfinalizedEvaluations,
};
