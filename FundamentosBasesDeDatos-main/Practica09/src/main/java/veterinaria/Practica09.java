package transportecolectivo.practica09;

import java.sql.SQLException;
import veterinaria.Conexion.ConexionBD;
//import veterinaria.ProgramaEjemplo.Insertar;
/**
import transportecolectivo.practica09.Conexion.ConexionBD;
import java.sql.SQLException;
import transportecolectivo.practica09.Modelo.Operador;
import transportecolectivo.practica09.Repositorio.OperadorRepositorio;
*/
/**
 * Clase que ejecuta la aplicacion de java de escritorio
 * @author Jurassic Team
 * @version 11-MAYO-2022
 */
public class Practica09 {

    public static void main(String[] pps){
        System.out.println("Ingresa la contrasena de la bd");
        String password = System.console().readLine();
        ConexionBD c = new ConexionBD(password);
        try{
            c.conectar();
            c.cerrar();
        }catch(SQLException sql){
            sql.printStackTrace();
        }
    }
}
