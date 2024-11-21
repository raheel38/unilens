const feedDisplay = document.querySelector('#feed')

fetch('http://localhost:8000/results')
    .then(response => response.json())
    .then(data => {
        data.forEach((article, index) => {
            const articleElement = `
                <div class="link-box">
                    <span class="link-number">${index + 1}</span>
                    <a href="${article.url}" target="_blank" class="link-title">${article.title}</a>
                    <span class="arrow-icon">→</span>
                </div>
            `
            feedDisplay.insertAdjacentHTML("beforeend", articleElement)
        })
    })
    .catch(err => console.log(err))