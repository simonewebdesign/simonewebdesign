const img = document.querySelector('.doge');
const menu = document.querySelector('.doge-demo .menu');

img.addEventListener('mousedown', function (event) {
    const { offsetX, offsetY } = event;
    menu.style.top = offsetY + 'px';
    menu.style.left = offsetX + 'px';
});