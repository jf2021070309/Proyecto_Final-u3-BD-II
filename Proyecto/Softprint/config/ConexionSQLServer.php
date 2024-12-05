<?php
class ConexionSQLServer {
    private $host = "sqlserver"; // Nombre del servicio en docker-compose
    private $puerto = "1433";    // Puerto por defecto de SQL Server
    private $nombre_bd = "bdimprenta"; // Nombre de la base de datos
    private $usuario = "sa";     // Usuario predeterminado de SQL Server
    private $contrasena = "Jkdevelopers24"; // Contraseña configurada en docker-compose
    public $conexion;

    public function obtenerConexion() {
        $this->conexion = null;

        try {
            // Crear la conexión usando PDO para SQL Server
            $dsn = "sqlsrv:Server=$this->host,$this->puerto;Database=$this->nombre_bd";
            $this->conexion = new PDO($dsn, $this->usuario, $this->contrasena);
            $this->conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            //echo "Conexión a SQL Server exitosa";
        } catch (PDOException $excepcion) {
            //echo "Error de conexión a SQL Server: " . $excepcion->getMessage();
        }

        return $this->conexion;
    }
}
?>
