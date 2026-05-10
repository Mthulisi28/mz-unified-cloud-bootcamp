const sessions = {
    1: { title: "Cloud Foundations", overview: "Intro to AWS", aws: "#", video: "#" },
    // Add other sessions here
};

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
    const data = sessions[id];
    if (!data) return;
    document.getElementById('sessionTitle').innerText = data.title;
    document.getElementById('overview').innerText = data.overview;
    document.getElementById('awsLink').setAttribute('data-url', data.aws);
    document.getElementById('videoLink').setAttribute('data-url', data.video);
}
