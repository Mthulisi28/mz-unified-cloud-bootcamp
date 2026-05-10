async function load() {
    try {
        const res = await fetch('sessions.json');
        const data = await res.json();
        const s = data.sessions[0];
        document.getElementById('sessionTitle').innerText = s.title;
        document.getElementById('overview').innerText = s.overview;
        document.getElementById('outcomes').innerText = s.outcomes;
    } catch (e) { document.body.innerHTML = '<h1>Sync Error: ' + e.message + '</h1>'; }
}
window.onload = load;
