<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú de Navegación</title>
    <link rel="stylesheet" href="css/barranavegacion.css"> <!-- Otros estilos generales -->
</head>
<body class="pagina-nav">
    <nav class="nav">
        <ul class="menu">
            <li><a href="index.php"><i class="fas fa-home"></i> Inicio</a></li>
            <li><a href="#nosotros"><i class="fas fa-info-circle"></i> Nosotros</a></li>
            <li><a href="#productos"><i class="fas fa-box-open"></i> Productos</a></li>
            <li><a href="#contacto"><i class="fas fa-envelope"></i> Contactanos</a></li>
            
            <?php if (isset($_SESSION['usuario']) && $_SESSION['estado'] === 'activo'): ?>
                <?php if ($_SESSION['tipo'] === 'admin'): ?>
                    <li><a href="vistas/menu_ingreso.php"><i class="fas fa-arrow-up"></i> Ingresos</a></li>
                    <li><a href="vistas/miperfil.php"><i class="fas fa-user"></i> Mi Perfil</a></li>
                    <li><a href="vistas/logout.php"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
                <?php elseif ($_SESSION['tipo'] === 'diseñador'): ?>
                    <li><a href="vistas/pedidos_asignados.php"><i class="fas fa-envelope"></i> Revisar Pedidos</a></li>
                    <li><a href="vistas/logout.php"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
                <?php elseif ($_SESSION['tipo'] === 'cajero'): ?>
                    <li><a href="vistas/historial_citas.php"><i class="fas fa-calendar-alt"></i> Citas</a></li>
                    <li><a href="vistas/pedidos.php"><i class="fas fa-envelope"></i> Asignar Pedido</a></li>
                    <li><a href="vistas/logout.php"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
                <?php else: ?>
                    <li><a href="vistas/registrar_cita.php"><i class="fas fa-calendar-alt"></i> Citas</a></li>
                    <li><a href="vistas/mispedidos.php"><i class="fas fa-envelope"></i> Mis Pedidos</a></li>
                    <li><a href="vistas/generarimagen.php"><i class="fas fa-brain"></i> Generar Imagen</a></li>
                    <li><a href="vistas/miperfil.php"><i class="fas fa-user"></i> Mi Perfil</a></li>
                    <li><a href="vistas/logout.php"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
                <?php endif; ?>
            <?php else: ?>
                <li><a href="vistas/login.php"><i class="fas fa-sign-in-alt"></i> Login</a></li>
                <li><a href="vistas/registrar.php"><i class="fas fa-user-plus"></i> Registrarme</a></li>
            <?php endif; ?>
        </ul>
    </nav>
</body>
</html>

