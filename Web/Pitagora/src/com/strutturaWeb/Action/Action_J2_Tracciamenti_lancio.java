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
import com.jexcel.ExcelWriter;

public class Action_J2_Tracciamenti_lancio implements ActionInterface
{
  public Action_J2_Tracciamenti_lancio()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    int ritorno = 0;
    String messaggio = "";

    String tipo_tracciamento = request.getParameter("tipo_tracciamento");
    
    System.out.println("Action_J2_Tracciamenti_lancio => esegui");
    try {
      System.out.println("Action_J2_Tracciamenti_lancio => esegui => prima");
      ritorno = ExcelWriter.main_jexcel(tipo_tracciamento);
      System.out.println("Action_J2_Tracciamenti_lancio => esegui => dopo");      
    }catch(Exception ex){
      System.out.println("Exception ExcelWriter.writeFileExcel: "+ex.toString());
    }
    
    if (ritorno == 0)
      messaggio = "File tracciamenti generato correttamente.";
    else if(ritorno == -1)
      messaggio = "File master.log non trovato.";
    else
      messaggio = "Errore generico contattare l'assistenza.";
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}