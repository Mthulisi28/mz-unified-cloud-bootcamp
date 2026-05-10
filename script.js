let sessions = [];

async function loadData() {
    try {
        const response = await fetch('sessions.json');
        const data = await response.json();
        sessions = data.sessions;
        renderSession(sessions[0].id); // Default load
    } catch (error) {
        console.error('UCA-Audit-Fail: Data fetch failed', error);
    }
}

document.addEventListener('click', (e) => {
    const action = e.target.closest('[data-action]');
    if (!action) return;
    e.preventDefault();
    const type = action.getAttribute('data-action');
    const url = action.getAttribute('data-url');

    if (type === 'navigate') {
        renderSession(action.getAttribute('data-id'));
    } else if (type === 'external') {
        window.open(url, '_blank', 'noopener,noreferrer');
    }
});

function renderSession(id) {
    const data = sessions.find(s => s.id == id);
    if (!data) return;
    
    document.getElementById('sessionTitle').innerText = data.title;
    document.getElementById('overview').innerText = data.overview;
    document.getElementById('outcomes').innerText = data.outcomes;
    document.getElementById('awsLink').setAttribute('data-url', data.aws);
    document.getElementById('videoLink').setAttribute('data-url', data.video);
}

window.onload = loadData;
