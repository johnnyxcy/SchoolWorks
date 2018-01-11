// This is the java script for fifteen puzzle game

// Has the feature of moving tiles based on user's mouse click.
// The default puzzle is ordered. User could shuffle the puzzle to start a new game
"use strict";
(function() {

    let SIZE = 4; // Initialize the size of the puzzle. In this case it is 4
    let BACKGROUNDIMAGE = "background.jpg"; // Set up the background image
    let empty_col = 4; // Initialize the empty space;
    let empty_row = 4;
    // Set up the page when it is loaded
    window.onload = function() {
        initializePuzzle();
        document.getElementById("shufflebutton").onclick = shuffle;
    };

    // Initialize the puzzle
    function initializePuzzle() {
        for (let i = 1; i < SIZE * SIZE; i++) {
            let tile = document.createElement("div");
            tile.innerHTML = i;
            tile.classList.add("tiles");
            let row = initializeRow(i);
            let col = initializeCol(i);
            tile.id = "square_" + row +"_" + col;
            putTile(tile, row, col);
            
            tile.onmouseover = detectCanMove; // Changes color if can move
            tile.onmousedown = move; // Move the tile
            tile.onmouseout = reset; // Reset the color after move is completed

            document.getElementById("puzzlearea").appendChild(tile);
        }
        setBckgrdImg(BACKGROUNDIMAGE); // Set up the background image
    }

    // Initialize the row of the puzzle according the number
    function initializeRow(num) {
        let n = parseInt(num / SIZE);
        if (num % SIZE == 0) {
            return n;
        } else {
            return n + 1;
        }
    }

    // Initialize the column of the puzzle according the number
    function initializeCol(num) {
        let n = num % SIZE;
        if (n == 0) {
            return SIZE;
        } else {
            return n;
        }
    }

    // Check if the given tile could move
    function canMove(tile) {
        let cur_row = findRow(tile);
        let cur_col = findCol(tile);
        if (cur_row == empty_row) {
            return Math.abs(cur_col - empty_col) == 1;
        } else if (cur_col == empty_col) {
            return Math.abs(cur_row - empty_row) == 1;
        }
        return false;
    }

    // If the tile could move, change its hover color
    function detectCanMove() {
        if (canMove(this)) {
            this.classList.add("hover");
        }
    }

    // Reset the hover color
    function reset() {
        this.classList.remove("hover");
    }

    // Move the tile
    function move() {
        toMove(this);
    }

    // Swap the given tile with empty space
    // Assuming the tile could move
    function toMove(tile) {
        if (canMove(tile)) {
            let col = findCol(tile);
            let row = findRow(tile);
            if (canMove(tile)) {
                putTile(tile, empty_row, empty_col);
                tile.id = "square_" + empty_row + "_" + empty_col;
                empty_row = row;
                empty_col = col;
            }
        }
    }

    function findCol(tile) {
        let x = parseInt(window.getComputedStyle(tile).left);
        return x / 100 + 1;
    }

    function findRow(tile) {
        let x = parseInt(window.getComputedStyle(tile).top);
        return x / 100 + 1;
    }

    // Put the given tile to the given row and column
    function putTile(tile, row, col) {
        let xcoor = (col - 1) * 100;
		let ycoor = (row - 1) * 100;
		tile.style.position = "absolute";
		tile.style.left = xcoor + "px";
		tile.style.top = ycoor + "px";
    }

    // Set up the background image with given image name
    function setBckgrdImg(imageName) {
        let allTiles = document.querySelectorAll(".tiles");
        for (let i = 0; i < allTiles.length; i++) {
            let col = findCol(allTiles[i]);
            let row = findRow(allTiles[i]);
            let xcoor = (1 - col) * 100;
            let ycoor = (1 - row) * 100;
            allTiles[i].style.backgroundImage = "url(" + imageName + ")";
            allTiles[i].style.backgroundPosition = xcoor + "px " + ycoor + "px";
        }
    }

    // Shuffle the puzzle
	function shuffle() {
		for (let i = 0; i < 1000; i++) {
            let neighbors = [];
            let neighborSet = getNeighbors();
            for (let i = 0; i < neighborSet.length; i++) {
                let n = neighborSet[i];
                let tile = document.getElementById("square_" + n[0] + "_" + n[1]);
                if (tile != null) { // if the tile exists
                    if (canMove(tile)) { // if the current tile could move
                        neighbors.push(tile);
                    }
                }
            }
            // Choose one direction randomly
            let choice = parseInt(Math.random() * neighbors.length); 
            toMove(neighbors[choice]);
        }
    }
    
    // Get all neighbors tile based on current empty space
    function getNeighbors() {
        let neighborSet = [];
        if (empty_row + 1 <= 4) {
            neighborSet.push([empty_row + 1, empty_col]);
        }
        if (empty_row - 1 >= 1) {
            neighborSet.push([empty_row - 1, empty_col]);
        }
        if (empty_col + 1 <= 4) {
            neighborSet.push([empty_row, empty_col + 1]);
        }
        if (empty_col - 1 >= 1) {
            neighborSet.push([empty_row, empty_col - 1]);
        }
        return neighborSet;
    }
    
})()