"use strict";
(function() {
    function $(id) {
        return document.getElementById(id);
    }
    
    function checkStatus(response) {
        if (response.status >= 200 && response.status < 300) {
            return response.text();
        } else {
            return Promise.reject(new Error(response.stauts + ": " + response()))
        }
    }

    window.onload = function() {
        setInterval(checkMessages, 5000); 
    }

    function checkMessages() {
        fetch("https://webster.cs.washington.edu/cse154/sections/9/chatit/chatit.php?reverse=true&limit=10")
        .then(checkStatus)
        .then(gotMessages)
    }
})()