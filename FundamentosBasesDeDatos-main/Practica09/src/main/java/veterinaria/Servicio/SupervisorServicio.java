/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package veterinaria.Servicio;

import java.util.List;
import veterinaria.Modelo.Supervisor;
import veterinaria.Repositorio.SupervisorRepositorio;

/**
 * Clase que se encarga de hacer CRUD con los supervisores
 * @author Jurassic Team
 * @version  p.09
 */
public class SupervisorServicio {
    private SupervisorRepositorio supervisorRepositorio;

    public SupervisorServicio(String password){
        this.supervisorRepositorio = new SupervisorRepositorio(password);
    }

    /**
     * Metodo que se encarga de obtener a todos los supervisores
     * @return List -- La lista de los supervisores
     * @throws Exception -- En caso de que suceda algun error
     */
    public List<Supervisor> getSupervisores() throws Exception{
        return supervisorRepositorio.getSupervisores();
    }

    /**
     * Metodo que se encarga de insertar un supervisor
     * @param supervisor -- EL supervisor a insertar
     * @throws Exception  -- En caso de que suceda algun error
     */
    public void insertarSupervisor(Supervisor supervisor) throws Exception{
        supervisorRepositorio.insertarSupervisor(supervisor);
    }

    /**
     * Metodo que se encarga de obtener un supervisor
     * @param curp -- El curp del supervisor a buscar
     * @throws Exception -- En caso de que ocurra algun error
     * @return Supervisor - El supervisor buscado
     */
    public Supervisor getSupervisor(String curp)throws Exception{
        return supervisorRepositorio.getSupervisor(curp);
    }

    /**
     * Metodo que actualiza un supervisor
     * @param curp -- EL curp del supervisor a buscar
     * @param supervisor -- Los valores nuevos a actualizar
     * @throws Exception -- En caso de que ocurra algun error
     */
    public void actualizarSupervisor(String curp, Supervisor supervisor)throws Exception{
        supervisorRepositorio.actualizarSupervisor(curp, supervisor);
    }

    /**
     * Metodo que borra un supervisor
     * @param curp -- El curp del supervisor a borrar
     * @throws Exception  -- EN caso de que ocurra algun error
     */
    public void borrarSupervisor(String curp)throws Exception{
        supervisorRepositorio.borrarSupervisor(curp);
    }
}
