package com.utl;
import java.text.NumberFormat;
import java.util.*;
import com.utl.Misc;

public class DataFormat 
{
  private static final int[] DaysOfMonth = {31,28,31,30,31,30,31,31,30,31,30,31};

  private static GregorianCalendar private_setData(int pint_dd, int pint_mm, int pint_year) 
   throws Exception 
   {
     try
     {
     GregorianCalendar lcld_Data = new GregorianCalendar();
     if ( pint_dd != 0 && pint_mm != 0 && pint_year != 0 )
        lcld_Data.set(pint_year,(pint_mm-1),pint_dd);
     else
        lcld_Data.set(0,0,1); // fittizio in caso di data non congruente
     return lcld_Data;
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }
 
  public static GregorianCalendar setData() 
   throws Exception 
   {
     try
     {
        GregorianCalendar lcld_Data = new GregorianCalendar();
        return (lcld_Data);
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static  GregorianCalendar setData(long plng_Time) 
   throws Exception 
   {
     try
     {
        Date pdat_Time = new Date ( plng_Time );
        GregorianCalendar lcld_Data = new GregorianCalendar();
        lcld_Data.setTime(pdat_Time);
        return (lcld_Data);
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static GregorianCalendar setData(int pint_dd, int pint_mm, int pint_year) 
   throws Exception 
   {
     try
     {
      return (private_setData(pint_dd, pint_mm, pint_year));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static GregorianCalendar setData(String pstr_Data, String formato) 
  throws Exception      
 {
   Vector lvct_Calendar = null;
   Integer lint_p = null;
   int lint_p1 = 0;
   int lint_p2 = 0; 
   int lint_p3 = 0;
   try
     {
      //Si individua il formato
      // 1 = dd/mm/yyyy; 2 = mm/dd/yyyy; 3 = yyyy/mm/dd
      lvct_Calendar = private_ParseDateString(pstr_Data);
      if (lvct_Calendar != null)
      {
        lint_p1 = Integer.parseInt((String)lvct_Calendar.get(0));
        lint_p2 = Integer.parseInt((String)lvct_Calendar.get(1));
        lint_p3 = Integer.parseInt((String)lvct_Calendar.get(2));
      }
      if (formato.startsWith("dd")) return (private_setData(lint_p1, lint_p2, lint_p3));
      else if (formato.startsWith("mm")) return (private_setData(lint_p2, lint_p1, lint_p3));
      else if (formato.startsWith("yyyy")) return (private_setData(lint_p3, lint_p2, lint_p1));
      else return null;
     }
   catch(Exception e)
     {
      throw new Exception(e.toString());
     }
  }

  private static Vector private_ParseDateString(String pstr_Data) 
   throws Exception 
   {
     Vector lvct_Calendar = null;
     Misc lcls_misc = null;
     try
     {
      if (! Misc.nh(pstr_Data).equalsIgnoreCase(""))
      {
        lvct_Calendar = new Vector();
        StringTokenizer tokenizer = new StringTokenizer(pstr_Data, "/");
        lvct_Calendar.addElement(tokenizer.nextToken());
        lvct_Calendar.addElement(tokenizer.nextToken());
        lvct_Calendar.addElement(tokenizer.nextToken());
      }
      return lvct_Calendar;
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }
 
  public static GregorianCalendar rollData(int pint_giorni) 
   throws Exception 
   {
     try
     {
        return (private_rollData(0L,0,0,pint_giorni));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static GregorianCalendar rollData(long plng_Time,int pint_giorni) 
   throws Exception 
   {
     try
     {
        return (private_rollData(plng_Time,0,0,pint_giorni));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static GregorianCalendar rollData(long plng_Time,int pint_anni, int pint_mesi, int pint_giorni) 
   throws Exception 
   {
     try
     {
        return (private_rollData(plng_Time,pint_anni,pint_mesi,pint_giorni));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  private static GregorianCalendar private_rollData(long plng_Time,int pint_anni,int pint_mesi,int pint_giorni) 
   throws Exception 
   {
     GregorianCalendar lcld_Data = new GregorianCalendar();
     try
     {
        if ( plng_Time == 0L )
          plng_Time = lcld_Data.getTime().getTime();
        else
        {
          Date pdat_Time = new Date ( plng_Time );
          lcld_Data.setTime(pdat_Time);
        } 
        if ( pint_anni != 0 )
          lcld_Data.roll(GregorianCalendar.YEAR,pint_mesi); 

        if ( pint_mesi != 0 )
        {
          if ( (pint_mesi > 0) && ((lcld_Data.get(GregorianCalendar.MONTH ) + 1) + pint_mesi) > 12 )
          {
            lcld_Data.roll(GregorianCalendar.YEAR,1); 
            lcld_Data.set(GregorianCalendar.MONTH,((lcld_Data.get(GregorianCalendar.MONTH ) + pint_mesi) - 12));
          }
          else
          {
            lcld_Data.roll(GregorianCalendar.MONTH,pint_mesi);
          }
          
        }

        if ( pint_giorni != 0 )
          lcld_Data = setData(lcld_Data.getTime().getTime() + (pint_giorni * 86400000) );

        return (lcld_Data);
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static String ConvertiRollData(String pstr_Data, String formato, int pint_anni, int pint_mesi, int pint_giorni) 
   throws Exception 
   {
     try
     {
        return(convertiData(rollData(setData(pstr_Data,formato).getTime().getTime(), pint_anni, pint_mesi, pint_giorni),formato));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

  public static String NextEndMonths(String pstr_Data, String formato, int pint_mesi) 
   throws Exception 
   {
     GregorianCalendar lcld_Data = null;
     try
     {
        lcld_Data = rollData(setData(pstr_Data,formato).getTime().getTime(), 0, pint_mesi, 0);
        if ( (lcld_Data.get(GregorianCalendar.MONTH) == 1 ) && (lcld_Data.isLeapYear(lcld_Data.get(GregorianCalendar.YEAR))))
        {
          // febbraio di anno bisestile
          lcld_Data.set(GregorianCalendar.DAY_OF_MONTH,( DaysOfMonth[lcld_Data.get(GregorianCalendar.MONTH)] + 1) );
        }
        else
        {
          lcld_Data.set(GregorianCalendar.DAY_OF_MONTH,DaysOfMonth[lcld_Data.get(GregorianCalendar.MONTH)] );
        }
        
        return(convertiData(lcld_Data,formato));
     }
     catch(Exception e)
     {
      throw new Exception(e.toString());
     }
   }

 /**
 * Acquisisce in ingresso un oggetto di tipo Gregorian Calendar
 * e una stringa che specifica il formato, e restituisce in output
 * una stringa contenente la data nel formato specificato;
 * i formati restituiti sono soltanto i seguenti:
 * dd mm yyyy;
 * mm dd yyyy;
 * yyyy mm dd;
 * Il carattere separatore è quello indicato nel formato
 * Creation date: (21/08/2001 12.57.20)
 * @return java.lang.String
 */
 public static String convertiData(GregorianCalendar data, String formato) 
 throws Exception {
 try{
  String strData = null;
  String strGiorno = null;
  String strMese = null;
  String strAnno = null;
 
  int intGiorno = 0;
  int intMese = 0;
  int intAnno = 0;
 
  //Si individua il formato
  int codFormato = 0;// 1 = ddmmyyyy; 2 = mmddyyyy; 3 = yyyymmdd
 
  if (formato.startsWith("dd")){
   codFormato = 1;  
  }
  if (formato.startsWith("mm")){
   codFormato = 2;  
  }
  if (formato.startsWith("yyyy")){
   codFormato = 3;  
  }
  
	//Si individua il carattere separatore
	String charSeparatore = "";
	if (formato.length() > 8)
	{
		if(codFormato == 1 || codFormato == 2){
			charSeparatore = formato.substring(2,3);
		}else{
			charSeparatore = formato.substring(4,5);   
		}
	}

  if(codFormato == 0) {
     throw new Exception("FORMATO DATA ERRATO");
  }else{
   intGiorno = data.get(GregorianCalendar.DAY_OF_MONTH);
   intMese = data.get(GregorianCalendar.MONTH) +1 ;
   intAnno = data.get(GregorianCalendar.YEAR);
   strGiorno = Integer.toString(intGiorno);
   if(strGiorno.length() == 1){
    strGiorno = "0"+ strGiorno;
   }
   strMese = Integer.toString(intMese); 
   strMese=Misc.addZero(strMese);
   strAnno = Integer.toString(intAnno);    
   if(codFormato == 1){
    strData = strGiorno + charSeparatore + strMese + charSeparatore + strAnno;
   }else if(codFormato == 2){
    strData = strMese + charSeparatore + strGiorno + charSeparatore +  strAnno;   
   }else{
    strData = strAnno + charSeparatore + strMese + charSeparatore + strGiorno;   
   }
   if (formato.endsWith("ss"))
   {
     int intOra = 0;
     if ( formato.substring(11,15).equalsIgnoreCase("hh24") )
     {
       intOra = data.get(GregorianCalendar.HOUR_OF_DAY);
     }
     else
     {
       intOra = data.get(GregorianCalendar.HOUR);
     }
     int intMM = data.get(GregorianCalendar.MINUTE);
     int intSS = data.get(GregorianCalendar.SECOND);
     
     charSeparatore = formato.substring(15,16);
     strData = strData + " " + Misc.addZero(Integer.toString(intOra)) + charSeparatore + Misc.addZero(Integer.toString(intMM)) + charSeparatore + Misc.addZero(Integer.toString(intSS));
   }
   return strData;
 }
 }catch(Exception e){
  throw new Exception(e.toString());
 }
}
/**
 * Insert the method's description here.
 * Creation date: (12/11/2001 12.02.52)
 * @return java.lang.String
 * @param strStringa java.lang.String
 * @exception java.rmi.RemoteException The exception description.
 */
 
public static String getDate() throws Exception{
 String strOutput = "";
 try
 {
  GregorianCalendar objCalendario = new GregorianCalendar();

  int intGiorno = objCalendario.get(GregorianCalendar.DAY_OF_MONTH);
  int  intMese = objCalendario.get(GregorianCalendar.MONTH) +1 ;
  String strGiorno = Integer.toString(intGiorno);
  if(strGiorno.length() == 1){
    strGiorno = "0"+ strGiorno;
  }
  String strMese = Integer.toString(intMese); 
  if(strMese.length() == 1){
    strMese = "0"+ strMese;
  }
  strOutput = strGiorno + "/" + strMese + "/" + objCalendario.get(GregorianCalendar.YEAR);
  return strOutput;
 }
 catch(Exception e)
 {
  throw new Exception("ERRORE IN FASE DI NORMALIZZAZIONE DELLA DATA: " + e.toString());
  
 }
}
/**
 * Insert the method's description here.
 * Creation date: (30/11/2001 18.03.02)
 * @return java.lang.String
 * @param param java.lang.String
 * @exception java.lang.Exception The exception description.
 */
public static String getFromItalyFormat(String lobj_strNumber) throws Exception {
 Number inUscita = null;
    Locale myLocale = Locale.ITALIAN;
    NumberFormat nf = NumberFormat.getNumberInstance(myLocale);
 
    try{
 
     if(lobj_strNumber.equalsIgnoreCase("")){
      lobj_strNumber = "0";
     }
     inUscita = nf.parse(lobj_strNumber);
  return inUscita.toString();      
  
 }catch(Exception e){
  throw new Exception("VALORE NON CONVERTIBILE IN FORMATO NUMERICO: " + e.toString());
 }
}
/**
 * Restituisce, dato un calendario, il giorno della settimana in lettere.
 * Creation date: (30/01/2002 12.57.20)
 * @return java.lang.String
 */
public static String getGiornoInLettere(GregorianCalendar calendario) 
 throws Exception {
 try{
  int giornoInNumeri = calendario.get(GregorianCalendar.DAY_OF_WEEK);
  String ggInLettere = null;
  switch (giornoInNumeri)
  {
   case GregorianCalendar.MONDAY :  ggInLettere =  "Lunedi"; break;
   case GregorianCalendar.TUESDAY : ggInLettere =  "Martedi"; break;
   case GregorianCalendar.WEDNESDAY : ggInLettere = "Mercoledi"; break;
   case GregorianCalendar.THURSDAY :  ggInLettere =  "Giovedi"; break;
   case GregorianCalendar.FRIDAY :  ggInLettere =  "Venerdi"; break;
   case GregorianCalendar.SATURDAY:  ggInLettere =  "Sabato"; break;
   case GregorianCalendar.SUNDAY:  ggInLettere =  "Domenica"; break;    
  }
  return ggInLettere;
 }catch(Exception e){
  throw new Exception(e.toString());
 }
}
/**
 * Insert the method's description here.
 * Creation date: (12/11/2001 12.02.52)
 * @return java.lang.String
 * @param strStringa java.lang.String
 * @exception java.rmi.RemoteException The exception description.
 */
 //tronca la data togliendo ore minuti e secondi
public static String truncData(String p_strData)
{
    String l_strReturnString = "";
    if(p_strData == null || p_strData.equals(""))
    {
        l_strReturnString = "";
    }else{
        l_strReturnString = p_strData.substring(0,10);
    }
    return l_strReturnString;
}

public static String getHour() throws Exception{
 String strOutput = "";
 try
 {
  GregorianCalendar objCalendario = new GregorianCalendar();
  String strMinuti =  Integer.toString(objCalendario.get(GregorianCalendar.MINUTE));
  if(strMinuti.length() < 2){
   strMinuti = "0" + strMinuti;
  }
  strOutput = objCalendario.get(GregorianCalendar.HOUR_OF_DAY) + ":" + strMinuti;
  return strOutput;
 }
 catch(Exception e)
 {
  throw new Exception("ERRORE IN FASE DI NORMALIZZAZIONE DELLA DATA: " + e.toString());
  
 }
}
/**
 * Restituisce, dato un calendario, il mese in lettere
 * Creation date: (30/01/2002 12.57.20)
 * @return java.lang.String
 */
public static String getMeseInLettere(GregorianCalendar calendario)
    throws Exception
{
    // UMBP 14052003 - modifica x spesa complessiva
    // return (pri_getMeseInLettere(calendario.get(GregorianCalendar.MONTH)));
    return (pri_getMeseInLettere(calendario.get(GregorianCalendar.MONTH)+1));
}
public static String getMeseInLettere(int pint_Mese)
    throws Exception
{
    return (pri_getMeseInLettere(pint_Mese));
}

private static String pri_getMeseInLettere(int pint_Mese)
    throws Exception
{
    try
    {
        String mmInLettere = null;
        
        switch (pint_Mese-1)
        {
            case GregorianCalendar.JANUARY:
                mmInLettere = "Gennaio";
                break;
            case GregorianCalendar.FEBRUARY:
                mmInLettere = "Febbraio";
                break;
            case GregorianCalendar.MARCH:
                mmInLettere = "Marzo";
                break;
            case GregorianCalendar.APRIL:
                mmInLettere = "Aprile";
                break;
            case GregorianCalendar.MAY:
                mmInLettere = "Maggio";
                break;
            case GregorianCalendar.JUNE:
                mmInLettere = "Giugno";
                break;
            case GregorianCalendar.JULY:
                mmInLettere = "Luglio";
                break;
            case GregorianCalendar.AUGUST:
                mmInLettere = "Agosto";
                break;
            case GregorianCalendar.SEPTEMBER:
                mmInLettere = "Settembre";
                break;
            case GregorianCalendar.OCTOBER:
                mmInLettere = "Ottobre";
                break;
            case GregorianCalendar.NOVEMBER:
                mmInLettere = "Novembre";
                break;
            case GregorianCalendar.DECEMBER:
                mmInLettere = "Dicembre";
                break; 
        }

        return mmInLettere;
    }
    catch(Exception e)
    {
        throw new Exception(e.toString());
    }
}

}
