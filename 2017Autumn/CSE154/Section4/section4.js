/*global fetch*/
"use strict";
(function(){
    
    function $(id){ return document.getElementById(id) }
    function qs(selector){ return document.querySelector(selector) }
    function qsa(selector){ return document.querySelectorAll(selector) }
    
    window.onload = function(){
        $("fetch").onclick = callAjax;
    };
    
    //include this code, based on: https://developers.google.com/web/updates/2015/03/introduction-to-fetch
    function checkStatus(response) {  
        if (response.status >= 200 && response.status < 300) {  
            return response.text();
        } else {  
            return Promise.reject(new Error(response.status+": "+response.statusText)); 
        } 
    }
 
    function callAjax(){
        let file = $("file-name").value;
        
        // dispaly loading text and disable button while ajax call is loading
        $("file-contents").innerHTML = "Loading...";
        $("fetch").disabled = true;
        
        //start ajax call
        fetch(file, {credentials: 'include'})
           .then(checkStatus)
           .then(function(responseText) {
                // ajax call succeded! place text and re-enable the button
                $("file-contents").innerHTML = responseText;
                $("fetch").disabled = false;
            })
           .catch(function(error) {
               $("error").innerHTML = error;
               $("fetch").disabled = false;
           });
    }
    
})();