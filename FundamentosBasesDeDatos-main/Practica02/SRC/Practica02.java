package laboratorio;

import laboratorio.Estetica;
import laboratorio.Mascota;
import laboratorio.Dueño;
import laboratorio.FileHandler;
import laboratorio.Parseable;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.InputMismatchException;
import java.io.IOException;

/**
 * Clase Main que sirve para ejecutar el programa manejador de archivos para la Practica02.
 * @author Jurasic Team
 * @version 22/03/2022
 */
public class Practica02 {

    final static String ESTETICA_FILE = "Estetica.csv";
    final static String DUEÑO_FILE = "Dueño.csv";
    final static String MASCOTA_FILE = "Mascota.csv";

    /**
    * Metodo principal, ejecuta el programa para operarse desde la linea de comandos.
    * @param args parametros de la linea de comandos, ninguno es necesario.
    */
    public static void main(String[] args) {

        boolean doNextAction = true;
      	int action = 0;
      	Scanner input = new Scanner(System.in);

        do{
            System.out.println("Ingresa la opción deseda\n 1-Leer datos\n 2.-Modificar datos\n 3.-Crear entrada\n 4-Nueva base de datos\n 5.-Salir");
            try{
                action = input.nextInt();
            } catch (InputMismatchException e) {
            		input.next();
            		System.out.println("Entrada no valida, elige un número 1-4 como opción");
            }
            switch (action){
                case 1:
                    System.out.println("Leyendo los datos guardados...");
                    handleFileLoad(input);
                    break;

                case 2:
                    System.out.println("Ingresa la opción deseada\n 1.-Modificar una entrada\n 2.-Borrar una entrada\n 3.-Regresar");
                    handleFileModify(input);
                    break;

                case 3:
                    System.out.println("Se creara una nueva entrada en la base de datos");
                    handleNewEntry(input);
                    break;

                case 4:
                    System.out.println("Si existen datos en los archivos estos serán borrados. ¿Continuar?\n 1-Si \n 2-No");
                    handleNewFiles(input);
                    break;

                case 5:
                    System.out.println("Bye!");
                    doNextAction = false;
                    break;

                default:
                    System.out.println("Entrada no valida, elige un número 1-3 como opción");
            }

        }while(doNextAction);
    }

    /**
    * Metodo encargado de mostrar en consola los contenidos de un archivo
    * @param input Scanner para leer la entrada de la consola.
    */
    private static void handleFileLoad(Scanner input){
        FileHandler esteticasFile = new FileHandler(ESTETICA_FILE);
        FileHandler mascotasFile = new FileHandler(MASCOTA_FILE);
        FileHandler dueñosFile = new FileHandler(DUEÑO_FILE);

        boolean tryAgain = true;
        int action = 0;
        do{
            System.out.println("Ingresa la opción deseda\n 1-Esteticas\n 2.-Dueños\n 3-Mascotas\n 4-Regresar");
            try{
                action = input.nextInt();
            } catch (InputMismatchException e) {
                input.next();
                System.out.println("Entrada no valida, elige un número 1-4 como opción");
            }

            FileHandler fileToRead = null;

            switch (action){
                case 1:
                    System.out.println("A continuacion se muestran los datos de Esteticas");
                    fileToRead = esteticasFile;
                    break;

                case 2:
                    System.out.println("A continuacion se muestran los datos de Dueños");
                    fileToRead = dueñosFile;
                    break;

                case 3:
                    System.out.println("A continuacion se muestran los datos de Mascotas");
                    fileToRead = mascotasFile;
                    break;

                case 4:
                    System.out.println("Regresando al menu anterior...");
                    tryAgain = false;
                    break;

                default:
                    System.out.println("Entrada no valida, elige un número 1-3 como opción");
            }
            if(fileToRead != null){
                String[] lines = fileToRead.read();
                for(int i = 0; i<lines.length; i++){
                    if(i==0){
                        System.out.println("    "+lines[i]);
                    }else{
                        System.out.println(i+".- "+lines[i]);
                    }
                }
            }
        }while(tryAgain);
    }

