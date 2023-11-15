package com.strutturaWeb.Action;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import java.text.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.Action.*;
import com.strutturaWeb.*;
public class ActionDownloadReport_ElencoFileCl implements ActionInterface
{
  public ActionDownloadReport_ElencoFileCl()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String codeFunz          = Misc.nh(request.getParameter("codeFunz"));          // OBBLIGATORIO
    String tipoBatch         = Misc.nh(request.getParameter("tipoBatch"));         // OBBLIGATORIO
    String flagSys           = Misc.nh(request.getParameter("flagSys"));           // OBBLIGATORIO
    String estensione        = Misc.nh(request.getParameter("estensione"));        // OBBLIGATORIO
    String estensioneStorico = Misc.nh(request.getParameter("estensioneStorico")); // OBBLIGATORIO    
    String codeCiclo         = Misc.nh(request.getParameter("codeCiclo"));         // NON OBBLIGATORIO
    String codeServizio      = Misc.nh(request.getParameter("codeServizio"));      // OBBLIGATORIO
    String codeAccount       = Misc.nh(request.getParameter("codeAccount"));       // NON OBBLIGATORIO
    String tipoFile          = Misc.nh(request.getParameter("tipoFile"));          // NON OBBLIGATORIO
    String tipoDett          = Misc.nh(request.getParameter("tipoDett"));          // NON OBBLIGATORIO
    String pathReport        = Misc.nh(request.getParameter("pathReport"));        // NON OBBLIGATORIO
    String pathReportStorici = Misc.nh(request.getParameter("pathReportStorici")); // NON OBBLIGATORIO
    String descAccount       = Misc.nh(request.getParameter("descAccount")); // NON OBBLIGATORIO
    
   
    System.out.println("ActionDownloadReport_ElencoFile - codeFunz          ["+codeFunz+"]");
    System.out.println("ActionDownloadReport_ElencoFile - tipoBatch         ["+tipoBatch+"]");
    System.out.println("ActionDownloadReport_ElencoFile - flagSys           ["+flagSys+"]");
    System.out.println("ActionDownloadReport_ElencoFile - codeCiclo         ["+codeCiclo+"]"); 
    System.out.println("ActionDownloadReport_ElencoFile - codeServizio      ["+codeServizio+"]");
    System.out.println("ActionDownloadReport_ElencoFile - codeAccount       ["+codeAccount+"]");
    System.out.println("ActionDownloadReport_ElencoFile - tipoFile          ["+tipoFile+"]");
    System.out.println("ActionDownloadReport_ElencoFile - tipoDett          ["+tipoDett+"]");
    System.out.println("ActionDownloadReport_ElencoFile - pathReport        ["+pathReport+"]");
    System.out.println("ActionDownloadReport_ElencoFile - pathReportStorici ["+pathReportStorici+"]");
    System.out.println("ActionDownloadReport_ElencoFile - estensione        ["+estensione+"]");
    System.out.println("ActionDownloadReport_ElencoFile - estensioneStorico ["+estensioneStorico+"]");
    System.out.println("ActionDownloadReport_ElencoFile - descAccount       ["+descAccount+"]");

    Ent_DownloadReportHome home=(Ent_DownloadReportHome)EjbConnector.getHome("Ent_DownloadReport",Ent_DownloadReportHome.class);
    
    Vector vect=new Vector();
    File path;
    String[] lista;
    String path1=pathReport;
    
    
    
