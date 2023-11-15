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
public class ActionDownloadReport_ElencoFile implements ActionInterface
{
  public ActionDownloadReport_ElencoFile()
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
    
    String ullddett  = "";
    String ulldsint  = "";
    String ulldett   = "";
    String ullsint   = "";
    String vull      = "";
    
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

    Ent_DownloadReportHome home=(Ent_DownloadReportHome)EjbConnector.getHome("Ent_DownloadReport",Ent_DownloadReportHome.class);
    
    Vector vect=new Vector();
    File path;
    String[] lista;
    String path1=pathReport;
    String tipoFileBatch="";
    
    
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
      /*FilenameFilter filterCorrente = new FilenameFilter() {
        public boolean accept(File path, String name) {
            //return name.startsWith("dnmon_gcti.")&& name.endsWith(".txt");
            //return name.startsWith(NameFileOut) && name.endsWith(".csv");
            return name.endsWith(".CSV") || name.endsWith(".TXT") || name.endsWith(".TXT.Z");
        }
      };*/
     
      
     
     
      /*preparazione filtri*/
      /*System.out.println("ActionDownloadReport_ElencoFile - filtri - inizio");*/
      String descrizione_ciclo = "";
      if(codeCiclo != null && !codeCiclo.equals(""))
      {
        DB_DownloadReport_Periodi paramCiclo=home.create().getParamCiclo(codeCiclo);
        descrizione_ciclo = paramCiclo.getDESCRIZIONE_CICLO().substring(0,3) + paramCiclo.getDESCRIZIONE_CICLO().substring(paramCiclo.getDESCRIZIONE_CICLO().length()-4);
      }
     /* System.out.println("ActionDownloadReport_ElencoFile - filtri - descrizione_ciclo   ["+descrizione_ciclo+"]");*/
      
      if (tipoBatch.equals("R"))
      tipoFileBatch="_REPR_";
      else if (tipoBatch.equals("M"))
        tipoFileBatch="_MAN_";
      
      String fatt_ndc = "";
      String fatt_NO_ndc_fc = "XXXXCCCVVVBBBNNNWWWQQQ"; // Stringa impossibile
      if(tipoFile != null && !tipoFile.equals(""))
      {
        if(tipoFile.equals("F"))
          fatt_ndc = "";
        else if(tipoFile.equals("N")) {
          fatt_ndc = "NC";
          fatt_NO_ndc_fc = "_FC";
        } else if(tipoFile.equals("M"))
          fatt_ndc = "MAN";
     // CS_349 Download NDC FCI - Inizio modifica             
        else if(tipoFile.equals("C"))
          fatt_ndc = "FC";
     // CS_349 Download NDC FCI - Fine modifica
        else
          fatt_ndc = "";
      }
     // System.out.println("ActionDownloadReport_ElencoFile - filtri - fatt_ndc   ["+fatt_ndc+"]");
      
      String tipoDettaglio="";
      if (tipoDett.equals("S"))
        tipoDettaglio="Sint";
      else  if (tipoDett.equals("D"))
       
        tipoDettaglio="Dett";
        
