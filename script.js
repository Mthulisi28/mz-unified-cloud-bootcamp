let sessions = [];
let progress = JSON.parse(localStorage.getItem('uca_p')) || [1];

async function init() {
    console.log("UCA Bootloader: Initializing...");
    try {
        const res = await fetch('sessions.json');
        if (!res.ok) throw new Error('HTTP error! status: ' + res.status);
        const data = await res.json();
        sessions = data.sessions;
        console.log("UCA Data Plane: Loaded", sessions.length, "sessions.");
        renderSidebar();
        render(localStorage.getItem('uca_last') || 1);
    } catch (e) {
        console.error("UCA Critical Failure:", e);
        document.getElementById('sessionTitle').innerText = "Data Plane Offline";
        document.getElementById('overview').innerText = "Check sessions.json formatting or GitHub path.";
    }
}

function renderSidebar() {
    const list = document.getElementById('sessionList');
    if (!list) return;
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
    
    document.getElementById('awsLink').onclick = () => window.open(s.aws, '_blank');
    document.getElementById('videoLink').onclick = () => window.open(s.video, '_blank');
    
    const pdfArea = document.getElementById('pdfArea');
    pdfArea.innerHTML = s.pdf ? '<a href="' + s.pdf + '" target="_blank" style="color:#60a5fa; text-decoration:none;">📥 Download Playbook</a>' : '';
    
    document.getElementById('completeBtn').onclick = () => {
        if (!progress.includes(s.id)) progress.push(s.id);
        localStorage.setItem('uca_p', JSON.stringify(progress));
        const next = sessions.find(x => x.id == s.id + 1);
        if (next) render(next.id);
        renderSidebar();
    };
    renderSidebar();
}

window.onload = init;