    /**
    * Metodo encargado de seleccionar una base de datos para editar
    * @param input Scanner para leer la entrada de la consola.
    * @return FileHandler La base de datos seleccionada
    */
    private static FileHandler pickDatabase(Scanner input){
        int database = 0;
        boolean tryAgain = true;
        FileHandler databaseFile = null;
        do{
            try{
                database = input.nextInt();
            }catch(InputMismatchException e){
                input.next();
                System.out.println("Entrada no valida, elige un número 1-3 como opción");
            }

            switch (database) {
                case 1:
                    databaseFile = new FileHandler(ESTETICA_FILE);
                    tryAgain = false;
                    break;
                case 2:
                    databaseFile = new FileHandler(DUEÑO_FILE);
                    tryAgain = false;
                    break;
                case 3:
                    databaseFile = new FileHandler(MASCOTA_FILE);
                    tryAgain = false;
                    break;
                default:
                    System.out.println("Entrada no valida, elige un número 1-3 como opción");
            }
        }while(tryAgain);
        System.out.println("Elegiste: "+databaseFile.getName());
        return databaseFile;
    }

    /**
    * Metodo encargado de guardar los cambios en un archivo
    * @param database La base de datos seleccionada
    * @param list Un array list con los datos que seran escritos
    */
    private static void handleFilePersist(FileHandler database, ArrayList<Parseable> list){
        try{
            String data = "";
            switch (database.getName()) {
                case ESTETICA_FILE:
                    data = "Nombre,Estado,Calle,Calle#,CP,telefono,horario,cantidadConsultorios,TieneBaño,TieneObservacion\n";
                    break;
                case MASCOTA_FILE:
                    data = "Nombre,Edad,Peso,Especie,Raza,Dueño\n";
                    break;
                case DUEÑO_FILE:
                    data = "Nombre(s),ApellidoPaterno,ApellidoMaterno,CURP,Estado,Calle,Calle#,CP,Telefono,Cumpleaños,Email,EsClienteFrequente\n";
            }
            for (Parseable line : list) {
                data += line.toString()+"\n";
            }
            database.wipe();
            database.write(data, false);
        }catch(IOException ioe){
            System.out.println("Ocurrio un error durante la escritura, revisa la integridad del archivo"+database.getName());
        }
    }

    /**
    * Metodo encargado de selecionar una entrada de una de las bases de datos
    * @param input Scanner para leer la entrada de la consola.
    * @param database La base de datos seleccionada
    * @param action la accion a realizar con la entrada que se seleccione
    * @return Parseable La entrada seleccionada
    */
    private static Parseable handleEntryPick(Scanner input, FileHandler database, String action){
        String[] lines = database.read();
        ArrayList<Parseable> list = new ArrayList<>();
        Parseable entry = null;
        for(int i = 0; i<lines.length; i++){
            if(i==0){
                System.out.println("    "+lines[i]);
            }else{
                System.out.println(i+".- "+lines[i]);
                //ya se que esto esta bien feo pero la clase parseable originalmente era una interfaz y no queria compilar
                //asi que solo se me ocurrio como arreglarlo asi, sorry :(
                //Seria facil si fuera estatico el metodo pero no se puede hacer override de un metodo estatico
                switch (database.getName()){
                    case ESTETICA_FILE:
                        Estetica dummyEstetica = new Estetica();
                        list.add(dummyEstetica.fromString(lines[i]));
                        break;
                    case DUEÑO_FILE:
                        Dueño dummyDueño = new Dueño();
                        list.add(dummyDueño.fromString(lines[i]));
                        break;
                    case MASCOTA_FILE:
                        Mascota dummyMascota = new Mascota();
                        list.add(dummyMascota.fromString(lines[i]));
                        break;
                }

            }
        }
        if(list.size() == 0){
            System.out.println("La base seleccionada no tiene datos");
            return null;
        }
        System.out.println("Ingresa el numero de la entrada");
        int index = 0;
        boolean tryAgain = true;
        do{
            try{
                index = input.nextInt() - 1;
                if(action == "pickDueño"){
                    entry = list.get(index);
                    System.out.println(entry);
                }else{
                    entry = list.remove(index);
                }
                tryAgain = false;
            }catch(InputMismatchException|IndexOutOfBoundsException e){
                input.next();
                System.out.println("Entrada no valida, elige un número 1-"+list.size());
            }
        }while(tryAgain);

        if(action == "update"){
            System.out.println("Ingresa el valor");
            entry = handleEntryModify(input, database, entry);
            list.add(entry);
            handleFilePersist(database, list);
            System.out.println("Entrada actualizada");
        }
        if(action == "delete"){
            handleFilePersist(database, list);
            System.out.println("Entrada eliminada");
        }
        if(action == "pickDueño"){
            System.out.println(entry.toString());
        }
        return entry;
    }

