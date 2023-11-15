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

public class AssOfPsCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private InsAssOfPsBMPHome homeInsAss=null;
  private InsAssOfPsBMP remoteInsAss=null;
  private InsAssOfPsBMP remote1=null;
  private InsAssOfPsBMP remote2=null;
  private InsAssOfPsBMP remote3=null;
  private InsAssOfPsBMP remote6=null;

  private AssOfPsVerifEsistBMPHome  homeAssOfPsVerifEsist;//=null;
  private AssOfPsVerifEsistBMP      remoteAssOfPsVerifEsist;// = null;
  private AssOfPsVerEsistAperteBMPHome homeAssOfPsVerEsist;//=null;
  private AssOfPsVerEsistAperteBMP      remoteAssOfPsVerEsist;// = null;
  int NumAssTrovate;
  int NumAssAperteTrovate;


private InsAssOfPsBMP remote_min;// = null;
private InsAssOfPsBMP remote_max;// = null;

  String codiceUtente;
  String cod_contratto;
  String code_of;
  String des_contratto;
  String des_PS;
  String cod_PS;
  String classeSelezionata;
  String descSelezionata;
  String classeSelezValue;
  String descSelezValue;
  String freqSelezionata;
  String modApplSelezionata;
  String freqSelezValue;
  String modApplSelezValue;
  String modApplProrSelezionata;
  String modApplProrSelezValue;
  String shiftStringa;
  int shiftNumero;
  String data_ini;
  String data_fine;
  String flagAP;

  String      dateFormat =  "dd/MM/yyyy";
  DateFormat  dataIniFormat = new SimpleDateFormat(dateFormat);
  String      dataIniValAssOfPs;
  Date        dataIniValAssOfPs1;
  DateFormat  dataIniValAssOfPsFormat = new SimpleDateFormat(dateFormat);
  String      dataIniValOf;
  Date        dataIniValOf1;
  DateFormat  dataIniValOfFormat = new SimpleDateFormat(dateFormat);
  String      dataFineValOf;
  Date        dataFineValOf1;
  DateFormat  dataFineValOfFormat = new SimpleDateFormat(dateFormat);
  Date        data_ini_date;
  Date        data_fine_date;
  String      dataInizioOf;
  Date        dataInizioOf1;
  DateFormat  dataInizioOfFormat = new SimpleDateFormat(dateFormat);

  String      dataIniValidMin;
  Date        dataIniValidMin1;
  DateFormat  dataIniValidMinFormat = new SimpleDateFormat(dateFormat);
  String      dataFineValidMax;
  Date        dataFineValidMax1;
  DateFormat  dataFineValidMaxFormat = new SimpleDateFormat(dateFormat);


  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    Context context=null;
    try
		{
    	context = new InitialContext();     
      Object homeObject = context.lookup("InsAssOfPsBMP");
      homeInsAss = (InsAssOfPsBMPHome)PortableRemoteObject.narrow(homeObject, InsAssOfPsBMPHome.class);

    	Object homeObject2 = context.lookup("AssOfPsVerifEsistBMP");
      homeAssOfPsVerifEsist = (AssOfPsVerifEsistBMPHome)PortableRemoteObject.narrow(homeObject2, AssOfPsVerifEsistBMPHome.class);

    	Object homeObject3 = context.lookup("AssOfPsVerEsistAperteBMP");
      homeAssOfPsVerEsist = (AssOfPsVerEsistAperteBMPHome)PortableRemoteObject.narrow(homeObject3, AssOfPsVerEsistAperteBMPHome.class);

		}
    catch(NamingException e)
    {
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"AssOfPsCntl","","",StaticContext.APP_SERVER_DRIVER));
       e.printStackTrace();
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


  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    processing(request,response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    processing(request,response);
  }


  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
    //response.setContentType(CONTENT_TYPE);
    try
      {
       PrintWriter out = response.getWriter();
       String action=request.getParameter("act");
//System.out.println("SONO IN processing");       
       codiceUtente      =request.getParameter("codiceUtente");
       cod_contratto=request.getParameter("cod_contratto");
       code_of=request.getParameter("code_of");
       des_contratto=request.getParameter("des_contratto");
       cod_PS           =request.getParameter("cod_PS");
       des_PS           =request.getParameter("des_PS");
       classeSelezionata = request.getParameter("classeSelezionata");
       descSelezionata = request.getParameter("descSelezionata");
       classeSelezValue = request.getParameter("classeSelezValue");
       descSelezValue = request.getParameter("descSelezValue");
       freqSelezionata = request.getParameter("freqSelezionata");
       modApplSelezionata = request.getParameter("modApplSelezionata");
       freqSelezValue = request.getParameter("freqSelezValue");
//       modApplSelezValue = request.getParameter("modApplSelezValue");
       modApplProrSelezionata = request.getParameter("modApplProrSelezionata");
       modApplProrSelezValue = request.getParameter("modApplProrSelezValue");
       data_ini = request.getParameter("data_ini");
       data_fine = request.getParameter("data_fine");
       flagAP = request.getParameter("flagAP");



/*       
       if(modApplSelezValue.equals("1"))
       {
         flagAP="A";
       }
       else if(modApplSelezValue.equals("2"))
       {
         flagAP="P";
       }
       else
       {
         flagAP="X";
       }
*/       


       shiftStringa = request.getParameter("shift");
       if (!(shiftStringa!=null))
         shiftStringa = "0";

       Integer shiftInteger=new Integer (shiftStringa);
       shiftNumero=shiftInteger.intValue();
/*
System.out.println("shiftStringa="+shiftStringa);
System.out.println("shiftInteger="+shiftInteger);
System.out.println("shiftNumero="+shiftNumero);

System.out.println("descSelezValue="+descSelezValue);
System.out.println("cod_PS="+cod_PS);
*/

        // controllo date
/*
System.out.println("=============================");
System.out.println("data_ini="+data_ini);
System.out.println("data_fine="+data_fine);
System.out.println("=============================");
*/
         getDataIni(request,response);
         getDataIniOfPs(request,response);
         getDataIniOf(request,response);
         getDataFine(request,response);
         getDataFineOf(request,response);
/*
System.out.println("dataIniValAssOfPs1="+dataIniValAssOfPs1);
System.out.println("dataIniValOf1="+dataIniValOf1);
System.out.println("data_fine_validità="+data_fine_date);
System.out.println("dataFineValOf1="+dataFineValOf1);
System.out.println("data_ini_date="+data_ini_date);
*/
//System.out.println("=============================");

         if (dataFineValOf1!=null && data_fine_date!=null)
         {
            if (data_fine_date.after(dataFineValOf1))
            {
             //data fine validità non consentita
               action="no_data_3";
               //System.out.println(" ************ data fine validità MAGGIORE data_fine_validità OF "+dataFineValOf1);
            }
         }

         if (dataIniValAssOfPs1!=null && data_ini_date!=null)
         {
           if (dataIniValAssOfPs1.after(data_ini_date))
               
           {
             //data inizio validità maggiore della Max data inizio validità PS
             action="no_data_1";
             //System.out.println(" ************ data inizio validità non consentita "+dataIniValAssOfPs1);
           }
         }
         else if (dataIniValOf1!=null && data_ini_date!=null)
         {
           if (dataIniValOf1.after(data_ini_date))
           {
             //data inizio validità maggiore della Max data inizio validità OF
             action="no_data_2";
             //System.out.println(" ************ data inizio validità non consentita "+dataIniValOf1);
           }
         }
         else
         {
          //date di confronto non disponibili
          action="no_data_0";
          //System.out.println(" ************ date di confronto Ini non disponibili");
         }



         getNumOfPs(request,response);
         if (NumAssTrovate >0 )
         {
           action="Ass_esist_1";
           //System.out.println("!!!!! esiste un'associazione identica !!!!!!");
         }
         else
         {
           getNumAss(request,response);
           if (NumAssAperteTrovate > 0 )
           {
              //action="Ass_aperta";
              //System.out.println("!!!!! esiste un'associazione aperta !!!!!!");

//             //System.out.println("data_fine_date="+data_fine_date);
              //controlla che data fine validità è impostata
              if ((data_fine_date != null) && (!data_fine_date.equals("")))
              {
    	         //determina la data inizio validità MIN tra quelle presenti
	             // tramite la funzione ASSOC_OFPS_MIN_DIV
               getDataIniValidMin(request,response);


               //data fine validità >= MIN data ini valid
               //System.out.println("dataIniValidMin1="+dataIniValidMin1);
               if (dataIniValidMin1!=null)
                 if (dataIniValidMin1.after(data_fine_date))
                 {
                   action="data_min";
                   //System.out.println("   data fine validità inferiore alla minima data inizio validità  "+dataIniValidMin1);
                 }
              }
              else
              {
               action="no_data_fine";
               //System.out.println("   data fine validità non impostata");
              }
           }
           else
           {
             //System.out.println("!!!!! NON esiste un'associazione aperta !!!!!!");

	           //calcola la MAX data fine validità tra quelle presenti
	           // tramite la funzione ASSOC_OFPS_MAX_DFV
             getDataFineValidMax(request,response);


             if ((data_fine_date != null) && (!data_fine_date.equals("")))
             { //data fine validità IMPOSTATA

              //determina la data inizio validità MIN tra quelle presenti
	            // tramite la funzione ASSOC_OFPS_MIN_DIV
              getDataIniValidMin(request,response);

  	          //controlla: data inizio validità < la MAX data fine validità
              //System.out.println("dataFineValidMax="+dataFineValidMax);
              //System.out.println("dataFineValidMax1="+dataFineValidMax1);
              if (dataFineValidMax1!=null)
               if (!(data_ini_date.after(dataFineValidMax1)))
               {
                  action="data_max";
                  //System.out.println("   data inizio validità inferiore alla massima data fine validità  "+dataFineValidMax1);
               }
	             
              //controlla: data fine validità < MIN data ini valid
              if (dataIniValidMin1!=null)
               if (data_fine_date.after(dataIniValidMin1))
               {
                 action="data_min2";
                 //System.out.println("   data fine validità superiore alla minima data inizio validità  "+dataIniValidMin1);
               }

             }
             else //data fine validità NON IMPOSTATA
             {
  	           //controlla: data inizio validità > la MAX data fine valid
               //System.out.println("dataFineValidMax="+dataFineValidMax);
               //System.out.println("dataFineValidMax1="+dataFineValidMax1);
               if (dataFineValidMax1!=null)
                 if (dataFineValidMax1.after(data_ini_date))
                 {
                  action="data_max";
                  //System.out.println("   data inizio validità inferiore alla massima data fine validità  ");
                 }
             }
           }
         }//fine else di if (NumAssTrovate >0 )



    if(action.equals("null"))
    {
        //preleva la data di inizio OF tramite la funzione OGGETTO_FATT_LEGGI_DETTAGLIO
        getDataInizioOf(request,response);

        //effettua l'inserimento tramite la funzione ASSOC_OFPS_INSERISCI
        doInsert(request,response);
        action="salvato";

        request.getSession().setAttribute("cod_contratto",cod_contratto);
        request.getSession().setAttribute("des_contratto",des_contratto);

        //response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/ListaAssOfPsSp.jsp");
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/InsAssOfPsSp.jsp");
    }
    else
    {
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/InsAssOfPsSp.jsp?act="+action+
       "&cod_contratto="+cod_contratto+
       "&des_contratto="+java.net.URLEncoder.encode(des_contratto,com.utl.StaticContext.ENCCharset)+
       "&code_of="+code_of+
       "&cod_PS="+cod_PS+
       "&des_PS="+java.net.URLEncoder.encode(des_PS,com.utl.StaticContext.ENCCharset)+
       "&classeSelezionata="+classeSelezionata+
       "&descSelezionata="+java.net.URLEncoder.encode(descSelezionata,com.utl.StaticContext.ENCCharset)+
       "&classeSelezValue="+classeSelezValue+
       "&descSelezValue="+java.net.URLEncoder.encode(descSelezValue,com.utl.StaticContext.ENCCharset)+
       "&freqSelezionata="+freqSelezionata+
       "&modApplSelezionata="+modApplSelezionata+
       "&freqSelezValue="+freqSelezValue+
       "&modApplSelezValue="+modApplSelezValue+
       "&modApplProrSelezValue="+modApplProrSelezValue+
       "&modApplProrSelezionata="+modApplProrSelezionata+
       "&shift="+shiftStringa+
       "&flagAP="+flagAP+
       "&data_ini="+data_ini+
       "&data_fine="+data_fine);

    }

