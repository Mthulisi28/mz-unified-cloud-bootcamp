html_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MZ | UCA Cloud Bootcamp</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #05070a; color: #e5e7eb; font-family: sans-serif; }
        .gold-ink { color: #d4af37; }
        .session-card { background: #0b0e14; border: 1px solid #1f2937; transition: all 0.2s ease; }
        .session-card:hover { border-color: #d4af37; transform: translateY(-2px); }
    </style>
</head>
<body class="p-8 md:p-20 max-w-7xl mx-auto">
    <header class="mb-12 border-b border-gray-900 pb-8">
        <h1 class="text-4xl font-black italic uppercase tracking-tighter mb-2">MZ UNIFIED CLOUD ARCHITECTURE</h1>
        <p class="text-[10px] gold-ink font-bold tracking-[0.3em]">◈ GLOBAL ACADEMY | 2026 EXECUTION</p>
    </header>

    <div id="session-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6"></div>

    <script>
        const sessions = [
            { n: 1, title: 'Cloud Foundations', link: 'assets/WEEK 1 — SESSION 1.pdf', status: 'active' },
            { n: 2, title: 'Shared Responsibility', link: 'assets/session2sharedresp.pdf', status: 'active' },
            { n: 3, title: 'IAM Masterclass', link: 'assets/SESSION3 Identity & Access Management (IAM).pdf', status: 'active' },
            { n: 4, title: 'Compute Layer', link: 'assets/WEEK 2 — SESSION 4.pdf', status: 'active' },
            { n: 5, title: 'Storage Layer', link: '#', status: 'locked' },
            { n: 6, title: 'Databases', link: '#', status: 'locked' },
            { n: 7, title: 'Networking', link: '#', status: 'locked' },
            { n: 8, title: 'Network Security', link: '#', status: 'locked' },
            { n: 9, title: 'Architecture Design', link: '#', status: 'locked' },
            { n: 10, title: 'Billing & Pricing', link: '#', status: 'locked' },
            { n: 11, title: 'Exam Strategy', link: '#', status: 'locked' },
            { n: 12, title: 'Final Mock Exam', link: '#', status: 'locked' }
        ];

        const container = document.getElementById('session-grid');
        container.innerHTML = sessions.map(s => `
            <div class="session-card p-6 ${s.status === 'locked' ? 'opacity-30 grayscale' : ''}">
                <p class="text-[10px] font-black ${s.status === 'active' ? 'gold-ink' : 'text-gray-500'} mb-2">S-${s.n}</p>
                <h3 class="text-sm font-bold mb-6 text-white h-10 uppercase">${s.title}</h3>
                <div class="space-y-2">
                    ${s.status === 'active' ? 
                        \`<a href="${s.link}" target="_blank" class="block text-[11px] text-gray-400 hover:text-white transition">◈ VIEW ASSETS</a>
                         <a href="#" class="block text-[11px] text-gray-400 hover:text-white transition">◈ WATCH REPLAY</a>\` : 
                        \`<span class="block text-[11px] text-gray-700 italic">SYSTEM LOCKED</span>\`
                    }
                </div>
            </div>
        `).join('');
    </script>
</body>
</html>
"""

with open("index.html", "w", encoding="utf-8") as f:
    f.write(html_content)
