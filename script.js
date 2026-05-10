let sessions = [];
async function init() {
    try {
        const res = await fetch('sessions.json');
        const data = await res.json();
        sessions = data.sessions;
        const last = localStorage.getItem('lastSession') || 1;
        render(last);
    } catch (e) { console.error('UCA Audit Fail', e); }
}

function render(id) {
    const s = sessions.find(x => x.id == id);
    if (!s) return;
    localStorage.setItem('lastSession', id);
    document.getElementById('sessionTitle').innerText = s.title;
    document.getElementById('overview').innerText = s.overview;
    document.getElementById('outcomes').innerText = s.outcomes;
    document.getElementById('awsLink').setAttribute('data-url', s.aws);
    document.getElementById('videoLink').setAttribute('data-url', s.video);
}

document.addEventListener('click', (e) => {
    const act = e.target.closest('[data-action]');
    if (!act) return;
    e.preventDefault();
    if (act.getAttribute('data-action') === 'navigate') {
        render(act.getAttribute('data-id'));
    } else {
        window.open(act.getAttribute('data-url'), '_blank', 'noopener,noreferrer');
    }
});
window.onload = init;
