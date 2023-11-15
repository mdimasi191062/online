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

public class ActionListaAnniEstrazione implements ActionInterface
{
  public ActionListaAnniEstrazione()
  {
  }

   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

     
      ElencoClliSTLHome home=(ElencoClliSTLHome)EjbConnector.getHome("ElencoCLLISTL",ElencoClliSTLHome.class); 
      ViewGenerica view=new ViewGenerica(  home.create().getAnniEstrazione());
      
      Vector vect=new Vector();
      ClassCLLI seleziona=new ClassCLLI();
      seleziona.setCode_clli("-1");
      seleziona.setNome_sede("Seleziona un Anno");
      vect.add(seleziona);
      for(int i=0;i<view.getVector().size();i++)
      { 
         
          ClassCLLI temp=new ClassCLLI();
          temp=(ClassCLLI)view.getVector().elementAt(i);
          vect.add(temp);
      }
      ViewGenerica view2=new ViewGenerica(vect);
      return new Java2JavaScript().execute(view2,new String[]{"nome_sede","code_clli"},new String[]{"text","value"});
      
  }
}