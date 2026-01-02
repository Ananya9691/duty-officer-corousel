let currentSlide = 0;
let slides = [];

fetch('http://localhost:4000/duty-carousel')
    .then(res => res.json())
    .then(data => buildCarousel(data));

function buildCarousel(data) {
    const grouped = {};

    data.forEach(d => {
        const key = d.DUTY_DATE + '_' + d.STANDBY_FLAG;
        if (!grouped[key]) grouped[key] = [];
        grouped[key].push(d);
    });

    const carousel = document.getElementById('carousel');

    Object.values(grouped).forEach(group => {
        const slide = document.createElement('div');
        slide.className = 'slide';

        const title = document.createElement('h2');
        title.innerText =
            `${group[0].DUTY_DAY} – ${group[0].STANDBY_FLAG === 'N' ? 'Active Duty' : 'Standby Duty'}`;
        slide.appendChild(title);

        const cards = document.createElement('div');
        cards.className = 'cards';

       group.forEach(o => {

    const avatar =
        o.GENDER === 'F'
            ? 'http://localhost:4000/images/officer_female.png'
            : 'http://localhost:4000/images/officer_male.png';

    cards.innerHTML += `
        <div class="card">
            <img src="${avatar}" alt="Officer">
            <div class="name">${o.OFFICER_NAME}</div>
            <div class="meta">${o.DUTY_POINT} | ${o.SHIFT}</div>
        </div>
    `;
});


        slide.appendChild(cards);
        carousel.appendChild(slide);
    });

    slides = document.querySelectorAll('.slide');
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
    updateSlide();
}

function prevSlide() {
    currentSlide = (currentSlide - 1 + slides.length) % slides.length;
    updateSlide();
}

function updateSlide() {
    document.getElementById('carousel').style.transform =
        `translateX(-${currentSlide * 100}%)`;
}