    /**
    * Metodo encargado de obtener el tipo y nombre de un campo en una base de datos
    * @param int Entero que representa un campo de una de las bases de datos
    * @param database La base de datos seleccionada
    *@return La informacion del campo seleccionado
    */
    private static String[] getFieldData(int chosenField, String databaseName){
        switch (databaseName) {
            case ESTETICA_FILE:
                switch (chosenField) {
                    case 1:
                        return new String[]{"String", "name"};
                    case 2:
                        return new String[]{"String", "state"};
                    case 3:
                        return new String[]{"String", "street"};
                    case 4:
                        return new String[]{"String", "streetNumber"};
                    case 6:
                        return new String[]{"String", "phoneNumber"};
                    case 7:
                        return new String[]{"String", "openHours"};
                    case 5:
                        return new String[]{"int", "zipCode"};
                    case 8:
                        return new String[]{"int", "vetOfficesAmount"};
                    case 9:
                        return new String[]{"boolean", "bathService"};
                    case 10:
                        return new String[]{"boolean", "observationService"};
                }
                break;
            case DUEÑO_FILE:
                switch (chosenField) {
                    case 1:
                        return new String[]{"String", "firstName"};
                    case 2:
                        return new String[]{"String", "lastName"};
                    case 3:
                        return new String[]{"String", "mothersName"};
                    case 4:
                        return new String[]{"String", "curp"};
                    case 5:
                        return new String[]{"String", "state"};
                    case 6:
                        return new String[]{"String", "street"};
                    case 7:
                        return new String[]{"String", "streetNumber"};
                    case 9:
                        return new String[]{"String", "phoneNumber"};
                    case 10:
                        return new String[]{"String", "birthday"};
                    case 11:
                        return new String[]{"String", "email"};
                    case 8:
                        return new String[]{"int", "zipCode"};
                    case 12:
                        return new String[]{"boolean", "isFrequent"};
                }
                break;
            case MASCOTA_FILE:
                switch(chosenField){
                    case 1:
                        return new String[]{"String", "name"};
                    case 4:
                        return new String[]{"String", "race"};
                    case 5:
                        return new String[]{"String", "species"};
                    case 2:
                        return new String[]{"int", "age"};
                    case 3:
                        return new String[]{"float", "weight"};
                    case 6:
                        System.out.println("No se puede editar el dueño de una mascota directamente, borra esta mascota y crea una nueva bajo el dueño correcto");
                        break;
                }
        }
        return new String[]{"",""};
    }

    /**
    * Metodo encargado de modificar una entrada en la base de datos en base al input del usuario
    * @param fieldData Los parametros del campo a editar
    * @param database La base de datos seleccionada
    * @param entry la entrada a ser editada
    * @return Object El nuevo valor elegido
    */
    private static Object handleInputData(String[] fieldData, FileHandler database, Parseable entry){
        Scanner input = new Scanner(System.in);
        boolean tryAgain = true;
        String fieldType = fieldData[0];
        String key = fieldData[1];
        String inputString = "";
        int inputInt = 0;
        boolean inputBoolean = false;
        float inputFloat = 0;
        Object inputData = null;
        switch (fieldType) {
            case "String":
                do{
                    try{
                        String stringValue = input.nextLine();
                        entry.setStringField(key, stringValue);
                        tryAgain = false;
                        inputData = stringValue;
                    }catch(InputMismatchException|IllegalArgumentException e){
                        System.out.println("Formato de entrada incorrecto, intenta de nuevo el valor para: "+key);
                        input.next();
                    }
                }while(tryAgain);
                break;
            case "int":
                do{
                    try{
                        int intValue = input.nextInt();
                        entry.setIntField(key, intValue);
                        tryAgain = false;
                        inputData = new Integer(intValue);
                    }catch(InputMismatchException|IllegalArgumentException e){
                        System.out.println("Formato de entrada incorrecto, debe ser un numero entero valido, intenta de nuevo el valor para: "+key);
                        input.next();
                    }
                }while(tryAgain);
                break;
            case "boolean":
                do{
                    try{
                        boolean booleanValue = input.nextBoolean();
                        entry.setBooleanField(key, booleanValue);
                        tryAgain = false;
                        inputData = new Boolean(booleanValue);
                    }catch(InputMismatchException|IllegalArgumentException e){
                        System.out.println("Formato de entrada incorrecto, debe ser true/false, intenta de nuevo el valor para: "+key);
                        input.next();
                    }
                }while(tryAgain);
                break;
            case "float":
                do{
                    try{
                        float floatValue = input.nextFloat();
                        entry.setFloatField(key, floatValue);
                        tryAgain = false;
                        inputData = new Float(floatValue);
                    }catch(InputMismatchException|IllegalArgumentException e){
                        System.out.println("Formato de entrada incorrecto, debe ser un numero de la forma 'X.Y', intenta de nuevo el valor para: "+key);
                        input.next();
                    }
                }while(tryAgain);
                break;
        }
        return inputData;
    }

