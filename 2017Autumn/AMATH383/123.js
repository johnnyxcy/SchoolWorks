// Yichao Wang
// CSE 154 AK
// A classic game consisting of a 4x4 grid of numberedsquares with one square missing. 

// The object of the game is to arrange the tiles into numerical order by repeatedly
// sliding a square that neighbors the missing square into its empty space.
// Applied Extra Feature #5. Multiple Backgrounds (allow the user to choose between backgrounds)
(function() {
	"use strict";

	var DIMENSION = 4; // # of rows/cols in the puzzle
	var AREA = 100; // the pixel width/height of each tile
	var erow = 4; // current row of empty space
	var ecol = 4; // current column of empty space

	// Setup the page
	// Attaches event handlers to each of the controls;
	window.onload = function() {
		setPuzzle();
		setImageBar();
//		document.getElementById("shufflebutton").onclick = shuffle;
	};
	
	// Setup the puzzle (15 tiles)
	function setPuzzle() {
		// Setup each tile
		for (var i = 1; i < DIMENSION * DIMENSION; i++) {
			var tile = document.createElement("div");
			tile.innerHTML = i;
			tile.classList.add("tiles");
			
			var row = getInitialRow(i);
			var col = getInitialCol(i);
			tile.id = "square_" + row +"_" + col;
			
			// Set position
			setPosition(row, col, tile);
			
			// Set event handlers
			tile.onmousedown = getMove;
			tile.onmouseover = change;
			tile.onmouseout = changeBack;
			
			document.getElementById("puzzlearea").appendChild(tile);
		}
		setBackground("background");
	}
	
	// Set each tile's backgound using given background images
	// based on each tile's number
	function setBackground(backgroundImg) {
		var allimg = document.querySelectorAll(".tiles");
		for (var i = 0; i < allimg.length; i++) {
			var row = getInitialRow(allimg[i].innerHTML);
			var col = getInitialCol(allimg[i].innerHTML);
			var x = AREA * (1 - col);
			var y = AREA * (1 - row);
			allimg[i].style.backgroundImage = "url(" + backgroundImg + ".jpg)";
			allimg[i].style.backgroundPosition = x + "px " + y + "px";
		}
	}
	
	// this tile is ready to move
	function getMove() {
		move(this);
	}
	
	// move the tile to blanl space if it is next to it
	function move(tile) {
		var col = getCol(tile);
		var row = getRow(tile);
		if (movable(tile)) {
			setPosition(erow, ecol, tile);
			tile.id = "square_" + erow + "_" + ecol;
			erow = row;
			ecol = col;
		}
	}
	
	// return true if  the tile is next to the empty space
	// false otherwise
	function movable(tile) {
		return tile.id == "square_" + (erow + 1) + "_" + ecol || 
			   tile.id == "square_" + (erow - 1) + "_" + ecol ||
			   tile.id == "square_" + erow + "_" + (ecol + 1) ||
			   tile.id == "square_" + erow + "_" + (ecol - 1);
	}

	// Set the tile to given row/column
	function setPosition(row, col, tile) {
		var x = (col - 1) * AREA;
		var y = (row - 1) * AREA;
		tile.style.position = "absolute";
		tile.style.left = x + "px";
		tile.style.top = y + "px";
	}

	// Get the tile's column
	function getCol(tile) {
		var x = parseInt(window.getComputedStyle(tile).left);
		return x / AREA + 1;
	}

	// Get the tile's row
	function getRow(tile) {
		var y = parseInt(window.getComputedStyle(tile).top);
		return y / AREA + 1;
	}
	
	// Get the tile's inital column based on its number
	function getInitialCol(n) {
		if (n % DIMENSION == 0) {
			var col = DIMENSION;		
		} else {
			var col = n % DIMENSION;
		}
		return col;
		
	}
	
	// Get the tile's inital row based on its number
	function getInitialRow(n) {
		if (n % DIMENSION == 0) {
			var row = n / DIMENSION;
		} else {
			var row = parseInt(n / DIMENSION) + 1;
		}
		return row;
	}
	
	// If the mouse is over the tile, apply class hover (movable) or hover2
	function change() {
		if (movable(this)) {
			this.classList.add("hover");
            //console.log(this.id);
		} //else {
			//this.classList.add("hover2");
		//}
	}

	// Change to origin state if mouse out the tile
	function changeBack() {
		this.classList.remove("hover");
	}

	// Shuffle the puzzle
	function shuffle() {
		for (var i = 0; i < 1000; i++) {
			var neighbors = []; // neighbors of empty space
			var truen = []; // exist neighbors
			// Get neighbors
			neighbors.push(document.getElementById("square_" + (erow + 1) + "_" + ecol));
			neighbors.push(document.getElementById("square_" + (erow - 1) + "_" + ecol));
			neighbors.push(document.getElementById("square_" + erow + "_" + (ecol + 1)));
			neighbors.push(document.getElementById("square_" + erow + "_" + (ecol - 1)));
			
			// Check existence
			for (var j = 0; j < neighbors.length; j++) {
				if (neighbors[j] !== null) {
					truen.push(neighbors[j]);
				}
			}
			
			// random moving one of the neighbors
			var random = parseInt(Math.random() * truen.length);
			move(truen[random]);	
		}
	}
	
	// for the extra feature 
	// set image option
	// allow the user to choose between backgrounds
	function setImageBar() {
		var newDiv = document.createElement("div");
		var imgBar = document.createElement("select");	
		
		// default img
		var defaultImg = document.createElement("option");
		defaultImg.value = "background";
		defaultImg.innerHTML = "background";
		defaultImg.selected = "selected";
		imgBar.appendChild(defaultImg);
		
		// other img
		for (var i = 2; i < 5; i++) {
			var img = document.createElement("option");
			img.value = "background" + i;
			img.innerHTML = "background" + i;
			imgBar.appendChild(img);
		}
		
		imgBar.onchange = changeBackground;
		newDiv.appendChild(imgBar);
		document.getElementById("controls").appendChild(newDiv);
	}
	
	// change the background
	function changeBackground() {
		setBackground(this.value);
	}
})();
