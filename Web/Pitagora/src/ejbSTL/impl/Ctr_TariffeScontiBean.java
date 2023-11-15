package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.*;
import javax.rmi.PortableRemoteObject;
import java.util.Vector;
import java.util.*;
import java.text.*;
import java.rmi.RemoteException;
import com.utl.*;
import com.ejbSTL.*;

public class Ctr_TariffeScontiBean extends AbstractClassicEJB implements SessionBean 
{
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }

/*
 * Esegue la insert, dopo alcuni controlli, nella tabella I5_2TARIFFE_SCONTI
 */
  public String insert
      (Vector pvct_tariffe
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid)
      throws CustomException, RemoteException
  {
    String lstr_risultato = null;

    try
    {
      /*
       * Verifica correttezza dei parametri ricevuti in ingresso.
       */
      if ((pvct_tariffe != null && pvct_tariffe.size() > 0)
          && (pstr_codeSconto != null && pstr_codeSconto.length() > 0)
          && (pstr_dataInizioValid != null && pstr_dataInizioValid.length() > 0)
          )
      {
        /*
         * Si verifica l'esistenza di elaborazioni batch in corso.
         */
        // Acquisisco il contesto del componente
        Context lcls_Contesto = new InitialContext();

        // Se non risultano elaborazioni Batch in corso....
        lstr_risultato = this.isRunningBatch(lcls_Contesto, StaticContext.INSERT);
        if (lstr_risultato == null)
        {
          // Istanzio una classe Ent_TariffeSconti
          Object homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
          Ent_TariffeScontiHome lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
          Ent_TariffeSconti lent_TariffeSconti = lent_TariffeScontiHome.create();


          /* 
           * Per ognuna delle occorrenze presenti nella lista tariffe si verifica che non esista
           * una occorrenza della tabella I5_2TARIFFE_SCONTI ricavata a partire da:
           *    I5_2TARIFFA.CODE_TARIFFA dell'occorrenza della lista tariffe;
           *    I5_2SCONTO.CODE_SCONTO selezionata;
           *    I5_2TARIFFE_SCONTI.DATA_FINE_VALID = NULL;
           * Se esiste una occorrenza viene visualizzato il messaggio "E' già definita una
           * associazione con data fine validità non valorizzata, tra lo sconto selezionato
           * ed una delle tariffe scelte".
           * L'azione viene interrotta.
           */

          /*
           * Per ognuna delle occorrenze presenti nella lista tariffe si verifica che non esista
           * una occorrenza della tabella I5_2TARIFFE_SCONTI ricavata a partire da:
           *    I5_2TARIFFA.CODE_TARIFFA dell'occorrenza della lista tariffe;
           *    I5_2SCONTO.CODE_SCONTO selezionata;
           *    I5_2TARIFFE_SCONTI.DATA_FINE_VALID valorizzata è maggiore o uguale alla data
           *        inizio validità inserita dall'utente;
           * Se esiste un'occorrenza viene visualizzato il messaggio "E' già definita un'associazione
           * tra lo sconto selezionato ed una delle tariffe scelte, avente data fine validità maggiore
           * della data inizio validità inserita".
           * L'azione viene interrotta.
           */

          DateFormat lobj_dateFormat = new SimpleDateFormat("dd/MM/yyyy");
          Date ldat_newDataInizioValid = (Date)lobj_dateFormat.parse(pstr_dataInizioValid);

          for (int i=0; i<pvct_tariffe.size() && lstr_risultato==null; i++)
          {
            Vector lvct_parametri = Misc.split((String)pvct_tariffe.get(i), "|");
            String lstr_codeTariffa = (String)lvct_parametri.get(0);
            String lstr_codePrTariffa = (String)lvct_parametri.get(1);

            Vector lvct_tariffeSconti = lent_TariffeSconti.getTariffeSconti
                        (StaticContext.LIST
                        ,StaticContext.FN_ASS_TAR_SCO
                        ,lstr_codeTariffa
                        ,pstr_codeSconto);
            for (int j=0; j<lvct_tariffeSconti.size(); j++)
            {
              DB_TariffeSconti lobj_tariffaSconto = (DB_TariffeSconti)lvct_tariffeSconti.get(j);

              if (lobj_tariffaSconto.getDATA_FINE_VALID().equalsIgnoreCase(""))
              {
                lstr_risultato = "E' già definita una associazione con data fine validità non valorizzata, tra lo sconto selezionato ed una delle tariffe scelte";
              }
              else
              {
                Date ldat_dataFineValid = (Date)lobj_dateFormat.parse(lobj_tariffaSconto.getDATA_FINE_VALID());
                if (ldat_dataFineValid.compareTo(ldat_newDataInizioValid) >= 0)
                {
                  lstr_risultato = "E' già definita un'associazione tra lo sconto selezionato ed una delle tariffe scelte, avente data fine validità maggiore della data inizio validità inserita";
                }
              }
            }
          }


          /*
           * QUESTO CONTROLLO E' FATTO SULLA PAGINA JSP
           * Per ognuna delle occorrenze presenti nella lista tariffe:
           * Si ricavano le occorrenze della I5_2TARIFFA associate a I5_2TARIFFA.CODE_TARIFFA
           * dell'occorrenza della lista tariffe;
           * Si determina la I5_2TARIFFA.DATA_INIZIO_TARIFFA più piccola.
           * Se la data inizio tariffa più piccola determinata nel modo suddetto, risulta
           * strettamente maggiore del valore del campo "Data inizio validità" inserito dall'utente,
           * viene visualizzato il messaggio "La data inizio validità deve essere compresa nel
           * periodo di validità delle tariffe selezionate".
           * L'azione viene interrotta.
           * QUESTO CONTROLLO E' FATTO SULLA PAGINA JSP
           */


          if (lstr_risultato == null)
          {
            /*
             * Si procede con l'inserimento nella tabella I5_2TARIFFE_SCONTI.
             * Per ogni valore distinto di I5_2TARIFFA.CODE_TARIFFA presente nella lista tariffe:
             *    CODE_TARIFFA: pari al valore di I5_2TARIFFA.CODE_TARIFFA;
             *    CODE_PR_TARIFFA: valore di I5_2TARIFFA.CODE_PR_TARIFFA più piccolo presente in I5_2TARIFFA,
             *                      a parità di I5_2TARIFFA.CODE_TARIFFA.
             *    CODE_SCONTO: pari al valore relativo all'oggetto "Sconto";
             *    DATA_INIZIO_VALID:  pari al valore dell'oggetto "Data inizio validità";
             *    DATA_CREAZ: data di sistema (comprensiva di ore, minuti e secondi);
             *    DATA_DUAS: pari a NULL;
             *    DATA_FINE_VALID: pari a NULL.
             * In caso di risposta negativa l'azione viene interrotta.
             */
            for (int i=0; i<pvct_tariffe.size() && lstr_risultato==null; i++)
            {
              Vector lvct_parametri = Misc.split((String)pvct_tariffe.get(i), "|");
              String lstr_codeTariffa = (String)lvct_parametri.get(0);
              String lstr_codePrTariffa = (String)lvct_parametri.get(1);

              lent_TariffeSconti.insert
                  (lstr_codeTariffa
                  ,lstr_codePrTariffa
                  ,pstr_codeSconto
                  ,pstr_dataInizioValid);
            }

            lstr_risultato = "Elaborazione terminata correttamente";
          }
        } // Fine se non risultano elaborazioni Batch in corso....
        else
        {
          lstr_risultato = "Non è possibile inserire l'associazione selezionata a causa di elaborazioni batch in corso.";
        }
      }
      else // Verifica correttezza dei parametri ricevuti in ingresso.
      {
        lstr_risultato = "Parametri ricevuti in ingresso non corretti";
      }
    }
    catch (Exception lexc_Eccezione)
    {
      throw new CustomException(lexc_Eccezione.toString(),
                                  "",
                                  "insert",
                                  this.getClass().getName(),
                                  StaticContext.FindExceptionType(lexc_Eccezione));
    }

    return (lstr_risultato);
  }



