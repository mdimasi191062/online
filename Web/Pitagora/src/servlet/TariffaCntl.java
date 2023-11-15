package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import java.text.*;
import com.utl.*;
import java.lang.Object;

public class TariffaCntl extends HttpServlet
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private TariffaBMPHome home=null;
  private TariffaBMP remoteNumTar=null;
  private TariffaBMP remoteTariffa = null;
  private TariffaBMPPK pk = new TariffaBMPPK();

  int numElabBatch;
  String progTar;
  String codUM;
  String codUt;
  String descTar ;
  Double impTar  ;
  String flgMat  ;
  String causFatt;
  String codTar;
  String codOf;
  String clasOggFattSelez;
  String cod_PS;
  String des_PS;
  String caricaOggFatt;
  String caricaCausale;
  String caricaUniMis;
  String codClSc = null;
  String prClSc  = null;
  String dataIniTar;
  String dataFineTar=null;
  String dataIniValOf;
  String dataIniValAssOfPs;
  Integer numeroTariffe;
  String abilitaImporto;
  String chiamante;
  String tipo_pannello = null;
  String des_tipo_contr = null;
  String cod_tipo_contr = null;
  String act = null;
  String cod_tipo_caus = null;
  String causaleSelez = null;
  String oggFattSelez = null;  
  String descr_estesa_ps = null;
  String caricaLista = null;
  String hidFlagSys = null;
  String tipo_importo = null;
  String      dateFormat =  "dd/MM/yyyy";
  DateFormat  dataIniTarFormat        = new SimpleDateFormat(dateFormat);
  DateFormat  dataIniValOfFormat      = new SimpleDateFormat(dateFormat);
  DateFormat  dataIniValAssOfPsFormat = new SimpleDateFormat(dateFormat);
  DateFormat  maxDate                 = new SimpleDateFormat(dateFormat);
  Date        data_ini;
  Date        dataIniValOf1;
  Date        dataIniValAssOfPs1;
  Date        maxDate1;

  //modifica opzioni 18-02-03 inizio
  String caricaOpzione;
  String opzioneSelez;
  String descr_opzione;
  //modifica opzioni 18-02-03 fine

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    Context context=null;
    try
		{
    	context = new InitialContext();
    	Object homeObject = context.lookup("TariffaBMP");
      home = (TariffaBMPHome)PortableRemoteObject.narrow(homeObject, TariffaBMPHome.class);
		}
    catch(NamingException e)
      {
		  //nuova gestione eccezioni
		   StaticMessages.setCustomString(e.toString());
		   StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaCntl","","",StaticContext.APP_SERVER_DRIVER));
		  //throw new ServletException("Errore lookup TariffaBMP", e); //vecchia gestione
      }
    finally
      {
        try
          {
          if( context != null )
            {
            context.close();
            }
          }
        catch( Exception ex )
          {
          throw new ServletException("Errore close context", ex);
          }
        }
  }
  /**
   * Process the HTTP doGet request.
   */
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    try
    {
      processing(request,response);
    }
    catch (Exception e)
    {
      try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }

  }


   /**
   * Process the HTTP doPost request.
   */
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
   try
    {
      processing(request,response);
    }
    catch (Exception e)
    {
    try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
    //response.setContentType(CONTENT_TYPE);

    boolean elab_ok = true;

    //System.out.println("*********************SERVLET**********************");

    try
      {
       PrintWriter out = response.getWriter();

       //nuova gestione eccezioni
       StaticContext.writeLog(StaticMessages.getMessage(1001,request,StaticContext.APP_SERVER_DRIVER)); //PASSWORD ERRATA

       //ho separato gli attributi della classe che sono comuni ai pannelli richiamati da quelli che
       //non lo sono (rispetto al mio pannello ElabTariffaSp.jsp)
       //gli attributi seguenti sono quelli comuni
       String action = request.getParameter("act");
       cod_PS = request.getParameter("cod_PS");
       des_PS = request.getParameter("des_PS");
     //linea di codice spostata
	   clasOggFattSelez = request.getParameter("clasOggFattSelez");

     //linea di codice spostata
 	   caricaCausale    = request.getParameter("caricaCausale");
       

//       act = equest.getParameter("act");

       String impTarString = request.getParameter("importo_tariffa");
       if (impTarString!=null)
          impTar =new Double(impTarString.replace(',','.'));
       else
          impTar     =null;

	   if (action!=null && (action.equalsIgnoreCase("disattiva") || action.equalsIgnoreCase("aggiorna") || action.equalsIgnoreCase("cancella")))
	   {
  			//System.out.println("Sono in disattiva - cancella - aggiorna ---> "+action);
			  tipo_pannello = request.getParameter("tipo_pannello");
			  des_tipo_contr = request.getParameter("des_tipo_contr");
			  cod_tipo_contr = request.getParameter("cod_tipo_contr");
			  hidFlagSys = request.getParameter("hidFlagSys");
			  codOf = request.getParameter("cod_of");
			  codTar = request.getParameter("cod_tar");
			  progTar = request.getParameter("prog_tar");
			  dataFineTar = request.getParameter("data_fine_tariffa");
			  dataIniTar = request.getParameter("data_inizio_tariffa");
			  descTar = request.getParameter("descrizione_tariffa");
 			  cod_tipo_caus = request.getParameter("cod_tipo_caus");
        caricaLista = request.getParameter("caricaLista");
        tipo_importo = request.getParameter("tipo_importo");

         //modifica opzioni 18-02-03 inizio
         caricaOpzione = request.getParameter("caricaOpzione");
         opzioneSelez = request.getParameter("opzioneSelez");
         descr_opzione = request.getParameter("descr_opzione");
         //modifica opzioni 18-02-03 inizio
        String ritorno = "";

			  if (action.equalsIgnoreCase("disattiva"))
				  elab_ok = doDisattiva(request,response);
			  else if (action!=null && action.equalsIgnoreCase("aggiorna")){
          ritorno = doAggiorna(request,response);
          if(ritorno.equals(""))
            elab_ok = true;
          else
            elab_ok = false;
			  }else //if (action!=null && action.equalsIgnoreCase("cancella"))
          elab_ok = doCancella(request,response);


			  if (elab_ok) // si torna al pannello chiamante
			  {
          //System.out.println("Si torna al pannello chiamante");
          causaleSelez = cod_tipo_caus;
          oggFattSelez = codOf;
          //hidFlagSys = flag_sys;
         //System.out.println("hidFlagSys 1 --> "+hidFlagSys);          
          //chiamata modificata
          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
          request.getSession().setAttribute("hidFlagSys",hidFlagSys); 
          request.getSession().setAttribute("cod_PS",cod_PS);                    
          request.getSession().setAttribute("des_PS",des_PS);                              
          request.getSession().setAttribute("caricaLista",caricaLista);  
          request.getSession().setAttribute("tipo_pannello",tipo_pannello);                              
          request.getSession().setAttribute("caricaCausale",caricaCausale);  

          //modifica opzioni 18-02-03 inizio
          //request.getSession().setAttribute("caricaOpzione",caricaOpzione);  
          //request.getSession().setAttribute("opzioneSelez",opzioneSelez);  
          //request.getSession().setAttribute("descr_opzione",descr_opzione);  
          //modifica opzioni 18-02-03 inizio
 
          //modifica opzioni 18-02-03 aggiunti i dati caricaOpzione, opzioneSelez all'interfaccia
          response.sendRedirect(request.getContextPath()+"/tariffe/jsp/ListaTariffeSp.jsp?oggFattSelez="+codOf+
                                "&causaleSelez="+cod_tipo_caus+
                                "&tipo_pannello="+tipo_pannello+
                                "&des_PS="+java.net.URLEncoder.encode(des_PS,com.utl.StaticContext.ENCCharset)+
                                "&cod_PS="+cod_PS+
                                "&clasOggFattSelez="+clasOggFattSelez+
                                "&caricaCausale="+caricaCausale+
                                "&caricaLista="+caricaLista+
                                "&cod_tipo_contr="+cod_tipo_contr+
                                "&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)+
                                "&hidFlagSys="+hidFlagSys+
                                "&caricaOpzione="+caricaOpzione+
                                "&opzioneSelez="+opzioneSelez); 

				out.close();
			  }
			  else //si torna al pannello corrente per emettere un alert
			  {
          if(!ritorno.equals("") && ritorno.equals("no_data"))
            act = "no_data";
          else if(!ritorno.equals("") && ritorno.equals("no_provv"))
            act = "no_provv";        
          else
            act = "no_batch";
          // request.getSession().setAttribute("act",act); 06-03-03
          response.sendRedirect(request.getContextPath()+
          "/tariffe/jsp/ElabTariffaSp.jsp?act="+act+
          "&cod_tar="+codTar+
          "&prog_tar="+progTar+
          "&cod_PS="+cod_PS+
          "&des_PS="+java.net.URLEncoder.encode(des_PS,com.utl.StaticContext.ENCCharset)+
          "&cod_of="+codOf+
          "&tipo_pannello="+tipo_pannello+
          "&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)+
          "&cod_tipo_contr="+cod_tipo_contr+
          "&hidFlagSys="+hidFlagSys+
          "&data_fine_tariffa="+dataFineTar+
          "&data_inizio_tariffa="+dataIniTar+
          "&descrizione_tariffa="+java.net.URLEncoder.encode(descTar,com.utl.StaticContext.ENCCharset)+
          "&importo_tariffa="+impTarString+
          "&tipo_importo="+tipo_importo+
          "&caricaOpzione="+caricaOpzione+"&opzioneSelez="+opzioneSelez);  //06-03-03
          out.close();

  		  }
        
			  return;
	   }


//   chiamante=request.getParameter("chiamante");
     cod_tipo_contr  = request.getParameter("cod_tipo_contr");
     clasOggFattSelez  = request.getParameter("clasOggFattSelez");
     codTar  = request.getParameter("codTar");
     if (codTar!=null &&  codTar.equals("null"))
         codTar=null;
     progTar = request.getParameter("progTar");
     codUM   = request.getParameter("codUM");
 	   if (codUM!=null && codUM.equals("null"))
			   codUM=null;
     codUt   = request.getParameter("codUt");
     dataIniValAssOfPs   = request.getParameter("dataIniValAssOfPs");
     codOf  = request.getParameter("codOf");
     dataIniValOf  = request.getParameter("dataIniValOf");
     cod_PS      = request.getParameter("cod_PS");
     dataIniTar  = request.getParameter("dataIniTar");
     dataFineTar = null;
     descTar = request.getParameter("descTar");
     String impTarString_1 = request.getParameter("impTar");
     if (impTarString_1!=null)
          impTar =new Double(impTarString_1.replace(',','.'));
     else
          impTar     =null;
     flgMat = request.getParameter("flgMat");     
     codClSc = null;
     prClSc  = null;
     causFatt = request.getParameter("causFatt");
 	   if (causFatt!=null && causFatt.equals("null"))
			   causFatt=null;

    //viti
     opzioneSelez = request.getParameter("opzioneSelez");
 	   if (opzioneSelez!=null && opzioneSelez.equals("null")) 
         opzioneSelez=null;
   

   
if (action.equalsIgnoreCase("insert"))
	   {
			 doInsert(request,response);
       action="refresh";
       response.sendRedirect(request.getContextPath()+"/tariffe/jsp/TariffaWfSp.jsp?act="+action+
       "&oggFattSelez="+codOf+"&cod_tipo_contr="+cod_tipo_contr+"&cod_PS="+cod_PS+"&clasOggFattSelez="+clasOggFattSelez);
	    out.close();
    }
   }
    //nuova gestione eccezioni
      catch (Exception e)
          {
      if (e instanceof CustomEJBException)
      {
        CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore durante processing","processing","TariffaCntl",StaticContext.FindExceptionType(e));
          }
  }


  /***********************
  *   DO_DISATTIVA
  */

  //inserita nuova gestione eccezioni

  private boolean doDisattiva(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
   //System.out.println("******DO_DISATTIVA*******");

    Integer num_elab_trovate;       //per ELAB_BATCH_IN_CORSO_FATT
    String testoEccezione = "";

    dataIniValOf = request.getParameter("data_ini_val_of");
    dataIniValAssOfPs = request.getParameter("data_ini_val_ass_ofps");

    try
    {
       //System.out.println("1) ELAB_BATCH_IN_CORSO_FATT");
       //Chiamo ELAB_BATCH_IN_CORSO_FATT
       testoEccezione = "TariffaBMPHome.findElabBatchInCorsoFatt";
       TariffaBMP remoteTariffa = home.findElabBatchInCorsoFatt();
       num_elab_trovate = remoteTariffa.getNumElaborazTrovate();

       if (num_elab_trovate.intValue()==0)
       {
          //chiamo TARIFFA_GEST_DISATTIVA
          //System.out.println("2) TARIFFA_GEST_DISATTIVA");
          testoEccezione = "TariffaBMPHome.findTariffaGestDisattiva";
          remoteTariffa = home.findTariffaGestDisattiva(codTar, progTar, dataFineTar, cod_PS, codOf, dataIniValOf, dataIniValAssOfPs); 

          return true;
        }
       else
       {
           //ci sono elaborazioni in corso: l'operazione non è completata
           return false;
       }

    }
    catch (Exception e)
    {
	  //nuova gestione eccezioni: la vecchia gestione era data dall'istruzione seguente
      //throw new ServletException("Errore "+testoEccezione,e);
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doDisattiva","TariffaCntl",StaticContext.FindExceptionType(e));
    }
  }

/**************************************************************************************
*   private void doCancella (HttpServletRequest request, HttpServletResponse response)
*
*/

  //inserita nuova gestione eccezioni

  private boolean doCancella(HttpServletRequest request, HttpServletResponse response) throws ServletException, CustomEJBException
  {
    Integer num_elab_trovate;                           //per ELAB_BATCH_IN_CORSO_FATT
    String testoEccezione="";

    //System.out.println("******DO_CANCELLA*******");

    try
    {

     //Chiamo ELAB_BATCH_IN_CORSO_FATT
     //System.out.println("1) ELAB_BATCH_IN_CORSO_FATT");
     testoEccezione = "TariffaBMPHome.findElabBatchInCorsoFatt";
     TariffaBMP remoteTariffa = home.findElabBatchInCorsoFatt();
     num_elab_trovate = remoteTariffa.getNumElaborazTrovate();

      if (num_elab_trovate.intValue()==0)
      {
        //chiamo TARIFFA_GEST_CANCELLA
       testoEccezione = "TariffaBMPHome.findTariffaGestCancella";
       //System.out.println("2) TARIFFA_GEST_CANCELLA con cod_tar --> "+codTar+" e prog_tar --> "+progTar);
       remoteTariffa = home.findTariffaGestCancella(codTar, progTar); 

       //l'operazione è stata completata
       return true;
      }
      else
      {
          //ci sono elaborazioni in corso: l'operazione non è completata
          return false;
      }


    }
    catch (Exception e)
    {
	  //nuova gestione eccezioni: la vecchia gestione era data dall'istruzione seguente
      //throw new ServletException("Errore "+testoEccezione,e);
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doCancella","TariffaCntl",StaticContext.FindExceptionType(e));
    }

}

/**********************
* DO_AGGIORNA
***/

//inserita nuova gestione eccezioni

  private String doAggiorna(HttpServletRequest request, HttpServletResponse response) throws ServletException, CustomEJBException
  {

  //CI SONO DA FARE GLI ALTRI CONTROLLI DELLA SPECIFICA
  //ricordarsi di fare la gestione try catch

    Integer num_elab_trovate;   //per ELAB_BATCH_IN_CORSO_FATT
    Integer num_tar_provvisor;  //per TARIFFA_VER_ALMENO_1_PROVV

    String testoEccezione = "";
    String nome_utente = request.getParameter("nome_utente");    
    String dataIniTarDigitata = "";
    String ritorno = "";
    
    int yearDg = 0;
    int monthDg = 0;
    int dayDg = 0;
    int hhDg = 0;
    int miDg = 0;
    int ssDg = 0;
            
    int yearDb = 0;
    int monthDb = 0;
    int dayDb = 0;
    int hhDb = 0;
    int miDb = 0;
    int ssDb = 0;

    boolean controllo = true;
    
    try
    {
      testoEccezione = "TariffaBMPHome.findElabBatchInCorsoFatt";
      TariffaBMP remoteTariffa = home.findElabBatchInCorsoFatt();
      num_elab_trovate = remoteTariffa.getNumElaborazTrovate();
      
      if (num_elab_trovate.intValue()==0)
      {
        remoteTariffa = home.findTariffaUnica(codTar);
        num_tar_provvisor = remoteTariffa.getNumTarProvvisor();

        pk.setCodTar(codTar);
        pk.setProgTar(progTar);  
        remoteTariffa = home.findByPrimaryKey(pk);

        String DESC_DB = remoteTariffa.getDescTar();
        System.out.println("DESC_DB ["+DESC_DB+"]");
        String DESC_DG = descTar;
        System.out.println("DESC_DG ["+DESC_DG+"]");
        
        String DATA_DB = invertiCampoData(remoteTariffa.getDataIniTar());
        String DATA_DG = invertiCampoData(dataIniTar);
        int IMP_DB = remoteTariffa.getImpTar().intValue();
        int IMP_DG = impTar.intValue();
        
        yearDg = Integer.parseInt(DATA_DG.substring(0,4));
        monthDg = Integer.parseInt(DATA_DG.substring(4,6));
        dayDg = Integer.parseInt(DATA_DG.substring(6,8));
        hhDg = 0;
        miDg = 0;
        ssDg = 0;
        
        yearDb = Integer.parseInt(DATA_DB.substring(0,4));
        monthDb = Integer.parseInt(DATA_DB.substring(4,6));
        dayDb = Integer.parseInt(DATA_DB.substring(6,8));
        hhDb = 0;
        miDb = 0;
        ssDb = 0;
        
        int inserimentoUnica = 0;
        if(yearDg == yearDb || yearDg < yearDb){
          if(yearDg < yearDb){
            System.out.println("Anno digitato < Anno DB - Inserimento TARIFFA UNICA");
            inserimentoUnica = 1;
          }else{
            if(monthDg == monthDb || monthDg < monthDb){
              if(monthDg < monthDb){
                System.out.println("Mese digitato < Mese DB - Inserimento nuova tariffa");
                inserimentoUnica = 1;
              }else{
                if(dayDg < dayDb){
                  System.out.println("Giorno digitato < Giorno DB - Inserimento nuova tariffa");
                  inserimentoUnica = 1;
                }else{
                  inserimentoUnica = 0;
                }
              }
            }else{
              System.out.println("Mese digitato > Mese DB");
              inserimentoUnica = 0;
            }
          }
        }else{
          System.out.println("Anno digitato > Anno DB");
          inserimentoUnica = 0;
        }
        if(num_tar_provvisor.intValue()==1 && inserimentoUnica == 1){
          remoteTariffa = home.findAlmeno1TariffaProvv(codTar);
          num_tar_provvisor = remoteTariffa.getNumTarProvvisor();
          
          if (num_tar_provvisor.intValue()!=0){
             remoteTariffa = home.findTariffaAggiornaUnicaProvv(codTar, DATA_DG, descTar, impTar, nome_utente);
             num_tar_provvisor = remoteTariffa.getNumTarProvvisor();
             if(num_tar_provvisor.intValue() == 1){
                //ritorno = "no_data";
                return ritorno;
             }
          }else{
             if(IMP_DB == IMP_DG){
                if(DESC_DG.equals(DESC_DB)){
                  remoteTariffa = home.findTariffaAggiornaUnica(codTar, DATA_DG, descTar, impTar, nome_utente);
                  num_tar_provvisor = remoteTariffa.getNumTarProvvisor();
                  //if(num_tar_provvisor.intValue() == 1){
                  return ritorno;
                }else{
                  ritorno = "no_provv";
                  return ritorno;
                }
             }else{
                ritorno = "no_provv";
                return ritorno;
             }
          }
        }else{
          //procedere come negli altri casi
        
        
          testoEccezione = "TariffaBMPHome.findAlmeno1TariffaProvv";
          remoteTariffa = home.findAlmeno1TariffaProvv(codTar);
          num_tar_provvisor = remoteTariffa.getNumTarProvvisor();
          if (num_tar_provvisor.intValue()!=0) //(a)
          {
            testoEccezione = "TariffaBMPHome.findTariffaAggiornaConProvv";
            //System.out.println("3) TARIFFA_AGGIORNA_CON_PROVV");
            //dataIniTar = invertiCampoData(dataIniTar);

            //Ottengo il valore dell'ultima tariffa
            pk.setCodTar(codTar);
            pk.setProgTar(progTar);  
            remoteTariffa = home.findByPrimaryKey(pk);
            dataIniTarDigitata = invertiCampoData(dataIniTar);
            dataIniTar = invertiCampoData(remoteTariffa.getDataIniTar());
            if (remoteTariffa.getDataFineTar()!=null && !remoteTariffa.getDataFineTar().equalsIgnoreCase(""))
              dataFineTar = invertiCampoData(remoteTariffa.getDataFineTar());  
            else dataFineTar = null;

            dataIniValOf = invertiCampoData(remoteTariffa.getDataIniValOf());   
            dataIniValAssOfPs = invertiCampoData(remoteTariffa.getDataIniValAssOfPs()); 

            yearDg = Integer.parseInt(dataIniTarDigitata.substring(0,4));
            monthDg = Integer.parseInt(dataIniTarDigitata.substring(4,6));
            dayDg = Integer.parseInt(dataIniTarDigitata.substring(6,8));
            hhDg = 0;
            miDg = 0;
            ssDg = 0;
            
            yearDb = Integer.parseInt(dataIniTar.substring(0,4));
            monthDb = Integer.parseInt(dataIniTar.substring(4,6));
            dayDb = Integer.parseInt(dataIniTar.substring(6,8));
            hhDb = 0;
            miDb = 0;
            ssDb = 0;

            int inserimento = 0;
            
            if(yearDg == yearDb || yearDg > yearDb){
              if(yearDg > yearDb){
                System.out.println("Inserimento nuova tariffa");
                inserimento = 1;
              }else{
                //System.out.println("Anno digitato = Anno DB");
                if(monthDg == monthDb || monthDg > monthDb){
                  if(monthDg > monthDb){
                    System.out.println("Inserimento nuova tariffa");
                    inserimento = 1;
                  }else{
                    //System.out.println("Mese digitato == Mese DB");
                    if(dayDg > dayDb){
                      //System.out.println("Giorno digitato > Giorno DB");
                      System.out.println("Inserimento nuova tariffa");
                      inserimento = 1;
                    }else{
                      //System.out.println("Giorno digitato <= Giorno DB");
                      inserimento = 0;
                    }
                  }
                }else{
                  //System.out.println("Mese digitato < Mese DB");
                  inserimento = 0;
                }
              }
            }else{
              //System.out.println("Anno digitato < Anno DB");
              inserimento = 0;
            }
          
            remoteTariffa = home.findTariffaAggiornaConProvv(codTar, dataIniTarDigitata, descTar, impTar, nome_utente, inserimento);

            num_tar_provvisor = remoteTariffa.getNumTarProvvisor();

            if(num_tar_provvisor.intValue() == 1){
              ritorno = "no_provv";
              return ritorno;
            }

          } //fine (a)
          else //(b)
          {
              testoEccezione = "TariffaBMPHome.findByPrimaryKey";
              pk.setCodTar(codTar);
              pk.setProgTar(progTar);  
              remoteTariffa = home.findByPrimaryKey(pk); //TARIFFA_DETTAGLIO   (b.1)
            
              //inverto il formato delle date in aaaa/mm/gg
              //salvo la dataIniTar del pannello
              dataIniTarDigitata = invertiCampoData(dataIniTar);
              //ora dataIniTar conterrà la dataIniTar del DB
              dataIniTar = invertiCampoData(remoteTariffa.getDataIniTar());
              if (remoteTariffa.getDataFineTar()!=null && !remoteTariffa.getDataFineTar().equalsIgnoreCase(""))
                dataFineTar = invertiCampoData(remoteTariffa.getDataFineTar());  
              else dataFineTar = null;
              
              dataIniValOf = invertiCampoData(remoteTariffa.getDataIniValOf());   
              dataIniValAssOfPs = invertiCampoData(remoteTariffa.getDataIniValAssOfPs());  

              /*******************CONTINUARE DA QUI********************************/


              testoEccezione = "TariffaBMPHome.findTariffaAggiornaSenzaProvv";

              //Valeria inizio 12-02-03 aggiunto code_opzione_tariffa al metodo seguente
            
              yearDg = Integer.parseInt(dataIniTarDigitata.substring(0,4));
              monthDg = Integer.parseInt(dataIniTarDigitata.substring(4,6));
              dayDg = Integer.parseInt(dataIniTarDigitata.substring(6,8));
              hhDg = 0;
              miDg = 0;
              ssDg = 0;

              yearDb = Integer.parseInt(dataIniTar.substring(0,4));
              monthDb = Integer.parseInt(dataIniTar.substring(4,6));
              dayDb = Integer.parseInt(dataIniTar.substring(6,8));
              hhDb = 0;
              miDb = 0;
              ssDb = 0;

              controllo = true;
            
              if(yearDg == yearDb || yearDg > yearDb){
                if(yearDg > yearDb){
                  //System.out.println("Anno digitato > Anno DB");
                  controllo = true;
                }else{
                  //System.out.println("Anno digitato = Anno DB");
                  if(monthDg == monthDb || monthDg > monthDb){
                    if(monthDg > monthDb){
                      //System.out.println("Mese digitato > Mese DB");
                      controllo = true;
                    }else{
                      //System.out.println("Mese digitato == Mese DB");
                      if(dayDg > dayDb){
                        //System.out.println("Giorno digitato > Giorno DB");
                        controllo = true;
                      }else{
                        //System.out.println("Giorno digitato <= Giorno DB");
                        controllo = false;
                      }
                    }
                  }else{
                    //System.out.println("Mese digitato < Mese DB");
                    controllo = false;
                  }
                }
              }else{
                //System.out.println("Anno digitato < Anno DB");
                controllo = false;
              }
               
              if(remoteTariffa.getFlgProvv().equals("N") || controllo){
                remoteTariffa = home.findTariffaAggiornaSenzaProvv(remoteTariffa.getCodTar(), remoteTariffa.getProgTar(), 
                                           dataIniTarDigitata, remoteTariffa.getCodUM(), 
                                           dataIniValAssOfPs, remoteTariffa.getCodOf(), 
                                           dataIniValOf, remoteTariffa.getCodPs(), 
                                           remoteTariffa.getFlgMat(), remoteTariffa.getCodTipoCaus(), 
                                           remoteTariffa.getCodClSc(), remoteTariffa.getPrClSc(), 
                                           remoteTariffa.getCodTipoOf(), dataIniTar, 
                                           dataFineTar, descTar, 
                                           impTar, remoteTariffa.getCausFatt(), 
                                           remoteTariffa.getFlgProvv(), nome_utente, 
                                           remoteTariffa.getCodTipoOpz());
              }else{
                ritorno = "no_data";
                return ritorno;             
              }
          }
        }
        return ritorno;
      }
      else
      {
          //ci sono elaborazioni in corso: l'operazione non è completata
          ritorno = "Batch in corso";
          return ritorno;
      }

/**/

    }
    catch (Exception e)
    {
	  //nuova gestione eccezioni: la vecchia gestione era data dall'istruzione seguente
      //throw new ServletException("Errore "+testoEccezione,e);
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doAggiorna","TariffaCntl",StaticContext.FindExceptionType(e));
    }

  }
  //inserita nuova gestione eccezioni: prima era solo throws ServletException
  private void doInsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, CustomEJBException
  {
        if (causFatt!=null && causFatt.equalsIgnoreCase("-1"))
            causFatt=null;
        if (opzioneSelez!=null && opzioneSelez.equalsIgnoreCase("-1"))
            opzioneSelez=null;
        try
          {
          TariffaBMP remote= home.create(codTar,progTar,codUM,codUt,dataIniValAssOfPs,codOf,dataIniValOf,cod_PS,dataIniTar,dataFineTar,descTar,impTar,flgMat,codClSc,prClSc,causFatt, opzioneSelez);
          }
        catch (Exception e)
          {
			  //nuova gestione eccezioni: la vecchia gestione era data dall'istruzione seguente
			  
			  if (e instanceof CustomEJBException)
			  {
				CustomEJBException myexception = (CustomEJBException)e;
				throw myexception;
			  }
			  else
				throw new CustomEJBException(e.toString(),"Errore in TariffaBMPHome.create", "doInsert","TariffaCntl",StaticContext.FindExceptionType(e));

          }
  }

  private String invertiCampoData(String stringa_data)
  {
    //stringa_data ha formato dd/mm/yyyy (non importa il separatore)
    stringa_data = stringa_data.substring(6)+
                   stringa_data.substring(3,5)+
                   stringa_data.substring(0,2);
    return stringa_data;
  }
}