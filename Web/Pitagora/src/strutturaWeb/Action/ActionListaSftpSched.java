
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

public class ActionListaSftpSched implements ActionInterface
{
  public ActionListaSftpSched()
  {
  }
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
  
    
      
    Vector vect=new Vector();
    Object objs[];
    
   StatiElabBatchSTLHome home=(StatiElabBatchSTLHome)EjbConnector.getHome("StatiElabBatchSTL",StatiElabBatchSTLHome.class);
   objs=home.create().getElencoSftpEstrazioni("").toArray();
    for(int i=0;i<objs.length;i++)
    {   String messag=((SFTP_SCHED_ROW)objs[i]).getDesc_message();
        messag=messag.substring(messag.indexOf("/"),messag.indexOf(".zip"))+".zip";
        ((SFTP_SCHED_ROW)objs[i]).setDesc_message(messag);
        vect.add(((SFTP_SCHED_ROW)objs[i]));
        
    }
    ViewGenerica view=new ViewGenerica(vect);
    return new Java2JavaScript().execute(view,new String[]{"id_message","code_elab","code_utente","start_sched_time","desc_message","Modifica",},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5"});
   
  }
}