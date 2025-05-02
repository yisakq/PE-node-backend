const prisma = require("../prismaclient")

const getCriteria = async(req, res) =>{
    try{
        const criteriaCategories = await prisma.criteriaCategory.findMany({
            include: {
                criteria: true
            }
        });
        
        res.status(200).json(criteriaCategories);
    }
    catch(error){
        res.status(500).json({error: error.message})
    }
}

const createCriteriaCategory = async(req, res) =>{
    try{
        const {criYear, deptId, divisionId, positionId, criRegion, criDistrict, criteria} = req.body;

        // Validate required fields
        if (!criYear || !deptId || !criteria || !Array.isArray(criteria) || criteria.length === 0) {
            return res.status(400).json({ error: "Missing required fields or invalid criteria data" });
        }

        const newCategory = await prisma.criteriaCategory.create({
            data: {
                criYear: new Date(criYear),
                deptId,
                divisionId,
                positionId,
                criRegion,
                criDistrict,
                criAbleToEdit: "FormCreated",
                criCreatedBy: req.user.userId,
                criteria: {
                    create: criteria.map((c) => ({
                        criQuestion: c.criQuestion,
                        criWeight: parseFloat(c.criWeight),
                        criIsActive: true,
                    })),
                },
            },
            include: {
                criteria: true
            }
        });

        res.status(201).json(newCategory);
    } catch (error) {
        console.error("Error creating criteria category:", error);
        res.status(500).json({ error: error.message });
    }
};

const updateCriteriaCategory = async(req, res) =>{
    try{
        
        const { criCategoryId, criteria } = req.body;

        // First get the existing category to check its status
        const existingCategory = await prisma.criteriaCategory.findUnique({
            where: { criCategoryId: parseInt(criCategoryId) },
            include: { criteria: true }
        });

       
        // If category is in FormCriteria state, only allow criteria updates
        if (existingCategory.criAbleToEdit === "FormCreated") {
            // Separate new criteria from existing ones
            const newCriteria = criteria.filter(c => !c.criId);
            const existingCriteria = criteria.filter(c => c.criId);

            const updatedCategory = await prisma.criteriaCategory.update({
                where: { criCategoryId: parseInt(criCategoryId) },
                data: {
                    criteria: {
                        // Update existing criteria
                        update: existingCriteria.map((c) => ({
                            where: { criId: c.criId },
                            data: {
                                criQuestion: c.criQuestion,
                                criWeight: parseFloat(c.criWeight),
                                criIsActive: c.criIsActive,
                                criUpdatedBy: req.user.userId,
                            },
                        })),
                        // Add new criteria
                        create: newCriteria.map((c) => ({
                            criQuestion: c.criQuestion,
                            criWeight: parseFloat(c.criWeight),
                            criIsActive: true,
                            criUpdatedBy: req.user.userId,
                        })),
                    },
                },
                include: { criteria: true }
            });

            return res.status(200).json(updatedCategory);
        }
       
        return res.status(400).json({ error: "Criteria category is not in editable state. Current state: " + existingCategory.criAbleToEdit });
    } catch (error) {
        return res.status(500).json({ error: error.message });
    }
};

module.exports = {
    getCriteria,
    createCriteriaCategory,
    updateCriteriaCategory
};

