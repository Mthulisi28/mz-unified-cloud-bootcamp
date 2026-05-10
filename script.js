async function loadData() {
    try {
        const response = await fetch('sessions.json');
        if (!response.ok) throw new Error('File not found');
        const data = await response.json();
        const sessions = data.sessions;
        
        // Render first session
        const s = sessions[0];
        document.getElementById('sessionTitle').innerText = s.title;
        document.getElementById('overview').innerText = s.overview;
        document.getElementById('outcomes').innerText = s.outcomes;
    } catch (e) {
        document.body.innerHTML = '<h1>Audit Error: ' + e.message + '</h1>';
    }
}
window.onload = loadData;
