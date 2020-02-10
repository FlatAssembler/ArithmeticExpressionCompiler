<?php
$json=$_POST["password"];
if (!file_exists("key.txt"))
	exit("Cryptographic key appears not to have been generated before this program was executed. Something went very wrong.");
$file=fopen("key.txt","r");
$key=fscanf($file,"%d")[0];
$key0=$key%256;
$key1=$key/256;
fclose($file);
unlink("key.txt");
$password="";
$json=json_decode($json);
for ($i=0; $i<count($json); $i++)
    $password=$password.chr($json[$i]^(($i%2)?($key0):($key1))); //Of course, if you are going to host AEC on your website, it would be a good idea to implement some better cyphering algorithm...
$typable=1;
for ($i=0; $i<strlen($password); $i++)
    if (!(substr($password,$i)>="0" && substr($password,$i)<="9"
          || substr($password,$i)>='a' && substr($password,$i)<='z'
          || substr($password,$i)>='A' && substr($password,$i)<='Z'
          || substr($password,$i)==' '))
    $typable=0;
$hash=0;
for ($i=0; $i<strlen($password); $i++)
    $hash=($hash*127+ord(substr($password,$i)))%9907; //...and a better hashing algorithm.
if ($hash!=5834 || !$typable) //Of course, at the very least, you should set the hash and the hint to correspond to some password you know.
    exit("Incorrect password! Hint: The correct password is a short description of Digital Physics.");
$count=0;
for ($i=0; $i<100; $i++)
    if (file_exists("download".$i.".asm"))
        $count+=unlink("download".$i.".asm");
echo "$count files deleted!";
?>
