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
import com.strutturaWeb.*;
import com.usr.clsInfoUser;

public class ActionTracciabilitaListini implements ActionInterface
{
  public ActionTracciabilitaListini()
  {
  }
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String risorse = request.getParameter("aryRisorse");


   
    String i_minCiclo=request.getParameter("minCiclo");
    String i_maxCiclo=request.getParameter("maxCiclo");
  
    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    try
    {
       Date minCiclo = df.parse(i_minCiclo);
       Date maxCiclo = df.parse(i_maxCiclo);
       if(minCiclo.after(maxCiclo))
       {
         throw new Exception("La data minimo ciclo deve essere minore della data max ciclo!");          
       }       
    }catch (ParseException e)
    {
      throw new Exception("Controllare le date del ciclo di valorizzazione! (dd/mm/yyyy)");
    }
    
    
    
    ElaborBatchBMPHome homeEB=(ElaborBatchBMPHome)EjbConnector.getHome("ElaborBatchBMP",ElaborBatchBMPHome.class);
    int numElabInCorsoAcc=0;
    numElabInCorsoAcc = (homeEB.findElabBatchCodeFunz("30").getElabUguali());
    if(numElabInCorsoAcc>0)
    {
      String mb="Impossibile lanciare il batch. Ci sono elaborazioni in corso!";
      return new Java2JavaScript().execute(new ViewLancioBatch(mb),new String[]{"_messaggio"},new String[]{"messaggio"});
    }
    
    if(!inviaRisorse(risorse))
    throw new Exception("Inserire almeno una risorsa!");
      
    //  codiceTipoContratto=1 codeFunz=30 id_funz=6   <---- nostro caso.
    return  new ActionFactory().getAction("lancioBatchRepricing").esegui(request,response);
  }

  private boolean inviaRisorse(String risorse)
  {
    risorse=risorse.replace("\r","");
    risorse=risorse.replace("\t","");
    Vector arrRisorse = new Vector();
    String[] appo;
    appo = risorse.split("\n");
    int count = 0;

    while(count < appo.length)
    {
        if(appo[count].length()>1)
        {
            arrRisorse.add(appo[count]);   
        }
        count ++;
    }
    if((arrRisorse.size()==0)||risorse.equalsIgnoreCase("Inserire un ID Risorsa per riga (manualmente o tramite caricamento di un file txt) ."))
      return false;
    EstrazioniListiniSTLHome home; 
    
    //aggiungere la chiamata all'ejb 
    //che effettuerà gli inserimenti delle risorse caricate dalla pagina:


    try
    {
      home = (EstrazioniListiniSTLHome)EjbConnector.getHome("EstrazioniListiniSTL",EstrazioniListiniSTLHome.class);
      home.create().insertRisorse(arrRisorse);
      
    } catch (Exception e)
    {
      
    }
    return true;
  }
}
