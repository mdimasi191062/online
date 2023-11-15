package com.strutturaWeb;
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

import com.usr.*;
public class StrutturaWebStaticUtil 
{
  public static String creaClobLancioBatch(HttpServletRequest request) throws Exception
  {
 
/*schedulazione e generazione report*/
      String        fcIva = request.getParameter("fcIva");
      String parallelo = request.getParameter("parallelo");      /*F: F.Spiezia - 18-11-2015*/
      String ant5Anni= request.getParameter("ant5Anni");
      String generaReport = request.getParameter("generaReport");
      String dataSched = request.getParameter("dataSched");
      String cod_tipo_contr = request.getParameter("codeTipoContr");
      
      String reprDel = request.getParameter("reprDel");
      String richEmissRepr = request.getParameter("richEmissRepr");
      String dataDelib = request.getParameter("dataDelib");
      String dataChiusAnnoCont = request.getParameter("dataChiusAnnoCont");
      String motRepricing = request.getParameter("motRepricing");
      

      
      System.out.println("cod_tipo_contr ["+cod_tipo_contr+"]");
      System.out.println("dataSched      ["+dataSched+"]");
      System.out.println("generaReport   ["+generaReport+"]");   
      System.out.println("fcIva          ["+fcIva+"]");   
      System.out.println("parallelo      ["+parallelo+"]"); /*F: F.Spiezia - 18-11-2015*/
      System.out.println("ant5Anni       ["+ant5Anni+"]");
/*schedulazione e generazione report*/

      String code_funz=request.getParameter("codeFunz");
      clsInfoUser strUserName=(clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER);
      String codUtente=strUserName.getUserName();

      String messaggio=null;
      if(code_funz.compareTo("26")==0)
      {
        motRepricing = motRepricing.replace(' ','*');
        String newParameter = reprDel + ";" + richEmissRepr + ";" + dataDelib + ";" + dataChiusAnnoCont + ";" + motRepricing;      
        
        String elencoAccount=request.getParameter("elencoAccount");
        if(!dataSched.equals("") && dataSched != null)
          //messaggio="$"+dataSched+"$"+cod_tipo_contr+"$"+code_funz+"$"+codUtente+"$"+generaReport+"$"+fcIva+"$"+parallelo+"$"+ant5Anni+"$'"+reprDel+"$"+richEmissRepr+"$"+dataDelib+"$"+dataChiusAnnoCont+"$"+motRepricing+"'$_$"+elencoAccount;  /*F: F.Spiezia - 18-11-2015 --> Aggiunta flag parallelo */
           messaggio="$"+dataSched+"$"+cod_tipo_contr+"$"+code_funz+"$"+codUtente+"$"+generaReport+"$"+fcIva+"$"+parallelo+"$"+ant5Anni+"$"+newParameter+"$_$"+elencoAccount;  /*F: F.Spiezia - 18-11-2015 --> Aggiunta flag parallelo */
        else
          //messaggio=code_funz+"$"+codUtente+"$"+generaReport+"$"+fcIva+"$"+parallelo+"$"+ant5Anni+"$'"+reprDel+"$"+richEmissRepr+"$"+dataDelib+"$"+dataChiusAnnoCont+"$"+motRepricing+"'$_$"+elencoAccount; /*F: F.Spiezia - 18-11-2015 --> Aggiunto flag parallelo */
           messaggio=code_funz+"$"+codUtente+"$"+generaReport+"$"+fcIva+"$"+parallelo+"$"+ant5Anni+"$"+newParameter+"$_$"+elencoAccount; /*F: F.Spiezia - 18-11-2015 --> Aggiunto flag parallelo */
      }
      if(code_funz.compareTo("27")==0)
      {
        String elencoParam=request.getParameter("elencoParam");     
        messaggio=code_funz+"$"+codUtente+"$_$"+elencoParam;
      }
      if(code_funz.compareTo("28")==0)
      {
        String code_contr=request.getParameter("codeTipoContr"); 
        messaggio=code_funz+"$"+codUtente+"$_$"+code_contr;
      }
      
      if(code_funz.compareTo("40")==0)
      {
    
        String codServizio=request.getParameter("codServizio"); 
          String codAccount=request.getParameter("codAccount"); 
          String dataInizio=request.getParameter("dataInizio"); 
          String dataFine=request.getParameter("dataFine"); 
          String flagFunzione=request.getParameter("flagFunzione"); 
          String codeProdotto=request.getParameter("codeProdotto");
          if ("".equals(codAccount)) codAccount = "*";
          if ("".equals(codeProdotto)) codeProdotto = "*";
        messaggio=code_funz+"$"+codUtente+"$_$"+codServizio+"$_$"+codAccount+"$_$"+dataInizio+"$_$"+dataFine+"$_$"+flagFunzione+"$_$"+codeProdotto;
      }
      
      if(code_funz.compareTo("30")==0)
      {
        // String i_flag=request.getParameter("codiceTipoContratto");
        String i_id_funz=request.getParameter("id_funz");
        //cs_383
        int n_id_funz;
        try {
              n_id_funz = Integer.parseInt(i_id_funz);
        } catch (NumberFormatException e) {
               n_id_funz=0;
        }
        //cs_383
        if (i_id_funz.compareToIgnoreCase("1")==0)
        {
          String i_Code_tipo_contr=request.getParameter("codeTipoContr");
          String i_Tipo_Dati= request.getParameter("tipoDati");
          String i_Code_Account=request.getParameter("codeAccount");
          String i_minCiclo=request.getParameter("minCiclo");
          String i_maxCiclo=request.getParameter("maxCiclo");
          String i_minCess=request.getParameter("minCess");
          String i_maxCess=request.getParameter("maxCess");
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Tipo_Dati+" "+i_Code_Account+" "+i_minCiclo+" "+i_maxCiclo+" "+i_minCess+" "+i_maxCess;
        } 
        else if (i_id_funz.compareToIgnoreCase("2")==0) 
        {
          //String i_Tipologia=request.getParameter("tipologia");
          String i_CLLI_Prog=request.getParameter("codeCLLIProg");
          String i_Code_tipo_contr=request.getParameter("codeTipoContr");
          String i_CLLI=request.getParameter("codeCLLI");
          //String i_Code_Account=request.getParameter("codeAccount");
          String i_minCiclo=request.getParameter("minCiclo");
          String i_maxCiclo=request.getParameter("maxCiclo");
          //R1I-13-0066 Digital Divide
          String onlyAsimm = request.getParameter("onlyAsimm");
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_CLLI_Prog+" "+i_CLLI+" "+i_Code_tipo_contr+" "+i_minCiclo+" "+i_maxCiclo+" "+onlyAsimm;
          System.out.println("creaClobLancioBatch - messaggio ["+messaggio+"]");
        }
        else if (i_id_funz.compareToIgnoreCase("5")==0) 
        {
          String i_codeTipoContr=Misc.nh(request.getParameter("codeTipoContr"));
          if(i_codeTipoContr.equals("") || i_codeTipoContr.equals("0"))
            i_codeTipoContr = "null";
          String i_contr=Misc.nh(request.getParameter("contr"));
          if(i_contr.equals("") || i_contr.equals("0"))
            i_contr = "null";
          String i_prodotto=Misc.nh(request.getParameter("prodotto"));
          if(i_prodotto.equals("") || i_prodotto.equals("0"))
            i_prodotto = "null";
          String i_oggFatrz=Misc.nh(request.getParameter("oggFatrz"));
          if(i_oggFatrz.equals("") || i_oggFatrz.equals("0"))
            i_oggFatrz = "null";
          String i_causale=Misc.nh(request.getParameter("causale"));
          if(i_causale.equals("") || i_causale.equals("0"))
            i_causale = "null";
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_codeTipoContr+" "+i_contr+" "+i_prodotto+" "+i_oggFatrz+" "+i_causale;
        }
        else if (i_id_funz.compareToIgnoreCase("4")==0)
        {
          String i_codeTipoContr=Misc.nh(request.getParameter("codeTipoContr"));
          if(i_codeTipoContr.equals("") || i_codeTipoContr.equals("0"))
            i_codeTipoContr = "null";
          String i_contr=Misc.nh(request.getParameter("contr"));
          if(i_contr.equals("") || i_contr.equals("0"))
            i_contr = "null";
          String i_prodotto=Misc.nh(request.getParameter("prodotto"));
          if(i_prodotto.equals("") || i_prodotto.equals("0"))
            i_prodotto = "null";
          String i_oggFatrz=Misc.nh(request.getParameter("oggFatrz"));
          if(i_oggFatrz.equals("") || i_oggFatrz.equals("0"))
            i_oggFatrz = "null";
          String i_causale=Misc.nh(request.getParameter("causale"));
          if(i_causale.equals("") || i_causale.equals("0"))
            i_causale = "null";
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_codeTipoContr+" "+i_contr+" "+i_prodotto+" "+i_oggFatrz+" "+i_causale;
        }
        else if (i_id_funz.compareToIgnoreCase("6")==0)
        {
          String i_Code_tipo_contr=request.getParameter("codeTipoContr");
          String i_Code_Account=request.getParameter("codeAccount");
          String i_Tipo_Estraz=request.getParameter("tipoEstrazione");
          String i_Periodo_Estraz=request.getParameter("periodoEstrazione");
          String i_minCiclo=request.getParameter("minCiclo");
          String i_maxCiclo=request.getParameter("maxCiclo");
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Code_Account+" "+i_Tipo_Estraz+" "+i_Periodo_Estraz+" "+i_minCiclo+" "+i_maxCiclo;
        } 
        else if (i_id_funz.compareToIgnoreCase("7")==0||i_id_funz.compareToIgnoreCase("8")==0)
        {
          String i_Code_tipo_contr=request.getParameter("codeTipoContr");
          String i_Code_Account=request.getParameter("codeAccount");
          String i_Periodo_Estraz=request.getParameter("periodoEstrazione");
          String i_minCiclo=request.getParameter("minCiclo");
          String i_maxCiclo=request.getParameter("maxCiclo");
          String i_dataDRO=request.getParameter("dataDRO");
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Code_Account+" "+i_Periodo_Estraz+" "+i_minCiclo+" "+i_maxCiclo +" "+ i_dataDRO;
        }
      else if (i_id_funz.compareToIgnoreCase("15")==0)
      {
        String i_Code_tipo_contr=request.getParameter("codeTipoContr");
        String i_Code_Gestore=request.getParameter("codeGestore");
        String i_DataCongelamento=request.getParameter("dataCongelamento");
        String i_checkAttive=request.getParameter("checkAttive");
        String i_checkCessate=request.getParameter("checkCessate");
        //inizio cs_381
        String i_checkHD=request.getParameter("checkHD");
        String i_checkAnagrafica=request.getParameter("checkAnagrafica");
          //messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Code_Gestore+" "+i_DataCongelamento+" "+i_checkAttive+" "+i_checkCessate;
           messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Code_Gestore+" "+i_DataCongelamento+" "+i_checkAttive+" "+i_checkCessate+" "+i_checkHD+" "+i_checkAnagrafica;
           
      }    
      //R1H-20-0181
      else if (i_id_funz.compareToIgnoreCase("37")==0)
      {
          String i_chkAssurance=request.getParameter("chkAssurance");
          String i_chkProvisioning=request.getParameter("chkProvisioning");
            
            messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_chkAssurance+" "+i_chkProvisioning ;
      }
      //fine R1H-20-0181
      //inizio cs_381
      else if (i_id_funz.compareToIgnoreCase("18")==0)
      {
        String i_checkUnaTantum=request.getParameter("checkUnaTantum");
          
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_checkUnaTantum;
      }
      else if (i_id_funz.compareToIgnoreCase("19")==0)
      {
        String i_checkUnaTantum=request.getParameter("checkUnaTantum");
          
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_checkUnaTantum;
      } 
        else if (i_id_funz.compareToIgnoreCase("14")==0)
        {
          String i_checkAntePost=request.getParameter("checkAntePost");
            String i_Code_tipo_contr=request.getParameter("codiceTipoContratto");
          //String i_dataInizioPeriodo=nu; 
          Date d = null;
          SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yy");
          Date data = new Date();
          String dataStr = formatter.format(data);
          //GregorianCalendar c = new GregorianCalendar(); 
           // c.set(Calendar.DAY_OF_MONTH, 1); // Primo giorno del mese
            //c.add(Calendar.MONTH, -1); // Data con un mese in più
             DateFormat formatoData = DateFormat.getDateInstance(DateFormat.SHORT, Locale.ITALY);
            formatoData.setLenient(false); 
            d = formatoData.parse(dataStr);
            Calendar c = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
                      // c.setTime(d);
                       c.setTime(data);                       
                       //aggiunge 10 anni e 6 mesi alla data d
                       //c.add(Calendar.YEAR, +10);
                       c.add(Calendar.MONTH, -1);
                       c.set(Calendar.DAY_OF_MONTH, 1);
             dataStr = formatter.format(c.getTime());
         
          //messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+dataStr+" "+i_checkAntePost;
            messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+dataStr+" "+i_checkAntePost;
           // messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_checkUnaTantum;
        } 
            else if (i_id_funz.compareToIgnoreCase("11")==0)
            {
              String i_checkAntePost=request.getParameter("checkAntePost");
                String i_checkRegXDSL=request.getParameter("checkRegXDSL");
                if (i_checkRegXDSL.compareToIgnoreCase("1")==0)
                   i_id_funz = "12";
                //String i_Code_tipo_contr=request.getParameter("codiceTipoContratto");
              //String i_dataInizioPeriodo=nu; 
              Date d = null;
              SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yy");
              Date data = new Date();
              String dataStr = formatter.format(data);
              //GregorianCalendar c = new GregorianCalendar(); 
               // c.set(Calendar.DAY_OF_MONTH, 1); // Primo giorno del mese
                //c.add(Calendar.MONTH, -1); // Data con un mese in più
                 DateFormat formatoData = DateFormat.getDateInstance(DateFormat.SHORT, Locale.ITALY);
                formatoData.setLenient(false); 
                d = formatoData.parse(dataStr);
                Calendar c = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
                          // c.setTime(d);
                           c.setTime(data);                       
                           //aggiunge 10 anni e 6 mesi alla data d
                           //c.add(Calendar.YEAR, +10);
                           c.add(Calendar.MONTH, -1);
                           c.set(Calendar.DAY_OF_MONTH, 1);
                 dataStr = formatter.format(c.getTime());
             
              //messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+dataStr+" "+i_checkAntePost;
                messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+dataStr+" "+i_checkAntePost;
               // messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_checkUnaTantum;
            } 
      //fine cs_381
      else if (i_id_funz.compareToIgnoreCase("16")==0)
      {
        String i_Code_tipo_contr=request.getParameter("codeTipoContr");
        String i_DataCongelamento=request.getParameter("dataCongelamento");
        String i_checkAttive=request.getParameter("checkAttive");
        String i_checkCessate=request.getParameter("checkCessate");
        
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_DataCongelamento+" "+i_checkAttive+" "+i_checkCessate;
      }       
      else if (i_id_funz.compareToIgnoreCase("17")==0)
      {
        String i_Code_tipo_contr=request.getParameter("codeTipoContr");
        String i_DataCongelamento=request.getParameter("dataCongelamento");
        String i_checkAttive=request.getParameter("checkAttive");
        String i_checkCessate=request.getParameter("checkCessate");
        
          messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_DataCongelamento+" "+i_checkAttive+" "+i_checkCessate;
      }
      else if (i_id_funz.compareToIgnoreCase("20")==0 || i_id_funz.compareToIgnoreCase("21")==0)
      {
       
        String codGest = request.getParameter("codGest") ;
        codGest = ( "".equals(codGest) || codGest == null ) ? null : codGest;
        String codAccount =  request.getParameter("codAccount");
        codAccount = ( "".equals(codAccount) || codAccount == null ) ? null : codAccount;
        String dataInizio =request.getParameter("dataInizio");
        dataInizio = ( "".equals(dataInizio) || dataInizio == null ) ? null : dataInizio;
        String dataFine = request.getParameter("dataFine");
        dataFine = ( "".equals(dataFine) || dataFine == null ) ? null : dataFine;
        String flagFunzione = request.getParameter("flagFunzione");
        flagFunzione = ( "".equals(flagFunzione) || flagFunzione == null || "-1".equals(flagFunzione) ) ? null : flagFunzione;
        String rifFattura = request.getParameter("rifFattura");
        rifFattura = ( "".equals(rifFattura) || rifFattura == null || "-1".equals(rifFattura) ) ? null : rifFattura;
        
        messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+dataInizio+" "+dataFine+" "+flagFunzione+" "+rifFattura+" "+codGest+" "+codAccount;
      }    
        else if (i_id_funz.compareToIgnoreCase("22")==0)
        {
         
          String Ambiente = request.getParameter("Ambiente") ;
          String TipoEstrazione = request.getParameter("TipoEstrazione") ;
          String codeFunz =  request.getParameter("codeFunz");
          String AnnoCessazione = request.getParameter("AnnoCessazione");
          String MeseCessazione = request.getParameter("MeseCessazione");
          String listaServizi = request.getParameter("listaServizi");
         String listaOperatori = request.getParameter("listaOperatori");
          messaggio=TipoEstrazione+"$"+codUtente+"$_$"+i_id_funz+" "+Ambiente+" "+AnnoCessazione+" "+MeseCessazione+" "+listaServizi+" "+listaOperatori;
        }
        //ini cs_383
        else if ((n_id_funz>22)&&(n_id_funz<36))
        {
            messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+ null;
        } 
        //fine cs_383
      else 
      {
        String i_Code_tipo_contr=request.getParameter("codeTipoContr");
        String i_Code_Account=request.getParameter("codeAccount");
        String i_Data_Inizio_Fatrz=request.getParameter("dataInizioFatrz");
        String i_seq=request.getParameter("seq");
        messaggio=code_funz+"$"+codUtente+"$_$"+i_id_funz+" "+i_Code_tipo_contr+" "+i_Code_Account+" "+i_Data_Inizio_Fatrz+" "+i_seq;
      }
    }
    
    return messaggio;
  }
}