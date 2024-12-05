<?php
class ConexionRedis {
    private $host = "redis"; // Nombre del servicio en docker-compose
    private $puerto = "6379"; // Puerto por defecto de Redis
    public $conexion;

    public function obtenerConexion() {
        $this->conexion = null;

        try {
            // Crear una instancia de Redis y conectarse al servidor
            $this->conexion = new Redis();
            $this->conexion->connect($this->host, $this->puerto);

            // Verificar si la conexión fue exitosa
            if ($this->conexion->ping()) {
            }   
        } catch (RedisException $excepcion) {
            echo "Error de conexión a Redis: " . $excepcion->getMessage();
        }

        return $this->conexion;
    }
}
?>
