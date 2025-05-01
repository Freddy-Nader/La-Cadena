<?php
$con = mysqli_connect("localhost", "root", "", "la_cadena");

if (mysqli_connect_errno()) {
    echo "<p>No se pudo realizar la conexión: " . mysqli_connect_errno() . "</p>";
}
?>