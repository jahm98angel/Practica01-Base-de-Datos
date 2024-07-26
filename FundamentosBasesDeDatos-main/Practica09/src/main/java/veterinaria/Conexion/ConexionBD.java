
package veterinaria.Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Clase que permite la conexión con la base de datos
 * @author Jurassic Team
 * @version  p.09
 */
public class ConexionBD {

    private String password;

    public ConexionBD(String password){
        this.password = password;
    }

    private Connection conexion = null;
    /**
     * Metodo que hace la conexion con la Base De Datos
     * @throws SQLException -- Cuando no se establece una conexion
     */
    public void conectar() throws SQLException{
        String jdbc= "jdbc:postgresql://localhost:5432/postgres";
        conexion = DriverManager.getConnection(jdbc,"postgres",password);
        System.out.println("Conexion exitosa");
    }

    /**
     * Metodo encargado de preparar la base de datos para recibir una sentancia
     * @return Statement -- Objeto que utilizaremos para crear sentencias sql
     * @throws SQLException -- Si no se logra preparar lanza un error
     */
    public Statement prepararDeclaracion() throws SQLException{
        return conexion.createStatement();
    }

    /**
     * Metodo que prepara la base de datos para recibir una sentencia preparada
     * @param query -- La query a ejecutar
     * @return PreparedStatement -- Objeto que utilizaremos para las sentencias sql
     * @throws SQLException -- Lanza un error cuando no se logra preparar
     */
    public PreparedStatement prepararDeclaracionPreparada(String query)  throws SQLException{
        return conexion.prepareStatement(query);
    }
    /**
     * Metodo que cierra la conexion con la Base de Datos
     * @throws SQLException -- Lanza un error si no se puede cerrar exitosamente
     */
    public void cerrar() throws SQLException{
        conexion.close();
        System.out.println("Conexion finalizada");
    }
}
