<?php
    if(isset($_POST['login'])){
        include 'connection.php';
        
        if(!isset($_SESSION)){
            session_start();
        }

        $email = mysqli_real_escape_string($conn, $_POST['email']);
        $password = mysqli_real_escape_string($conn, $_POST['password']);

        $passwordSalt = "6ExDpjwkp93fTRq";
        $encryptedPassword = sha1($password.$passwordSalt);
        $verifyUser = $conn -> query("CALL login_user('$email', '$encryptedPassword')");
        if($verifyUser -> num_rows > 0){
            $userData = mysqli_fetch_object($verifyUser);
            $_SESSION['User'] = $userData;
        } 
    }
?>