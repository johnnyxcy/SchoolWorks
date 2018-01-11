<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This inserts the found pokemon to the Pokedex Table in my database

    include("common.php");
    
    header("Content-Type: application/json");
    if (isset($_GET["name"])) { # if the name is passed
        $name = $_GET["name"];
        if (isset($_GET["nickname"])) { # if the nickname is passed
            $nickname = $_GET["nickname"];
        } else { # if the nickname is not passed
            $nickname = strtoupper($name);
        }
        
        #insert name, nicknames and date found into the Pokedex Table
        $time = date('y-m-d H:i:s');
        $result = $db->exec("INSERT INTO Pokedex(name, nickname, datefound) 
        VALUES(". strtolower($name). ", ". strtolower($nickname). ", ". $time. ")");
        $output = array();
        if ($result) { # if inserted successfully
            $output["success"] = "Success! ". $name. " added to your Pokedex!";
        } else {
            header("HTTP/1.0 400 Bad Request");
            $output["error"] = "Error: Pokemon". $name. " already found.";
        }
        
        print(json_encode($output));
    } else { # if the name parameter is missing
        missing('only_one', 'name');
    }
?>