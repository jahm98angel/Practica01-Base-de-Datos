package laboratorio;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 * Clase que representa a un Dueño.
 * @author Jurasic Team
 * @version 22/03/2022
 */
public class Dueño extends Parseable{

    private String firstName;
    private String lastName;
    private String mothersName;
    private String curp;
    private String state;
    private String street;
    private String streetNumber;
    private int zipCode;
    private String phoneNumber;
    private Date birthday;
    private String email;
    private boolean isFrequent;

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy");

    /**
     * Metodo que regresa el Nombre(s) de un Dueño
     * @return String El Nombre(s) de un Dueño
     */
    public String getFirstName(){
        return firstName;
    }

     /**
      * Metodo que define el Nombre(s) de un Dueño
      * @param firstName El Nombre(s).
      * @throws IllegalArgumentException Cuando el valor es invalido
      */
    private void setFirstName(String firstName) throws IllegalArgumentException{
        if(firstName.length() == 0) throw new IllegalArgumentException();
        this.firstName = firstName;
    }
    /**
     * Metodo que regresa el ApellidoPaterno de un Dueño
     * @return String El ApellidoPaterno de un Dueño
     */
    public String getLastName(){
        return lastName;
    }

    /**
     * Metodo que define el ApellidoPaterno de un Dueño
     * @param lastName El ApellidoPaterno.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setLastName(String lastName) throws IllegalArgumentException{
        if(lastName.length() == 0) throw new IllegalArgumentException();
        this.lastName = lastName;
    }
    /**
     * Metodo que regresa el ApellidoMaterno de un Dueño
     * @return String El ApellidoMaterno de un Dueño
     */
    public String getMothersName(){
        return mothersName;
    }

    /**
     * Metodo que define el ApellidoMaterno de un Dueño
     * @param mothersName El ApellidoMaterno.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setMothersName(String mothersName) throws IllegalArgumentException{
        if(mothersName.length() == 0) throw new IllegalArgumentException();
        this.mothersName = mothersName;
    }
    /**
     * Metodo que regresa el CURP de un Dueño
     * @return String El CURP de un Dueño
     */
    public String getCURP(){
        return curp;
    }

    /**
     * Metodo que define el CURP de un Dueño
     * @param curp El CURP.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setCURP(String curp) throws IllegalArgumentException{
        if(curp.length() == 0) throw new IllegalArgumentException();
        this.curp = curp;
    }
    /**
     * Metodo que regresa el Estado de un Dueño
     * @return String El Estado de un Dueño
     */
    public String getState(){
        return state;
    }

    /**
     * Metodo que define el Estado de un Dueño
     * @param state El Estado.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setState(String state) throws IllegalArgumentException{
        if(state.length() == 0) throw new IllegalArgumentException();
        this.state = state;
    }
    /**
     * Metodo que regresa la Calle de un Dueño
     * @return String  Calle de un Dueño
     */
    public String getStreet(){
        return street;
    }

    /**
     * Metodo que define la Calle de un Dueño
     * @param street la Calle.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setStreet(String street) throws IllegalArgumentException{
        if(street.length() == 0) throw new IllegalArgumentException();
        this.street = street;
    }
    /**
     * Metodo que regresa el Calle# de un Dueño
     * @return String El Calle# de un Dueño
     */
    public String getStreetNumber(){
        return streetNumber;
    }

    /**
     * Metodo que define el Calle# de un Dueño
     * @param streetNumber El Calle#.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setStreetNumber(String streetNumber) throws IllegalArgumentException{
        if(streetNumber.length() == 0) throw new IllegalArgumentException();
        this.streetNumber = streetNumber;
    }
    /**
     * Metodo que regresa el CP de un Dueño
     * @return int El CP de un Dueño
     */
    public int getZipCode(){
        return zipCode;
    }

    /**
     * Metodo que define el CP de un Dueño
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
     * Metodo que regresa el NumeroTelefono de un Dueño
     * @return String El NumeroTelefono de un Dueño
     */
    public String getPhoneNumber(){
        return phoneNumber;
    }

    /**
     * Metodo que define el NumeroTelefono de un Dueño
     * @param phoneNumber El NumeroTelefono.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setPhoneNumber(String phoneNumber) throws IllegalArgumentException{
        Pattern pattern = Pattern.compile("\\d{10}");
        Matcher matcher = pattern.matcher(phoneNumber);
        boolean isValid = matcher.find();
        if(!isValid) throw new IllegalArgumentException();
        this.phoneNumber = phoneNumber;
    }
    /**
     * Metodo que regresa el Cumpleaños de un Dueño
     * @return Date El Cumpleaños de un Dueño
     */
    public Date getBirthday(){
        return birthday;
    }

