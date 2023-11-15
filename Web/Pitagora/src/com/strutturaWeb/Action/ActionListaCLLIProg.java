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

public class ActionListaCLLIProg implements ActionInterface
{
  public ActionListaCLLIProg()
  {
  }

   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

      ElencoClliProgSTLHome home=(ElencoClliProgSTLHome)EjbConnector.getHome("ElencoCLLIProgSTL",ElencoClliProgSTLHome.class); 
      ViewGenerica view=new ViewGenerica(  home.create().getAllCLLIProg());
      
      Vector vect=new Vector();
      for(int i=0;i<view.getVector().size();i++)
      { 
          ClassCLLIProg temp=new ClassCLLIProg();
          temp=(ClassCLLIProg)view.getVector().elementAt(i);
          vect.add(temp);
      }
      ViewGenerica view2=new ViewGenerica(vect);
      return new Java2JavaScript().execute(view2,new String[]{"desc_prog","code_prog"},new String[]{"text","value"});
      
  }
}