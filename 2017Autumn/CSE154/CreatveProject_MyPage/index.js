"use strict";
(function(){
    function $(id) {
        return document.getElementById(id);
    }
    
    window.onload = function() {
        $("dropdown").onchange = dropdownChange;
        let links = document.getElementsByClassName("BarLinks");
        for (let i = 0; i < links.length - 1; i++) {
            $(links[i]).onclick = openclick;
        }
    }    

    function dropdownChange() {
        let val = $("dropdown").value;
        if (val == "English") {
            $("English").style.display = "block";
            $("Chinese").style.display = "none";
            $("Japanese").style.display = "none";
        } else if (val == "Chinese") {
            $("English").style.display = "none";
            $("Chinese").style.display = "block";
            $("Japanese").style.display = "none";
        } else if (val == "Japanese") {
            $("English").style.display = "none";
            $("Chinese").style.display = "none";
            $("Japanese").style.display = "block";
        }
    }
    function openLink(evt, linkName) {
        let links = document.getElementsByClassName("link");
        for (let i = 0; i < links.length; i++) {
            if (links[i.classList])
            links[i].classList.add("hidden");
        }
        let tablinks = document.getElementsByClassName("BarLinks");
        for (let i = 0; i < x.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" redTab", "");
        }
        document.getElementById(linkName).style.display = "block";
        evt.currentTarget.className += " redTab";
    }
})();