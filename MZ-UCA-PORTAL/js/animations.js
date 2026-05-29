document.addEventListener('DOMContentLoaded', () => {
    const interactiveElements = document.querySelectorAll('.sc, .cet-card, .cal-day');
    const observerOptions = { root: null, threshold: 0.05, rootMargin: '0px 0px -20px 0px' };
    const elementObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.style.transform = 'translateY(0)';
                    entry.target.style.opacity = '1';
                }, index * 40);
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);
    interactiveElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(10px)';
        el.style.transition = 'opacity 0.4s cubic-bezier(0.16, 1, 0.3, 1), transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), border-color 0.2s ease, background 0.2s ease';
        elementObserver.observe(el);
    });
});
