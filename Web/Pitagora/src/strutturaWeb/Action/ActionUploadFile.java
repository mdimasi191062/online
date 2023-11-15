package com.strutturaWeb.Action;

import com.oreilly.servlet.MultipartRequest;

import com.oreilly.servlet.multipart.FilePart;
import com.oreilly.servlet.multipart.MultipartParser;

import com.oreilly.servlet.multipart.ParamPart;
import com.oreilly.servlet.multipart.Part;

import com.strutturaWeb.Java2JavaScript;

import com.strutturaWeb.View.ViewGenerica;

import com.utl.Risorsa;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

import java.io.InputStreamReader;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionUploadFile implements ActionInterface
{
  public ActionUploadFile()
  {
  }

  public String esegui(HttpServletRequest request, 
                       HttpServletResponse response) throws Exception
  {
  
  
    MultipartParser multiParser ;
    multiParser = new MultipartParser(request, 1000000);
    StringBuffer tutto=new StringBuffer();
    FilePart filePart = null;  
    ParamPart paramPart = null;
    Part part = null;
    InputStreamReader inputReader = null;
    BufferedReader br = null;
    String riga=null;
    part = multiParser.readNextPart();

    while(part !=null)
    {
      if(part.isFile())
      {
        filePart = (FilePart)part;
        inputReader = new InputStreamReader(filePart.getInputStream());
        br=new BufferedReader(inputReader);
        int i=0;
        while((riga=br.readLine())!=null)
        {
        riga=riga.replace("\\","\\\\");
        if(i!=0)
            tutto.append("\\n");
        i=1;
        tutto.append(riga);
        }
        br.close();
        inputReader.close();
      }
      part = multiParser.readNextPart();
    
    }  
    br.close();
    inputReader.close();
   
    return new Java2JavaScript().execute(tutto);
   
    
      /*  Seconda versione:
      MultipartRequest multiRequest;

      multiRequest = new MultipartRequest(request,"."); 
      File f=multiRequest.getFile("datafileshown");
      BufferedReader br=new BufferedReader(new FileReader(f));
      String riga=null;
      
       StringBuffer tutto=new StringBuffer();
       int i=0;
       while((riga=br.readLine())!=null)
       {
       if(i!=0)
           tutto.append("\\n");
      i=1;
      tutto.append(riga);
             
       }
    return new Java2JavaScript().execute(tutto);
    
    */
    
    
    
    
    
    /*   Versione Iniziale:
    Vector vect=new Vector();
    while((riga=br.readLine())!=null)
    {
      Risorsa r=new Risorsa();
      r.setID_RISORSA(riga);
      vect.add(r);
    }
    ViewGenerica vg=new ViewGenerica(vect);
    return new Java2JavaScript().execute(vg,new String[]{"ID_RISORSA","ID_RISORSA"},new String[]{"text","value"});*/
  }
}
