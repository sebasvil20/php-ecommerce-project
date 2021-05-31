<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/global.css">
    <link rel="stylesheet" href="styles/userProfile.css">
    <title>Deckstore | User Profile</title>
</head>
<body>
    <?php 
        session_start();
        require_once 'components/header.php';

        if(isset($_POST['logout'])){
            session_destroy();
            header('Location: login.php');
        }

        if(!isset($_SESSION['User'])){
            header('Location: login.php');
        }
    ?>

    <div class="container">
        <img src="https://i.ibb.co/pLxVZz5/mavatar.png" alt="">
        <h2>Nombre: <span> <?php echo $_SESSION['User'] -> name . " " . $_SESSION['User'] -> lastname ?> </span></h2>
        <h2>Email: <span><?php echo $_SESSION['User'] -> email ?></span></h2>
        <form action="#" method="POST">
            <button class="logout" type="submit" name="logout"> Cerrar Sesión </button>
        </form>
    </div>


    <?php
        include 'components/footer.php';
    ?>
    
</body>
</html>