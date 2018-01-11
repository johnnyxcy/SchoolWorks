"use strict";
(function(){
    function $(id) {
        return document.getElementById(id);
    }
    function qs(name) {
        return document.querySelector(name);
    }
    function qsa(name) {
        return document.querySelectorAll(name);
    }
    
    window.onload = function() {
        $("dropdown").onchange = dropdownChange;
        let links = qsa(".BarLinks");
        for (let i = 0; i < links.length; i++) {
            links[i].onclick = openLink;
        }
    }    

    function dropdownChange() {
        let val = $("dropdown").value;
        let languages = ["English", "Chinese", "Japanese"];
        for (let lan in languages) {
            if (languages[lan] == val) {
                $(languages[lan]).classList.add("show");
            } else {
                $(languages[lan]).classList.remove("show");
            }
        }
    }
    function openLink() {
        let links = qsa(".link");
        for (let i = 0; i < links.length; i++) {
            links[i].classList.remove("show");
        }
        let tablinks = qsa(".BarLinks");
        for (let i = 0; i < links.length; i++) {
            tablinks[i].classList.remove("redTab");
        }
        let context = this.id.substring(0, 4);
        $(context).classList.add("show");
        this.classList.add("redTab");
    }
})();