    /**
     * Metodo que define el Cumpleaños de un Dueño
     * @param birthdayString El Cumpleaños.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setBirthday(String birthdayString) throws IllegalArgumentException{
        try{
            Date birthday = DATE_FORMAT.parse(birthdayString);
            this.birthday = birthday;
        }catch(ParseException pe){
            System.out.println("Valor debe ser con formato dd-MM-yyyy");
            throw new IllegalArgumentException();
        }
    }
    /**
     * Metodo que regresa el Email de un Dueño
     * @return String El Email de un Dueño
     */
    public String getEmail(){
        return firstName;
    }

    /**
     * Metodo que define el Email de un Dueño
     * @param email El Email.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setEmail(String email) throws IllegalArgumentException{
        if(email.length() == 0) throw new IllegalArgumentException();
        this.email = email;
    }

    /**
     * Metodo que regresa el EsFrequente de un Dueño
     * @return boolean El EsFrequente de un Dueño
     */
    public boolean getIsFrequent(){
        return isFrequent;
    }

    /**
     * Metodo que define el EsFrequente de un Dueño
     * @param isFrequent El EsFrequente.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setIsFrequent(boolean isFrequent){
        this.isFrequent = isFrequent;
    }

    /**
     * Metodo que regresa la representacion en cadena de un Dueño
     * @return String Representacion en cadena para ser usada en un archivo .csv
     */
    public String toString(){
        return firstName + "," + lastName + "," + mothersName + "," + curp + "," + state + "," + street + "," + streetNumber + "," + zipCode + "," + phoneNumber + "," + DATE_FORMAT.format(birthday) + "," + email + "," + isFrequent;
    }

    /**
     * Metodo que crea un dueño a partir de una cadena con el formato de un archivo CSV
     * @param dueñoString cadena con formato identico a toString().
     * @throws IllegalArgumentException Cuando el valor es invalido
     * @return Parseable - Un Dueño creado de la cadena
     */
    public static Parseable fromString(String dueñoString) throws IllegalArgumentException{
        if(dueñoString.length() == 0) throw new IllegalArgumentException();
        String[] dueñoParams = dueñoString.split(",");
        if(dueñoParams.length != 12) throw new IllegalArgumentException();

        String firstName = dueñoParams[0].trim();
        String lastName = dueñoParams[1].trim();
        String mothersName = dueñoParams[2].trim();
        String curp = dueñoParams[3].trim();
        String state = dueñoParams[4].trim();
        String street = dueñoParams[5].trim();
        String streetNumber = dueñoParams[6].trim();
        int zipCode = Integer.parseInt(dueñoParams[7].trim());
        String phoneNumber = dueñoParams[8].trim();
        String birthday = dueñoParams[9].trim();
        String email = dueñoParams[10].trim();
        boolean isFrequent= Boolean.parseBoolean(dueñoParams[11].trim());

        Dueño dueño = new Dueño();
        dueño.setFirstName(firstName);
        dueño.setLastName(lastName);
        dueño.setMothersName(mothersName);
        dueño.setCURP(curp);
        dueño.setState(state);
        dueño.setStreet(street);
        dueño.setStreetNumber(streetNumber);
        dueño.setZipCode(zipCode);
        dueño.setPhoneNumber(phoneNumber);
        dueño.setBirthday(birthday);
        dueño.setEmail(email);
        dueño.setIsFrequent(isFrequent);

        return dueño;
    }

    /**
     * Metodo que un parametro de tipo String del Dueño
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setStringField(String key, String value) throws IllegalArgumentException{
        switch (key) {
            case "firstName":
                setFirstName(value);
                break;
            case "lastName":
                setLastName(value);
                break;
            case "mothersName":
                setMothersName(value);
                break;
            case "curp":
                setCURP(value);
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
            case "email":
                setEmail(value);
                break;
            case "birthday":
                setBirthday(value);
                break;
        }
    }

    /**
     * Metodo que un parametro de float String del Dueño
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setIntField(String key, int value) throws IllegalArgumentException{
        if(key == "zipCode"){
            setZipCode(value);
        }
    }

    /**
     * Metodo que un parametro de float String del Dueño
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setFloatField(String key, float value){};

    /**
     * Metodo que un parametro de boolean String del Dueño
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setBooleanField(String key, boolean value) throws IllegalArgumentException{
        if(key == "isFrequent"){
            setIsFrequent(value);
        }
    }

}
