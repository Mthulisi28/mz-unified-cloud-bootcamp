let sessions = [];
let progress = JSON.parse(localStorage.getItem('uca_p')) || [1];

async function init() {
    const res = await fetch('sessions.json');
    const data = await res.json();
    sessions = data.sessions;
    renderSidebar();
    render(localStorage.getItem('uca_last') || 1);
}

function renderSidebar() {
    const list = document.getElementById('sessionList');
    list.innerHTML = '';
    sessions.forEach(s => {
        const isLocked = s.id !== 1 && !progress.includes(s.id - 1);
        const btn = document.createElement('button');
        btn.className = 'session-btn' + (localStorage.getItem('uca_last') == s.id ? ' active' : '');
        btn.disabled = isLocked;
        btn.innerHTML = (isLocked ? '🔒 ' : '✅ ') + s.title;
        btn.onclick = () => render(s.id);
        list.appendChild(btn);
    });
}

function render(id) {
    const s = sessions.find(x => x.id == id);
    if (!s) return;
    localStorage.setItem('uca_last', id);
    document.getElementById('sessionTitle').innerText = s.title;
    document.getElementById('overview').innerText = s.overview;
    document.getElementById('outcomes').innerText = s.outcomes;
    document.getElementById('awsLink').setAttribute('data-url', s.aws);
    document.getElementById('videoLink').setAttribute('data-url', s.video);
    
    const pdfArea = document.getElementById('pdfArea');
    pdfArea.innerHTML = s.pdf ? '<a href="' + s.pdf + '" target="_blank" style="color:#60a5fa">📥 Download PDF Slides</a>' : '';
    
    document.getElementById('completeBtn').onclick = () => {
        if (!progress.includes(s.id)) progress.push(s.id);
        localStorage.setItem('uca_p', JSON.stringify(progress));
        renderSidebar();
        const next = sessions.find(x => x.id == s.id + 1);
        if (next) render(next.id);
        else alert('UCA Roadmap Complete! Certification Unlocked.');
    };
    renderSidebar();
}

document.addEventListener('click', e => {
    const act = e.target.closest('[data-action="external"]');
    if (act) window.open(act.getAttribute('data-url'), '_blank');
});

window.onload = init;
