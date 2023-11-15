package com.utl;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.lang.reflect.Method;
import java.sql.*;
import javax.sql.DataSource;
import javax.naming.*;
import java.util.Vector;
import com.utl.AbstractEJBTypes;



public abstract class AbstractEJB extends AbstractSessionCommonBean
{

/**
 * Acquisisce la connessione al database
 * Creation date: (26/05/2002 23:37:00)
 * @return java.sql.Connection
 **
protected Connection getConnection()
  throws Exception
  {
    try
    {
      return (private_getConnection("jdbc/PitagoraDS"));
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".getConnection --> " + lexc_Exception.toString());
    }
  }
protected Connection getConnection(String pstr_DataSource)
  throws Exception
  {
    try
    {
      return (private_getConnection(pstr_DataSource));
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".getConnection --> " + lexc_Exception.toString());
    }
  }
private Connection private_getConnection(String pstr_DataSource)
  throws Exception
  {
    InitialContext lcls_Contesto = new InitialContext();
    DataSource lcls_DataSource = (DataSource)lcls_Contesto.lookup(pstr_DataSource);
    return (lcls_DataSource.getConnection());
  }
*/

/**
 * Dato un ResultSet, e un oggetto di tipo classe
 * rappresentante una classe di data beans, restituisce
 * un vettore di data beans, in cui ogni data bean corrisponde
 * ad un record del resultset
 * Creation date: (29/10/2001)
 **/
protected final Object getDataBeansList(ResultSet prs_Dati,
                                          Class pcls_RecordType,
                                          Class pcls_ReturnClass)
  throws Exception
  {
    try
    {
      Object lcls_ReturnValue = null;

      // Si verifica il tipo della classe di ritorno. In base al tipo si istanzia
      // la classe corrispondente.
      if (pcls_ReturnClass.equals(Vector.class))
        lcls_ReturnValue = new Vector(); // Vector


      // Acquisisco il metodo "valorizzaCampi" della classe "pcls_RecordType".
      // Inizializzo il vettore di oggetti da passare come argomento alla "valorizzaCampi"
      // con il resultSet ricevuto in input.
      Method lcls_MethodToCall = null;
      Class[] lvct_ParametriValorizzaCampi = new Class[1];
      lvct_ParametriValorizzaCampi[0] = ResultSet.class;
      Method lcls_ValorizzaCampiMethod = pcls_RecordType.getMethod("valorizzaCampi", lvct_ParametriValorizzaCampi);
      Object[] lvct_ArgomentiValorizzaCampi = new Object[1];
      lvct_ArgomentiValorizzaCampi[0] = prs_Dati;

      while (prs_Dati.next())
      {
        // Chiamo la "valorizzaCampi" per valorizzare la classe "pcls_RecordType"
        // con i valori presenti nell'attuale record del resultSet "prs_Dati"
        Object lobj_Record = pcls_RecordType.newInstance();
        lcls_ValorizzaCampiMethod.invoke(lobj_Record, lvct_ArgomentiValorizzaCampi);

        // Aggiungo l'oggetto appena valorizzato nella classe di ritorno.
        if (pcls_ReturnClass.equals(Vector.class))
          ((Vector)lcls_ReturnValue).addElement(lobj_Record); // Vector
      }

      return lcls_ReturnValue;
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".getDataBeansList --> " + lexc_Exception.toString());
    }
  }



/**
 * Creation date: (01/06/2002)
 **/
protected final Vector callSP (String[][] parr_Input)
  throws Exception
  {
    try
    {
      return (private_callSP(parr_Input, null));
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".callSP --> " + lexc_Exception.toString());
    }
  }
protected final Vector callSP (String[][] parr_Input,
                                Class pcls_OutputDataBean)
  throws Exception
  {
    try
    {
      return (private_callSP(parr_Input, pcls_OutputDataBean));
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".callSP --> " + lexc_Exception.toString());
    }
  }
private Vector private_callSP (String[][] parr_Input,
                                Class pcls_OutputClass)
  throws Exception
  {
    Connection lcls_Connection = null;
    CallableStatement lcls_Call = null;

    try
    {
      Vector lvct_Result = null;

      // Controllo che il vettore passato come parametro non sia vuoto.
      if (parr_Input.length > 0)
      {
        Vector lvct_OutputParameters = new Vector();
        lcls_Connection = getConnection(dsName);

        // Dichiaro e preparo la classe CallableStatement.
        lcls_Call = lcls_Connection.prepareCall(getCallableStatementString (parr_Input));

        // Setto i parametri della chiamata alla stored procedure.
        setSPParameters(lcls_Call,
                          parr_Input,
                          lvct_OutputParameters);

        // Eseguo la stored procedure.
        lcls_Call.execute();

        // Valorizzo il vettore da ritornare al chiamante.
        lvct_Result = getSPParameters(lcls_Call,
                                        lvct_OutputParameters,
                                        pcls_OutputClass);

        // Chiudo gli oggetti aperti.
        lcls_Call.close();
        lcls_Connection.close();
      }

      return (lvct_Result);
    }
    catch (Exception lexc_Eccezione)
    {
      if (lcls_Call != null)
        lcls_Call.close();

      if (lcls_Connection != null)
        if (!lcls_Connection.isClosed())
          lcls_Connection.close();

      throw new Exception (lexc_Eccezione.toString());
    }
  }


