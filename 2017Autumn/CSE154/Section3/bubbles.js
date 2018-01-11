"use strict";
(function(){

    window.onload = pageLoad;
    
    let n = 16;

    function pageLoad() {
        document.getElementById("bubble-container").onclick = remove(this);
    }

    function remove(container) {
        container.innerHTML = "";
        n--;
        for (var i = 0; i < n; i++) {
            let bubble = document.createElement("div");
            bubble.className = "bubble";
            container.appendChild(bubble);
        }
    }
})()