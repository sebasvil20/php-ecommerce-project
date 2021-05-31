<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/global.css">
    <link rel="stylesheet" href="styles/login.css">
    <title>Deckstore | Login</title>
</head>

<body>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="sweetalert2.all.min.js"></script>
    <?php 
        include_once 'components/header.php';
        include 'components/signupController.php';
        include 'components/loginController.php';

        if(isset($_SESSION['User'])){
            header('Location: userProfile.php');
        }
    ?>

    <div class="container">
        <div class="form-container sign-up-container">
            <form action="#" method="POST">
                <h1>Crea una cuenta</h1>
                <span class="login-span">Llena el formulario para crear una cuenta</span>
                <input type="text" placeholder="Nombre" name="firstName"  required/>
                <input type="text" placeholder="Apellido" name="lastName"  required/>
                <input type="email" placeholder="Email" name="email"  required/>
                <input type="password" placeholder="Password" name="password" pattern="{6,}" title="Minimo 6 caracteres" required/>
                <button type="submit" name="signup">Registrarse</button>
            </form>
        </div>
        <div class="form-container sign-in-container">
            <form action="#" method="POST">
                <h1>Iniciar Sesión</h1>
                <input type="email" placeholder="Email" name="email"  required/>
                <input type="password" placeholder="Password" name="password" required/>
                <button type="submit" name="login">Iniciar sesión</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>¡Bienvenido de nuevo!</h1>
                    <p>¿Quieres iniciar sesión?</p>
                    <button class="ghost" id="signIn">Iniciar sesión</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>¡Hola, Extraño¡</h1>
                    <p>Para registrarte llena tus datos en el formulario de registro</p>
                    <button class="ghost" id="signUp">Registrarse</button>
                </div>
            </div>
        </div>
    </div>



    <?php include_once 'components/footer.php' ?>

    <script>
    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.querySelector('.container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });
    </script>
</body>

</html>