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
import com.ejbSTL.*;

public class AssOfPsXContrCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

  private ProdServSTLHome homeProdServ=null;
  private AssOfPsXContrSTLHome homeAssOfPS=null;
  private ContrattoSTLHome homeContr=null;

  private InsAssOfPsBMPHome homeInsAss=null;
//  private InsAssOfPsBMP remoteInsAss=null;
  private InsAssOfPsBMP remote1=null;
  private InsAssOfPsBMP remote2=null;
  private InsAssOfPsBMP remote3=null;
  private InsAssOfPsBMP remote6=null;
  private AssOfPsXContrBMPHome homeGestAss   = null;
  private AssOfPsXContrBMP     remoteGestAss = null;
  private AssOfPsXContrBMPPK pk = new AssOfPsXContrBMPPK();

  private AssOfPsVerifEsistBMPHome  homeAssOfPsVerifEsist;//=null;
  private AssOfPsVerifEsistBMP      remoteAssOfPsVerifEsist;// = null;
  private AssOfPsVerEsistAperteBMPHome homeAssOfPsVerEsist;//=null;
  private AssOfPsVerEsistAperteBMP      remoteAssOfPsVerEsist;// = null;
  int NumAssTrovate;
  int NumAssAperteTrovate;


private InsAssOfPsBMP remote_min;// = null;
private InsAssOfPsBMP remote_max;// = null;
/*
  String codiceUtente;
  String code_of;
  String des_PS;
  String cod_PS;
  String freqSelezionata;
  String modApplSelezionata;
  String freqSelezValue;
  String modApplSelezValue;
  String shiftStringa;
  int shiftNumero;
  String data_ini;
  String data_fine;
  String flagAP;
*/
  String flag_sys;
  String cod_tipo_contr;
  String des_tipo_contr;
  String codeContr;
  String dataIniOfPs;
  String codOf;
  String codPs;
  String dataIniOf;
  String codModal;
  String codeFreq;
  String codUtente;
  String shift;
  String shiftStringa;
  int shiftNumero;
  String flag;
  String dataFineOfPs;
  String des_PS;
  String descSelezValue;
  String classeSelezionata;
  String descSelezionata;
  String classeSelezValue;
  String modApplProrSelezValue;
  String modApplProrSelezionata;
  String cod_contratto;
  String des_contratto;

  String      dateFormat =  "dd/MM/yyyy";
  DateFormat  dataIniFormat = new SimpleDateFormat(dateFormat);
  String      dataIniValAssOfContr;
  Date        dataIniValAssOfContr1;
  DateFormat  dataIniValAssOfContrFormat = new SimpleDateFormat(dateFormat);
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
//System.out.println("init");
    try
		{
    	context = new InitialContext();     
      Object homeObject = context.lookup("InsAssOfPsBMP");
      homeInsAss = (InsAssOfPsBMPHome)PortableRemoteObject.narrow(homeObject, InsAssOfPsBMPHome.class);

    	Object homeObject2 = context.lookup("AssOfPsVerifEsistBMP");
      homeAssOfPsVerifEsist = (AssOfPsVerifEsistBMPHome)PortableRemoteObject.narrow(homeObject2, AssOfPsVerifEsistBMPHome.class);

    	Object homeObject3 = context.lookup("AssOfPsVerEsistAperteBMP");
      homeAssOfPsVerEsist = (AssOfPsVerEsistAperteBMPHome)PortableRemoteObject.narrow(homeObject3, AssOfPsVerEsistAperteBMPHome.class);

    	Object homeObject4 = context.lookup("AssOfPsXContrBMP");
      homeGestAss = (AssOfPsXContrBMPHome)PortableRemoteObject.narrow(homeObject4, AssOfPsXContrBMPHome.class);

    	Object homeObject5 = context.lookup("AssOfPsXContrSTL");
      homeAssOfPS = (AssOfPsXContrSTLHome)PortableRemoteObject.narrow(homeObject5, AssOfPsXContrSTLHome.class);

    	Object homeObject6 = context.lookup("ContrattoSTL");
      homeContr = (ContrattoSTLHome)PortableRemoteObject.narrow(homeObject6, ContrattoSTLHome.class);


		}
    catch(NamingException e)
    {
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"AssOfPsXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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
//System.out.println("--------------- action="+action);       
//System.out.println("SONO IN processing");       
 //System.out.println("PRIMA flag="+flag);
/*
       codiceUtente      =request.getParameter("codiceUtente");
       code_of=request.getParameter("code_of");
       cod_PS           =request.getParameter("cod_PS");
       freqSelezionata = request.getParameter("freqSelezionata");
       modApplSelezionata = request.getParameter("modApplSelezionata");
       freqSelezValue = request.getParameter("freqSelezValue");
//       modApplSelezValue = request.getParameter("modApplSelezValue");
       data_ini = request.getParameter("data_ini");
       data_fine = request.getParameter("data_fine");
       flagAP = request.getParameter("flagAP");

System.out.println("cod_contratto="+cod_contratto);
System.out.println("code_of="+code_of);
System.out.println("cod_PS="+cod_PS);

//System.out.println("CODICEmodApplPror="+modApplProrSelezValue);
*/
   flag_sys=request.getParameter("flag_sys");
   cod_tipo_contr=request.getParameter("cod_tipo_contr");
   des_tipo_contr=request.getParameter("des_tipo_contr");
   codeContr=request.getParameter("cod_tipo_contr");
   dataIniOfPs=request.getParameter("data_ini");
   codOf=request.getParameter("code_of");
   codPs=request.getParameter("cod_PS");
   dataIniOf=request.getParameter("dataIniOf");
   codModal=request.getParameter("modApplProrSelezValue");
   codeFreq=request.getParameter("freqSelezValue");
   codUtente=request.getParameter("codiceUtente");
   shift=request.getParameter("shift");
   flag=request.getParameter("flagAP");
   dataFineOfPs=request.getParameter("data_fine");
   des_PS           =request.getParameter("des_PS");
   descSelezValue = request.getParameter("descSelezValue");
   classeSelezionata = request.getParameter("classeSelezionata");
   descSelezionata = request.getParameter("descSelezionata");
   classeSelezValue = request.getParameter("classeSelezValue");
   modApplProrSelezValue = request.getParameter("modApplProrSelezValue");
   modApplProrSelezionata = request.getParameter("modApplProrSelezionata");
   cod_contratto=request.getParameter("code_contratto");
   des_contratto=request.getParameter("des_contratto");
 //System.out.println("DOPO flag="+flag);

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
*/

        // controllo date
         getDataIni(request,response);
         getDataIniOfContr(request,response);
         getDataIniOfPs(request,response);
         getDataIniOf(request,response);
         getDataFine(request,response);
         getDataFineOf(request,response);


//System.out.println("dataIniValAssOfContr1="+dataIniValAssOfContr1);
//System.out.println("dataIniValAssOfPs1="+dataIniValAssOfPs1);
//System.out.println("dataIniValOf1="+dataIniValOf1);
//System.out.println("data_fine_validità="+data_fine_date);
//System.out.println("dataFineValOf1="+dataFineValOf1);
//System.out.println("data_ini_date="+data_ini_date);
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

//nicola
         if (dataIniValAssOfContr1!=null && data_ini_date!=null)
         {
           if (dataIniValAssOfContr1.after(data_ini_date))
               
           {
             //data inizio validità maggiore della Max data inizio validità contratto
             action="no_data";
             //System.out.println(" ************ data inizio validità non consentita "+dataIniValAssOfContr1);
           }
         }
         else if (dataIniValAssOfPs1!=null && data_ini_date!=null)
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
              action="Ass_aperta";
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
	           // tramite la funzione ASSOC_OFPS_X_CONTR_MAX_DFV
             getDataFineValidMax(request,response);

             if ((data_fine_date != null) && (!data_fine_date.equals("")))
             { //data fine validità IMPOSTATA

              //determina la data inizio validità MIN tra quelle presenti
	            // tramite la funzione ASSOC_OFPS_X_CONTR_MIN_DIV
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
         }//fine else di if (NumAssTrovate >1 )


    if(action.equals("null"))
    {
        //preleva la data di inizio OF tramite la funzione OGGETTO_FATT_LEGGI_DETTAGLIO
        getDataInizioOf(request,response);

        //effettua l'inserimento tramite la funzione ASSOC_OFPS_INSERISCI
        doInsert(request,response);
        action="salvato";

        request.getSession().setAttribute("cod_tipo_contr",codeContr);
        request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);

//        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/ListaAssOfPsXContrSp.jsp");
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/InsAssOfPsXContrSp.jsp");
    }
    else
    {
        request.getSession().setAttribute("cod_tipo_contr",codeContr);
        request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);
