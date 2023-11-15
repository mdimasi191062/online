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

import java.util.regex.Pattern;

public class ActionPopolaPsXTariffa implements ActionInterface
{
  public ActionPopolaPsXTariffa()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

      String code_tipo_contr=request.getParameter("codiceTipoContratto");
      String code_contr= request.getParameter("code_contr");

      ProdServSTLHome home=(ProdServSTLHome)EjbConnector.getHome("ProdServSTL",ProdServSTLHome.class);
      Vector vect;
    if(code_contr.compareTo("0")!=0)
    {
    
        if ( code_contr.indexOf("||") >= 0 ) {
            String[] loc_data = code_contr.split(Pattern.quote( "||" ) );
            vect=home.create().getPsXContrClusIns(code_tipo_contr,loc_data[0],loc_data[1],loc_data[2]);
        } else {
        
          vect=home.create().getPsXContrIns(code_tipo_contr,code_contr);
        }
    }
    else
    {
       vect=home.create().getPsTar(code_tipo_contr);
    }
    
      ViewPs view=new ViewPs(vect);
      return new Java2JavaScript().execute(view,new String[]{"descPs","codePs"},new String[]{"colonna0","colonna1"});

  }
}