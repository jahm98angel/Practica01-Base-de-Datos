package laboratorio;

import laboratorio.Dueño;

/**
 * Clase que representa a una Mascota.
 * @author Jurasic Team
 * @version 22/03/2022
 */
public class Mascota extends Parseable{

    private String name;
    private int age;
    private float weight;
    private String species;
    private String race;
    private Dueño owner;

    /**
     * Metodo que regresa el Nombre de una Mascota
     * @return String El Nombre de una Mascota
     */
    public String getName(){
        return name;
    }

    /**
     * Metodo que define el Nombre de una Mascota
     * @param firstName El Nombre.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setName(String name) throws IllegalArgumentException{
        if(name.length() == 0) throw new IllegalArgumentException();
        this.name = name;
    }

    /**
     * Metodo que regresa la Edad de una Mascota
     * @return int La Edad de una Mascota
     */
    public int getAge(){
        return age;
    }
    /**
     * Metodo que define la Edad de una Mascota
     * @param age La Edad.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setAge(int age){
        if(age < 0) throw new IllegalArgumentException();
        this.age = age;
    }
    /**
     * Metodo que regresa el peso de una Mascota
     * @return float El peso de una Mascota
     */
    public float getWeight(){
        return weight;
    }
    /**
     * Metodo que define el peso de una Mascota
     * @param age El peso.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setWeight(float weight){
        if(weight < 0) throw new IllegalArgumentException();
        this.weight = weight;
    }
    /**
     * Metodo que regresa la Especie de una Mascota
     * @return int La Especie de una Mascota
     */
    public String getSpecies(){
        return species;
    }
    /**
     * Metodo que define la Especie de una Mascota
     * @param age La Especie.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setSpecies(String species) throws IllegalArgumentException{
        if(species.length() == 0) throw new IllegalArgumentException();
        this.species = species;
    }
    /**
     * Metodo que regresa la Raza de una Mascota
     * @return String La Raza de una Mascota
     */
    public String getRace(){
        return race;
    }
    /**
     * Metodo que define la Raza de una Mascota
     * @param age La Raza.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    private void setRace(String race) throws IllegalArgumentException{
        if(race.length() == 0) throw new IllegalArgumentException();
        this.race = race;
    }
    /**
     * Metodo que regresa el Dueño de una Mascota
     * @return String el Dueño de una Mascota
     */
    public Dueño getDueño(){
        return owner;
    }
    /**
     * Metodo que define el Dueño de una Mascota
     * @param owner el Dueño.
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setDueño(Dueño owner){
        if(owner == null) throw new IllegalArgumentException();
        this.owner = owner;
    }

    /**
     * Metodo que regresa la representacion simple del nombre de un Dueño
     * @return String el nombre del Dueño de una Mascota
     */
    public String getDueñoName(){
        return owner.getFirstName()+" "+owner.getLastName()+" "+owner.getMothersName();
    }

    /**
     * Metodo que regresa la representacion en cadena de una Mascota
     * @return String Representacion en cadena para ser usada en un archivo .csv
     */
    public String toString(){
        return name + "," + age + "," + weight + "," + species + "," + race + "," + getDueñoName();
    }

    /**
     * Metodo que crea una Mascota a partir de una cadena con el formato de un archivo CSV
     * @param mascotaString cadena con formato identico a toString().
     * @throws IllegalArgumentException Cuando el valor es invalido
     * @return Parseable - una Mascota creado de la cadena
     */
    public static Parseable fromString(String mascotaString) throws IllegalArgumentException{
        if(mascotaString.length() == 0) throw new IllegalArgumentException();
        String[] mascotaParams = mascotaString.split(",");
        if(mascotaParams.length != 6) throw new IllegalArgumentException();

        String name = mascotaParams[0].trim();
        int age = Integer.parseInt(mascotaParams[0].trim());
        float weight = Float.parseFloat(mascotaParams[0].trim());
        String species = mascotaParams[0].trim();
        String race = mascotaParams[0].trim();

        Mascota mascota = new Mascota();
        mascota.setName(name);
        mascota.setAge(age);
        mascota.setWeight(weight);
        mascota.setSpecies(species);
        mascota.setRace(race);

        return mascota;
    }

    /**
     * Metodo que un parametro de tipo String de la Mascota
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setStringField(String key, String value) throws IllegalArgumentException{
        switch (key) {
            case "name":
                setName(value);
                break;
            case "species":
                setSpecies(value);
                break;
            case "race":
                setRace(value);
                break;
        }
    }

    /**
     * Metodo que un parametro de float String de la Mascota
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setIntField(String key, int value) throws IllegalArgumentException{
        if(key == "age"){
            setAge(value);
        }
    }

    /**
     * Metodo que un parametro de float String de la Mascota
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setFloatField(String key, float value) throws IllegalArgumentException{
        if(key == "weight"){
            setWeight(value);
        }
    }

    /**
     * Metodo que un parametro de boolean String de la Mascota
     * @param key El nombre del parametro a editar.
     * @param value El valor a poner
     * @throws IllegalArgumentException Cuando el valor es invalido
     */
    public void setBooleanField(String key, boolean value){};
}
