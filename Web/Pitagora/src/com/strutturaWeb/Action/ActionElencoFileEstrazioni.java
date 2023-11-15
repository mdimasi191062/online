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
import com.usr.clsInfoUser;

public class ActionElencoFileEstrazioni  implements ActionInterface
{
  public ActionElencoFileEstrazioni()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String nomeFile=request.getParameter("nomeFile");
    String path1=request.getParameter("path");
    
   // path1="C:/prova/";
    
    System.out.println("ActionElencoFileEstrazioni - nomeFile ["+nomeFile+"]" );
    System.out.println("ActionElencoFileEstrazioni - path1 ["+path1+"]" );    
    
    Vector vect=new Vector();
    File path;
    String[] lista;

    try {
      int lung;
      path = new File(path1);
      lista = path.list();
      if(nomeFile.indexOf("_") >-1 && (nomeFile.lastIndexOf(".csv")>-1 || nomeFile.lastIndexOf(".txt")>-1 || nomeFile.lastIndexOf("__")>-1 ))
      {
        nomeFile=nomeFile.substring(0,nomeFile.indexOf("_"));
        lung=nomeFile.length();
        
      } 
      else 
      {
        lung=nomeFile.length();
      }


      for(int i=0 ; i<lista.length ; i++) {
        if(lista[i].length()>nomeFile.length()){
          if(lista[i].contains(nomeFile)){
              ClassFileEstrazioni temp=new ClassFileEstrazioni();
              temp.setPath_file(path1);
              temp.setNome_file(lista[i]);
               vect.add(temp);
          }
        }
      }



    } catch(Exception e) {
      System.out.println("ActionElencoFileEstrazioni - "+e.getMessage());
    }

    ViewGenerica view2=new ViewGenerica(vect);
    return new Java2JavaScript().execute(view2,new String[]{"nome_file","path_file"},new String[]{"text","value"});
  }
}