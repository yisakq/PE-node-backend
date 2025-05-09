const cron = require('node-cron');
const { checkUnfinalizedEvaluations } = require('./controllers/employeeEvaluation');
const prisma = require('./prismaclient');

// Run every day at midnight
cron.schedule('0 0 * * *', async () => {
    try {
        
        const hasUnfinalizedEvaluations = await prisma.employeeEvaluation.findFirst({
            where: {
                finalizedByEvaluator: false
            }
        });

       
        if (hasUnfinalizedEvaluations) {
            console.log('Running daily check for unfinalized evaluations...');
            await checkUnfinalizedEvaluations();
        } else {
            console.log('No unfinalized evaluations found, skipping check...');
        }
    } catch (error) {
        console.error('Error in cron job:', error);
    }
});