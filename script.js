// UCA Hardened Bootloader
const sessions = [
    { id: 1, title: "Session 1: Foundations", overview: "AWS Global Infrastructure", outcomes: "✔ AZ Isolation\n✔ Region Strategy", aws: "sessions/session-1-cloud-foundations.html", video: "#", pdf: "assets/session1.pdf" },
    { id: 2, title: "Session 2: IAM Governance", overview: "Identity Perimeter", outcomes: "✔ Least Privilege\n✔ Role Assumption", aws: "sessions/session-2-iam.html", video: "#", pdf: "assets/session2.pdf" },
    { id: 3, title: "Session 3: Shared Responsibility", overview: "Governance Boundaries", outcomes: "✔ Security OF vs IN", aws: "sessions/session-3-shared-responsibility.html", video: "#", pdf: "assets/session3.pdf" },
    { id: 4, title: "Session 4: VPC Networking", overview: "Global Network Mesh", outcomes: "✔ VPC Peering\n✔ Transit Gateway", aws: "sessions/session-4-vpc-networking.html", video: "#", pdf: "assets/session4.pdf" },
    { id: 5, title: "Session 5: Compute Strategy", overview: "[LOCKED]", outcomes: "✔ Coming Soon", aws: "#", video: "#", pdf: "" }
];

let progress = JSON.parse(localStorage.getItem('uca_p')) || [1];

function init() {
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
    
    document.getElementById('awsLink').onclick = () => window.open(s.aws, '_blank');
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
