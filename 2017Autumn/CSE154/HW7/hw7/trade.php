<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This implements the trading feature for my Pokedex

    include("common.php");
    header("Content-Type: application/json");
    
    # if both parameter are passed.
    if (isset($_GET["mypokemon"]) && isset($_GET["theirpokemon"])) {
        $my = $_GET["mypokemon"];
        $their = $_GET["theirpokemon"];
        $result = $db->exec("INSERT INTO Pokedex(name, datefound) 
            VALUES(". strtolower($their). ", ". date('y-m-d H:i:s'). ")");
        $db->exec("DELETE FROM Pokedex WHERE name='". strtolower($my). "'");
        $output = array();
        if ($result) {
            $output["success"] = "Success! You have traded your ". $my. "for ". $their. "!";
        } else {
            header("HTTP/1.0 400 Bad Request");
            $output["error"] = "Error: You have already found ". $theirpokemon. ".";
        }
        print(json_encode($output));
    } else{ # if any of the parameters is missing
        missing("missing_or", "mypokemon", "theirpokemon");
    }
?>