    /**
    * Metodo encargado de modificar una entrada en la base de datos
    * @param input Scanner para leer la entrada de la consola.
    * @param database La base de datos seleccionada
    * @param entry la entrada a ser editada
    * @return Parseable El valor con los campos modificados
    */
    private static Parseable handleEntryModify(Scanner input, FileHandler database, Parseable entry){
        String[] fields;
        System.out.println("Valores actuales: ");
        System.out.println(entry.toString());
        System.out.println("Escoge el numero del campo a editar");
        int maxOption = 12;
        int chosenField = 0;
        boolean tryAgain = true;
        switch (database.getName()) {
            case ESTETICA_FILE:
                System.out.println(" 1.-Nombre\n 2.-Estado\n 3.-Calle\n 4.-Calle#\n 5.-CP\n 6.-telefono\n 7.-horario,\n 8.-cantidadConsultorios\n 9.-TieneBaño\n 10.-TieneObservacion");
                maxOption = 10;
                break;
            case DUEÑO_FILE:
                System.out.println(" 1.-Nombre(s)\n 2.-ApellidoPaterno\n 3.-ApellidoMaterno\n 4.-CURP\n 5.-Estado\n 6.-Calle\n 7.-Calle#\n 8.-CP\n 9.-Telefono\n 10.-Cumpleaños\n 11.-Email\n 12.-EsClienteFrequente");
                maxOption = 12;
                break;
            case MASCOTA_FILE:
                System.out.println(" 1.-Nombre\n 2.-Edad\n 3.-Peso\n 4.-Especie\n 5.-Raza\n 6.-Dueño");
                maxOption = 5;
                break;
        }
        do{
            try{
                chosenField = input.nextInt();
                if(chosenField > maxOption){
                    System.out.println("Entrada no valida, elige un número valido 1-"+maxOption);
                }
                tryAgain = chosenField > maxOption;
            }catch(InputMismatchException e){
                input.next();
                System.out.println("Entrada no valida, elige un número valido 1-"+maxOption);
            }
        }while(tryAgain);

        String[] fieldData = getFieldData(chosenField, database.getName());
        handleInputData(fieldData, database, entry);
        return entry;
    }

    /**
    * Metodo encargado de crear una nueva entrada en la base de datos
    * @param input Scanner para leer la entrada de la consola.
    */
    private static void handleNewEntry(Scanner input){
        System.out.println("Elige el elemento a crear");
        System.out.println(" 1.-Esteticas\n 2.-Dueños\n 3.-Mascotas");
        FileHandler database = pickDatabase(input);
        String[] fields;
        Parseable entry;
        switch (database.getName()) {
            case ESTETICA_FILE:
                entry = new Estetica();
                fields = new String[]{"Nombre","Estado","Calle","Calle#","CP","telefono","horario","cantidadConsultorios","TieneBaño","TieneObservacion"};
                break;
            case DUEÑO_FILE:
                entry = new Dueño();
                fields = new String[]{"Nombre(s)","ApellidoPaterno","ApellidoMaterno","CURP","Estado","Calle","Calle#","CP","telefono","Cumpleaños","Email","EsClienteFrequente"};
                break;
            case MASCOTA_FILE:
                entry = new Mascota();
                fields = new String[]{"Nombre","Edad","Peso","Especie","Raza"};
                break;
            default:
                entry = null;
                fields = new String[]{};
        }
        for(int i=0; i<fields.length; i++){
            String[] fieldData = getFieldData(i+1,database.getName());
            System.out.println("Ingresa el valor para: "+fields[i]);
            Object inputData = handleInputData(fieldData, database, entry);
            System.out.println("Valor guardado: "+inputData.toString());
        }
        if(database.getName() == MASCOTA_FILE){
            System.out.println("Elige un dueño para la mascota");
            FileHandler ownerDatabase = new FileHandler(DUEÑO_FILE);
            Dueño owner =(Dueño) handleEntryPick(input, ownerDatabase, "pickDueño");
            if(owner == null){
              System.out.println("Error escogiendo dueño");
              return;
            }
            Mascota mascota =(Mascota) entry;
            mascota.setDueño(owner);
        }
        database.write(entry.toString()+"\n", true);
        System.out.println("Se agregó el valor con exito");
    }

