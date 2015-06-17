// display a different greeting each minute
function updateGreeting(id) {
    var greetings = ['Hello', 'Hola', 'Привет', 'こんにちは'];
    var minutes = (new Date()).getMinutes();
    document.getElementById(id).innerHTML = greetings[minutes % greetings.length] + "!";
}
