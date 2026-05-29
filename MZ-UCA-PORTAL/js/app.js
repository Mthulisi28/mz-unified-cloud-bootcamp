/**
 * Master Enterprise Orchestrator & Dynamic Rendering Engine
 * Fetches decoupled resource modules and hydrates the viewport presentation layers.
 */

const MZ_APP_CORE = {
    version: "2026.1.2",
    environment: "Production-StaticEdge",

    initializeSystem: function() {
        console.log("■ MZ-UCA Core Engine Active.");
        this.loadSessionData();
    },

    loadSessionData: function() {
        const containerGov = document.getElementById('track-governance');
        const containerEng = document.getElementById('track-engineering');

        fetch('./data/sessions.json')
            .then(res => res.json())
            .then(data => {
                // Clear out hardcoded shell components safely
                if(containerGov) containerGov.innerHTML = '<div class="div-grid"></div>';
                if(containerEng) containerEng.innerHTML = '<div class="cet-grid"></div>';

                const gridGov = containerGov ? containerGov.querySelector('.div-grid') : null;
                const gridEng = containerEng ? containerEng.querySelector('.cet-grid') : null;

                data.forEach(session => {
                    const cardHtml = `
                        <div class="sc">
                            <div class="card-tag">${session.sessionNum} — ${session.division}</div>
                            <h3>${session.title}</h3>
                            <p style="margin-bottom: 1rem; color: var(--text-muted); font-size: 0.8rem;">${session.subtitle}</p>
                            <div class="sc-resources" style="display: flex; flex-direction: column; gap: 0.5rem; margin-bottom: 1rem;">
                                ${session.resources.map(res => `
                                    <a href="${res.url}" class="nav-item" style="font-size: 0.8rem; text-transform: none; display: flex; align-items: center; gap: 0.5rem;" target="_blank">
                                        <span>${res.icon}</span> ${res.label}
                                    </a>
                                `).join('')}
                            </div>
                            <div class="sc-week" style="font-family: var(--font-mono); font-size: 0.75rem; color: var(--accent-gold); text-transform: uppercase;">
                                ${session.week}
                            </div>
                        </div>
                    `;

                    if (session.track === 'governance' && gridGov) {
                        gridGov.innerHTML += cardHtml;
                    } else if (session.track === 'engineering' && gridEng) {
                        gridEng.innerHTML += cardHtml;
                    }
                });

                // Re-trigger hardware-accelerated animations after rendering complete
                if (window.MZ_Animate_Init) window.MZ_Animate_Init();
            })
            .catch(err => console.error("▲ Content data plane hydration failure:", err));
    }
};

document.addEventListener('DOMContentLoaded', () => { MZ_APP_CORE.initializeSystem(); });