//System.out.println(codeContr);
//System.out.println(des_tipo_contr);
//System.out.println(cod_contratto);
//System.out.println(codOf);
//System.out.println(codPs);
//System.out.println("descSelezValue="+descSelezValue);

        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/InsAssOfPsXContrSp.jsp?act="+action+
       "&code_contratto="+cod_contratto+
       "&cmb_contratto="+cod_contratto+
       "&contrattoSelezionata=true"+
//       "&des_contratto="+des_contratto+
       "&code_of="+codOf+
       "&cod_PS="+codPs+
       "&des_PS="+java.net.URLEncoder.encode(des_PS,com.utl.StaticContext.ENCCharset)+
       "&classeSelezionata="+classeSelezionata+
       "&descSelezionata="+java.net.URLEncoder.encode(descSelezionata,com.utl.StaticContext.ENCCharset)+
       "&classeSelezValue="+classeSelezValue+
       "&descSelezValue="+java.net.URLEncoder.encode(descSelezValue,com.utl.StaticContext.ENCCharset)+
       "&freqSelezionata="+codeFreq+
       "&modApplSelezionata="+codModal+
       "&freqSelezValue="+codeFreq+
       "&modApplSelezValue="+codModal+
       "&modApplProrSelezValue="+modApplProrSelezValue+
       "&modApplProrSelezionata="+modApplProrSelezionata+
       "&shift="+shiftStringa+
       "&flagAP="+flag+
       "&data_ini="+dataIniOfPs+
       "&data_fine="+dataFineOfPs);
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
            throw new CustomEJBException(e.toString(),"Errore durante processing","processing","AssOfPsXContrCntl",StaticContext.FindExceptionType(e));
          }
  }



  private void doInsert(HttpServletRequest request, HttpServletResponse response)
