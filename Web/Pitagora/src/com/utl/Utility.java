package com.utl;

import java.util.Date;
import java.text.SimpleDateFormat;

public class Utility
{
static final SimpleDateFormat lastYearDateFmt       = new SimpleDateFormat ("dd'/'MM'/'yyyy");
static final SimpleDateFormat firstMonthDateFmt     = new SimpleDateFormat ("MM'/'dd'/'yyyy");
public static String TRATTINO="-";
public static String SPAZIO="&nbsp;";

public static String getTrattini(int num)
  {
  String s="";
  for (int i=0;i<num;i++)
      s=s+TRATTINO;
  return s;
  }

public static String getSpazi(int num)
  {
  String s="";
  for (int i=0;i<num;i++)
      s=s+SPAZIO;
  return s;
  }
  
public static String getTO_DATE(String date)
  {
  String s="";
  s="TO_DATE('"+date+"','DD/MM/YYYY')";
  return s;
  }

public static String getDateDDMMYYYY()
  {
        String dateString;
        try {
            dateString = lastYearDateFmt.format(new Date());
        }
        catch (Exception x) {
//            PACIPdL.error(StndMsgTypeCdConst.WARNING,x,
//                "Errore di parse su una data - metodo getClientDate - classe PACIUtil");
            return(null);
        }
        return(dateString);
  }

public static String getDateMMDDYYYY()
  {
        String dateString;
        try {
            dateString = firstMonthDateFmt.format(new Date());
        }
        catch (Exception x) {
//            PACIPdL.error(StndMsgTypeCdConst.WARNING,x,
//                "Errore di parse su una data - metodo getClientDate - classe PACIUtil");
            return(null);
        }
        return(dateString);
  }


public static String getDateDDMMYYYY(String data)
  {
        String dateString;
        //
        java.text.DateFormat df = java.text.DateFormat.getDateInstance();
        //
        
        try {
            //dateString = lastYearDateFmt.format(new Date(data));
            dateString = lastYearDateFmt.format(df.parse(data));
        }
        catch (Exception x) {
            return(null);
        }
        return(dateString);
  }

public static String getDateMMDDYYYY(String data)
  {
        //
        java.text.DateFormat df = java.text.DateFormat.getDateInstance();
        //
        String dateString;
        try {
       //System.out.println(">>>>>>>>>>>>>>>>>>>>>"+data);
        dateString = firstMonthDateFmt.format(df.parse(data));
        //dateString = firstMonthDateFmt.format(new Date(data));
        }
        catch (Exception x) {
            return(null);
        }
        return(dateString);
  }
  //MB 13/09/2004 codifica una stringa per l'inserimento in un nodo xml
  public static String encodeXML(String value){
    for(int i=0;i<value.length();i++){

      switch (value.charAt(i)){
        case ('>') :
          value = value.substring(0,i) + "&gt;" + value.substring(i + 1);
        break;
        case ('<') :
          value = value.substring(0,i) + "&lt;" + value.substring(i + 1);        
        break;
        case ('\'') :
          value = value.substring(0,i) + "\\'" + value.substring(i + 1);
          i++;
        break;
        case ('&') :
          value = value.substring(0,i) + "&amp;" + value.substring(i + 1);        
        break;        
      }
    }
    return value;
  }

}