/**
 * Creation date: (29/05/2002)
 **/
private String getCallableStatementString (String[][] parr_Input)
  throws Exception
  {
    try
    {
      String lstr_Result = "";
      boolean lbln_Primo = true;
      boolean lbln_ReturnParam = false;

      // Il primo vettore contenuto in pstr_Input contiene il nome della stored procedure.
      String lstr_StoredProcedureName = parr_Input[0][0];

      for (int i=1; i<parr_Input.length; i++)
      {
        String lstr_Direzione = parr_Input[i][0];

        switch (Integer.parseInt(lstr_Direzione))
        {
          case AbstractEJBTypes.PARAMETER_RETURN_NUMBER:
            lbln_ReturnParam = true;
            lstr_Result = "{? = call " + lstr_StoredProcedureName;
            break;
          case AbstractEJBTypes.PARAMETER_OUTPUT_NUMBER:
            lstr_Result += ",?";
            break;
          case AbstractEJBTypes.PARAMETER_INPUT_NUMBER:
            if (! lbln_ReturnParam )
            {
                lbln_ReturnParam = true;
                lstr_Result = "{call " + lstr_StoredProcedureName;
            }
            if (lbln_Primo)
            {
              lbln_Primo = false;
              lstr_Result += " (?";
            }
            else
              lstr_Result += ",?";
            break;
        }
      }

      if (!lbln_Primo)
        lstr_Result += ")";

      lstr_Result += "}";

      return (lstr_Result);
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".getCallableStatementString --> " + lexc_Exception.toString());
    }
  }


/**
 * Data una matrice che contiene la lista dei parametri da
 * passare alla stored procedure 
 * viene, per ognumo di questi, interpretato il parametro
 * e chiamato il metodo "setSPParameter"
 * Viene valorizzato, inoltre, il vettore dei parametri
 * di output.
 * Creation date: (29/05/2002)
 **/
private void setSPParameters (CallableStatement pcls_Call,
                                String[][] parr_Input,
                                Vector pvct_OutputParameters)
  throws Exception
  {
    try
    {
      // Con questo ciclo si elaborano tutti i vettori che rappresentano i singoli parametri
      // della stored procedure.
      
      for (int i=1; i<parr_Input.length; i++)
      {
        String lstr_Direzione = "";
        String lstr_Tipo = "";
        String lstr_Valore = "";

      // Con questo ciclo si acquisiscono tutte le informazioni relative ad un singolo parametro
      // della stored procedure.
        for (int j=0; j<parr_Input[i].length; j++)
        {
          switch (j)
          {
            case 0:
              lstr_Direzione = parr_Input[i][0];
              break;
            case 1:
              lstr_Tipo = parr_Input[i][1];
              break;
            case 2:
              lstr_Valore = parr_Input[i][2];
              break;
          }
        }

        setSPParameter(pcls_Call,
                        pvct_OutputParameters,
                        i,
                        lstr_Direzione,
                        lstr_Tipo,
                        lstr_Valore);
      // UMBP DEBUG
      //System.out.println("setSPParameters2: lstr_Valore"+lstr_Valore);
            
      }
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".setSPParameters --> " + lexc_Exception.toString());
    }
  }


/**
 * Dato l'indice, la direzione, il tipo e il valore di
 * un parametro viene chiamato il rispettivo metodo
 * nella classe CallableStatement che setta i parametri
 * di una stored procedure.
 * Creation date: (29/05/2002)
 **/
