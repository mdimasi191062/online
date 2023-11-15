package com.utl;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.lang.reflect.*;
import java.io.Serializable;
import java.net.*;

public abstract class AbstractDataBean implements Serializable
{

/*******************************************************
 * Restituisce una stringa formata dai nomi dei campi
 * della classe con il loro rispettivo valore.
 * I campi sono separati all'interno della stringa con
 * il separatore passato o altrimenti con ';'.
 * I campi con valore null o stringa vuota non vengono
 * presi in considerazione.
 * Creation date: (29/08/2002 9:00:00 AM)
 * @return String
 *******************************************************/
public String FieldsToString ()
	throws Exception
{
	return (pri_FieldsToString(';'));
}
public String FieldsToString (char pchr_Delimiter)
	throws Exception
{
	return (pri_FieldsToString(pchr_Delimiter));
}

private String pri_FieldsToString (char pchr_Delimiter)
	throws Exception
{
	Method lcls_Method = null;
	String lstr_Value = "";
	String lstr_Nome = "";
	String lstr_Return = "";
	Object[] larr_Argoments = new Object[0];

	try
	{
		Class lcls_Class = this.getClass();
		Method[] larr_Methods = lcls_Class.getDeclaredMethods();
		for (int i=0; i < Array.getLength(larr_Methods); i++)
		{
			lcls_Method = larr_Methods[i];
			if (lcls_Method.getName().startsWith("get"))
			{
				lstr_Value = (String)lcls_Method.invoke(this, larr_Argoments);
				if ((lstr_Value != null)
					&& (!lstr_Value.equalsIgnoreCase("")))
				{
					lstr_Nome = lcls_Method.getName().substring(3);
					lstr_Return += lstr_Nome + "=" + lstr_Value + pchr_Delimiter;
				}
			}
		}
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
	}

	return (lstr_Return);
}


/**
 * A partire dal resultset passato come parametro,
 * valorizza le proprietà dell'oggetto
 * Creation date: (3/26/01 6:33:20 PM)
 * @return boolean
 */
public void valorizzaCampi (ResultSet prs_ResultSet)
  throws Exception
  {
    try
    {
      if ((prs_ResultSet != null)
            && (!prs_ResultSet.isAfterLast())
            && (!prs_ResultSet.isBeforeFirst()))
      {
        Class lcls_ClassObj = this.getClass();

        // Acquisiamo la struttura del resultset.
        ResultSetMetaData lcls_RSMetaData = prs_ResultSet.getMetaData();
        int lint_NumColonne = lcls_RSMetaData.getColumnCount();

        // Ciclo di valorizzazione degli attributi.
        Class[] lvct_Parametri = new Class[1];
        lvct_Parametri[0] = String.class;
        Object[] lvct_Argomenti = new Object[1];
        for (int i=1; i <= lint_NumColonne; i++)
        {
          String lstr_NomeColonna = lcls_RSMetaData.getColumnLabel(i);
          String lstr_NomeMetodo = "set" + lstr_NomeColonna.toUpperCase();

          try {
            
            Method lcls_Metodo = lcls_ClassObj.getMethod(lstr_NomeMetodo, lvct_Parametri);

            String lstr_Valore = prs_ResultSet.getString(i);
            if (lstr_Valore != null) {

                // lp 08092004 i caratteri ",',<,> vengono sostituiti come segue :
                //                                 " e ' con spazio
                //                                 < con la dicitura "fino a ..."
                //                                 > con la dicitura "da.."
                //                                 < e > con la dicitura "da.. a..."

                lstr_Valore = StaticContext.replaceString(lstr_Valore,"\""," ");
                lstr_Valore = StaticContext.replaceString(lstr_Valore,"'"," ");

                if (lstr_Valore.indexOf(">") > 0) {

                    lstr_Valore = StaticContext.replaceString(lstr_Valore,">"," da ");
                    // si verifica la presenza di "- <" oppure "E <" per sostituire con " da .... a ...."
                    if (lstr_Valore.indexOf("- <") > 0 || lstr_Valore.indexOf(" E <") > 0 || lstr_Valore.indexOf(" e <") > 0) {
                        lstr_Valore = StaticContext.replaceString(lstr_Valore,"- <"," a ");
                        lstr_Valore = StaticContext.replaceString(lstr_Valore,"E <"," a ");
                        lstr_Valore = StaticContext.replaceString(lstr_Valore,"e <"," a ");
                    }
                }

                if (lstr_Valore.indexOf("<") > 0) {
                    lstr_Valore = StaticContext.replaceString(lstr_Valore,"<"," fino a ");
                }
                lvct_Argomenti[0] = lstr_Valore;
                lcls_Metodo.invoke(this, lvct_Argomenti);
            }
          }
          catch (NoSuchMethodException lexc_Eccezione)
          {
            // Questa eccezione non va propagata in quanto può tranquillamente accadere
            // che nel resultSet sia presente un campo che non esiste nella classe
            // di DataBean.
          }
        }
      }
    }
    catch (Exception lexc_Eccezione)
    {
      throw new Exception (this.getClass().getName() + ".valorizzaCampi --> " + lexc_Eccezione.toString());
    }
  }

}