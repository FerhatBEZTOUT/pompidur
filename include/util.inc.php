<?php

declare(strict_types=1);

function initiales(string $name, string $surname) : string {
	
	$array_name = str_split($name);
	$array_surname = str_split($surname);
	$n = $array_name[0];
	$s = $array_surname[0];
	return strtoupper($n).". ".strtoupper($n).".";
}


?>