/*
Name: Chongyi Xu
Date: 10/18/2017
Section: CSE 154 AI

This is the java script for speed runer. It controls behaviors
of the speed runer.
*/
"use strict";
(function () {

	let input = ""; // Initialize the value of input
	let timer = null; // Initialize the value of timer
	let index = -1; // Initialize the value of index
	let delay = 171; // Initialize the delay time

	// Returns get element by id
	function $(id) {
		return document.getElementById(id);
	}


	window.onload = function () {
		$("stop").disabled = true; // Set stop to be disabled
		$("medium").onchange = changeFont;
		$("big").onchange = changeFont;
		$("bigger").onchange = changeFont;
		$("start").onclick = start;
		$("stop").onclick = stop;
		$("change-speeds").onchange = changeSpeed;
	};

	// Controls the behavior after pressing start button
	function start() {
		$("start").disabled = true;
		$("stop").disabled = false;
		// Split the input by space, newline, or tab
		input = $("input").value.split(/[ \t\n]+/);
		for (let i = 0; i < input.length; i++) {
			let punc = input[i].charAt(input[i].length - 1);
			if (punc == "," || punc == "." || punc == "!" ||
				punc == "?" || punc == ";" || punc == ":") {
				input[i] = input[i].substring(0, input[i].length - 1);
				for (let k = input.length; k > i + 1; k--) {
					input[k] = input[k - 1];
				}
				input[i + 1] = input[i];
				i++;
			}
		}
		timer = setInterval(display, delay);
	}

	// Clear the output box after pressing stop
	function stop() {
		$("stop").disabled = true;
		$("start").disabled = false;
		clearInterval(timer);
		timer = null;
		index = -1;
		$("output-box").innerHTML = "";
	}

	// Display the text to the output box
	function display() {
		index += 1;
		if (index < input.length) {
			$("output-box").innerHTML = input[index];
		} else {
			stop();
		}
	}

	// Change the font of the text in the output box
	function changeFont() {
		if (this.value == "48pt") {
			$("output-box").className = "big";
		} else if (this.value == "60pt") {
			$("output-box").className = "bigger";
		} else {
			$("output-box").className = "medium";
		}
	}

	// Change of speed of text showing
	function changeSpeed() {
		delay = this.value;
		if (timer !== null) {
			clearInterval(timer);
			timer = setInterval(display, delay);
		}
	}
})();