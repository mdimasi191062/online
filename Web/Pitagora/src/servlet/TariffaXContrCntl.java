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

public class TariffaXContrCntl extends HttpServlet
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private TariffaBMPHome home=null;
  private TariffaXContrBMPHome homeXContr=null;
  private TariffaBMP remoteTariffa = null;
  private TariffaXContrBMP remoteTariffaXContr = null;
  private TariffaXContrBMPPK pkTariffaXContr = new TariffaXContrBMPPK();
  
  int numElabBatch;
  String des_contratto;
  String cod_contr;
  String cod_tipo_contr;
  String des_tipo_contr;
  String progTar;
  String codUM;
  String desc_UM; //07-03-03
  String codUt;
  String descTar ;
  Double impTar  ;
  String flgMat  ;
  String causFatt;
  String code_tipo_contr = null;
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
  String act = null;
  String cod_tipo_caus = null;
  String causaleSelez = null;
  String contrSelez = null;
  String oggFattSelez = null;
  String descr_estesa_ps = null;
  String caricaLista = null;
//  String descr_tipo_contr = null; 06-03-03
  String hidFlagSys = null;
 	String cod_contratto=null;
	String tipo_importo=null;   
  String  des_contr = null;
  String      dateFormat =  "dd/MM/yyyy";
  DateFormat  dataIniTarFormat        = new SimpleDateFormat(dateFormat);
  DateFormat  dataIniValOfFormat      = new SimpleDateFormat(dateFormat);
  DateFormat  dataIniValAssOfPsFormat = new SimpleDateFormat(dateFormat);
  DateFormat  maxDate                 = new SimpleDateFormat(dateFormat);
  Date        data_ini;
  Date        dataIniValOf1;
  Date        dataIniValAssOfPs1;
  Date        maxDate1;

 //modifica opzioni 24-02-03 inizio
  String caricaOpzione;
  String opzioneSelez;
  String descr_opzione;
 //modifica opzioni 24-02-03 fine


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
		    StaticMessages.setCustomString(e.toString());
		    StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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

