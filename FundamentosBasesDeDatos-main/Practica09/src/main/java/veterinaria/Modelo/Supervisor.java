
package veterinaria.Modelo;

import java.sql.Date;
import java.sql.Time;

/**
 * Clase que modela a un Supervisor
 * @author Jurassic Team
 * @version  p.09
 */
public class Supervisor {
    private String curp;
    private String telefono;
    private String calle;
    private String numero;
    private String estado;
    private int cp;
    private Date fechaNac;
    private String nombre;
    private String paterno;
    private String materno;
    private float salario;
    private String genero;
    private String periodo;
    private String rfc;
    private Time horaInicio;
    private Time horaFin;


    /**
     * Constructor por parametros que crea un supervisor
     * @param curp -- El CURP del supervisor
     * @param telefono  -- El codigo numero de telefono del supervisor
     * @param calle  -- La calle donde vive el supervisor
     * @param numero  -- El numero de la calle donde vive el supervisor
     * @param estado  -- El estado donde vive el supervisor
     * @param cp  -- El codigo postal donde vive el supervisor
     * @param fechaNac  -- La fecha de nacimiento del supervisor
     * @param nombre -- El nombre del supervisor
     * @param paterno -- El apellido Paterno del supervisor
     * @param materno -- El apellido Materno del supervisor
     * @param salario -- El salario del supervisor
     * @param genero -- El genero Materno del supervisor
     * @param periodo -- El horario de trabajo del supervisor
     * @param rfc -- La ciudad donde vive el supervisor
     * @param horaInicio -- La hora en la que inicia el trabajo del supervisor
     * @param horaFin -- La hora en la que termina el trabajo del supervisor
     */
    public Supervisor(String curp, String telefono, String calle, String numero, String estado, int cp, Date fechaNac, String nombre, String paterno, String materno, float salario, String genero, String periodo, String rfc, Time horaInicio, Time horaFin) {
        this.curp = curp;
        this.telefono = telefono;
        this.calle = calle;
        this.numero = numero;
        this.estado = estado;
        this.cp = cp;
        this.fechaNac = fechaNac;
        this.nombre = nombre;
        this.paterno = paterno;
        this.materno = materno;
        this.salario = salario;
        this.genero = genero;
        this.periodo = periodo;
        this.rfc = rfc;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
    }

    /**
     * Metodo que obtiene el curp
     * @return -- String el curp del supervisor
     */
    public String getCurp() {
        return curp;
    }

    /**
     * Metodo set que define el curp del supervisor
     * @param curp -- El nuevo CURP
     */
    public void setCurp(String curp) {
        this.curp = curp;
    }

    /**
     * Metodo que obtiene el telefono
     * @return -- String el telefono del supervisor
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * Metodo set que define el telefono del supervisor
     * @param telefono -- El nuevo telefono
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * Metodo que obtiene la calle
     * @return -- String la calle del supervisor
     */
    public String getCalle() {
        return calle;
    }

    /**
     * Metodo set que define la calle del supervisor
     * @param calle -- la nueva calle
     */
    public void setCalle(String calle) {
        this.calle = calle;
    }

    /**
     * Metodo que obtiene el numero de la calle
     * @return -- String el numero de la calle del supervisor
     */
    public String getNumero() {
        return numero;
    }

    /**
     * Metodo set que define el numero de la calle del supervisor
     * @param numero -- El nuevo numero
     */
    public void setNumero(String numero) {
        this.numero = numero;
    }

    /**
     * Metodo que obtiene el estado
     * @return -- String el estado del supervisor
     */
    public String getEstado() {
        return estado;
    }

    /**
     * Metodo set que define el estado del supervisor
     * @param estado -- El nuevo estado
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }

    /**
     * Metodo que obtiene el cp
     * @return -- int el cp del supervisor
     */
    public int getCp() {
        return cp;
    }

