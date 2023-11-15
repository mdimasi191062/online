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

public class ActionListaCLLI implements ActionInterface
{
  public ActionListaCLLI()
  {
  }

   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

      String prog=request.getParameter("prog");
      String anno=request.getParameter("anno");
      ElencoClliSTLHome home=(ElencoClliSTLHome)EjbConnector.getHome("ElencoCLLISTL",ElencoClliSTLHome.class); 
      ViewGenerica view=new ViewGenerica(  home.create().getAllCLLIdaProg(prog,anno));
      
      Vector vect=new Vector();
      for(int i=0;i<view.getVector().size();i++)
      { 
          ClassCLLI temp=new ClassCLLI();
          temp=(ClassCLLI)view.getVector().elementAt(i);
          temp.setNome_sede(temp.getCode_clli()+" - "+temp.getNome_sede());
          vect.add(temp);
      }
      ViewGenerica view2=new ViewGenerica(vect);
      return new Java2JavaScript().execute(view2,new String[]{"nome_sede","code_clli"},new String[]{"text","value"});
      
  }
}