<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This gets all the pokemons the user has found according to Pokedex Table

    include("common.php");
    
    #select all columns from the Pokedex table
    $rows = $db->query("SELECT name, nickname, datefound FROM Pokedex;");
    
    header("Content-Type: application/json");
    $output = array();
    $output["pokemon"] = array();
    
    foreach($rows as $row) {
        $output_array = array();
        $output_array["name"] = $row["name"];
        $output_array["nickname"] = $row["nickname"];
        $output_array["datefound"] = $row["datefound"];
        
        $output_array["pokemon"][] = $output_array;
    }
    
    print(json_encode($output));
?>