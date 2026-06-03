const grid = document.getElementById("grid");
const status = document.getElementById("status");
const message = document.getElementById("message");

const last = localStorage.getItem("last_session");

if (last) {
  status.innerText = "Last session visited: Session " + last;
}

async function loadSessions() {
  try {
    const res = await fetch("session-registry.json");
    const data = await res.json();

    status.innerText = "Loaded " + data.length + " sessions";
    message.style.display = "none";

    data.forEach(session => {
      const div = document.createElement("div");
      div.className = "card";

      const key = "session_" + session.id;
      const completed = localStorage.getItem(key) === "done";

      div.innerHTML =
        "<div>" + session.title + "</div>" +
        "<small style='color:" + (completed ? "#4ade80" : "#aab4c0") + "'>" +
        (completed ? "Completed" : "Not started") +
        "</small>";

      div.onclick = function () {
        localStorage.setItem("last_session", session.id);
        window.location.href = "session.html?id=" + session.id;
      };

      grid.appendChild(div);
    });

  } catch (err) {
    console.error(err);
    status.innerText = "System error";
    message.innerText = "Failed to load session registry";
    message.style.color = "red";
  }
}

loadSessions();
