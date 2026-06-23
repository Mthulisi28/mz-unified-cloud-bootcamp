/**
 * MZ Unified Control Architecture (UCA) - Student Portal Engine v2
 * Blueprint: AWS Solutions Architect - Associate (SAA-C03)
 */

const SAA_DOMAINS = {
    SECURE: 0.30,
    RESILIENT: 0.26,
    HIGH_PERF: 0.24,
    COST_OPT: 0.20
};

const PASSING_TARGET = 720;

function calculateStudentSAAScore(secure, resilient, highPerf, costOpt) {
    const weightedPercentage = 
        (secure * SAA_DOMAINS.SECURE) +
        (resilient * SAA_DOMAINS.RESILIENT) +
        (highPerf * SAA_DOMAINS.HIGH_PERF) +
        (costOpt * SAA_DOMAINS.COST_OPT);

    const scaledScore = Math.round(100 + (weightedPercentage * 9));
    const isReady = scaledScore >= PASSING_TARGET;

    return {
        score: scaledScore,
        target: PASSING_TARGET,
        status: isReady ? "EXAM_READY" : "REMEDIATION_REQUIRED",
        action: isReady ? "PROCEED_TO_VOUCHER_ISSUANCE" : "TRIGGER_DOMAIN_REVIEW"
    };
}

function calculateLeadScore(userSession) {
    let score = 0;
    if (userSession.completed === true) score += 50;
    if (userSession.timeSpent > 300) score += 30; 

    const THRESHOLD = 70;
    return {
        score: score,
        triggerPayment: score >= THRESHOLD,
        paystackLink: score >= THRESHOLD ? "https://paystack.com/pay/mz-premium-access" : null
    };
}

async function initializePortal() {
    try {
        const response = await fetch('./session-registry.json');
        if (!response.ok) throw new Error('Registry failed to load');
        
        const registry = await response.json();
        console.log("Registry loaded. Total sessions:", registry.length);
        
        registry.forEach(session => {
            const mockTelemetry = { completed: true, timeSpent: 350 }; 
            const leadState = calculateLeadScore(mockTelemetry);
            
            console.log(`Session: ${session.title} | LeadScore: ${leadState.score} | PaymentTrigger: ${leadState.triggerPayment}`);
            
            if (leadState.triggerPayment) {
                console.log(`Payment Link Generated: ${leadState.paystackLink}`);
            }
        });
        
        return registry;
    } catch (error) {
        console.error("Critical Engine Failure:", error);
    }
}

initializePortal();
console.log("SAA Portal Engine successfully initiated.");