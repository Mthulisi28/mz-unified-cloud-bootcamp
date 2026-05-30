/**
 * MZ-UCA Portal Interaction Engine — Hardened Production Accordion & Card Toggle
 * Binds robust click handlers to session cards to dynamically reveal nested resources.
 */

document.addEventListener("DOMContentLoaded", () => {
    console.log("■ MZ-UCA Interaction Engine Active: Monitoring session card nodes.");

    // Delegate click events globally across the document body to survive asynchronous rendering
    document.body.addEventListener("click", (event) => {
        // Track if the click originated from or inside a session card header/trigger
        const cardElement = event.target.closest(".sc");
        
        // Prevent event fire if clicking directly on an active resource hyperlink
        if (event.target.closest("a") || event.target.closest(".sc-resources")) {
            return;
        }

        if (cardElement) {
            console.log("■ Session card interaction intercepted:", cardElement);
            
            // Toggle active expansion layout state
            cardElement.classList.toggle("expanded");
            
            // Locate the underlying hidden resources section within this specific card
            const resourcesBlock = cardElement.querySelector(".sc-resources");
            if (resourcesBlock) {
                if (cardElement.classList.contains("expanded")) {
                    resourcesBlock.style.display = "flex";
                    resourcesBlock.style.maxHeight = "500px";
                    resourcesBlock.style.opacity = "1";
                    resourcesBlock.style.marginTop = "1rem";
                } else {
                    resourcesBlock.style.maxHeight = "0px";
                    resourcesBlock.style.opacity = "0";
                    setTimeout(() => { 
                        if(!cardElement.classList.contains("expanded")) {
                            resourcesBlock.style.display = "none"; 
                        }
                    }, 200);
                }
            }
        }
    });
});

/**
 * Global Enterprise Resource Vault Engine
 * Hydrates legacy monolithic onclick bindings and handles premium document delivery.
 */
window.vaultOpen = function(assetUrl, assetTitle, requiredTier) {
    console.log(`■ Vault access request intercepted | Asset: ${assetTitle} | Required Tier: ${requiredTier}`);
    
    if (!assetUrl || assetUrl === "#") {
        console.error("▲ Vault delivery blocked: Asset reference is empty or invalid.");
        return false;
    }

    try {
        const targetWindow = window.open(assetUrl, '_blank');
        if (targetWindow) {
            targetWindow.focus();
        } else {
            window.location.href = assetUrl;
        }
    } catch (error) {
        console.error("▲ Critical exception inside vault delivery loop:", error);
    }
    
    return false;
};