try
		{
    	context = new InitialContext();
    	Object homeObject = context.lookup("TariffaXContrBMP");
      homeXContr = (TariffaXContrBMPHome)PortableRemoteObject.narrow(homeObject, TariffaXContrBMPHome.class);
		}
    catch(NamingException e)
      {
		    StaticMessages.setCustomString(e.toString());
		    StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"TariffaXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
  	boolean elab_ok = true;
    try
      {
       PrintWriter out = response.getWriter();
       StaticContext.writeLog(StaticMessages.getMessage(1001,request,StaticContext.APP_SERVER_DRIVER)); //PASSWORD ERRATA
       //Valeria inizio 02-10-02
       //ho separato gli attributi della classe che sono comuni ai pannelli richiamati da quelli che
       //non lo sono (rispetto al mio pannello ElabTariffaSp.jsp)
       //gli attributi seguenti sono quelli comuni
       String action=request.getParameter("act");
       cod_PS = request.getParameter("cod_PS");
       des_PS = request.getParameter("des_PS");
  	   clasOggFattSelez = request.getParameter("clasOggFattSelez");
       //linea di codice spostata
	      caricaCausale    = request.getParameter("caricaCausale");

       String impTarString = request.getParameter("importo_tariffa");
       if (impTarString!=null)
          impTar =new Double(impTarString.replace(',','.'));
       else
          impTar     =null;

     /**************************************************************/
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
        cod_contr = request.getParameter("cod_contr");  
        tipo_importo = request.getParameter("tipo_importo");   
        des_contr = request.getParameter("des_contr");   

        //modifica opzioni 24-02-03 inizio
        caricaOpzione = request.getParameter("caricaOpzione");
        opzioneSelez = request.getParameter("opzioneSelez");
        descr_opzione = request.getParameter("descr_opzione");
        //modifica opzioni 24-02-03 inizio

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

			  //SIMULAZIONE
          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
          contrSelez = cod_contr;  //07-03-03

			  if (elab_ok) // si torna al pannello chiamante
			  {
          causaleSelez = cod_tipo_caus;
          oggFattSelez = codOf;

          /*contrSelez = cod_contr;  //07-03-03
          request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr); 
          request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);*/

          response.sendRedirect(request.getContextPath()+"/tariffe_x_contr/jsp/ListaTariffeXContrSp.jsp?oggFattSelez="+codOf+
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
                                "&contrSelez="+contrSelez+
                                "&des_contr="+java.net.URLEncoder.encode(des_contr,com.utl.StaticContext.ENCCharset)+  //10-03-03
                                "&caricaOpzione="+caricaOpzione+"&opzioneSelez="+opzioneSelez);   //24-02-03
				out.close();
			  }
			  else //si torna al pannello corrente per emettere un alert
			  {
          if(!ritorno.equals("") && ritorno.equals("no_data")){
            act = "no_data";
          }else if(!ritorno.equals("") && ritorno.equals("no_provv")){
            act = "no_provv";        
          }else{
            act = "no_batch";
          }
          //act = "no_batch";
          //contrSelez = cod_contr; //06-03-03
          //request.getSession().setAttribute("act",act); //06-03-03
          response.sendRedirect(request.getContextPath()+
          "/tariffe_x_contr/jsp/ElabTariffaXContrSp.jsp?act="+act+
          "&contrSelez="+contrSelez+ //06-03-03
          "&des_contr="+java.net.URLEncoder.encode(des_contr,com.utl.StaticContext.ENCCharset)+  //07-03-03
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
          "&caricaOpzione="+caricaOpzione   //06-03-03
          +"&opzioneSelez="+opzioneSelez);  //06-03-03
          out.close();
  		  }

			  return;
	   }
	   //Valeria inizio 02-10-02
	   //questi sono gli attributi del pannello di Gianluca, che ho spostato
     cod_contr   = request.getParameter("cod_contr");
     code_tipo_contr   = request.getParameter("cod_tipo_contr");
     clasOggFattSelez  = request.getParameter("clasOggFattSelez");
     codTar  = request.getParameter("codTar");
     if (codTar!=null &&  codTar.equals("null")) codTar=null;
     progTar = request.getParameter("progTar");
     codUM   = request.getParameter("codUM");
 	   if (codUM!=null && codUM.equals("null"))    codUM=null;

//desc_UM
     
     codUt   = request.getParameter("codUt");
     dataIniValAssOfPs   = request.getParameter("dataIniValAssOfPs");
     codOf  = request.getParameter("codOf");
     dataIniValOf  = request.getParameter("dataIniValOf");
     cod_PS      = request.getParameter("cod_PS");
     dataIniTar  = request.getParameter("dataIniTar"); dataFineTar = null;
     descTar = request.getParameter("descTar");
     String impTarString_1 = request.getParameter("impTar");
     if (impTarString_1!=null) impTar =new Double(impTarString_1.replace(',','.'));
     else impTar     =null;
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
					doInsertXContr(request,response);
          action="refresh";
          response.sendRedirect(request.getContextPath()+"/tariffe_x_contr/jsp/TariffaXContrWfSp.jsp?act="+action+
          "&contrSelez="+cod_contr+"&oggFattSelez="+codOf+"&cod_tipo_contr="+code_tipo_contr+"&cod_PS="+cod_PS+
          "&clasOggFattSelez="+clasOggFattSelez);
	        out.close();
    }
   }
    catch (IOException e)
      {
      throw new ServletException(e.getMessage());
      }
    catch (ServletException se)
      {
      throw se;
      }
  }

  /***********************
  *   DO_DISATTIVA
  */
  private boolean doDisattiva(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
    Integer num_elab_trovate;       //per ELAB_BATCH_IN_CORSO_FATT
    String testoEccezione = "";
    dataIniValOf = request.getParameter("data_ini_val_of");
    dataIniValAssOfPs = request.getParameter("data_ini_val_ass_ofps");

    try
    {
       testoEccezione = "TariffaBMPHome.findElabBatchInCorsoFatt";
       TariffaBMP remoteTariffa = home.findElabBatchInCorsoFatt();
       num_elab_trovate = remoteTariffa.getNumElaborazTrovate();
       if (num_elab_trovate.intValue()==0)
       {
          testoEccezione = "TariffaXContrBMPHome.findTariffaXContrGestDis";
          remoteTariffaXContr = homeXContr.findTariffaXContrGestDis(codTar, progTar, dataFineTar, cod_PS, codOf, dataIniValOf, dataIniValAssOfPs); 
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
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doDisattiva","TariffaXContrCntl",StaticContext.FindExceptionType(e));
    }
  }

/**************************************************************************************
*   private void doCancella (HttpServletRequest request, HttpServletResponse response)
*
*/
  private boolean doCancella(HttpServletRequest request, HttpServletResponse response) throws ServletException, CustomEJBException
  {
    Integer num_elab_trovate;                           //per ELAB_BATCH_IN_CORSO_FATT
    String testoEccezione="";
    try
    {
     testoEccezione = "TariffaBMPHome.findElabBatchInCorsoFatt";
     TariffaBMP remoteTariffa = home.findElabBatchInCorsoFatt();
     num_elab_trovate = remoteTariffa.getNumElaborazTrovate();

      if (num_elab_trovate.intValue()==0)
      {
       testoEccezione = "TariffaBMPHome.findTariffaXContrGestCanc";
       remoteTariffaXContr = homeXContr.findTariffaXContrGestCanc(codTar, progTar); 
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
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doCancella","TariffaXContrCntl",StaticContext.FindExceptionType(e));
    }
}

/**********************
* DO_AGGIORNA
***/
  private String doAggiorna(HttpServletRequest request, HttpServletResponse response) throws ServletException, CustomEJBException
  {

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
        testoEccezione = "TariffaBMPHome.findAlm1TarXContrProvv";
        remoteTariffaXContr = homeXContr.findTariffaUnicaXContr(cod_contr,codTar);
        num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();

        pkTariffaXContr.setCodContr(cod_contr);
        pkTariffaXContr.setCodTar(codTar);
        pkTariffaXContr.setProgTar(progTar);  
        remoteTariffaXContr = homeXContr.findByPrimaryKey(pkTariffaXContr);
        String DESC_DB = remoteTariffaXContr.getDescTar();
        System.out.println("DESC_DB ["+DESC_DB+"]");
        String DESC_DG = descTar;
        System.out.println("DESC_DG ["+DESC_DG+"]");
        String DATA_DB = invertiCampoData(remoteTariffaXContr.getDataIniTar());
        String DATA_DG = invertiCampoData(dataIniTar);
        String IMP_DB = remoteTariffaXContr.getImpTar().toString();
        //System.out.println("IMPORTO DB ["+IMP_DB+"]");
        String IMP_DG = impTar.toString();
        //System.out.println("IMPORTO DG ["+IMP_DG+"]");
        
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
          remoteTariffaXContr = homeXContr.findAlm1TarXContrProvv(codTar);
          num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();
          
          if (num_tar_provvisor.intValue()!=0){
             remoteTariffaXContr = homeXContr.findTariffaAggiornaUnicaProvvXContr(cod_contr,codTar, DATA_DG, descTar, impTar, nome_utente);
             num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();
             if(num_tar_provvisor.intValue() == 1){
                //ritorno = "no_data";
                return ritorno;
             }
          }else{
             if(IMP_DB.equals(IMP_DG)){
                if(DESC_DG.equals(DESC_DB)){
                  remoteTariffaXContr = homeXContr.findTariffaAggiornaUnicaXContr(cod_contr,codTar, DATA_DG, descTar, impTar, nome_utente);
                  num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();
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
          remoteTariffaXContr = homeXContr.findAlm1TarXContrProvv(codTar);
          num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();
          if (num_tar_provvisor.intValue()!=0) //(a)
          {
            testoEccezione = "TariffaBMPHome.findTariffaAggiornaConProvv";
            
            pkTariffaXContr.setCodContr(cod_contr);
            pkTariffaXContr.setProgTar(progTar);  
            pkTariffaXContr.setCodTar(codTar);
            
            remoteTariffaXContr = homeXContr.findByPrimaryKey(pkTariffaXContr);
            dataIniTarDigitata = invertiCampoData(dataIniTar);
            dataIniTar = invertiCampoData(remoteTariffaXContr.getDataIniTar());
            if (remoteTariffaXContr.getDataFineTar()!=null && 
                !remoteTariffaXContr.getDataFineTar().equalsIgnoreCase(""))
              dataFineTar = invertiCampoData(remoteTariffaXContr.getDataFineTar());  
            else dataFineTar = null;

            dataIniValOf = invertiCampoData(remoteTariffaXContr.getDataIniValOf());   
            dataIniValAssOfPs = invertiCampoData(remoteTariffaXContr.getDataIniValAssOfPs()); 

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
          
            remoteTariffaXContr = homeXContr.findTariffaXContrAggConProvv(codTar, dataIniTarDigitata, descTar, impTar, nome_utente, inserimento);

            num_tar_provvisor = remoteTariffaXContr.getNumTarProvvisor();

            if(num_tar_provvisor.intValue() == 1){
              ritorno = "no_provv";
              return ritorno;
            }

          } //fine (a)
          else //(b)
          {
              testoEccezione = "TariffaBMPHome.findByPrimaryKey";
              pkTariffaXContr.setCodContr(cod_contr);
              pkTariffaXContr.setProgTar(progTar);  
              pkTariffaXContr.setCodTar(codTar);
            
              remoteTariffaXContr = homeXContr.findByPrimaryKey(pkTariffaXContr);
            
              //inverto il formato delle date in aaaa/mm/gg
              //salvo la dataIniTar del pannello
              dataIniTarDigitata = invertiCampoData(dataIniTar);
              //ora dataIniTar conterrà la dataIniTar del DB
              dataIniTar = invertiCampoData(remoteTariffaXContr.getDataIniTar());
              if (remoteTariffaXContr.getDataFineTar()!=null && 
                  !remoteTariffaXContr.getDataFineTar().equalsIgnoreCase(""))
                dataFineTar = invertiCampoData(remoteTariffaXContr.getDataFineTar());  
              else dataFineTar = null;
              
              dataIniValOf = invertiCampoData(remoteTariffaXContr.getDataIniValOf());   
              dataIniValAssOfPs = invertiCampoData(remoteTariffaXContr.getDataIniValAssOfPs());  

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
                      if(dayDb > dayDb){
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
               
              if(remoteTariffaXContr.getFlgProvv().equals("N") || controllo){
                remoteTariffaXContr = homeXContr.findTariffaXContrAggNoProvv(remoteTariffaXContr.getCodContr(),
                                           remoteTariffaXContr.getCodTar(), remoteTariffaXContr.getProgTar(), 
                                           dataIniTarDigitata, remoteTariffaXContr.getCodUM(), 
                                           dataIniValAssOfPs, remoteTariffaXContr.getCodOf(), 
                                           dataIniValOf, remoteTariffaXContr.getCodPs(), 
                                           remoteTariffaXContr.getFlgMat(), remoteTariffaXContr.getCodTipoCaus(), 
                                           remoteTariffaXContr.getCodClSc(), remoteTariffaXContr.getPrClSc(), 
                                           remoteTariffaXContr.getCodTipoOf(), dataIniTar, 
                                           dataFineTar, descTar, 
                                           impTar, remoteTariffaXContr.getCausFatt(), 
                                           remoteTariffaXContr.getFlgProvv(), nome_utente, 
                                           remoteTariffaXContr.getCodTipoOpz());
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
        throw new CustomEJBException(e.toString(),"Errore nella stored "+ testoEccezione,"doAggiorna","TariffaXContrCntl",StaticContext.FindExceptionType(e));
    }

  }

  private String invertiCampoData(String stringa_data)
  {
    //stringa_data ha formato dd/mm/yyyy (non importa il separatore)
    stringa_data = stringa_data.substring(6)+stringa_data.substring(3,5)+stringa_data.substring(0,2);
    return stringa_data;
  }

  private void doInsertXContr(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
        if (causFatt!=null && causFatt.equalsIgnoreCase("-1"))
            causFatt=null;
        try
          {
          TariffaXContrBMP remoteIns= homeXContr.create(cod_contr,codTar,progTar,codUM,codUt,dataIniValAssOfPs,codOf,dataIniValOf,cod_PS,dataIniTar,dataFineTar,descTar,impTar,flgMat,codClSc,prClSc,causFatt, opzioneSelez);
          }
        catch (Exception e)
          {
          throw new ServletException("Errore TariffaXContrBMPHome.create",e);
          }
  }

}