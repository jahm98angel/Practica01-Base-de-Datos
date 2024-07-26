
package veterinaria.Modelo;

/**
 * Clase que modela a un Estetica
 * @author Jurassic Team
 * @version  p.09
 */
public class Estetica {
    private int idEstetica;
    private String curpSupervisor;
    private String nombre;
    private boolean servicioObservacion;
    private boolean servicioBano;
    private String telefono;
    private String calle;
    private String numero;
    private String estado;
    private int cp;
    private int numConsultorios;
    private String horario;

    /**
     * Constructor por parametros que crea una estetica
     * @param idEstetica -- El id unico de la estetica
     * @param curpSupervisor -- El CURP del supervisor de la estetica
     * @param nombre -- El nombre de la estetica
     * @param servicioObservacion -- Indica si la estetica tiene servicio de observacion
     * @param servicioBano -- Indica si la estetica tiene servicio de baño
     * @param telefono  -- El codigo numero de telefono de la estetica
     * @param calle  -- La calle donde se ubica la estetica
     * @param numero  -- El numero de la calle donde se ubica la estetica
     * @param estado  -- El estado donde se ubica la estetica
     * @param cp  -- El codigo postal donde se ubica la estetica
     * @param numConsultorios -- La cantidad de consultorios que hay en la estetica
     * @param horario -- El horario en el que opera la estetica
     */
    public Estetica(int idEstetica, String curpSupervisor, String nombre, boolean servicioObservacion, boolean servicioBano, String telefono, String calle, String numero, String estado, int cp, int numConsultorios, String horario) {
      this.idEstetica = idEstetica;
      this.curpSupervisor = curpSupervisor;
      this.nombre = nombre;
      this.servicioObservacion = servicioObservacion;
      this.servicioBano = servicioBano;
      this.telefono = telefono;
      this.calle = calle;
      this.numero = numero;
      this.estado = estado;
      this.cp = cp;
      this.numConsultorios = numConsultorios;
      this.horario = horario;
    }


    /**
     * Metodo que obtiene el idEstetica
     * @return -- String el idEstetica
     */
    public int getIdEstetica() {
        return idEstetica;
    }

    /**
     * Metodo set que define el idEstetica del estetica
     * @param idEstetica -- El nuevo CURP
     */
    public void setIdEstetica(int idEstetica) {
        this.idEstetica = idEstetica;
    }

    /**
     * Metodo que obtiene el curp
     * @return -- String el curp del estetica
     */
    public String getCurpSupervisor() {
        return curpSupervisor;
    }

    /**
     * Metodo set que define el curp del estetica
     * @param curpSupervisor -- El nuevo CURP
     */
    public void setCurpSupervisor(String curpSupervisor) {
        this.curpSupervisor = curpSupervisor;
    }

    /**
     * Metodo que obtiene el nombre
     * @return -- String el nombre del estetica
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Metodo set que define el nombre del estetica
     * @param nombre -- El nuevo nombre
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Metodo que obtiene el servicioObservacion
     * @return -- boolean el servicioObservacion del estetica
     */
    public boolean getServicioObservacion() {
        return servicioObservacion;
    }

    /**
     * Metodo set que define el servicioObservacion del estetica
     * @param servicioObservacion -- El nuevo servicioObservacion
     */
    public void setServicioObservacion(boolean servicioObservacion) {
        this.servicioObservacion = servicioObservacion;
    }

    /**
     * Metodo que obtiene el servicioBano
     * @return -- boolean el servicioBano del estetica
     */
    public boolean getServicioBano() {
        return servicioBano;
    }

    /**
     * Metodo set que define el servicioBano del estetica
     * @param servicioBano -- El nuevo servicioBano
     */
    public void setServicioBano(boolean servicioBano) {
        this.servicioBano = servicioBano;
    }

    /**
     * Metodo que obtiene el telefono
     * @return -- String el telefono del estetica
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * Metodo set que define el telefono del estetica
     * @param telefono -- El nuevo telefono
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * Metodo que obtiene el numero de la calle
     * @return -- String el numero de la calle del estetica
     */
    public String getNumero() {
        return numero;
    }

    /**
     * Metodo set que define el numero de la calle del estetica
     * @param numero -- El nuevo numero
     */
    public void setNumero(String numero) {
        this.numero = numero;
    }

    /**
     * Metodo que obtiene el estado
     * @return -- String el estado del estetica
     */
    public String getEstado() {
        return estado;
    }

    /**
     * Metodo set que define el estado del estetica
     * @param estado -- El nuevo estado
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * Metodo que obtiene el cp
     * @return -- int el cp del estetica
     */
    public int getCp() {
        return cp;
    }

    /**
     * Metodo set que define el cp del estetica
     * @param cp -- El nuevo cp
     */
    public void setCp(int cp) {
        this.cp = cp;
    }

    /**
     * Metodo que obtiene la numConsultorios
     * @return -- int la numConsultorios del estetica
     */
    public int getNumConsultorios() {
        return numConsultorios;
    }

    /**
     * Metodo set que define la numConsultorios del estetica
     * @param numConsultorios -- la nueva numConsultorios
     */
    public void setNumConsultorios(int numConsultorios) {
        this.numConsultorios = numConsultorios;
    }

    /**
     * Metodo que obtiene el horario
     * @return -- String el horario del estetica
     */
    public String getHorario() {
        return horario;
    }

    /**
     * Metodo set que define el horario del estetica
     * @param horario -- El nuevo horario
     */
    public void setHorario(String horario) {
        this.horario = horario;
    }

    /**
     * Metodo toString que imprime un estetica
     * @return String -- lo que define a un estetica
     */
    @Override
    public String toString() {
        return "Estetica{" + "idEstetica=" + idEstetica + ", curpSupervisor=" + curpSupervisor + ", nombre=" + nombre + ", servicioObservacion=" + servicioObservacion + ", servicioBano=" + servicioBano + ", telefono=" + telefono + ", calle=" + calle + ", numero=" + numero + ", estado=" + estado + ", cp=" + cp + ", numConsultorios=" + numConsultorios + ", horario=" + horario + "}";
    }


}
