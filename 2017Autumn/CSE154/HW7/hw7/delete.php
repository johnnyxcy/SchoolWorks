<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This implements the delete feature for my webservice

    include("common.php");
    
    header("Content-Type: application/json");
    $output = array();
    
    if (isset($_GET["name"])) { # if the parameter "name" is passed
        $name = $_GET["name"];
        $result = $db->exec("DELETE FROM Pokdex WHERE name='". strtolower($name). "'");
        if ($result) { # if deleted successfully
            $output["success"] = "Success! ". $name. " removed from your Pokedex!";
        } else { # if deleted unsuccessfully
            header("HTTP/1.0 400 Bad Request");
            $output["error"] = "Error: Pokemon". $name. " not found in your Pokedex.";
        }
        print(json_encode($output));
    } else if (isset($_GET["mode"]) && $_GET["mode"] == "removeall") { # if the deleteall
        $result = $db->exec("TRUNCATE TABLE Pokdex");
        if ($result) { # if deleted successfully
            $output["success"] = "Success! All Pokemon removed from your Pokedex!";
        }
        print(json_encode($output));
    } else if (isset($_GET["mode"])) {  # if the mode is not "deleteall"
        header("HTTP/1.0 400 Bad Request");
        $output["error"] = "Error: Unknown mode ". $_GET["mode"]. ".";
        print(json_encode($output));
    } else { # if neither "name" nor "mode" is passed
        missing("missing_or", "name", "mode");
    }
?>