/*
 * Esegue la disattivazione, dopo alcuni controlli, nella tabella I5_2TARIFFE_SCONTI
 */
  public String disattiva
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid
      ,String pstr_dataFineValid)
      throws CustomException, RemoteException
  {
    String lstr_risultato = null;

    try
    {
      /*
       * Verifica correttezza dei parametri ricevuti in ingresso.
       */
      if ((pstr_codeTariffa != null && pstr_codeTariffa.length() > 0)
          && (pstr_codePrTariffa != null && pstr_codePrTariffa.length() > 0)
          && (pstr_codeSconto != null && pstr_codeSconto.length() > 0)
          && (pstr_dataInizioValid != null && pstr_dataInizioValid.length() > 0)
          && (pstr_dataFineValid != null && pstr_dataFineValid.length() > 0)
          )
      {
        /*
         * Si verifica l'esistenza di elaborazioni batch in corso.
         */
        // Acquisisco il contesto del componente
        Context lcls_Contesto = new InitialContext();

        // Se non risultano elaborazioni Batch in corso....
        lstr_risultato = this.isRunningBatch(lcls_Contesto, StaticContext.UPDATE);
        if (lstr_risultato == null)
        {
          // Istanzio una classe Ent_TariffeSconti
          Object homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
          Ent_TariffeScontiHome lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
          Ent_TariffeSconti lent_TariffeSconti = lent_TariffeScontiHome.create();

          /*
           * viene aggiornata l'occorrenza  di I5_2TARIFFE_SCONTI:
           * Si ricava l'occorrenza da aggiornare a partire dai valori
           * I5_2TARIFFE_SCONTI.CODE_TARIFFA, I5_2TARIFFE_SCONTI.CODE_PR_TARIFFA,
           * I5_2TARIFFE_SCONTI.CODE_SCONTO e I5_2TARIFFE_SCONTI.DATA_INIZIO_VALID
           * passati in input;
           * I5_2TARIFFE_SCONTI.DATA_FINE_VALID è aggiornato con il valore inserito
           * nel campo Data Fine Validità.
           */
            lent_TariffeSconti.update
                (pstr_codeTariffa
                ,pstr_codePrTariffa
                ,pstr_codeSconto
                ,pstr_dataInizioValid
                ,pstr_dataFineValid);

            lstr_risultato = "Elaborazione terminata correttamente";
        } // Fine se non risultano elaborazioni Batch in corso....
        else
        {
          lstr_risultato = "Non è possibile disattivare l'occorrenza selezionata a causa di elaborazioni batch in corso.";
        }
      }
      else // Verifica correttezza dei parametri ricevuti in ingresso.
      {
        lstr_risultato = "Parametri ricevuti in ingresso non corretti";
      }
    }
    catch (Exception lexc_Eccezione)
    {
      throw new CustomException(lexc_Eccezione.toString(),
                                  "",
                                  "insert",
                                  this.getClass().getName(),
                                  StaticContext.FindExceptionType(lexc_Eccezione));
    }

    return (lstr_risultato);
  }


}