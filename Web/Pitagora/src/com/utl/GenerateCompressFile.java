package com.utl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.StringTokenizer;
import java.util.zip.*;


public class GenerateCompressFile{

  /*DATI INPUT
   * strElencoFile => nomefile, possibilità di passare più nome file separati dal carattere |
   * pathFile      => path provenienza file da comprimere
   * pathZipFile   => path destinazione file compresso
   * nomeFileZip   => nome file compresso
   * */
	public static int generateZipFile(String strElencoFile,String pathFile,
                                        String pathZipFile,String nomeFileZip) throws Exception
	{
    int ret = 0;
    byte[] buf = new byte[1024];
    
    try{
      System.out.println("generateZIP - inizio");
	    
      System.out.println("generateZIP - pathFile ["+pathFile+"]");
	    System.out.println("generateZIP - pathZipFile ["+pathZipFile+"]");
      System.out.println("generateZIP - nomeFileGZip ["+nomeFileZip+"]");

      //String path_nome_file = pathGZipFile+"/"+nomeFileGZip;      
      
      /*DA TOGLIERE SOLO DEBUG*/
      String fileZip = pathZipFile+"/"+nomeFileZip;
      System.out.println("generateZIP - fileZip ["+fileZip+"]");
      String strFile = null;

      try {
        // Create the ZIP file        
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(fileZip));
        
        if(strElencoFile!=null && strElencoFile.length() > 0){
          StringTokenizer stzElencoFile = new StringTokenizer(strElencoFile, "|");
          while(stzElencoFile.hasMoreTokens()){
            strFile = stzElencoFile.nextToken();
            System.out.println("generateZIP - strFile ["+strFile+"]");
            
            //String fileInputStream = pathFile+strFile;

            /*DA TOGLIERE SOLO DEBUG*/
            String fileInputStream = pathFile+strFile;
            File f  = new File(fileInputStream);
            FileInputStream in = new FileInputStream(f);
              
            // Add ZIP entry to output stream.
            out.putNextEntry(new ZipEntry(strFile));
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            in.close(); 
          }
          // Complete the entry  
        } 
        // Complete the ZIP file
        out.closeEntry();
        out.close();
        ret = 0;
        
      } catch (IOException e) {
        System.out.println(e.getMessage());
        ret = 1;
        return ret;
        
      }
    return ret;
    }catch (Exception e) {
      System.out.println(e.getMessage());
      ret = 1;
      return ret;
    }
  }
   
  public static int generateZipFileByArray(String[] strElencoFile,String pathFile,
                                        String pathZipFile,String nomeFileZip) throws Exception
  {
    int ret = 0;
    byte[] buf = new byte[1024];
    
    try{
      System.out.println("generateZipFileByArray - inizio");
      
      System.out.println("generateZipFileByArray - pathFile ["+pathFile+"]");
      System.out.println("generateZipFileByArray - pathZipFile ["+pathZipFile+"]");
      System.out.println("generateZipFileByArray - nomeFileGZip ["+nomeFileZip+"]");

      //String path_nome_file = pathGZipFile+"/"+nomeFileGZip;      
      
      /*DA TOGLIERE SOLO DEBUG*/
      String fileZip = pathZipFile+"/"+nomeFileZip;
      System.out.println("generateZipFileByArray - fileZip ["+fileZip+"]");
      String strFile = null;

      try {
        // Create the ZIP file        
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(fileZip));
        
        if(strElencoFile!=null && strElencoFile.length > 0){
          for(int i=0;i<strElencoFile.length;i++){
            strFile = strElencoFile[i];
            System.out.println("generateZipFileByArray - strFile ["+strFile+"]");
            
            //String fileInputStream = pathFile+strFile;

            /*DA TOGLIERE SOLO DEBUG*/
            String fileInputStream = pathFile+strFile;
            File f  = new File(fileInputStream);
            FileInputStream in = new FileInputStream(f);
              
            // Add ZIP entry to output stream.
            out.putNextEntry(new ZipEntry(strFile));
            int len;
            while ((len = in.read(buf)) > 0) {
                out.write(buf, 0, len);
            }
            in.close(); 
          }
          // Complete the entry  
        } 
        // Complete the ZIP file
        out.closeEntry();
        out.close();
        ret = 0;
        System.out.println("generateZipFileByArray - end");
        
      } catch (IOException e) {
        System.out.println("generateZipFileByArray - error ["+e.getMessage()+"]");
        ret = 1;
        return ret;
        
      }
    return ret;
    }catch (Exception e) {
      System.out.println("generateZipFileByArray - error generic ["+e.getMessage()+"]");
      ret = 1;
      return ret;
    }
  }

}

 