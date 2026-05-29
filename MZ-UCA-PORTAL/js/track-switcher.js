/**
 * MZ-UCA Portal State Engine — Hardened Production Scope & Binding Engine
 * Explicitly exposes track switching to the window context for inline event handlers.
 */

window.switchProg = function(trackName) {
    if (!trackName) return;
    
    const tracks = ['governance', 'engineering'];
    if (!tracks.includes(trackName)) return;

    // Isolate and manipulate content frames safely using robust query selections
    tracks.forEach(track => {
        const targetContainer = document.getElementById(`track-${track}`);
        const targetButton = document.querySelector(`.ts-btn[data-track="${track}"]`);

        if (track === trackName) {
            if (targetContainer) {
                targetContainer.classList.add('active');
                targetContainer.style.display = 'block';
                // Trigger sub-pixel paint optimization cycle
                setTimeout(() => { targetContainer.style.opacity = '1'; }, 10);
            }
            if (targetButton) {
                targetButton.classList.add('active');
            }
        } else {
            if (targetContainer) {
                targetContainer.style.opacity = '0';
                targetContainer.style.display = 'none';
                targetContainer.classList.remove('active');
            }
            if (targetButton) {
                targetButton.classList.remove('active');
            }
        }
    });

    // Write state down deterministically inside client session storage
    try {
        localStorage.setItem('activeTrack', trackName);
    } catch (e) {
        console.warn('◆ Storage operations disabled on client platform context:', e);
    }
};

// Handle asynchronous state rehydration upon safe DOM readiness
document.addEventListener("DOMContentLoaded", () => {
    try {
        const savedTrack = localStorage.getItem('activeTrack') || 'governance';
        if (typeof window.switchProg === 'function') {
            window.switchProg(savedTrack);
        }
    } catch (e) {
        if (typeof window.switchProg === 'function') {
            window.switchProg('governance');
        }
    }
});
