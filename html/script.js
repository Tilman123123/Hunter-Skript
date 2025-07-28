function sellAnimal(animal) {
  fetch(`https://${GetParentResourceName()}/sellAnimal`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ animal: animal })
  }).then(resp => resp.json()).then(data => {
    console.log(data.message);
  });
}

function closeMenu() {
  fetch(`https://${GetParentResourceName()}/closeMenu`, {
    method: 'POST'
  });
}

window.addEventListener("message", function (event) {
    if (event.data.type === "playSound") {
        let audio = new Audio(`./sounds/${event.data.sound}.ogg`);
        audio.volume = event.data.volume || 1.0;
        if (event.data.loop) audio.loop = true;
        audio.play();
        window.currentSound = audio;
    }

    if (event.data.type === "stopSound") {
        if (window.currentSound) {
            window.currentSound.pause();
            window.currentSound.currentTime = 0;
            window.currentSound = null;
        }
    }
});

window.addEventListener("message", function (event) {
    if (event.data.type === "ui") {
        document.body.style.display = event.data.display ? "block" : "none";
    }

    if (event.data.type === "updatePoints") {
        document.getElementById("pointsDisplay").innerText = "Punkte: " + event.data.points;
    }
});

function closeUI() {
    fetch(`https://${GetParentResourceName()}/exit`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8",
        },
        body: "{}"
    });
}

window.addEventListener("message", function (event) {
    if (event.data.action === "playSound") {
        const audio = new Audio(`./sounds/${event.data.sound}.mp3`);
        audio.volume = 0.5;
        audio.play();
    }
});

window.addEventListener("message", function (event) {
    if (event.data.type === "updateTracking") {
        document.getElementById("status").textContent = event.data.status ? "ON" : "OFF";
    }
});

window.addEventListener('message', function (event) {
    if (event.data.type === "showAnimalUI") {
        document.getElementById("animalDisplay").innerText = "Spur: " + event.data.animal;
    }
});
