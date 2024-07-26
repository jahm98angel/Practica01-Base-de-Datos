package laboratorio;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Clase que representa a una Estetica.
 * @author Jurasic Team
 * @version 22/03/2022
 */
public class Estetica extends Parseable{

    private String name;
    private String state;
    private String street;
    private String streetNumber;
    private int zipCode;
    private String phoneNumber;
    private String openHours;
    private int vetOfficesAmount;
    private boolean bathService;
    private boolean observationService;

    public static final int MAX_VET_OFFICES = 4;

    /**
     * Metodo que regresa el Nombre de una Estetica
     * @return String El Nombre de una Estetica
     */
    public String getName(){
        return name;
    }

    /**
     * Metodo que define el Nombre de una Estetica
     * @param name El Nombre.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setName(String name) throws IllegalArgumentException{
        if(name.length() == 0) throw new IllegalArgumentException();
        this.name = name;
    }
    /**
     * Metodo que regresa el Estado de una Estetica
     * @return String El Estado de una Estetica
     */
    public String getState(){
        return state;
    }
    /**
     * Metodo que define el Estado de una Estetica
     * @param state El Estado.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setState(String state) throws IllegalArgumentException{
        if(state.length() == 0) throw new IllegalArgumentException();
        this.state = state;
    }
    /**
     * Metodo que regresa la Calle de una Estetica
     * @return String  Calle de una Estetica
     */
    public String getStreet(){
        return street;
    }
    /**
     * Metodo que define la Calle de una Estetica
     * @param street la Calle.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setStreet(String street) throws IllegalArgumentException{
        if(street.length() == 0) throw new IllegalArgumentException();
        this.street = street;
    }
    /**
     * Metodo que regresa el Calle# de una Estetica
     * @return String El Calle# de una Estetica
     */
    public String getStreetNumber(){
        return streetNumber;
    }
    /**
     * Metodo que define el Calle# de una Estetica
     * @param streetNumber El Calle#.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setStreetNumber(String streetNumber) throws IllegalArgumentException{
        if(streetNumber.length() == 0) throw new IllegalArgumentException();
        this.streetNumber = streetNumber;
    }
    /**
     * Metodo que regresa el CP de una Estetica
     * @return int El CP de una Estetica
     */
    public int getZipCode(){
        return zipCode;
    }
    /**
     * Metodo que define el CP de una Estetica
     * @param zipCode El CP.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setZipCode(int zipCode) throws IllegalArgumentException{
        if(zipCode < 10000 || zipCode > 99999){
          System.out.println("Valor debe ser entre 10000 y 99999");
          throw new IllegalArgumentException();
        }
        this.zipCode = zipCode;
    }
    /**
     * Metodo que regresa el NumeroTelefono de una Estetica
     * @return String El NumeroTelefono de una Estetica
     */
    public String getPhoneNumber(){
        return phoneNumber;
    }
    /**
     * Metodo que define el NumeroTelefono de una Estetica
     * @param phoneNumber El NumeroTelefono.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setPhoneNumber(String phoneNumber) throws IllegalArgumentException{
        Pattern pattern = Pattern.compile("[1234567890]{10}");
        Matcher matcher = pattern.matcher(phoneNumber);
        boolean isValid = matcher.find();
        if(!isValid){
            System.out.println("Valor deben de ser solo 10 digitos");
            throw new IllegalArgumentException();
        }
        this.phoneNumber = phoneNumber;
    }

    /**
     * Metodo que regresa el Horario de una Estetica
     * @return String El Horario de una Estetica
     */
    public String getOpenHours(){
        return openHours;
    }
    /**
     * Metodo que define el horario de una Estetica
     * @param openHours El horario.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setOpenHours(String openHours) throws IllegalArgumentException{
      if(openHours.length() == 0) throw new IllegalArgumentException();
      this.openHours = openHours;
    }
    /**
     * Metodo que regresa el CantidadConsultorios de una Estetica
     * @return int El CantidadConsultorios de una Estetica
     */
    public int getVetOfficesAmount(){
        return vetOfficesAmount;
    }
    /**
     * Metodo que define el CantidadConsultorios de una Estetica
     * @param vetOfficesAmount El CantidadConsultorios.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setVetOfficesAmount(int vetOfficesAmount) throws IllegalArgumentException{
        if(vetOfficesAmount < 0 || vetOfficesAmount > MAX_VET_OFFICES) {
            System.out.println("Valor debe ser entre 0 y "+MAX_VET_OFFICES);
            throw new IllegalArgumentException();
        };
        this.vetOfficesAmount = vetOfficesAmount;
    }
    /**
     * Metodo que regresa el TieneBaño de una Estetica
     * @return boolean El TieneBaño de una Estetica
     */
    public boolean getBathService(){
        return bathService;
    }
    /**
     * Metodo que define el TieneBaño de una Estetica
     * @param bathService El TieneBaño.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setBathService(boolean bathService){
        this.bathService = bathService;
    }
    /**
     * Metodo que regresa el tieneObservacion de una Estetica
     * @return boolean El tieneObservacion de una Estetica
     */
    public boolean getObservationService(){
        return observationService;
    }
    /**
     * Metodo que define el tieneObservacion de una Estetica
     * @param observationService El tieneObservacion.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setObservationService(boolean observationService){
        this.observationService = observationService;
    }

    /**
     * Metodo que regresa la representacion en cadena de una Estetica
     * @return String Representacion en cadena para ser usada en un archivo .csv
     */
    public String toString(){
        return name + "," + state + "," + street + "," + streetNumber + "," + zipCode + "," + phoneNumber + "," + openHours + "," + vetOfficesAmount + "," + bathService + "," + observationService;
    }
    /**
     * Metodo que crea una Estetica a partir de una cadena con el formato de un archivo CSV
     * @param esteticaString cadena con formato identico a toString().
     * @throws IllegalArgumentException Cuando el valor es invalido
     * @return Parseable - una Estetica creado de la cadena
     */
    public static Parseable fromString(String esteticaString) throws IllegalArgumentException{
        if(esteticaString.length() == 0) throw new IllegalArgumentException();
        String[] esteticaParams = esteticaString.split(",");
        if(esteticaParams.length != 10) throw new IllegalArgumentException();
        String name = esteticaParams[0].trim();
        String state = esteticaParams[1].trim();
        String street = esteticaParams[2].trim();
        String streetNumber = esteticaParams[3].trim();
        int zipCode = Integer.parseInt(esteticaParams[4].trim());
        String phoneNumber = esteticaParams[5].trim();
        String openHours = esteticaParams[6].trim();
        int vetOfficesAmount = Integer.parseInt(esteticaParams[7].trim());
        boolean bathService = Boolean.parseBoolean(esteticaParams[8].trim());
        boolean observationService = Boolean.parseBoolean(esteticaParams[9].trim());
        Estetica estetica = new Estetica();
        estetica.setName(name);
        estetica.setState(state);
        estetica.setStreet(street);
        estetica.setStreetNumber(streetNumber);
        estetica.setZipCode(zipCode);
        estetica.setPhoneNumber(phoneNumber);
        estetica.setOpenHours(openHours);
        estetica.setVetOfficesAmount(vetOfficesAmount);
        estetica.setBathService(bathService);
        estetica.setObservationService(observationService);
        return estetica;
    }

    /**
     * Metodo que un parametro de tipo String del Estetica
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setStringField(String key, String value) throws IllegalArgumentException{
        switch (key) {
            case "name":
                setName(value);
                break;
            case "state":
                setState(value);
                break;
            case "street":
                setStreet(value);
                break;
            case "streetNumber":
                setStreetNumber(value);
                break;
            case "phoneNumber":
                setPhoneNumber(value);
                break;
            case "openHours":
                setOpenHours(value);
                break;
        }
    }

    /**
     * Metodo que un parametro de float String del Estetica
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setIntField(String key, int value) throws IllegalArgumentException{
        switch(key){
            case "zipCode":
                setZipCode(value);
                break;
            case "vetOfficesAmount":
                setVetOfficesAmount(value);
                break;
        }
    }

    /**
     * Metodo que un parametro de float String del Estetica
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setFloatField(String key, float value){};

    /**
     * Metodo que un parametro de boolean String del Estetica
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setBooleanField(String key, boolean value){
        switch(key){
            case "bathService":
                setBathService(value);
                break;
            case "observationService":
                setObservationService(value);
                break;
        }
    }
}
