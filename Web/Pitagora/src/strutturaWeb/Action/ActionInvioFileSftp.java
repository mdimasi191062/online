package com.strutturaWeb.Action;

import java.util.StringTokenizer;
import java.util.Vector;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.*;
import javax.rmi.PortableRemoteObject;
import com.ejbSTL.Ent_Contratti;
import com.ejbSTL.Ent_ContrattiHome;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.*;

public class ActionInvioFileSftp implements ActionInterface
{
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String mb= "";
    int res = 0;
    
    Ent_ContrattiHome ent_contrattiHome=null;
    Ent_Contratti ent_ValAttiva=null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    
    String nomeFileZip = "";
    String nomeFileCheckEmail = "";
    
    System.out.println("ActionInvioFileSftp - inizio");
    
    try{
      
      String sourcePath = Misc.nh(request.getParameter("path"));      
      String pathZip = sourcePath+"zip_file";      

      System.out.println("ActionInvioFileSftp - sourcePath ["+sourcePath+"]");
      System.out.println("ActionInvioFileSftp - pathZip ["+pathZip+"]");
      
      String nomeFile = Misc.nh(request.getParameter("nomeFile"));      
      nomeFileCheckEmail = nomeFile;
      System.out.println("ActionInvioFileSftp - nomeFile ["+nomeFile+"]");
      
      StringTokenizer stzElencoFile = new StringTokenizer(nomeFile, ".");
      nomeFileZip = stzElencoFile.nextToken()+".zip";
      
      System.out.println("ActionInvioFileSftp - nomeFileZip ["+nomeFileZip+"]");
 
      res = GenerateCompressFile.generateZipFile(nomeFile,sourcePath,pathZip,nomeFileZip);
      System.out.println("ActionInvioFileSftp - res ["+res+"]");
      if (res == 1)
        res = 2;
      
      if(res==0)
      {
        String destinationPath = "/usr/shk/prod/wholesale/FTP_AREA/JPB";
        //String destinationPath = "/home/jpubrac/ESTRAZIONI";
      
        try{
        //  res = Sftp.main_sftp("ias10g","10.41.84.29",22,"/home/ias10g/.ssh","id_rsa","known_hosts",pathZip,destinationPath,nomeFileZip);
        //  res = Sftp.main_sftp("jpubrac","10.50.16.8",22,"/home/ias10g/.ssh","id_rsa","known_hosts",pathZip,destinationPath,nomeFileZip);
         res = Sftp.main_sftp("shkwhjpb","10.170.196.7",22,"/home/ias10g/.ssh","id_rsa","known_hosts",pathZip,destinationPath,nomeFileZip);
        }catch(Exception e)
        {
          System.out.println(e.getMessage());
          mb="Errore nell''invio del file SFTP!";
          res = 1;
        }
        
        if (res == 0) 
        {
          try
          {

            lcls_Contesto = new InitialContext();
            homeObject = lcls_Contesto.lookup("Ent_Contratti");
            ent_contrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
            I52Estrazioni_cvidya_lanci ritorno = (I52Estrazioni_cvidya_lanci)ent_contrattiHome.create().getDatiObjFileEstrazioni(nomeFileCheckEmail);
            
            if(ritorno != null){
              System.out.println("ActionInvioFileSftp - codeTipoContr     ["+ritorno.getCode_tipo_contr()+"]");
              System.out.println("ActionInvioFileSftp - dataInizioPeriodo ["+ritorno.getData_inizio_periodo()+"]");
              System.out.println("ActionInvioFileSftp - dataFinePeriodo   ["+ritorno.getData_fine_periodo()+"]");
              System.out.println("ActionInvioFileSftp - descTipoContr     ["+ritorno.getDescrizione_ciclo()+"]");            
            }
            else
            {
              throw new Exception("Dati non trovati nella tabella I5_2ESTRAZIONI_CVIDIA_LANCI!");
            }
            
          
            new SendMail2(ritorno.getCode_tipo_contr(),
                        ritorno.getData_inizio_periodo(),
                        ritorno.getData_fine_periodo(),
                        ritorno.getDescrizione_ciclo());
            
            mb="Invio file SFTP e email avvenuto con successo!";

          }catch(Exception e){
            System.out.println(e.getMessage());
            res = 1;
            mb="Errore invio email!";
          }
        }
      }
     
      if(res==0)
        mb="Invio file SFTP e email avvenuto con successo!";
      else if(res==1)
        mb="Errore invio email!!";
      else if(res==2)
        mb="Errore generazione file commpress!!";
      else
        mb="Errore SFTP";
     
      return new Java2JavaScript().execute(new ViewLancioBatch(mb),new String[]{"_messaggio"},new String[]{"messaggio"});

    }
    catch (Exception e)
    {
      System.out.println("ActionInvioFileSftp - exception ["+e.getMessage()+"]");
      mb="Impossibile lanciare il batch per problemi tecnici!";
      return new Java2JavaScript().execute(new ViewLancioBatch(mb),new String[]{"_messaggio"},new String[]{"messaggio"});
    }
  }
}