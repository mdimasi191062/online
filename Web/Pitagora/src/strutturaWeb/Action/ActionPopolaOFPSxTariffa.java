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

public class ActionPopolaOFPSxTariffa implements ActionInterface
{
  public ActionPopolaOFPSxTariffa()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
     String code_ps=request.getParameter("code_ps");
      String code_contr= request.getParameter("code_contr");
      String code_tipo_contr=request.getParameter("codiceTipoContratto");

      OggFattBMPHome home=(OggFattBMPHome)EjbConnector.getHome("OggFattBMP",OggFattBMPHome.class);
      Vector vect=new Vector();
      Object objs[];
    if(code_contr.compareTo("0")!=0)
    {
    
        if ( code_contr.indexOf("||") >= 0 ) {
            String[] loc_data = code_contr.split(Pattern.quote( "||" ) );
            objs=home.findOFPSXContrXTariffaClus(code_ps,loc_data[0],code_tipo_contr,loc_data[1],loc_data[2]).toArray();
        } else {
          objs=home.findOFPSXContrXTariffa(code_ps,code_contr,code_tipo_contr).toArray();
        }
        for(int i=0;i<objs.length;i++)
           vect.add(((OggFattBMP)objs[i]).getPrimaryKey());

    }
    else
    {
      objs=home.findOFPSXTariffa(code_ps,code_tipo_contr).toArray();
      for(int i=0;i<objs.length;i++)
         vect.add(((OggFattBMP)objs[i]).getPrimaryKey());
    }
      ViewPs view=new ViewPs(vect);
           return new Java2JavaScript().execute(view,new String[]{"descOf","codeOf","codeClasseOf"},new String[]{"text","value","classe"});

  }
}


 