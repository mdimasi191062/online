package com.service;

import com.model.ValorPathModel;

import com.repository.ReportRepository;

import com.utl.ExtensionFilter;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ReportService {

    private ReportRepository reportRepository; 
    private File file;
    private  String[] listaFilesStorico = null;
    private String type = null;

    public ReportService() {
    this.reportRepository = new ReportRepository();
    }
    
    public ValorPathModel getInfoFromType(String type) throws RemoteException,
                                                              SQLException {
        
        ValorPathModel path = new ValorPathModel();
        
        path = this.reportRepository.getInfoFromType(type);
        
        return path;
    }
    
    public Vector<ValorPathModel> getResulListPathFiles(String codeServizio, 
                                                        String descServizio, 
                                                        String codeFunzione, 
                                                        String descAccount, 
                                                        String codePeriodo, 
                                                        String tipoDettaglio,
                                                        String tipoReport) throws RemoteException,
                                                                                   SQLException {
        
        Vector<ValorPathModel> results = new Vector<ValorPathModel>();
        
        ValorPathModel path = this.getInfoFromType(codeFunzione);
        
        Vector<String> nameFiles = getListFiles(path);
        
        this.type = path.getExtFile();
        
        for(int i = 0; i<nameFiles.size(); i++){
            
            String nameFile = nameFiles.get(i);
            
            if(
                nameFile.contains(this.type) && (
                nameFile.contains((descServizio==null?"":descServizio)) &&
                (nameFile.contains(("R".equals(codeFunzione)?"_REPR_":"")) || !nameFile.contains(("V".equals(codeFunzione)?"_REPR_":""))) &&
                //nameFile.contains((codeAccount==null?"":codeAccount)) &&
                (nameFile.contains(("N".equals(tipoReport)?"_NC":"")) || !nameFile.contains(("F".equals(tipoReport)?"_NC":""))) &&
                nameFile.contains((codePeriodo==null?"":codePeriodo)) &&
                nameFile.contains((descAccount==null?"":descAccount)) &&
                nameFile.contains((tipoDettaglio==null?"":tipoDettaglio)) 
              )
            ){
                ValorPathModel item = new ValorPathModel();
                item.setNameFile(nameFile);
                item.setDescr(path.getDescr());
                item.setCode(path.getCode());
                results.add(item);
            }
        }
        
        return results;
        
    }
    
    private Vector<String> getListFiles(ValorPathModel path){
    
        Vector<String> nameFiles = new Vector<String>();
        
        //ExtensionFilter filterCorrente = new ExtensionFilter(path.getExtFileStorico());
        ExtensionFilter filterCorrente = new ExtensionFilter(path.getExtFile());
         
        //file = new File(path.getPathStorico());
        file = new File(path.getPathReport());
         
        listaFilesStorico = file.list(filterCorrente);
                
        for(int i=0 ; i<listaFilesStorico.length ; i++) {
            String nameFile = listaFilesStorico[i];
            nameFiles.add(nameFile);
            System.out.println(nameFile);
        }
        
        return nameFiles;
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