    /**
     * Metodo set que define el cp del supervisor
     * @param cp -- El nuevo cp
     */
    public void setCp(int cp) {
        this.cp = cp;
    }

    /**
     * Metodo que obtiene la fechaNac
     * @return -- Date la fechaNac del supervisor
     */
    public Date getFechaNac() {
        return fechaNac;
    }

    /**
     * Metodo set que define la fechaNac del supervisor
     * @param fechaNac -- la nueva fechaNac
     */
    public void setFechaNac(Date fechaNac) {
        this.fechaNac = fechaNac;
    }

    /**
     * Metodo que obtiene el nombre
     * @return -- String el nombre del supervisor
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Metodo set que define el nombre del supervisor
     * @param nombre -- El nuevo nombre
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Metodo que obtiene el paterno
     * @return -- String el paterno del supervisor
     */
    public String getPaterno() {
        return paterno;
    }

    /**
     * Metodo set que define el paterno del supervisor
     * @param paterno -- El nuevo paterno
     */
    public void setPaterno(String paterno) {
        this.paterno = paterno;
    }

    /**
     * Metodo que obtiene el materno
     * @return -- String el materno del supervisor
     */
    public String getMaterno() {
        return materno;
    }

    /**
     * Metodo set que define el materno del supervisor
     * @param materno -- El nuevo materno
     */
    public void setMaterno(String materno) {
        this.materno = materno;
    }

    /**
     * Metodo que obtiene el salario
     * @return -- String el salario del supervisor
     */
    public float getSalario() {
        return salario;
    }

    /**
     * Metodo set que define el salario del supervisor
     * @param salario -- El nuevo salario
     */
    public void setSalario(float salario) {
        this.salario = salario;
    }

    /**
     * Metodo que obtiene el genero
     * @return -- String el genero del supervisor
     */
    public String getGenero() {
        return genero;
    }

    /**
     * Metodo set que define el genero del supervisor
     * @param genero -- El nuevo genero
     */
    public void setGenero(String genero) {
        this.genero = genero;
    }

    /**
     * Metodo que obtiene el periodo
     * @return -- String el periodo del supervisor
     */
    public String getPeriodo() {
        return periodo;
    }

    /**
     * Metodo set que define el periodo del supervisor
     * @param periodo -- El nuevo periodo
     */
    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    /**
     * Metodo que obtiene el rfc
     * @return -- String el rfc del supervisor
     */
    public String getRfc() {
        return rfc;
    }

    /**
     * Metodo set que define el rfc del supervisor
     * @param rfc -- El nuevo rfc
     */
    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    /**
     * Metodo que obtiene el horaInicio
     * @return -- Time el horaInicio del supervisor
     */
    public Time getHoraInicio() {
        return horaInicio;
    }

    /**
     * Metodo set que define el horaInicio del supervisor
     * @param horaInicio -- El nuevo horaInicio
     */
    public void setHoraInicio(Time horaInicio) {
        this.horaInicio = horaInicio;
    }

    /**
     * Metodo que obtiene el horaFin
     * @return -- Time el horaFin del supervisor
     */
    public Time getHoraFin() {
        return horaFin;
    }

    /**
     * Metodo set que define el horaFin del supervisor
     * @param horaFin -- El nuevo horaFin
     */
    public void setHoraFin(Time horaFin) {
        this.horaFin = horaFin;
    }

    /**
     * Metodo toString que imprime un supervisor
     * @return String -- lo que define a un supervisor
     */
    @Override
    public String toString() {
        return "Supervisor{" + "curp=" + curp +", telefono=" + telefono +", calle=" + calle +", numero=" + numero +", estado=" + estado +", cp=" + cp +", fechaNac=" + fechaNac +", nombre=" + nombre +", paterno=" + paterno +", materno=" + materno +", salario=" + salario +", genero=" + genero +", periodo=" + periodo +", rfc=" + rfc +", horaInicio=" + horaInicio +", horaFin=" + horaFin + "}";
    }


}
