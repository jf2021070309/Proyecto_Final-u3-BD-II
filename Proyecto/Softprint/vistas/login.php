<?php
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="../css/login.css">
</head>
<body class="fade-in">
    <div class="container"> 
        <h2>Iniciar Sesión</h2>
        <form method="POST" action="../controladores/UsuarioControlador.php?accion=login" onsubmit="return validateForm()">
            
            <div class="input-icon">
                <label for="email">Correo electrónico:</label>
                <input type="email" name="email" required placeholder="Ingresa tu Email">
                <i class="fas fa-envelope"></i> 
            </div>

            <div class="input-icon">
                <label for="password">Contraseña:</label>
                <input type="password" name="password" required placeholder="Ingresa tu Contraseña">
                <i class="fas fa-lock"></i> 
            </div>

            <div class="remember-forgot">
                <label>
                    <input type="checkbox" name="remember"> Recordarme
                </label>
                <a href="#">¿Olvidaste tu contraseña?</a>
            </div>

            <input type="submit" name="login" value="Iniciar Sesión">
        </form>

        <div class="or-divider">O con</div>

        <div class="social-buttons">
            <button class="social-btn google">
                <img src="../img/googleicono.png" alt="Google" width="20">
                Continuar con Google
            </button>
        </div>
        <p>¿No tienes una cuenta? <a href="../vistas/registrar.php">Regístrate</a></p> 
    </div>
</body>
</html>