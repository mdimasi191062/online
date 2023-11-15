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
public class Action_J2_Caratteristiche implements ActionInterface
{
  public Action_J2_Caratteristiche()
  {
  }
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String elementi=request.getParameter("elementi");
    String tipo=request.getParameter("tipo");
    String ProdottoRif=request.getParameter("ProdottoRif");
    String ComponenteRif=request.getParameter("ComponenteRif");

    /* determinazione righe tokenizer */
    String strSingolaRiga = "";
    String strSingoloElemento = "";
    String strElementoToken = "";
    String strCarattToken = "";
    String strColocatoToken = "";
    String strTrasmissivoToken = ""; 
    String messaggio = "";
          
    int ritorno = 0;
          
    int contaElemento = 1;

    Ent_CatalogoHome home=(Ent_CatalogoHome)EjbConnector.getHome("Ent_Catalogo",Ent_CatalogoHome.class);
          
    StringTokenizer strElementoRiga = new StringTokenizer( elementi, "|" );                          
    do {
      strSingolaRiga = strElementoRiga.nextToken();
      System.out.println("strSingolaRiga ["+strSingolaRiga+"]");
      StringTokenizer strElemento = new StringTokenizer( strSingolaRiga, "$" );
      do {
        strSingoloElemento = strElemento.nextToken();
        System.out.println("strSingoloElemento ["+strSingoloElemento+"]");

        if (contaElemento == 1)
          strElementoToken = strSingoloElemento;
        else if (contaElemento == 2)
          strCarattToken = strSingoloElemento;
        else if (contaElemento == 3)
          strColocatoToken = strSingoloElemento;
        else
          strTrasmissivoToken = strSingoloElemento;

        if (contaElemento > 3)
        {
          /* effettuo l'inserimento */
          ritorno = home.create().insCaratt_x_elem(strElementoToken,tipo,strCarattToken,strColocatoToken,strTrasmissivoToken,ProdottoRif,ComponenteRif);
          contaElemento = 1;
          if (ritorno != 0)
            break;
        }else{
          contaElemento++;
        }
              
      } while ( strElemento.hasMoreElements() );
    } while ( strElementoRiga.hasMoreElements() );
          
    /* istanzio l'ejb dove fare le select - inizio */
    if (ritorno == 0)
      messaggio = "Inserimento Caratteristiche avvenuto con successo";
    else
      messaggio = "Errore durante Inserimento Caratteristiche.";
          
    return new Java2JavaScript().execute(new ViewLancioBatch(messaggio),new String[]{"_messaggio"},new String[]{"messaggio"});
  }
}