    try {
      
      path = new File(pathReport);
      
      // It is also possible to filter the list of returned files.
      // This example does not return any files that start with `.'.
      
      ExtensionFilter filterCorrente;
      
      
      FilenameFilter filter = new FilenameFilter() {
          public boolean accept(File dir, String name) {
              boolean ritorno=false;
              if(name.contains("importFileFatture")==true && name.contains(".done")==true)
                ritorno=true;
              return ritorno;
          }
      };

      if(codeFunz.compareToIgnoreCase("UPLOAD_MAN")==0)
      {
        lista = path.list(filter);
      }
      else
      {
        if (estensione.equals(".SAP"))
        {
            lista = path.list();
        }
        else
        {
            filterCorrente = new ExtensionFilter(estensione);
            lista = path.list(filterCorrente);
        }
      }
   
      
     
     
      /*preparazione filtri*/
      /*System.out.println("ActionDownloadReport_ElencoFile - filtri - inizio");*/
      String descrizione_ciclo = "";
      String cicloAnno = "";
      String cicloMese = "";
      String cicloGiorno = "01";
      DB_DownloadReport_Periodi paramCiclo= new DB_DownloadReport_Periodi();
      if(codeCiclo != null && !codeCiclo.equals(""))
      {
        paramCiclo=home.create().getParamCiclo(codeCiclo);
        //descrizione_ciclo = paramCiclo.getDESCRIZIONE_CICLO().substring(0,3) + paramCiclo.getDESCRIZIONE_CICLO().substring(paramCiclo.getDESCRIZIONE_CICLO().length()-4);

          
          cicloAnno = paramCiclo.getDESCRIZIONE_CICLO().substring(paramCiclo.getDESCRIZIONE_CICLO().length()-4);
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Gen")) {
              cicloMese = "01";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Feb")) {
                cicloMese = "02";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Mar")) {
                cicloMese = "03";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Apr")) {
                cicloMese = "04";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Mag")) {
                cicloMese = "05";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Giu")) {
                cicloMese = "06";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Lug")) {
                cicloMese = "07";
          }      
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Ago")) {
              cicloMese = "08";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Set")) {
                cicloMese = "09";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Ott")) {
                cicloMese = "10";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Nov")) {
                cicloMese = "11";
          }
          if (paramCiclo.getDESCRIZIONE_CICLO().substring(0,3).equals("Dic")) {
                cicloMese = "12";
          }        
          descrizione_ciclo = cicloAnno + cicloMese;
         /* System.out.println("ActionDownloadReport_ElencoFile - filtri - descrizione_ciclo   ["+descrizione_ciclo+"]");*/
      }      
     // System.out.println("ActionDownloadReport_ElencoFile - filtri - fatt_ndc   ["+fatt_ndc+"]");
      
      String tipoDettaglio="";
      if (tipoDett.equals("S"))
        tipoDettaglio="Sint";
      else  if (tipoDett.equals("D"))
       
        tipoDettaglio="Dett";
        
           
      String codeAccountSearch = "";
      if(codeAccount != null && !codeAccount.equals(""))
      {
        codeAccountSearch = descAccount.replace(" ","_");
      }
      System.out.println("ActionDownloadReport_ElencoFile - filtri - codeAccountSearch   ["+codeAccountSearch+"]");

  //    System.out.println("ActionDownloadReport_ElencoFile - filtri - fine");

   //   System.out.println("ActionDownloadReport_ElencoFile - lista.length - ["+lista.length+"]");  
      for(int i=0 ; i<lista.length ; i++) {
      //  System.out.println("Filename corrente: "+lista[i].toString());
        //System.out.println("nome file ["+lista[i]+"]");
        if (codeFunz.equals("REP_FSAV_CLASSIC"))
        {
          if (lista[i].contains("2D")||lista[i].contains("2DFC") || lista[i].contains("2A")){
            
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);
            }
        }
        else
        if (codeFunz.equals("REP_FSAR_CLASSIC"))
        {
          if (lista[i].contains("2R")||lista[i].contains("2RFC") || lista[i].contains("2A")){
            
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);
            }
        }
        else
        if (tipoBatch.equals("V"))
        {
            if(tipoFile.equals("N")){
              if(lista[i].contains(descrizione_ciclo) &&
                (lista[i].contains("NDC")||lista[i].contains("NOTE-DI-CREDITO")) && !lista[i].contains("REPRICING") &&
                  (!lista[i].contains("FATT")&&!lista[i].contains("FATTURE")) &&
                lista[i].contains(codeAccountSearch)){
                
                      ClassFileEstrazioni temp=new ClassFileEstrazioni();
                      temp.setPath_file(path1);
                      temp.setNome_file(lista[i]);
                      vect.add(temp);
                }
            }
            else if(tipoFile.equals("F")){
              if(lista[i].contains(descrizione_ciclo) &&
                 (lista[i].contains("FATT")||lista[i].contains("FATTURE")) && !lista[i].contains("REPRICING")&& 
                 !lista[i].contains("NDC") &&!lista[i].contains("NOTE-DI-CREDITO")&&
                 lista[i].contains(codeAccountSearch)){
                  
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);          }
            }
            else
            if(tipoFile.equals("C")){
              if(lista[i].contains(descrizione_ciclo) &&
                 lista[i].contains("FC") && !lista[i].contains("REPRICING")&& 
                 lista[i].contains("NDC") &&
                 lista[i].contains(codeAccountSearch)){
                  
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);          }
            }
            else
            {              
            if(lista[i].contains(descrizione_ciclo) &&
                 !lista[i].contains("REPRICING")&& 
                 lista[i].contains(codeAccountSearch)){
                ClassFileEstrazioni temp=new ClassFileEstrazioni();
                temp.setPath_file(path1);
                temp.setNome_file(lista[i]);
                vect.add(temp);          
            }
            }
          }
          else
          {
              if(tipoFile.equals("N")){
                if(lista[i].contains(descrizione_ciclo) &&
                  (lista[i].contains("NDC")||lista[i].contains("NOTE-DI-CREDITO")) && lista[i].contains("REPRICING") &&
                    !lista[i].contains("FATT") && !lista[i].contains("FATTURE") &&
                  lista[i].contains(codeAccountSearch)){
                  
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                  }
              }
              else if(tipoFile.equals("F")){
                if(lista[i].contains(descrizione_ciclo) &&
                   (lista[i].contains("FATT")||lista[i].contains("FATTURE")) && lista[i].contains("REPRICING")&& 
                   !lista[i].contains("NDC") && !lista[i].contains("NOTE-DI-CREDITO") &&
                   lista[i].contains(codeAccountSearch)){
                    
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);          }
              }
              else
              if(tipoFile.equals("C")){
                if(lista[i].contains(descrizione_ciclo) &&
                   lista[i].contains("FC") && lista[i].contains("REPRICING")&& 
                   lista[i].contains("NDC") &&
                   lista[i].contains(codeAccountSearch)){
                    
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);          }
              }
              else
              {
                  if(lista[i].contains(descrizione_ciclo) &&
                       lista[i].contains("REPRICING")&& 
                       lista[i].contains(codeAccountSearch)){
                      ClassFileEstrazioni temp=new ClassFileEstrazioni();
                      temp.setPath_file(path1);
                      temp.setNome_file(lista[i]);
                      vect.add(temp);          
                  }

              }
          }
      }
      
      
    } catch(Exception e) {
      System.out.println(e.getMessage());
    }

    ViewGenerica view2=new ViewGenerica(vect);
    return new Java2JavaScript().execute(view2,new String[]{"nome_file","nome_file","path_file"},new String[]{"text","value","path_file"});
    
  }
}
