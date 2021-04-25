<?php
header('Content-type: text/plain');

// Strings

$str = 'World';

$greeting = "Hello $str";

echo $greeting . "\n";


// For loop

for ($i = 1; $i < 5; $i++) {
    $number = 10 + $i;
    echo $number . "\n";
}


// Function

$list_of_numbers = [9, 5, 17, 12, 8, 2, 10];

function get_total($array) {
    $total = 0;
    foreach ($array as $item) {
        $total += $item;
    }

    return $total;
}

$total = get_total($list_of_numbers);
echo $total . "\n";
?>
