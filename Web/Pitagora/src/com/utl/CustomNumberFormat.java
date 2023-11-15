package com.utl;
import java.util.*;
import java.text.NumberFormat;
//import java.math.BigDecimal;

public class CustomNumberFormat
{
  private static final Locale GSTR_LOCALE = Locale.ITALIAN;
  private static final int GINT_NUMBER_OF_DECIMAL = 2;
  private static final int GINT_NUMBER_OF_DECIMAL_CURRENCY = 2;
  private static final boolean GBLN_GROUPING_USED = true;

/**
 * Effettua la conversione nel formato
 * numerico indicato del numero contenuto nella string
 * Creation date: (18/06/2002 12.00.00)
 * @return java.lang.String
 */
  public static String setToNumberFormat(String pstr_Input)throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, GINT_NUMBER_OF_DECIMAL, false, GBLN_GROUPING_USED);
  }

  public static String setToNumberFormat(String pstr_Input,boolean pbln_GroupingUse) throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, GINT_NUMBER_OF_DECIMAL, false, pbln_GroupingUse);
  }

/*AGGIUNTA PER LO SPECIAL*/
  public static String setToNumberFormat(String pstr_Input,int pint_NumberOfDecimal,boolean pbln_ZeroBlank,boolean pbln_GroupingUse) throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, pint_NumberOfDecimal, pbln_ZeroBlank, pbln_GroupingUse);
  }
/********************************/




 public static String setToNumberFormat(String pstr_Input, int pint_NumberOfDecimal) throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, pint_NumberOfDecimal, false, GBLN_GROUPING_USED);
  }

  public static String setToNumberFormat(String pstr_Input, int pint_NumberOfDecimal,boolean pbln_ZeroBlank)throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, pint_NumberOfDecimal, pbln_ZeroBlank, GBLN_GROUPING_USED);
  }

   //QS MS: Aggiunta per visualizzazione tariffe (Rel 4.6)
   public static String setToCurrencyFormat(String pstr_Input, int pint_MinNumberOfDecimal, int pint_MaxNumberOfDecimal)throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, pint_MinNumberOfDecimal, pint_MaxNumberOfDecimal, false, false);
  }

 public static String setToCurrencyFormat(String pstr_Input) throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, GINT_NUMBER_OF_DECIMAL_CURRENCY, false, GBLN_GROUPING_USED);
  }

 public static String setToCurrencyFormat(String pstr_Input, int pint_NumberOfDecimal) throws Exception
  {
    return pri_setToNumberFormat(pstr_Input, GSTR_LOCALE, pint_NumberOfDecimal, false, GBLN_GROUPING_USED);
  } 


  private static String pri_setToNumberFormat(String pstr_Input,Locale pobj_Locale, int pint_NumberOfDecimal, boolean pbln_ZeroBlank, boolean pbln_GroupingUse) throws Exception
  {
    String lstr_Output = "";
    NumberFormat lobj_NF = NumberFormat.getNumberInstance(pobj_Locale);

    if(pstr_Input.equalsIgnoreCase("") || pstr_Input.equalsIgnoreCase("0"))
    {
        if (pbln_ZeroBlank)
            lstr_Output = "";
        else
            lstr_Output = "0";
    }
    else
    {
        pstr_Input.replace('.',',');//sia il punto che la vorgola sono separatori decimali!
        lobj_NF.setMinimumFractionDigits(pint_NumberOfDecimal);
        lobj_NF.setMaximumFractionDigits(pint_NumberOfDecimal);
        lobj_NF.setGroupingUsed(pbln_GroupingUse);
        lstr_Output = lobj_NF.format(Double.parseDouble(pstr_Input));
    }

    return (lstr_Output);
  }

   private static String pri_setToNumberFormat(String pstr_Input,Locale pobj_Locale, int pint_MinNumberOfDecimal, int pint_MaxNumberOfDecimal, boolean pbln_ZeroBlank, boolean pbln_GroupingUse) throws Exception
  {
    String lstr_Output = "";
    NumberFormat lobj_NF = NumberFormat.getNumberInstance(pobj_Locale);

    if(pstr_Input.equalsIgnoreCase("") || pstr_Input.equalsIgnoreCase("0"))
    {
        if (pbln_ZeroBlank)
            lstr_Output = "";
        else
            lstr_Output = "0";
    }
    else
    {
        pstr_Input.replace('.',',');//sia il punto che la vorgola sono separatori decimali!
        lobj_NF.setMinimumFractionDigits(pint_MinNumberOfDecimal);
        lobj_NF.setMaximumFractionDigits(pint_MaxNumberOfDecimal);
        lobj_NF.setGroupingUsed(pbln_GroupingUse);
        lstr_Output = lobj_NF.format(Double.parseDouble(pstr_Input));
    }

    return (lstr_Output);
  }





/**
 * Effettua la conversione dal formato
 * numerico indicato, del numero contenuto nella string
 * Creation date: (18/06/2002 12.00.00)
 * @return java.lang.String
 */
  public static String getFromNumberFormat(String pstr_Input) throws Exception
  {
    return pri_getFromNumberFormat(pstr_Input, GSTR_LOCALE);
  }

  private static String pri_getFromNumberFormat(String pstr_Input, Locale pobj_Locale) throws Exception
  {
    try
    {
        Number lnum_Output = null;
        NumberFormat lobj_NF = NumberFormat.getNumberInstance(pobj_Locale);

        if(pstr_Input.equalsIgnoreCase(""))
          pstr_Input = "0";
        pstr_Input = pstr_Input.replace('.',',');
        lnum_Output = lobj_NF.parse(pstr_Input);

        return (lnum_Output.toString());
    }
    catch(Exception e)
    {
        throw new Exception("getFromNumberFormat: " + pstr_Input + "\nErrore: " + e.toString());
    }
  }

}