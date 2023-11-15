package com.strutturaWeb.Action;
import javax.servlet.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import com.ejbSTL.impl.*;
import java.text.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.Action.*;
import com.strutturaWeb.*;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import java.util.Vector;
import java.sql.*;
import com.utl.*;
import oracle.jdbc.OracleTypes;

public class ActionListaTipoServiziAssuranceXDSL implements ActionInterface
{
  public ActionListaTipoServiziAssuranceXDSL()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

     Ent_TipiServizioHome home=(Ent_TipiServizioHome)EjbConnector.getHome("Ent_TipiServizio",Ent_TipiServizioHome.class);
     ViewGenerica view=new ViewGenerica(home.create().getTipiServiziAssuranceXDSL());
     Vector vect=new Vector();
     for(int i=0;i<view.getVector().size();i++)
     {
       DB_TipiServizio temp=new DB_TipiServizio();
       temp=(DB_TipiServizio)view.getVector().elementAt(i);
       vect.add(temp);
    }
    ViewGenerica view2=new ViewGenerica(vect);
    return new Java2JavaScript().execute(view2,new String[]{"DESC_TIPO_SERVIZIO","CODE_TIPO_SERVIZIO"},new String[]{"text","value"});
  }
}