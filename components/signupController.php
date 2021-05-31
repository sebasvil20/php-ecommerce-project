<?php
    if(isset($_POST['signup'])){
        $firstName = $_POST['firstName'];
        $lastName = $_POST['lastName'];
        $email = $_POST['email'];
        $password = $_POST['password'];

        $passwordSalt = "6ExDpjwkp93fTRq";
        $encryptedPassword = sha1($password.$passwordSalt);
        
        include 'connection.php';

        $verifyUser = $conn -> query("CALL find_user_by_email('$email')");
        if($verifyUser -> num_rows > 0){
            ?>
                <script> 
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'El usuario ya existe, intentelo de nuevo con otro correo',
                    });
                </script>
            <?php
        }
        else{
            include 'connection.php';
            $signupUser = $conn -> query("CALL create_new_user('$firstName', '$lastName', '$email', '$encryptedPassword')");
            if($signupUser){
                ?>
                    <script>
                        Swal.fire(
                            'Exito 😎',
                            'Se ha registrado correctamente, inicie sesión para continuar',
                            'success'
                        );
                    </script>
                <?php
            }
        }
    }
?>