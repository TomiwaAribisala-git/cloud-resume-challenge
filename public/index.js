const counter = document.querySelector(".counter-number");

async function updateCounter() {
    let response = await fetch("url"); // update url with lambda function url
    let data = await response.json();
    counter.innerHTML = `This page has been viewed ${data} times`;
}

updateCounter() 