//System.out.println("++++++ lancio doInsert");
//System.out.println("dataInizioOf="+dataInizioOf);

/*
System.out.println("data_ini="+data_ini);
System.out.println("code_of="+cod_contratto);
System.out.println("cod_PS="+cod_PS);
//System.out.println("CODICEmodAppl="+modApplSelezValue);
System.out.println("CODICEfreq="+freqSelezValue);
System.out.println("codiceUtente="+codiceUtente);
System.out.println("shift="+shiftStringa);
System.out.println("flagAP="+flagAP);
System.out.println("data_fine="+data_fine);
*/

/*
System.out.println("data_ini="+data_ini);
System.out.println("code_of="+cod_contratto);
System.out.println("cod_PS="+cod_PS);
System.out.println("dataInizioOf="+dataInizioOf);
System.out.println("CODICEmodAppl="+modApplSelezValue);
System.out.println("CODICEfreq="+freqSelezValue);
System.out.println("codiceUtente="+codiceUtente);
System.out.println("shift="+shiftStringa);
System.out.println("flagAP="+flagAP);
System.out.println("data_fine="+data_fine);
System.out.println("fine CNTL");
*/
/*
        dataIniValAssOfPs="";
        dataIniValAssOfPs1=null;
        dataIniValOf="";
        dataIniValOf1=null;
        dataFineValOf="";
        dataFineValOf1=null;
        data_ini_date=null;
        data_fine_date=null;
        dataInizioOf="";
        dataInizioOf1=null;
*/

