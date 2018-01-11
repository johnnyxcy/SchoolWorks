<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This updates the nickname of the given pokemon

    include("common.php");
    header("Content-Type: application/json");
    
    if (isset($_GET["name"])) { # if the name is passed
        $output = array();
        $name = $_GET["name"];
        if (isset($_GET["nickname"])) {
            $nickname = $_GET["nickname"];
        } else {
            $nickname = strtoupper($name);
        }
        
        #Update the nickname
        $result = $db->exec("UPDATE Pokedex SET nickname = ". $nickname. " WHERE 
        name = ". $name. ";");
        if ($result) {
            $output["success"] = "Success! Your ". $name. " is now named ". $nickname. "!";
        }else {
            header("HTTP/1.0 400 Bad Request");
            $output["error"] = "Error: Pokemon". $name. " not found in your Pokedex.";
        }
        print(json_encode($output));
    } else { # if the "name" parameter is missing
        missing("only_one", "name");
    }
    
?>