      String descrizione_tipo_contr = "";
      if(codeServizio != null && !codeServizio.equals(""))
      {
        DB_DownloadReport_Servizi paramTipoContr=home.create().getParamTipoContr(codeServizio,tipoBatch);
        descrizione_tipo_contr = paramTipoContr.getDESC_TIPO_CONTR();
        if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
          ulldett  = home.create().getParamTipoContr("9",tipoBatch).getDESC_TIPO_CONTR() + "Dett";
          ullsint  = home.create().getParamTipoContr("9",tipoBatch).getDESC_TIPO_CONTR() + "Sint";
          ullddett = home.create().getParamTipoContr("37",tipoBatch).getDESC_TIPO_CONTR() + "Dett";
          ulldsint = home.create().getParamTipoContr("37",tipoBatch).getDESC_TIPO_CONTR() + "Sint";
          vull = home.create().getParamTipoContr("23",tipoBatch).getDESC_TIPO_CONTR();
        }
        
      }
      System.out.println("ActionDownloadReport_ElencoFile - filtri - descrizione_tipo_contr   ["+descrizione_tipo_contr+"]");
      
      String codeAccountSearch = "";
      if(codeAccount != null && !codeAccount.equals(""))
      {
        codeAccountSearch = codeAccount;
      }
   //   System.out.println("ActionDownloadReport_ElencoFile - filtri - codeAccountSearch   ["+codeAccountSearch+"]");

  //    System.out.println("ActionDownloadReport_ElencoFile - filtri - fine");

   //   System.out.println("ActionDownloadReport_ElencoFile - lista.length - ["+lista.length+"]");  

      System.out.println("ulldett ["+ulldett+"]");
      System.out.println("ullsint ["+ullsint+"]");
      System.out.println("ullddett ["+ullddett+"]");
      System.out.println("ulldsint ["+ulldsint+"]");
        
      
      for(int i=0 ; i<lista.length ; i++) {
      //  System.out.println("Filename corrente: "+lista[i].toString());
        //System.out.println("nome file ["+lista[i]+"]");
         if (codeFunz.equals("REP_FSV_SPECIAL"))
         {
           if ((lista[i].contains("1D")
                || lista[i].contains("1DFC") 
                || lista[i].contains("1A"))
                &&(!lista[i].contains("_ID"))
                &&(!lista[i].contains("_MD5"))){
             
                   ClassFileEstrazioni temp=new ClassFileEstrazioni();
                   temp.setPath_file(path1);
                   temp.setNome_file(lista[i]);
                   vect.add(temp);
             }
         }
         else
         if (codeFunz.equals("REP_FSR_SPECIAL"))
         {
           if ((lista[i].contains("1R")
              || lista[i].contains("1RFC") 
              || lista[i].contains("1A"))
              &&(!lista[i].contains("_ID"))
              &&(!lista[i].contains("_MD5"))){
             
                   ClassFileEstrazioni temp=new ClassFileEstrazioni();
                   temp.setPath_file(path1);
                   temp.setNome_file(lista[i]);
                   vect.add(temp);
             }
         }
         else
        if(tipoFile.equals("N")){
          if(lista[i].contains(descrizione_ciclo) &&
            lista[i].contains(fatt_ndc) && !lista[i].contains(fatt_NO_ndc_fc) &&
            lista[i].contains(codeAccountSearch)&&
            lista[i].contains(tipoDettaglio)&&
            lista[i].contains(descrizione_tipo_contr)&&
            lista[i].contains(tipoFileBatch) ){
            
              if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                if(codeServizio.equals("9")){
                  System.out.println("dentro ULL");
                  if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else if(codeServizio.equals("37")){
                  System.out.println("dentro ULLD");
                  if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else{
                  System.out.println("dentro VULL");
                  if(lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }
              }else{
                if (lista[i].contains(descrizione_tipo_contr)){
                  //System.out.println("caso contiene NC");
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);
                }
              }
          }
        }
        else if(tipoFile.equals("F")){
          if(lista[i].contains(descrizione_ciclo) &&
             !lista[i].contains("NC") && !lista[i].contains(fatt_NO_ndc_fc) &&
             lista[i].contains(codeAccountSearch)&&
             lista[i].contains(tipoDettaglio)&&
             lista[i].contains(descrizione_tipo_contr)&&
             lista[i].contains(tipoFileBatch) ){
              
              if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                if(codeServizio.equals("9")){
                  System.out.println("dentro ULL");
                  if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else if(codeServizio.equals("37")){
                  System.out.println("dentro ULLD");
                  if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else{
                  System.out.println("dentro VULL");
                  if(lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }
              }else{
                if (lista[i].contains(descrizione_tipo_contr)){
                  //System.out.println("caso non contiene NC--");
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);
                }
              }
          }
        }else{     
          if(lista[i].contains(descrizione_ciclo) &&
            lista[i].contains(fatt_ndc) && !lista[i].contains(fatt_NO_ndc_fc) &&
            lista[i].contains(codeAccountSearch)&&
            lista[i].contains(tipoDettaglio)&&
            lista[i].contains(descrizione_tipo_contr)&&
            lista[i].contains(tipoFileBatch) ){
              
              if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                if(codeServizio.equals("9")){
                  System.out.println("dentro ULL");
                  if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else if(codeServizio.equals("37")){
                  System.out.println("dentro ULLD");
                  if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }else{
                  System.out.println("dentro VULL");
                  if(lista[i].contains(vull)){
                    //System.out.println("caso contiene NC");
                    ClassFileEstrazioni temp=new ClassFileEstrazioni();
                    temp.setPath_file(path1);
                    temp.setNome_file(lista[i]);
                    vect.add(temp);
                  }
                }
              }else{
                if (lista[i].contains(descrizione_tipo_contr)){
                   //System.out.println("caso contiene NC");
                  ClassFileEstrazioni temp=new ClassFileEstrazioni();
                  temp.setPath_file(path1);
                  temp.setNome_file(lista[i]);
                  vect.add(temp);
                }
              }
              
          }
        }
      }
      
      if(vect.size() == 0){
        System.out.println("ActionDownloadReport_ElencoFile - Cerco nello storico");
        path1=pathReportStorici;
        path = new File(path1);
        
        ExtensionFilter filterStorico = new ExtensionFilter(estensioneStorico);
        
        /*FilenameFilter filterStorico = new FilenameFilter() {
          public boolean accept(File path, String name) {
              //return name.startsWith("dnmon_gcti.")&& name.endsWith(".txt");
              //return name.startsWith(NameFileOut) && name.endsWith(".csv");
              return name.endsWith(".TXT.Z");
          }
        };*/
        
        lista = path.list(filterStorico);
        System.out.println("ActionDownloadReport_ElencoFile - STORICO -  lista.length - ["+lista.length+"]");
        
        
          for(int i=0 ; i<lista.length ; i++) {
          //  System.out.println("Filename corrente: "+lista[i].toString());
            //System.out.println("nome file ["+lista[i]+"]");
            
            if(tipoFile.equals("N")){
              if(lista[i].contains(descrizione_ciclo) &&
                lista[i].contains(fatt_ndc) && !lista[i].contains(fatt_NO_ndc_fc) &&
                lista[i].contains(codeAccountSearch)&&
                lista[i].contains(tipoDettaglio)&&
                lista[i].contains(descrizione_tipo_contr)&&
                lista[i].contains(tipoFileBatch) ){
                
                  if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                    if(codeServizio.equals("9")){
                      System.out.println("dentro ULL");
                      if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else if(codeServizio.equals("37")){
                      System.out.println("dentro ULLD");
                      if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else{
                      System.out.println("dentro VULL");
                      if(lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }
                  }else{
                    if (lista[i].contains(descrizione_tipo_contr)){
                      //System.out.println("caso contiene NC");
                      ClassFileEstrazioni temp=new ClassFileEstrazioni();
                      temp.setPath_file(path1);
                      temp.setNome_file(lista[i]);
                      vect.add(temp);
                    }
                  }
              }
            }
            else if(tipoFile.equals("F")){
              if(lista[i].contains(descrizione_ciclo) &&
                 !lista[i].contains("NC") && !lista[i].contains(fatt_NO_ndc_fc) &&
                 lista[i].contains(codeAccountSearch)&&
                 lista[i].contains(tipoDettaglio)&&
                 lista[i].contains(descrizione_tipo_contr)&&
                 lista[i].contains(tipoFileBatch) ){
                  
                  if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                    if(codeServizio.equals("9")){
                      System.out.println("dentro ULL");
                      if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else if(codeServizio.equals("37")){
                      System.out.println("dentro ULLD");
                      if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else{
                      System.out.println("dentro VULL");
                      if(lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }
                  }else{
                    if (lista[i].contains(descrizione_tipo_contr)){
                      //System.out.println("caso non contiene NC--");
                      ClassFileEstrazioni temp=new ClassFileEstrazioni();
                      temp.setPath_file(path1);
                      temp.setNome_file(lista[i]);
                      vect.add(temp);
                    }
                  }
              }
            }else{     
              if(lista[i].contains(descrizione_ciclo) &&
                lista[i].contains(fatt_ndc) && !lista[i].contains(fatt_NO_ndc_fc) &&
                lista[i].contains(codeAccountSearch)&&
                lista[i].contains(tipoDettaglio)&&
                lista[i].contains(descrizione_tipo_contr)&&
                lista[i].contains(tipoFileBatch) ){
                  
                  if(codeServizio.equals("9") || codeServizio.equals("37") || codeServizio.equals("23")){
                    if(codeServizio.equals("9")){
                      System.out.println("dentro ULL");
                      if(!lista[i].contains(ullddett) && !lista[i].contains(ulldsint) && !lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else if(codeServizio.equals("37")){
                      System.out.println("dentro ULLD");
                      if(!lista[i].contains(ulldett) && !lista[i].contains(ullsint) &&!lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }else{
                      System.out.println("dentro VULL");
                      if(lista[i].contains(vull)){
                        //System.out.println("caso contiene NC");
                        ClassFileEstrazioni temp=new ClassFileEstrazioni();
                        temp.setPath_file(path1);
                        temp.setNome_file(lista[i]);
                        vect.add(temp);
                      }
                    }
                  }else{
                    if (lista[i].contains(descrizione_tipo_contr)){
                       //System.out.println("caso contiene NC");
                      ClassFileEstrazioni temp=new ClassFileEstrazioni();
                      temp.setPath_file(path1);
                      temp.setNome_file(lista[i]);
                      vect.add(temp);
                    }
                  }
                  
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
