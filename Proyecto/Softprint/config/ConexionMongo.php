<?php
class ConexionMongo {
    private $host = "mongodb";  // Nombre del servicio en docker-compose
    private $puerto = "27017"; // Puerto por defecto de MongoDB
    private $base_de_datos = "bdimprenta"; // Nombre de la base de datos de MongoDB
    public $conexion;

    public function obtenerConexion() {
        $this->conexion = null;

        try {
            // Crear la conexión a MongoDB
            $this->conexion = new MongoDB\Driver\Manager("mongodb://$this->host:$this->puerto");
            echo "Conexión a MongoDB exitosa";
        } catch (MongoDB\Driver\Exception\Exception $e) {
            echo "Error de conexión a MongoDB: " . $e->getMessage();
        }

        return $this->conexion;
    }
}
?>
