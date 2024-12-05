<?php
// Incluir ConexionRedis.php
require_once '/var/www/html/config/ConexionRedis.php';
class ClsCliente {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function insertarCliente($idusuario, $nombre, $apellido, $dni, $celular, $direccion, $cod_ubigeo) {
        // Consulta SQL para insertar el cliente
        $sql = "INSERT INTO cliente (id_usuario, nombre, apellido, dni, celular, direccion, cod_ubigeo) VALUES (?, ?, ?, ?, ?, ?, ?)";

        // Preparar la consulta
        $stmt = $this->conn->prepare($sql);
        
        // Ejecutar la consulta y manejar errores
        if ($stmt->execute([$idusuario, $nombre, $apellido, $dni, $celular, $direccion, $cod_ubigeo])) {
            return true; // Registro exitoso
        } else {
            // Imprimir el error detallado
            echo "Error al registrar: " . implode(", ", $stmt->errorInfo());
            return false; // Error al registrar
        }
    }

    public function obtenerDatosCliente($idUsuario) {
        // Primero, obtener los datos básicos del cliente
        $stmt = $this->conn->prepare("
            SELECT c.nombre, c.apellido, c.dni, c.celular, c.direccion, c.cod_ubigeo
            FROM cliente c
            WHERE c.id_usuario = :id_usuario
        ");
        $stmt->bindParam(':id_usuario', $idUsuario);
        $stmt->execute();
    
        if ($stmt->rowCount() > 0) {
            $datosCliente = $stmt->fetch(PDO::FETCH_ASSOC); // Obtener datos del cliente
    
            // Ahora llamamos al procedimiento almacenado para obtener la descripción del ubigeo
            $codUbigeo = $datosCliente['cod_ubigeo'];
            
            $stmtUbigeo = $this->conn->prepare("CALL obtenerDPyD(:codUbigeo)");
            $stmtUbigeo->bindParam(':codUbigeo', $codUbigeo);
            $stmtUbigeo->execute();
    
            // Obtener los resultados del procedimiento almacenado
            $datosUbigeo = $stmtUbigeo->fetchAll(PDO::FETCH_ASSOC);
            
            // Combinar los datos del cliente y del ubigeo
            return array_merge($datosCliente, $datosUbigeo);
        } else {
            return false; // No se encontró el cliente
        }
    }

    /*public function obtenerDatosCliente($idUsuario) {
        // Obtener la conexión a Redis
        $conexionRedis = new ConexionRedis();
        $redis = $conexionRedis->obtenerConexion();  // Obtener la conexión a Redis
    
        // Usar Redis para obtener los datos del usuario
        $datosUsuario = $redis->hgetall("usuario:$idUsuario");
    
        if ($datosUsuario) {
            // Verificar el id_usuario del cliente directamente
            $idCliente = $redis->hget("cliente:$idUsuario", "id_usuario");
    
            if ($idCliente) {
                // Recuperar los datos del cliente usando el id_cliente
                $datosCliente = $redis->hgetall("cliente:$idCliente");
    
                if ($datosCliente) {
                    // Retornar los datos del cliente si se encontraron
                    return $datosCliente;
                } else {
                    return "No se encontraron datos del cliente.";
                }
            } else {
                return "No se encontró el id_cliente para este usuario.";
            }
        } else {
            return "No se encontraron datos para el usuario.";
        }
    }*/
    
    
    
    

    /*public function actualizarCliente($idusuario, $nombre, $apellido, $dni, $celular, $direccion) {
        $sql = "UPDATE cliente SET nombre = ?, apellido = ?, dni = ?, celular = ?, direccion = ? WHERE id_usuario = ?";

        $stmt = $this->conn->prepare($sql);

        if ($stmt->execute([$nombre, $apellido, $dni, $celular, $direccion, $idusuario])) {
            return true;
        } else {
            echo "Error al actualizar: " . implode(", ", $stmt->errorInfo());
            return false;
        }
    }*/

    public function actualizarCliente($idusuario, $nombre, $apellido, $dni, $celular, $direccion) {
        // Obtener la conexión a Redis
        $conexion = new ConexionRedis();
        $this->redis = $conexion->obtenerConexion();
    
        // Verifica que la conexión a Redis está funcionando
        if (!$this->redis) {
            return false;
        }
    
        // Buscar todos los clientes en Redis
        $clientes = $this->redis->keys('cliente:*');
    
        // Buscar el cliente con el id_usuario coincidente
        $clienteEncontrado = false;
        foreach ($clientes as $cliente) {
            // Obtener los datos del cliente desde Redis
            $datosCliente = $this->redis->hGetAll($cliente);
    
            // Depuración (comentar o eliminar si no es necesario)
            // var_dump($datosCliente);  // Esto te ayudará a ver los datos obtenidos
    
            // Verificar si el id_usuario existe y coincide con el proporcionado
            if (isset($datosCliente['id_usuario']) && $datosCliente['id_usuario'] == $idusuario) {
                // Si se encuentra, se actualiza
                $clienteEncontrado = true;
    
                // Crear un array con los campos que se actualizarán
                $campos = [
                    "nombre" => $nombre,
                    "apellido" => $apellido,
                    "dni" => $dni,
                    "celular" => $celular,
                    "direccion" => $direccion
                ];
    
                // Actualizar todos los campos de una sola vez
                $this->redis->hMSet($cliente, $campos);
    
                return true;
            }
        }
    
        // Si no se encuentra el cliente
        if (!$clienteEncontrado) {
            return false;
        }
    }
    
    

}
?>