//  throws ServletException
  throws  CustomEJBException
  {
    try
    {

//System.out.println("*********doInsert**************");
//  String cod_tipo_contr=request.getParameter("cod_tipo_contr");
int qtaShiftCanoni = 0;
if (shift!=null)
{
    Integer shi= new Integer(shift);      
    qtaShiftCanoni=shi.intValue();
}


//System.out.println("cod_contratto="+cod_contratto);
//System.out.println("codeContr="+codeContr);
//System.out.println("dataIniOfPs="+dataIniOfPs);
//System.out.println("codOf="+codOf);
//System.out.println("codPs="+codPs);
//System.out.println("codModal="+codModal);
//System.out.println("codeFreq="+codeFreq);
//System.out.println("codUtente="+codUtente);
//System.out.println("shift="+shift);
//System.out.println("flag="+flag);
//System.out.println("dataFineOfPs="+dataFineOfPs);
//System.out.println("dataInizioOf="+dataInizioOf);
//System.out.println("***********************");

        AssOfPsXContrBMP remoteGestAss= homeGestAss.create(cod_contratto,dataIniOfPs,codOf,codPs,dataInizioOf,codModal,codeFreq,codUtente,qtaShiftCanoni,flag,dataFineOfPs);
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
              throw new CustomEJBException(e.toString(),"Errore durante insert Special","doInsert","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }
  }



  //cattura data inizio validità inserita a mappa
  private void getDataIni(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
//System.out.println("===getDataIni===");

     //System.out.println("data_ini IN="+dataIniOfPs+".");
     data_ini_date = dataIniFormat.parse(dataIniOfPs); //formato Date
     //System.out.println("data trasfor="+data_ini_date+".");
    }
     catch (Exception e)
     {
        throw new ServletException("Errore AssOfPsBMPHome.create",e);
     }
  }


  //preleva la data inizio validità tra Contratti
  private void getDataIniOfContr(HttpServletRequest request, HttpServletResponse response)  throws ServletException
  {
    try
    {
//System.out.println("===getDataIniOfContr===");


     ContrattoSTL remoteContr= homeContr.create();
     dataIniValAssOfContr= remoteContr.getDataIni(codeContr,flag_sys);

     //System.out.println("dataIniValAssOfContr="+dataIniValAssOfContr);

     if (dataIniValAssOfContr != null)
       dataIniValAssOfContr1= dataIniValAssOfContrFormat.parse(dataIniValAssOfContr);

     //System.out.println("dataIniValAssOfContr trasformata="+dataIniValAssOfContr1);

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
//getDataIni(codPs);nicola1
     ProdServSTL remoteProdServ= homeProdServ.create();
     ProdServElem elemProdServ = remoteProdServ.getDataIni(codPs);
     dataIniValAssOfPs= elemProdServ.getDataIni();
*/
     remote1= homeInsAss.findAssOfPsMaxDataIni(codPs);
     dataIniValAssOfPs= remote1.getDataIni();

     //System.out.println("dataIniValAssOfPs="+dataIniValAssOfPs);

     if (dataIniValAssOfPs != null)
       dataIniValAssOfPs1= dataIniValAssOfPsFormat.parse(dataIniValAssOfPs);

     //System.out.println("dataIniValAssOfPs trasformata="+dataIniValAssOfPs1);

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
//getDataIni(codPs);nicola1
/*
     ProdServSTL remoteProdServ= homeProdServ.create();
     ProdServElem elemProdServ = remoteProdServ.getDataIni(codPs);
     dataIniValAssOfPs= elemProdServ.getDataIni();
*/
     remote2 = homeInsAss.findAssOfPsMaxDataIniOf(codeContr);
     dataIniValOf = remote2.getDataIniOf();
     //System.out.println("dataIniValOf="+dataIniValOf);
     if (dataIniValOf != null)
       dataIniValOf1 = dataIniValOfFormat.parse(dataIniValOf);
     //System.out.println("dataIniValOf trasformata="+dataIniValOf1);
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
//System.out.println("===getDataFine===");

     //System.out.println("dataFineOfPs="+dataFineOfPs+".");
     if ((dataFineOfPs != null) && (!dataFineOfPs.equals("")))
       data_fine_date = dataIniFormat.parse(dataFineOfPs); //formato Date
     //System.out.println("data_fine trasfor="+data_fine_date+".");
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
//System.out.println("==getDataFineOf===");
//getDataIni(codPs);nicola1
/*
     OggettoFattSTL remoteOggFatt= homeOggFatt.create();
     ...Elem elemProdServ = remoteOggFatt.getDataFine(codPs);
     dataFineValOf = elemProdServ.getDataFine();
*/
     remote3 = homeInsAss.findDataFineValOf(codOf);
     dataFineValOf = remote3.getDataFine();
     //System.out.println("dataFineValOf="+dataFineValOf);
     if (dataFineValOf != null)
       dataFineValOf1 = dataIniValOfFormat.parse(dataFineValOf);
     //System.out.println("dataFineValOf trasformata="+dataFineValOf1);
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
//System.out.println("===getNumOfPs===");

//nicola11
     AssOfPsXContrSTL remoteNumOfPs= homeAssOfPS.create();
     NumAssTrovate = remoteNumOfPs.check_esiste(codeContr,cod_contratto,codOf,codPs);

     //System.out.println("NumAssTrovate="+NumAssTrovate);
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
     //System.out.println("===getNumAss===");

//nicola11
     AssOfPsXContrSTL remoteAssOfPsVerEsist= homeAssOfPS.create();
     NumAssAperteTrovate = remoteAssOfPsVerEsist.check_aperte(cod_contratto,codeContr,codOf,codPs);

     //System.out.println("NumAssAperteTrovate="+NumAssAperteTrovate);
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
//System.out.println("=== getDataIniValidMin ===");

     AssOfPsXContrSTL remoteAssOfPS= homeAssOfPS.create();
     dataIniValidMin= remoteAssOfPS.getMinDataIni(cod_contratto,codeContr,codOf,codPs);

     //System.out.println("dataIniValidMin="+dataIniValidMin);
     if (dataIniValidMin != null)
       dataIniValidMin1 = dataIniValidMinFormat.parse(dataIniValidMin);
     //System.out.println("dataIniValidMin trasformata="+dataIniValidMin1);
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
//System.out.println("=== getDataFineValidMax ===");

     AssOfPsXContrSTL remoteAssOfPS= homeAssOfPS.create();
     dataFineValidMax= remoteAssOfPS.getMaxDataFine(cod_contratto,codeContr,codOf,codPs);

     //System.out.println("dataFineValidMax="+dataFineValidMax);
     if (dataFineValidMax != null)
       dataFineValidMax1 = dataFineValidMaxFormat.parse(dataFineValidMax);
     //System.out.println("dataFineValidMax trasf="+dataFineValidMax1);
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
//System.out.println(" getDataInizioOf===");

     remote6 = homeInsAss.findDataInizioOf(codOf);
     dataInizioOf = remote6.getDataIni();

     //System.out.println("dataInizioOf="+dataInizioOf);
     if (dataInizioOf != null)
       dataInizioOf1 = dataInizioOfFormat.parse(dataInizioOf);
     //System.out.println("dataInizioOf trasformata="+dataInizioOf1);

    }
    catch (Exception e)
    {
     throw new ServletException("Errore InsAssOfPsBMPHome.create",e);
    }
  }


}