<?php
include("conexion.php");

$name = mysqli_real_escape_string($con, $_POST['name']);
$lastname = mysqli_real_escape_string($con, $_POST['lastname']);
$email = mysqli_real_escape_string($con, $_POST['email']);
$date = mysqli_real_escape_string($con, $_POST['date']);
$password = mysqli_real_escape_string($con, $_POST['password']);
$query = "INSERT INTO usuarios (nombre, apellidos, email, fecha_nacimiento, contraseña) VALUES ('$name', '$lastname', '$email', '$date', '$password');";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiki Tiki</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../components/components.js"></script>
</head>

<body>
    <load-navbar></load-navbar>

    <main class="container">
        <?php
        if (mysqli_query($con, $query)) {
            die("Error: " . mysqli_error($con));
        }
        echo '<div class="alert alert-success"><strong>¡Éxito!</strong> Se ha registrado el usuario correctamente.</div>';
        mysqli_close($con);
        ?>
        <a href="../../" class="btn btn-success">Regresar al inicio</a>
    </main>

    <load-footer></load-footer>
</body>

</html>