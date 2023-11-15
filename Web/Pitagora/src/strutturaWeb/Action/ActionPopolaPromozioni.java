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

public class ActionPopolaPromozioni implements ActionInterface
{
  private final static String c_tipo_contr_ULL="9";
  private final static String c_tipo_contr_SHA="17";
  private final static String c_tipo_contr_ULLV="23";
  private final static String c_tipo_contr_BGSM="36";
  private final static String c_tipo_contr_ULL_DATI="37";
  private final static String c_tipo_contr_WLR="41";
  private final static String c_tipo_contr_BS_ATM="42";
  private final static String c_tipo_contr_SLUB="43";
  private final static String c_tipo_contr_BS_GBE="44";
  
  public ActionPopolaPromozioni()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String code_classe_of=request.getParameter("code_classe_of");
    String code_tipo_contr=request.getParameter("codiceTipoContratto");
    Vector vect;
     
    //R1I-13-0124 Servizi Promozioni  
    //System.out.println("code_classe_of="+code_classe_of);
    //System.out.println("codiceTipoContratto="+code_tipo_contr);

     CausaleSTLHome home=(CausaleSTLHome)EjbConnector.getHome("CausaleSTL",CausaleSTLHome.class);

     String i_code_tipo_contr = null;
     String i_code_cluster = null;
     String i_tipo_cluster = null;
     String i_code_contr = request.getParameter("code_contr");
     if ( i_code_contr != null && i_code_contr.indexOf("||") >= 0 ) {
               String[] loc_data = i_code_contr.split(Pattern.quote( "||" ) );
               i_code_contr = loc_data[0];
               i_code_tipo_contr = loc_data[3];
               i_code_cluster = loc_data[1];
               i_tipo_cluster = loc_data[2];
               
        /*vect=new Vector();
        PromozioniElem elem= new PromozioniElem();
        elem.setCodePromozione("0");
        elem.setDescPromozione("<Promozioni Non Disponibili>");
        vect.addElement(elem);*/
        vect=home.create().getLstPromozioni(i_code_tipo_contr,code_classe_of);
     } else {
        vect=home.create().getLstPromozioni(code_tipo_contr,code_classe_of);
     }
     
    ViewPs view=new ViewPs(vect);
    return new Java2JavaScript().execute(view,new String[]{"descPromozione","codePromozione"},new String[]{"text","value"});


  }
}