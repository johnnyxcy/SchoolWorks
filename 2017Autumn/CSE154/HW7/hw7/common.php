<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This is the common part of my webservice

    # be strict with errors
    error_reporting(E_ALL);
    
    # connect to the hw7 database
    $db = new PDO("mysql:dbname=hw7;host=localhost;charset=utf8", "root", "");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    # set the timezone
    date_default_timezone_set('America/Los_Angeles');
    
    # print out the error if parameter(s) is(are) missing.
    function missing($mode, $para1, $para2 = "") {
        $output = array();
        if ($mode == "only_one") {
            $output["error"] = "Missing ". $para1. " parameter";
        } else if ($mode == "missing_two") {
            $output["error"] = "Missing ". $para1. " and ". $para2. " parameter";
        } else if ($mode == "missing_or") {
            $output["error"] =  "Missing ". $para1. " or ". $para2. " parameter";
        }
        print(json_encode($output));
    }
?>