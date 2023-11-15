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

public class ActionPopolaCongelamenti implements ActionInterface
{
  private final static String codeFunz_VALO="21";
  private final static String codeFunz_REPR="26";
  
  public ActionPopolaCongelamenti()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String tipo_batch=request.getParameter("tipo_batch");
    Vector vect;

    AccountElabSTLHome home=(AccountElabSTLHome)EjbConnector.getHome("AccountElabSTL",AccountElabSTLHome.class);
    vect=home.create().getLstServiziDaCongelare(tipo_batch);

    ViewPs view=new ViewPs(vect);
    return new Java2JavaScript().execute(view,new String[]{"descTipoContr","codeTipoContr"},new String[]{"text","value"});

  }
}