package veterinaria.Repositorio;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;
import java.sql.Time;
import veterinaria.Conexion.ConexionBD;
import veterinaria.Modelo.Supervisor;

/**
 * Clase que permite las operaciones CRUD de la tabla Supervisor de la base de datos
 * @author Jurassic Team
 * @version  p.09
 */
public class SupervisorRepositorio {
    private ConexionBD conexion;
    //Objeto para ejecutar queries
    private Statement stmt;
    //Objeto para prepara un querie para su ejecucion
    private PreparedStatement ps;

    public SupervisorRepositorio(String password){
        this.conexion = new ConexionBD(password);
    }

    /**
    * Metodo que construye un supervisor a partir de un elemento del result set
    * @param rs - Elemento del result set
    * @return Supervisor - El supervisor nuevo
    */
    private Supervisor buildSupervisor(ResultSet rs) throws SQLException{
        Supervisor sup = new Supervisor(
          rs.getString("CURP"),
          rs.getString("telefono"),
          rs.getString("calle"),
          rs.getString("numero"),
          rs.getString("estado"),
          rs.getInt("cp"),
          rs.getDate("fechaNac"),
          rs.getString("nombre"),
          rs.getString("paterno"),
          rs.getString("materno"),
          rs.getFloat("salario"),
          rs.getString("genero"),
          rs.getString("periodo"),
          rs.getString("RFC"),
          rs.getTime("horaInicio"),
          rs.getTime("horaFin")
        );
        System.out.println(sup.toString());
        return sup;
    }

    /**
     * Metodo que se conecta a la base de datos y obtiene todas las entradas de los supervisores
     *
     * @return List Una lista de supervisores
     * @throws SQLException -- Excepcion que sale si no se logra a hacer la query de la consulta o la conexion
     */
    public List<Supervisor> getSupervisores() throws SQLException{
        String query = "SELECT * FROM supervisor"; //Escribimos nuestra query
        List supervisorLista = new ArrayList<Supervisor>();
        try{
            conexion.conectar();
            stmt = conexion.prepararDeclaracion();
            ResultSet rs = stmt.executeQuery(query);
            while(rs.next()){
                Supervisor sup = buildSupervisor(rs);
                supervisorLista.add(sup);
            }
        }catch(SQLException sql){
            sql.printStackTrace();
        }finally{
            try{
                conexion.cerrar();
            }catch(SQLException sql){
                sql.printStackTrace();
            }
        }
        return supervisorLista;
    }

    /**
     * Metodo que obtiene a un supervisor dentro de la base a partir de su curp
     * @param curp -- La curp del supervisor a buscar
     * @return Supervisor -- El supervisor en caso de encontrarse null, en otro caso
     * @throws SQLException --Excepcion que sale si no se logra a hacer
     * la query de la consulta o la conexion
     */
    public Supervisor getSupervisor(String curp) throws SQLException{
        String query = "SELECT * FROM supervisor WHERE CURP = ?";
        Supervisor sup = null;
        try{
            //Conectamos a la Base
            conexion.conectar();
            //Preparamos la Base para la consulta
            ps = conexion.prepararDeclaracionPreparada(query);
            //Modificamos la consulta, para ver que sustituira
            ps.setString(1, curp);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                sup = buildSupervisor(rs);
            }
        }catch(SQLException sql){
            sql.printStackTrace();
        }finally{
            try{
                conexion.cerrar();
            }catch(SQLException sql){
                sql.printStackTrace();
            }
        }
        return sup;
    }

    /**
     * Metodo que inserta un supervisor dentro de la base de datos
     * @param supervisor -- El supervisor que deseamos insertar en la base de datos
     */
    public void insertarSupervisor(Supervisor supervisor){
        String query = "INSERT INTO supervisor "
                + "(CURP, telefono, calle, numero, estado, cp, fechaNac, nombre, paterno, materno, salario, genero, periodo, RFC, horaInicio, horaFin)"
                + " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try{
            conexion.conectar();

            ps = conexion.prepararDeclaracionPreparada(query);
            ps.setString(1, supervisor.getCurp());
            ps.setString(2, supervisor.getTelefono());
            ps.setString(3, supervisor.getCalle());
            ps.setString(4, supervisor.getNumero());
            ps.setString(5, supervisor.getEstado());
            ps.setInt(6, supervisor.getCp());
            ps.setDate(7, supervisor.getFechaNac());
            ps.setString(8, supervisor.getNombre());
            ps.setString(9, supervisor.getPaterno());
            ps.setString(10, supervisor.getMaterno());
            ps.setFloat(11, supervisor.getSalario());
            ps.setString(12, supervisor.getGenero());
            ps.setString(13, supervisor.getPeriodo());
            ps.setString(14, supervisor.getRfc());
            ps.setTime(15, supervisor.getHoraInicio());
            ps.setTime(16, supervisor.getHoraFin());

            ps.executeUpdate();
        }catch(SQLException sql){
            sql.printStackTrace();
        }finally{
            try{
                conexion.cerrar();
            }catch(SQLException sql){
                sql.printStackTrace();
            }
        }
    }

    /**
     * Metodo que actualiza un supervisor dentro de la base de datos
     * @param curp -- El curp del supervisor a buscar para actualizar
     * @param supervisor -- El supervisor que vamos a intercambiar sus valores
     */
    public void actualizarSupervisor(String curp, Supervisor supervisor){
        String query = "UPDATE supervisor SET "
                        + "CURP=?, telefono=?, calle=?, numero=?, estado=?, cp=?, fechaNac=?, nombre=?, paterno=?, materno=?, salario=?, genero=?, periodo=?, RFC=?, horaInicio=?, horaFin=?";
        try{
            conexion.conectar();

            ps = conexion.prepararDeclaracionPreparada(query);
            ps.setString(1, supervisor.getCurp());
            ps.setString(2, supervisor.getTelefono());
            ps.setString(3, supervisor.getCalle());
            ps.setString(4, supervisor.getNumero());
            ps.setString(5, supervisor.getEstado());
            ps.setInt(6, supervisor.getCp());
            ps.setDate(7, supervisor.getFechaNac());
            ps.setString(8, supervisor.getNombre());
            ps.setString(9, supervisor.getPaterno());
            ps.setString(10, supervisor.getMaterno());
            ps.setFloat(11, supervisor.getSalario());
            ps.setString(12, supervisor.getGenero());
            ps.setString(13, supervisor.getPeriodo());
            ps.setString(14, supervisor.getRfc());
            ps.setTime(15, supervisor.getHoraInicio());
            ps.setTime(16, supervisor.getHoraFin());

            ps.executeUpdate();
        }catch(SQLException sql){
            sql.printStackTrace();
        }finally{
            try{
                conexion.cerrar();
            }catch(SQLException sql){
                sql.printStackTrace();
            }
        }
    }

    /**
     * Metodo para borrar un supervisor
     * @param curp -- Curp del supervisor a eliminar
     * @return Boolean -- true si se realizo, false en caso contrario
     */
    public Boolean borrarSupervisor(String curp){
        String query = "DELETE FROM supervisor WHERE CURP = ?";
        boolean ok = false;
        try{
            conexion.conectar();
            ps = conexion.prepararDeclaracionPreparada(query);
            ps.setString(1, curp);
            ps.executeUpdate();
            ok = true;
        }catch(SQLException sql){
            sql.printStackTrace();
        }finally{
            try{
                conexion.cerrar();
            }catch(SQLException sql){
                sql.printStackTrace();
            }
        }
       return ok;
    }

}
