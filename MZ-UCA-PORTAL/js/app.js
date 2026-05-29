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
