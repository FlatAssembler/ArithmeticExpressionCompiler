<?php
    $sessionId=$_POST["sessionId"];
    if (!($sessionId>-1 && $sessionId<101))
        exit("Can't determine the sessionID.");
    $key=rand(0,256*256-1); //Of course, you should use some better algorithm for generating pseudo-random numbers.
    $file=fopen("key.txt","w");
    fprintf($file,"%d",$key);
    fclose($file);
    echo $key+256*$sessionId+$sessionId;
?>