//System.out.println("ESCO");
       out.close();
      //}
    }
      catch (Exception e)
          {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
          if (e instanceof CustomEJBException)
           {
              CustomEJBException myexception = (CustomEJBException)e;
               throw myexception;
           }
          else
            throw new CustomEJBException(e.toString(),"Errore durante processing","processing","AssOfPsCntl",StaticContext.FindExceptionType(e));
          }
  }



  private void doInsert(HttpServletRequest request, HttpServletResponse response)
//  throws ServletException
  throws  CustomEJBException
  {
    try
    {

/*System.out.println("*********doInsert**************");
System.out.println("dataInizioOf="+dataInizioOf);

System.out.println("data_ini="+data_ini);
System.out.println("cod_contratto="+cod_contratto);
System.out.println("code_of="+code_of);
System.out.println("cod_PS="+cod_PS);
System.out.println("des_PS="+des_PS);
System.out.println("CODICEmodApplPror="+modApplProrSelezValue);
//System.out.println("CODICEmodAppl="+modApplSelezValue);
System.out.println("CODICEfreq="+freqSelezValue);
System.out.println("codiceUtente="+codiceUtente);
System.out.println("shift="+shiftStringa);
System.out.println("flagAP="+flagAP);
System.out.println("data_fine="+data_fine);
System.out.println("***********************");
*/
//      InsAssOfPsBMP remoteInsAss= homeInsAss.create(data_ini,cod_contratto,cod_PS,dataInizioOf,modApplProrSelezValue,freqSelezValue,codiceUtente,shiftNumero,flagAP,data_fine);
      InsAssOfPsBMP remoteInsAss= homeInsAss.create(data_ini,code_of,cod_PS,dataInizioOf,modApplProrSelezValue,freqSelezValue,codiceUtente,shiftNumero,flagAP,data_fine);
    }
    catch (Exception e)
    {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
            if (e instanceof CustomEJBException)
            {
              CustomEJBException myexception = (CustomEJBException)e;
              throw myexception;
            }
            else
              throw new CustomEJBException(e.toString(),"Errore durante insert Special","doInsert","OggFattCntl",StaticContext.FindExceptionType(e));
    }
  }


  //cattura data inizio validità inserita a mappa
  private void getDataIni(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
//System.out.println("===getDataIni===");

//    //System.out.println("data_ini IN="+data_ini+".");
     data_ini_date = dataIniFormat.parse(data_ini); //formato Date
//    //System.out.println("data trasfor="+data_ini_date+".");
    }
     catch (Exception e)
     {
        throw new ServletException("Errore AssOfPsBMPHome.create",e);
     }
  }


  //preleva la data inizio validità tra PS
  private void getDataIniOfPs(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
//System.out.println("===getDataIniOfPs===");
/*
     // FORZATURA!!!! PS=2596
     remote1= homeInsAss.findAssOfPsMaxDataIni("2596");
*/
     remote1= homeInsAss.findAssOfPsMaxDataIni(cod_PS);
     dataIniValAssOfPs= remote1.getDataIni();
//    //System.out.println("dataIniValAssOfPs="+dataIniValAssOfPs);

     if (dataIniValAssOfPs != null)
       dataIniValAssOfPs1= dataIniValAssOfPsFormat.parse(dataIniValAssOfPs);

//    //System.out.println("dataIniValAssOfPs trasformata="+dataIniValAssOfPs1);

    }
    catch (Exception e)
    {
     throw new ServletException("Errore AssOfPsBMPHome.create",e);
    }
  }


  //preleva la data inizio validità tra OF
  private void getDataIniOf(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
//System.out.println("===getDataIniOf===");
/*
     // FORZATURA!!!! cod_contratto=2 --> 1 gennaio 1999
     remote2 = homeInsAss.findAssOfPsMaxDataIniOf("2");
*/
     remote2 = homeInsAss.findAssOfPsMaxDataIniOf(cod_contratto);
     dataIniValOf = remote2.getDataIniOf();
//    //System.out.println("dataIniValOf="+dataIniValOf);
     if (dataIniValOf != null)
       dataIniValOf1 = dataIniValOfFormat.parse(dataIniValOf);
//    //System.out.println("dataIniValOf trasformata="+dataIniValOf1);
    }
    catch (Exception e)
    {
     throw new ServletException("Errore AssOfPsBMPHome.create",e);
    }
  }


  //cattura data fine validità inserita a mappa
  private void getDataFine(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     if ((data_fine != null) && (!data_fine.equals("")))
       data_fine_date = dataIniFormat.parse(data_fine); //formato Date
//    //System.out.println("data_fine trasfor="+data_fine_date+".");
    }
     catch (Exception e)
     {
        throw new ServletException("Errore AssOfPsBMPHome.create",e);
     }
  }


  //preleva la data fine validità tra OF
  private void getDataFineOf(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remote3 = homeInsAss.findDataFineValOf(code_of);
     dataFineValOf = remote3.getDataFine();
     if (dataFineValOf != null)
       dataFineValOf1 = dataIniValOfFormat.parse(dataFineValOf);
    }
    catch (Exception e)
    {
     throw new ServletException("Errore AssOfPsBMPHome.create",e);
    }
  }


  //preleva il numero di associazioni trovate
  private void getNumOfPs(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remoteAssOfPsVerifEsist = homeAssOfPsVerifEsist.findNumOfPs(cod_contratto, descSelezValue, cod_PS);
     NumAssTrovate = remoteAssOfPsVerifEsist.getNumOfPs();
    }
    catch (Exception e)
    {
     throw new ServletException("Errore AssOfPsBMPHome.create",e);
    }
  }

  //preleva il numero di associazioni trovate
  private void getNumAss(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remoteAssOfPsVerEsist = homeAssOfPsVerEsist.findNumAss(cod_contratto, descSelezValue, cod_PS);
     NumAssAperteTrovate = remoteAssOfPsVerEsist.getNumAss();

    }
    catch (Exception e)
    {
     throw new ServletException("Errore AssOfPsBMPHome.create",e);
    }
  }

             
  //preleva la minima data inizio validità
  private void getDataIniValidMin(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remote_min = homeInsAss.findMinData(cod_contratto, descSelezValue, cod_PS);
     dataIniValidMin = remote_min.getDataIniValidMin();

     if (dataIniValidMin != null)
       dataIniValidMin1 = dataIniValidMinFormat.parse(dataIniValidMin);
    }
    catch (Exception e)
    {
     throw new ServletException("Errore InsAssOfPsBMPHome.create",e);
    }
  }


  //preleva la massima data fine validità
  private void getDataFineValidMax(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remote_max = homeInsAss.findMaxData(cod_contratto, descSelezValue, cod_PS);
     dataFineValidMax = remote_max.getDataFineValidMax();

     if (dataFineValidMax != null)
       dataFineValidMax1 = dataFineValidMaxFormat.parse(dataFineValidMax);
    }
    catch (Exception e)
    {
     throw new ServletException("Errore InsAssOfPsBMPHome.create",e);
    }
  }


  //preleva la data inizio validità tra OF
  private void getDataInizioOf(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
     remote6 = homeInsAss.findDataInizioOf(code_of);
     dataInizioOf = remote6.getDataIni();

     if (dataInizioOf != null)
       dataInizioOf1 = dataInizioOfFormat.parse(dataInizioOf);

    }
    catch (Exception e)
    {
     throw new ServletException("Errore InsAssOfPsBMPHome.create",e);
    }
  }


}