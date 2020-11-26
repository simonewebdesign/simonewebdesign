var form = document.querySelector('[name="subscribe"]')
var btn = document.querySelector('[name="subscribe"] > button')
var input = document.querySelector('#email')

form.addEventListener('submit', function (e) {
    if (!form.checkValidity()) return;
    e.preventDefault()

    if (!('fetch' in window)) form.submit()

    fetch('/sub', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: "email="+encodeURIComponent(e.currentTarget[0].value)
    })

    var title = document.createElement('h2')
    title.innerText = "Thank you!"

    var par = document.createElement('p')
    par.innerText = "I'll send you an email next time I write an article :)"

    form.insertAdjacentElement('afterend', title)
    title.insertAdjacentElement('afterend', par)
    form.remove()
})