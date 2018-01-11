<?php
    # Chongyi Xu, 1531273
    # CSE 154 HW7 Pokedex2
    # Section AI
    # This stores my poketoken for trading and game-playing for my webservice
    # The poketoken won't refresh for 10 years (never expires)

    include("common.php");
    
    if (!isset($_COOKIE["poketoken"])) { # if the poketoken is not set yet.
        setcookie('poketoken', "poketoken_5a27476b1d4f50.47049981", 
                    time() + (10 * 365 * 24 * 60 * 60)); # 10 years to expire
    }
    header("Content-Type: text/plain");
    print("chongyix". "\n");
    print($_COOKIE["poketoken"]);
?>