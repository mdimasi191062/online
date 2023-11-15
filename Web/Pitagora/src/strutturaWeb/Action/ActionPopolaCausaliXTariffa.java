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
public class ActionPopolaCausaliXTariffa implements ActionInterface
{
  private final static String c_tipo_contr_ULL="9";
  private final static String c_tipo_contr_SHA="17";
  private final static String c_tipo_contr_ULLV="23";
  private final static String c_tipo_contr_BGSM="36";
  private final static String c_tipo_contr_ULL_DATI="37";
  private final static String c_tipo_contr_WLR="41";
  private final static String c_tipo_contr_BS_ATM="42";
  private final static String c_tipo_contr_SLA_BS_ATM="43";
  private final static String c_tipo_contr_BS_GBE="44";
  private final static String c_tipo_contr_EASY_IP_SL="1";
  private final static String c_tipo_contr_EASY_IP="13";
  
  private final static String c_tipo_contr_NP="7";
  private final static String c_tipo_contr_CPS="8";

  public ActionPopolaCausaliXTariffa()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
     String code_classe_of=request.getParameter("code_classe_of");
     String code_tipo_contr=request.getParameter("codiceTipoContratto");
     Vector vect;
   /*if (
        (
          (code_tipo_contr.compareTo(c_tipo_contr_ULL)==0)||
		   		(code_tipo_contr.compareTo(c_tipo_contr_SHA)==0)||
		   		(code_tipo_contr.compareTo(c_tipo_contr_ULLV)==0)||
		   		(code_tipo_contr.compareTo(c_tipo_contr_BGSM)==0)||
          (code_tipo_contr.compareTo(c_tipo_contr_WLR)==0)||
		   		(code_tipo_contr.compareTo(c_tipo_contr_ULL_DATI)==0)
        ) 
        && 
        (
          (code_classe_of.compareTo("5")==0)||
          (code_classe_of.compareTo("6")==0)||
          (code_classe_of.compareTo("8")==0)
          )
        )
        {
           CausaleSTLHome home=(CausaleSTLHome)EjbConnector.getHome("CausaleSTL",CausaleSTLHome.class);
           vect=home.create().getCausaliXTariffe(code_tipo_contr,code_classe_of);
        }
        else
        { */
          if( (code_classe_of.compareTo("2")!=0) && (code_classe_of.compareTo("13")!=0))
          {
            CausaleSTLHome home=(CausaleSTLHome)EjbConnector.getHome("CausaleSTL",CausaleSTLHome.class);
            vect=home.create().getCausaliXTariffe(code_tipo_contr,code_classe_of);
          }
          else
            vect=new Vector();
        /*}*/
     ViewPs view=new ViewPs(vect);
     return new Java2JavaScript().execute(view,new String[]{"descTipoCausFat","codeTipoCausFat"},new String[]{"text","value"});


  }
}