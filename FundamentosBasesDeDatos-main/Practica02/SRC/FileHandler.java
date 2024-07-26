package laboratorio;

import java.util.Scanner;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileNotFoundException;


/**
 * Clase para manejar archivos de texto
 * @author Jurasic Team
 * @version 22/03/2022
 */
public class FileHandler {

    private File file;

    /**
     * Constructor, genera un archivo nuevo.
     * @param fileName El nombre del archivo a crear.
     */
    public FileHandler(String fileName){
        file = new File(fileName);
    }

    /**
     * Metodo que regresa el nombre del archivo.
     * @return String El nombre del archivo.
     */
    public String getName(){
        return file.getName();
    }

    /**
     * Metodo que indica si el archivo existe o no.
     * @return boolean True si el archivo existe, False cuando no existe.
     */
    public boolean exists(){
        return file.exists();
    }

    /**
     * Metodo que crea un archivo en el disco duro solo si no existia antes.
     * @return boolean True si el archivo se creo, False si ya estaba en disco duro.
     * @throws IOException Se da cuando ocurre algun error durante la creación.
     */
    public boolean create() throws IOException{
        try{
            boolean newFile = false;
            if (!file.exists()) {
                newFile = file.createNewFile();
                System.out.println("El archivo: " + file.getName() + " se modificó con exito.");
            }
            return newFile;
        }catch(IOException ioe){
            System.out.println("Ocurrió un error con el archivo; " + file.getName() + ", intenta de nuevo.");
            throw ioe;
        }
    }

    /**
     * Metodo que borra todos los contenidos de un archivo.
     * @throws IOException Se da cuando ocurre algun error durante la creación del nuevo archivo.
     */
    public void wipe() throws IOException{
        try{
            if(exists()){
                file.delete();
            }
            create();
        }catch(IOException ioe){
            System.out.println("Ocurrió un error con el archivo; " + file.getName() + ", intenta de nuevo.");
            throw ioe;
        }
    }

    /**
     * Metodo que escribe texto en el archivo.
     * @param text La información a escribir.
     * @param append Indica si se sobreescribe el archivo o no.
     */
    public void write(String text, boolean append){
        try{
            FileWriter writer;
            writer = new FileWriter(file, append);
            writer.write(text);
            writer.close();
        }catch (IOException ioe){
            System.out.println("Ocurrió un error con el archivo; " + file.getName() + ", intenta de nuevo.");
        }
    }


    /**
     * Metodo que lee el archivo.
     * Escanea el contenido del archivo y regresa un arreglo ton todas las lineas.
     * @return String[] contiene como elementoa cada linea del archivo.
     */
    public String[] read(){
        Scanner input = null;
        String fileText = "";
        try {
            input = new Scanner(file);
            while (input.hasNextLine()) {
                fileText += input.nextLine() + "|";
            }
        } catch (FileNotFoundException fnfe) {
            System.out.println("Ocurrió un error con el archivo; " + file.getName() + ", intenta de nuevo.");
            String[] empty = {};
            return (empty);
        }
        return fileText.split("\\|");
    }

}
