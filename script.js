let sessions = [];

async function init() {
    try {
        const res = await fetch('sessions.json');
        const data = await res.json();
        sessions = data.sessions;
        render(localStorage.getItem('lastSession') || 1);
    } catch (e) { console.error('UCA Audit Fail', e); }
}

function render(id) {
    const s = sessions.find(x => x.id == id);
    if (!s) return;
    localStorage.setItem('lastSession', id);
    
    // Update Text
    document.getElementById('sessionTitle').innerText = s.title;
    document.getElementById('overview').innerText = s.overview;
    document.getElementById('outcomes').innerText = s.outcomes;
    
    // Update Buttons
    document.getElementById('awsLink').setAttribute('data-url', s.aws);
    document.getElementById('videoLink').setAttribute('data-url', s.video);
}

document.addEventListener('click', (e) => {
    const act = e.target.closest('[data-action]');
    if (!act) return;
    
    e.preventDefault();
    const type = act.getAttribute('data-action');
    const url = act.getAttribute('data-url');
    const id = act.getAttribute('data-id');

    if (type === 'navigate') {
        render(id);
    } else if (type === 'external') {
        window.open(url, '_blank', 'noopener,noreferrer');
    }
});

window.onload = init;
