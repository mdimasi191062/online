package com.utl;

import java.util.*;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.lang.reflect.*;
import javax.servlet.http.HttpServletRequest;

public class Misc
{

	public static boolean gestStepXLancio(HttpServletRequest prequest, int lint_ActualStep)
    throws Exception
    {
		Integer lInt_SessionStep = null;
		lInt_SessionStep = (Integer)prequest.getSession().getAttribute("NUMBER_STEP_LANCIO_BATCH");
		if(lInt_SessionStep == null){
			lInt_SessionStep = new Integer(0);
		}
		if(lint_ActualStep==(lInt_SessionStep.intValue()+1)){
			prequest.getSession().setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(lint_ActualStep));
            return true;
        }else{
			//prequest.getSession().setAttribute("NUMBER_STEP_LANCIO_BATCH",new Integer(0));
			return false;
		}
    }

    //funzione che gestisce i null delle stringhe
    //restituisce "".
    //nh = null handler
    public static String nh(String lstr_Input)
    throws Exception
    {
        if(lstr_Input==null){
            return "";
        }else{
            return lstr_Input;
        }
    }

	public static String buildParameterToLog(Vector pvct_Input)
		throws Exception
	{
		return (pri_buildParameterToLog(pvct_Input,
											"|"));
	}
	public static String buildParameterToLog(Vector pvct_Input,
												String pstr_delimiter)
		throws Exception
	{
		return (pri_buildParameterToLog(pvct_Input,
											pstr_delimiter));
	}

	private static String pri_buildParameterToLog(Vector pvct_Input,
													String pstr_Delimiter)
		throws Exception
	{
		String lstr_Return = "";
		String lstr_MethodReturn = "";

		Class[] lvct_ParametriFieldsToString = new Class[0];
		Object[] lvct_ArgomentiFieldsToString = new Object[0];

		for (int i=0; i<pvct_Input.size(); i++)
		{
			Class lcls_Classe = pvct_Input.get(i).getClass();
			Object lcls_Object = pvct_Input.get(i);
			Method lcls_ToStringMethod = lcls_Classe.getMethod("FieldsToString", lvct_ParametriFieldsToString);

			lstr_MethodReturn = (String)lcls_ToStringMethod.invoke(lcls_Object,
															lvct_ArgomentiFieldsToString);
			lstr_Return += lstr_MethodReturn + pstr_Delimiter;
		}

		return (lstr_Return);
	}

    //funzione che gestisce i null delle stringhe
    //che contengono true o false (stringa) restituisce "".
    public static boolean bh(String lstr_Input)
    throws Exception
    {
        if(lstr_Input==null){
            return false;
        }else{
            if(lstr_Input.equalsIgnoreCase("true")){
                return true;
            }else{
                return false;
            }
        }
    }


public static String replace (String pstr_Input,
                                String pstr_Old,
                                String pstr_New)
    throws Exception
{
    String lstr_Return = "";

    if (!(pstr_Input == null
        || pstr_Input.equalsIgnoreCase("")))
    {
        Vector lvct_Elementi = split(pstr_Input, pstr_Old);
        for (int i=0; i<lvct_Elementi.size(); i++)
        {
            if(i==(lvct_Elementi.size()-1)){
                 lstr_Return += (String)lvct_Elementi.get(i);
            }else{
                 lstr_Return += (String)lvct_Elementi.get(i) + pstr_New;
            }
        }

/*        int lint_StartPosition = 0;
        int lint_EndPosition = pstr_Input.indexOf(pstr_Old);
        while (lint_EndPosition > 0)
        {
            lstr_Return += pstr_Input.substring(lint_StartPosition, lint_EndPosition);
            lstr_Return += pstr_New;
            lstr_Return += pstr_Input.substring(lint_EndPosition+pstr_Old.length());
        }*/
    }

    return (lstr_Return);
}


public static Vector split (String pstr_Input,
                            String pstr_Delimiter)
  throws Exception
{
  Vector lvct_Return = new Vector();
  if(pstr_Input.equals("")){
    //ritorno un vettore di size 0!
  }else{
    pstr_Input += pstr_Delimiter;
    int lintStartPosition = 0;
    int lintEndPosition = 0;
    //StringTokenizer lst_Principale = new StringTokenizer (pstr_Input, pstr_Delimiter);
    while ((lintEndPosition = pstr_Input.indexOf(pstr_Delimiter,lintStartPosition))!=-1)
    {
      String lstr_Appo = pstr_Input.substring(lintStartPosition,lintEndPosition);
      lvct_Return.addElement(lstr_Appo);
      lintStartPosition = lintEndPosition + pstr_Delimiter.length();
    }
  }

  return (lvct_Return);
}


public static String getParameterValue (String pstr_Input,
                                          String pstr_Parameter)
  throws Exception
{
  String lstr_Result = "missing";
  StringTokenizer lst_Principale = new StringTokenizer (pstr_Input, "|");
  while (lst_Principale.hasMoreTokens()
          && lstr_Result.equalsIgnoreCase("missing"))
  {
    StringTokenizer lst_Elemento = new StringTokenizer (lst_Principale.nextToken(), "=");
    if (lst_Elemento.nextToken().equalsIgnoreCase(pstr_Parameter))
    {
      if (lst_Elemento.hasMoreTokens())
        lstr_Result = lst_Elemento.nextToken();
      else
        lstr_Result = "";
    }
  }

  return lstr_Result;
}