private void setSPParameter (CallableStatement pcls_Call,
                              Vector pvct_OutputParameters,
                              int pint_Indice,
                              String pstr_Direzione,
                              String pstr_Tipo,
                              String pstr_Valore)
  throws Exception
  {
    try
    {
      switch (Integer.parseInt(pstr_Direzione))
      {
        case AbstractEJBTypes.PARAMETER_RETURN_NUMBER:
        case AbstractEJBTypes.PARAMETER_OUTPUT_NUMBER:
          // Registro il parametro di output nel vettore dei parametri di output
          String[] larr_OutputParameter = {Integer.toString(pint_Indice), pstr_Tipo};
          pvct_OutputParameters.addElement(larr_OutputParameter);

          // Se è stato richiesto un Vector come tipologia di ritorno dalla stored procedure
          // lo trasformo in un ResultSet(Tipo di dato conosciuto dalla stored procedure).
          // La getSPParameters si occuperà della trasformazione.
          int lint_Tipo;
          if (pstr_Tipo.equalsIgnoreCase(AbstractEJBTypes.TYPE_STRUCT)){
            //lint_Tipo = AbstractEJBTypes.TYPE_STRUCT;
            pcls_Call.registerOutParameter(pint_Indice, AbstractEJBTypes.TYPE_STRUCT_NUMBER, "EXTERNAL_LIBRARY_OBJ");
          }else{
            if (pstr_Tipo.equalsIgnoreCase(AbstractEJBTypes.TYPE_VECTOR)){
              lint_Tipo = AbstractEJBTypes.TYPE_RESULTSET_NUMBER;
            }else{
              lint_Tipo = Integer.parseInt(pstr_Tipo);
            }
            pcls_Call.registerOutParameter(pint_Indice, lint_Tipo);
          }


          break;
        case AbstractEJBTypes.PARAMETER_INPUT_NUMBER:
           
           if((pstr_Valore == null)||(pstr_Valore.equalsIgnoreCase(""))){
              pcls_Call.setNull(pint_Indice, Integer.parseInt(pstr_Tipo));
            }else
            {
              switch (Integer.parseInt(pstr_Tipo))
              {
                case AbstractEJBTypes.TYPE_INTEGER_NUMBER:
                  pcls_Call.setInt(pint_Indice, Integer.parseInt(pstr_Valore));
                  break;
                case AbstractEJBTypes.TYPE_DOUBLE_NUMBER:
                  pcls_Call.setDouble(pint_Indice, Double.parseDouble(pstr_Valore));
                  break;
                case AbstractEJBTypes.TYPE_STRING_NUMBER:
                  pcls_Call.setString(pint_Indice, pstr_Valore);
                  break;
                // UMBP 25032003 Aggiunta gestione LONGVARCHAR
                case AbstractEJBTypes.TYPE_LONGVARCHAR_NUMBER:
                  pcls_Call.setString(pint_Indice, pstr_Valore);
                  break;
               // ------------------------------------------                
              }
            }
          break;
      }
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".setSPParameter --> " + lexc_Exception.toString());
    }
  }


/**
 * Dato un vettore che contiene la lista dei parametri di
 * output da restituire "pvct_OutputParameters"
 * restituisce un vettore contenente i valori risultanti
 * dalla chiamata alla stored procedure.
 * Creation date: (29/05/2002)
 **/
private Vector getSPParameters (CallableStatement pcls_Call,
                                  Vector pvct_OutputParameters,
                                  Class pcls_OutputClass)
  throws Exception
  {
    try
    {
      Vector lvct_Result = new Vector ();

      // Per ogni elemento presente nel vettore "pvct_OutputParameters" leggo il corrispondente
      // risultato dalla stored procedure "pcls_Call" e lo memorizzo nel vettore di ritorno.
      for (int i=0; i<pvct_OutputParameters.size(); i++)
      {
        String[] larr_OutputParameter = (String[])pvct_OutputParameters.get(i);

        switch (Integer.parseInt(larr_OutputParameter[1]))
        {
          case AbstractEJBTypes.TYPE_VECTOR_NUMBER:
            ResultSet lrs_Rset = (ResultSet)pcls_Call.getObject(Integer.parseInt(larr_OutputParameter[0]));
            lvct_Result.addElement(this.getDataBeansList(lrs_Rset, pcls_OutputClass, Vector.class));
            lrs_Rset.close();
            break;
          case AbstractEJBTypes.TYPE_RESULTSET_NUMBER:
            lvct_Result.addElement(pcls_Call.getObject(Integer.parseInt(larr_OutputParameter[0])));
            break;
          case AbstractEJBTypes.TYPE_INTEGER_NUMBER:
            lvct_Result.addElement(new Integer(pcls_Call.getInt(Integer.parseInt(larr_OutputParameter[0]))));
            break;
          case AbstractEJBTypes.TYPE_DOUBLE_NUMBER:
            lvct_Result.addElement(new Double(pcls_Call.getDouble(Integer.parseInt(larr_OutputParameter[0]))));
            break;
          case AbstractEJBTypes.TYPE_STRING_NUMBER:
            lvct_Result.addElement(pcls_Call.getString(Integer.parseInt(larr_OutputParameter[0])));
            break;
          // UMBP 25032003 Aggiunta Gestione LONGVARCHAR
          case AbstractEJBTypes.TYPE_LONGVARCHAR_NUMBER:
            lvct_Result.addElement(pcls_Call.getString(Integer.parseInt(larr_OutputParameter[0])));
            break;
          case AbstractEJBTypes.TYPE_STRUCT_NUMBER:
            lvct_Result.addElement(pcls_Call.getString(Integer.parseInt(larr_OutputParameter[0])));
            break;
          // --------------------------------------------
        }
      }

      return (lvct_Result);
    }
    catch (Exception lexc_Exception)
    {
      throw new Exception (this.getClass().getName() + ".getSPParameters --> " + lexc_Exception.toString());
    }
  }

}