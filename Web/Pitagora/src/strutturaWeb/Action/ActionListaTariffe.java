
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

public class ActionListaTariffe implements ActionInterface
{
  public ActionListaTariffe()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_ps=request.getParameter("code_ps");
    String code_contr= request.getParameter("code_contr");
    String code_tipo_contr=request.getParameter("codiceTipoContratto");
    String causale=request.getParameter("causale");
    String of=request.getParameter("of");

    TariffaBMP pk;
    
    Vector vect=new Vector();
    Object objs[];
    if(code_contr.compareTo("0")!=0)
    {
        if ( code_contr != null && code_contr.indexOf("||") >= 0 ) {
            String[] loc_data = code_contr.split(Pattern.quote( "||" ) ); 
            String i_code_contr_listino = loc_data[0];
            String i_code_tipo_contr_listino = loc_data[3];
            String i_code_cluster_listino = loc_data[1];
            String i_tipo_cluster_listino = loc_data[2];
 
            TariffaXContrBMPHome home=(TariffaXContrBMPHome)EjbConnector.getHome("TariffaXContrBMP",TariffaXContrBMPHome.class);
            objs=home.findTariffaClus(i_code_contr_listino, code_ps, of, causale,i_code_tipo_contr_listino,i_code_cluster_listino,i_tipo_cluster_listino).toArray();
            for(int i=0;i<objs.length;i++)
               vect.add(((TariffaXContrBMP)objs[i]).getPrimaryKey());
               
        } else {
    
          TariffaXContrBMPHome home=(TariffaXContrBMPHome)EjbConnector.getHome("TariffaXContrBMP",TariffaXContrBMPHome.class);
          objs=home.findTariffa(code_contr, code_ps, of, causale).toArray();
          for(int i=0;i<objs.length;i++)
             vect.add(((TariffaXContrBMP)objs[i]).getPrimaryKey());
             
        }
    }
    else
    {
      TariffaBMPHome home=(TariffaBMPHome)EjbConnector.getHome("TariffaBMP",TariffaBMPHome.class);
      objs=home.findTariffa(code_ps, of, causale).toArray();
      for(int i=0;i<objs.length;i++){
        pk = (TariffaBMP)objs[i];
        //String myString = NumberFormat.getInstance().format(pk.getImpTar().doubleValue());
        //System.out.println("importo = ["+myString+"]");          
        //pk.setImpTarStr(myString);
/*
        Float impFloat = new Float(pk.getImpTar().floatValue());
        pk.setImpTarFloat(impFloat);
        System.out.println("importo = ["+impFloat.floatValue()+"]");          
*/        
        vect.add(pk.getPrimaryKey());
      }
    }
      ViewPs view=new ViewPs(vect);
      return new Java2JavaScript().execute(view,new String[]{"codTar","progTar","impTarStr","flgMat","dataIniTar","dataCreazTar","codePromozione","descListinoApplicato"},new String[]{"colonna0","colonna1","colonna2","colonna3","colonna4","colonna5","colonna6","colonna7"});

  }
}