public static String setParameterValue (String pstr_Input,
                                        String pstr_Parameter,
                                        String pstr_newValue)
  throws Exception
{
  String lstr_Output = "";
  String lstr_Name = "";
  String lstr_OldValue = "";
  boolean lbln_updated = false;

  StringTokenizer lst_Principale = new StringTokenizer (pstr_Input, "|");
  while (lst_Principale.hasMoreTokens())
  {
    StringTokenizer lst_Elemento = new StringTokenizer (lst_Principale.nextToken(), "=");
    if (lst_Elemento.hasMoreTokens())
    {
      lstr_Name = lst_Elemento.nextToken();
      lstr_Output = lstr_Output + lstr_Name + "=";

      if (lst_Elemento.hasMoreTokens()) lstr_OldValue = lst_Elemento.nextToken();
      else lstr_OldValue = "";

      if (lstr_Name.equalsIgnoreCase(pstr_Parameter))
      {
        lstr_Output = lstr_Output + pstr_newValue;
        lbln_updated = true;
      }
      else
      {
        lstr_Output = lstr_Output + lstr_OldValue;
      }
    }
    lstr_Output = lstr_Output + "|";
  }
  if ( lbln_updated == false )
  {
    lstr_Output = lstr_Output + pstr_Parameter + "=" + pstr_newValue + "|";
  }
  return lstr_Output;
}

public static Vector MatchVectors(Vector pvct_Source, Vector pvct_Check, String Operazione)
  throws Exception
  {
    Object lobj_SourceElement = null;
    Object lobj_CheckElement = null;
    Method lcls_SourceMetodo = null;
    Method lcls_CheckMetodo = null;
    String lstr_SourceValue = null;
    String lstr_CheckValue = null;
    Vector lvct_Destination = new Vector();
    boolean lbln_ElementFound = false;

    if ( pvct_Source.size() == 3 && pvct_Check.size() == 3)
    {
      try
      {
        if ( Operazione.equalsIgnoreCase("MERGE") )
        {
          lvct_Destination = pvct_Check;
        }

        Vector lvct_SourceData = (Vector)pvct_Source.get(0);
        Class  lcls_SourceData = (Class)pvct_Source.get(1);
        if ( ! lcls_SourceData.getName().endsWith("String") )
        {
          String lstr_SourceData = (String)pvct_Source.get(2);
          String lstr_SourceMetodo = "get" + lstr_SourceData.toUpperCase();
          lcls_SourceMetodo = lcls_SourceData.getMethod(lstr_SourceMetodo, null);
        }

        Vector lvct_CheckData = (Vector)pvct_Check.get(0);
        Class  lcls_CheckData = (Class)pvct_Check.get(1);
        if ( ! lcls_CheckData.getName().endsWith("String") )
        {
          String lstr_CheckData = (String)pvct_Check.get(2);
          String lstr_CheckMetodo = "get" + lstr_CheckData.toUpperCase();
          lcls_CheckMetodo = lcls_CheckData.getMethod(lstr_CheckMetodo, null);
        }

        for ( int ind_src = 0; ind_src < lvct_SourceData.size(); ind_src ++)
        {
          lobj_SourceElement = lvct_SourceData.get(ind_src);
          if ( lcls_SourceData.getName().endsWith("String") )
          {
            lstr_SourceValue = (String)lobj_SourceElement;
          }
          else
          {
            lstr_SourceValue = (String)lcls_SourceMetodo.invoke(lobj_SourceElement, null);
          }
          lbln_ElementFound = false;
          for ( int ind_chk = 0; (ind_chk < lvct_CheckData.size()) && (lbln_ElementFound==false); ind_chk ++)
          {
            lobj_CheckElement = lvct_CheckData.get(ind_chk);
            if ( lcls_SourceData.getName().endsWith("String") )
            {
              lstr_CheckValue = (String)lobj_CheckElement;
            }
            else
            {
              lstr_CheckValue = (String)lcls_CheckMetodo.invoke(lobj_CheckElement, null);
            }

            if ( lstr_SourceValue.equalsIgnoreCase(lstr_CheckValue) )
            {
              lbln_ElementFound = true;
            }

          }

          if ( Operazione.equalsIgnoreCase("DIFF") || Operazione.equalsIgnoreCase("MERGE") )
          {
             if ( ! lbln_ElementFound  )
            {
              lvct_Destination.add(lobj_SourceElement);
            }
          }
          else
          {
            // Caso di Operazione = "MATCH"
             if ( lbln_ElementFound  )
            {
              lvct_Destination.add(lobj_SourceElement);
            }
          }

        }
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception ("Misc.MatchVectors --> " + lexc_Exception.toString());
      }
    }
  return lvct_Destination;
  }


    //funzione aggiunge uno zero alla stringa lunga 1
    public static String addZero(String lstr_Input)
    throws Exception
    {
        if(lstr_Input.length()==1){
            lstr_Input = "0" + lstr_Input;
        }
        return lstr_Input;
    }

}