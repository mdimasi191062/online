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

public class ActionListaTipoContratti implements ActionInterface
{
  public ActionListaTipoContratti()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

    String pstr_NoCodeTipoContrCL = "*_*";
    String pstr_NoCodeTipoContrSP = "* *";

     Ent_TipiContrattoHome home=(Ent_TipiContrattoHome)EjbConnector.getHome("Ent_TipiContratto",Ent_TipiContrattoHome.class);
     ViewGenerica view=new ViewGenerica(home.create().getTipiContratto(pstr_NoCodeTipoContrCL,pstr_NoCodeTipoContrSP));
    Vector vect=new Vector();
    DB_TipiContratto tutti=new DB_TipiContratto();
    tutti.setCODE_TIPO_CONTR("null");
    tutti.setDESC_TIPO_CONTR("Tutti");
    vect.add(tutti);
    for(int i=0;i<view.getVector().size();i++)
    {
      DB_TipiContratto temp=new DB_TipiContratto();
      temp=(DB_TipiContratto)view.getVector().elementAt(i);
      if(temp.getFLAG_SYS().compareToIgnoreCase("S")==0)
      {
        vect.add(temp);
      }

    }
       //ViewGenerica view=new ViewGenerica(home.create().getTipiContratto("*-*","* *"));
        ViewGenerica view2=new ViewGenerica(vect);
        return new Java2JavaScript().execute(view2,new String[]{"DESC_TIPO_CONTR","CODE_TIPO_CONTR"},new String[]{"text","value"});
  }
}