    /**
    * Metodo encargado elegir una base de datos para despues modificar una de sus entradas
    * @param input Scanner para leer la entrada de la consola.
    */
    private static void handleFileModify(Scanner input){
        int action = 0;
        boolean tryAgain = true;
        FileHandler database;
        Parseable entry;
        do{
            try{
                action = input.nextInt();
            }catch(InputMismatchException e){
                input.next();
                System.out.println("Entrada no valida, elige un número 1-3 como opción");
            }
            switch (action) {
                case 1:
                    tryAgain = false;
                    System.out.println("Elige la base de datos que quieres modificar");
                    System.out.println(" 1.-Esteticas\n 2.-Dueños\n 3.-Mascotas");
                    database = pickDatabase(input);
                    handleEntryPick(input, database, "update");
                    break;
                case 2:
                    tryAgain = false;
                    System.out.println("Elige la base de datos que quieres modificar");
                    System.out.println(" 1.-Esteticas\n 2.-Dueños\n 3.-Mascotas");
                    database = pickDatabase(input);
                    handleEntryPick(input, database, "delete");
                    break;
                case 3:
                    System.out.println("Regresando al menu anterior...");
                    tryAgain = false;
                default:
                    System.out.println("Entrada no valida, elige un número 1-2 como opción");
            }
        }while(tryAgain);
    }

    /**
    * Metodo encargado inicializar las bases de datos o borrarlas por completo
    * @param input Scanner para leer la entrada de la consola.
    */
    private static void handleNewFiles(Scanner input){
        int wipeFiles = 0;
        boolean tryAgain = true;

        do{
            try{
                wipeFiles = input.nextInt();
            } catch (InputMismatchException e) {
                input.next();
                System.out.println("Entrada no valida, elige un número 1-2 como opción");
            }
            switch (wipeFiles) {
                case 1:
                    System.out.println("Eliminado...");
                    FileHandler esteticasFile = new FileHandler(ESTETICA_FILE);
                    FileHandler mascotasFile = new FileHandler(MASCOTA_FILE);
                    FileHandler dueñosFile = new FileHandler(DUEÑO_FILE);
                    try{
                        esteticasFile.wipe();
                        esteticasFile.write("Nombre,Estado,Calle,Calle#,CP,telefono,horario,cantidadConsultorios,TieneBaño,TieneObservacion\n",false);
                        mascotasFile.wipe();
                        mascotasFile.write("Nombre,Edad,Peso,Especie,Raza,Dueño\n",false);
                        dueñosFile.wipe();
                        dueñosFile.write("Nombre(s),ApellidoPaterno,ApellidoMaterno,CURP,Estado,Calle,Calle#,CP,Telefono,Cumpleaños,Email,EsClienteFrequente\n",false);
                    }catch(IOException ioe){
                        tryAgain = false;
                        break;
                    }
                    System.out.println("La base de datos ha sido limpiada, elige 'Cargar datos' en el menu para empezar a llenarla");
                    tryAgain = false;
                    break;
                case 2:
                    System.out.println("Los datos guardados no han sido afectados");
                    tryAgain = false;
                    break;
                default:
                    System.out.println("Entrada no valida, elige un número 1-2 como opción");
            }
        }while(tryAgain);
    }

}
