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

public class ActionListaUnitaMisura implements ActionInterface
{
  public ActionListaUnitaMisura()
  {
  }
    public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
  
      UnitaMisuraSTLHome home=(UnitaMisuraSTLHome)EjbConnector.getHome("UnitaMisuraSTL",UnitaMisuraSTLHome.class);
      ViewAccounts view=new ViewAccounts(home.create().getUm());
      return new Java2JavaScript().execute(view,new String[]{"descUnitaMisura","codeUnitaMisura"},new String[]{"text","value"});
   
  }
}