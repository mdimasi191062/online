package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;
import java.sql.*;

public class Ctr_TariffeBean extends AbstractClassicEJB implements SessionBean 
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

  /*************
    insTariffa
  *************/
  public String insTariffa ( Vector pvct_Tariffe )
                            throws CustomException, RemoteException
  {
    int lint_Result;
    String lstr_Error = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    DB_Tariffe lDB_Tariffa = null;
    Ent_Tariffe lent_Tariffe = null;
    Ent_TariffeHome lent_TariffeHome = null;
    Ent_AssocOggettiFatturazione lent_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lent_AssocOggettiFatturazioneHome = null;
    Ent_OggettiFatturazione lent_OggettiFatturazione = null;
    Ent_OggettiFatturazioneHome lent_OggettiFatturazioneHome = null;
    Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
    Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;

    try {
	
      if ( pvct_Tariffe != null && pvct_Tariffe.size() > 0 ) {
		
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();
		
        // Se ho la classe Ent_Batch e non risultano elaborazioni Batch in corso....
        lstr_Error = this.isRunningBatch(lcls_Contesto,StaticContext.INSERT);
		
        if (lstr_Error == null) {

          // lcls_Contesto = new InitialContext();
          // Istanzio una classe Ent_Tariffe
          homeObject = lcls_Contesto.lookup("Ent_Tariffe");
          lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
          lent_Tariffe = lent_TariffeHome.create();
			
          homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
          lent_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
          lent_AssocOggettiFatturazione = lent_AssocOggettiFatturazioneHome.create();
			
          homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
          lent_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
          lent_OggettiFatturazione = lent_OggettiFatturazioneHome.create();
			
          // Se ho una classe Ent_Tariffe ed il controllo sulla Tariffa in questione torna 0....
          lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(0);
			
          DB_OggettoFatturazione lDB_OggettoFatturazione = (DB_OggettoFatturazione)lent_AssocOggettiFatturazione.getAssocOggFatturazione(StaticContext.LIST,
                                                                              StaticContext.FN_ASS_OFPS,
                                                                              lDB_Tariffa.getCODE_TIPO_CONTR(),
                                                                              "",
                                                                              lDB_Tariffa.getCODE_CONTR(),
                                                                              lDB_Tariffa.getCODE_PS(),
                                                                              lDB_Tariffa.getCODE_PREST_AGG(),
                                                                              lDB_Tariffa.getCODE_TIPO_CAUS(),
                                                                              lDB_Tariffa.getCODE_OGG_FATRZ(),
                                                                              false,
                                                                              "").get(0);
			                                                                  
          //Valorizzo le info prese dal metodo getAssocOggFatturazione
          lDB_Tariffa.setCODE_PR_PS_PA_CONTR(lDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR());
          lDB_Tariffa.setDATA_INIZIO_VALID_OF_PS(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS());
          lDB_Tariffa.setDATA_INIZIO_VALID_OF(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF());
			
          if ((lent_Tariffe != null ) && (lent_Tariffe.chkTariffa(StaticContext.INSERT,StaticContext.FN_TARIFFA,lDB_Tariffa).intValue() == 0)) {

                // Controllo le date.
                lstr_Error = pri_ChkDate(lent_AssocOggettiFatturazione, lent_OggettiFatturazione, lDB_Tariffa);
      			
                if ((lstr_Error == null) || (lstr_Error.equalsIgnoreCase(""))) {
					
              // Acquisisco la sequence per poter inserire un nuovo Codice Tariffa
              int lint_sequence = lent_Tariffe.getTariffaSequence(StaticContext.INSERT).intValue();
              // Il Progressivo Tariffa parte da 1
              int lint_progr = 1;
              String lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);
					
              // per ogni tariffa da inserire .....
              for (int lint_element = 0; lint_element < pvct_Tariffe.size(); lint_element ++) {
						
                lstr_Error = "Errore : Errore nell'inserimento.";
                lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(lint_element);
                // Valorizzo la sequence nella classe tariffa
                lDB_Tariffa.setCODE_TARIFFA(Integer.toString(lint_sequence));
                // Valorizzo il progressivo della Tariffa
                lDB_Tariffa.setCODE_PR_TARIFFA(Integer.toString(lint_progr));
                //Valorizzo le info prese dal metodo getAssocOggFatturazione
                lDB_Tariffa.setCODE_PR_PS_PA_CONTR(lDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR());
                lDB_Tariffa.setDATA_INIZIO_VALID_OF_PS(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS());
                lDB_Tariffa.setDATA_INIZIO_VALID_OF(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF());
                lDB_Tariffa.setDATA_CREAZ_MODIF(lstr_Oggi);
                lDB_Tariffa.setDATA_CREAZ_TARIFFA(lstr_Oggi);
						
                // Inserisco un record alla volta chiamando il metodo insTariffa della classe Ent_Tariffa
                lint_Result = lent_Tariffe.insTariffa(StaticContext.INSERT, lDB_Tariffa).intValue();
                lstr_Error = "";
						
                // Incremento il progressivo della Tariffa
                lint_progr++;
                
              } // fine ciclo tariffe da inserire
					
                } else {
              lstr_Error = "Errore : verifica associazione OFPS fallita.";
                }
          } else if (lent_Tariffe != null) {
						
            if ((lstr_Error = this.getErrorMessage(lcls_Contesto, "CCB420037")) == null) {
                        lstr_Error = "Errore : La tariffa non può essere inserita.";
            }

          } else {
            lstr_Error = "Errore : impossibile selezionare gli oggetti che compongono la struttura tariffaria.";
          }
    		  
        } else {
          lstr_Error = "Attenzione : impossibile procedere all'inserimento della struttura tariffaria per elaborazioni batch in corso.";
        }
		
      } else {
        lstr_Error = "Errore : Nessun record è stato passato per la tariffa .";
      }

    }  catch(Exception lexc_Exception) {
        throw new CustomException(lexc_Exception.toString(), "", "insTariffa",
                      this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
    }

    if (lstr_Error == null) {
        lstr_Error = "";
    }
    return lstr_Error;
  }
  
/*************
  updTariffa
*************/
public String updTariffa (Vector pvct_Tariffe) throws CustomException, RemoteException
{
    int lint_Result;
    String lstr_Error = null;
    String lstr_datafinevalid = "";
    Context lcls_Contesto = null;
    Object homeObject = null;
    DB_Tariffe lDB_Tariffa = null;
    Ent_Tariffe lent_Tariffe = null;
    Ent_TariffeHome lent_TariffeHome = null;
    Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
    Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;
    Ent_TariffeSconti lent_TariffeSconti = null;
    Ent_TariffeScontiHome lent_TariffeScontiHome = null;
      
    try 
    {
        
        if (pvct_Tariffe != null && pvct_Tariffe.size() > 0)
        {   
            // Acquisisco il contesto del componente
            lcls_Contesto = new InitialContext();
        
            lstr_Error = this.isRunningBatch(lcls_Contesto,StaticContext.UPDATE);
            if (lstr_Error == null)
            {
                // lcls_Contesto = new InitialContext();
                // Istanzio una classe Ent_Tariffe
                homeObject = lcls_Contesto.lookup("Ent_Tariffe");
                lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
                lent_Tariffe = lent_TariffeHome.create();

                homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
                lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
                lent_TariffeSconti = lent_TariffeScontiHome.create();

                // Se ho una classe Ent_Tariffe ed il controllo sulla Tariffa in questione torna 0....
                lstr_Error = "Errore : La tariffa non può essere modificata.";

                // if ((lent_Tariffe != null ) && ( lent_Tariffe.chkTariffa(StaticContext.UPDATE,lDB_Tariffa).intValue() == 0))
                if (lent_Tariffe != null ) 
                {
                    lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(0);

                    // Il Progressivo Tariffa parte dal massimo progressivo della tariffa in modifica + 1
                    int lint_newprogr = ( 1 + lent_Tariffe.getTariffaMaxProgr(StaticContext.UPDATE,lDB_Tariffa.getCODE_TARIFFA()).intValue());
                    String lstr_newdata = Misc.nh(lDB_Tariffa.getDATA_INIZIO_TARIFFA());
                    String lstr_olddata = Misc.nh(lDB_Tariffa.getDATA_INIZIO_TARIFFA_OLD());

                    GregorianCalendar lcld_newData = DataFormat.setData(lstr_newdata, StaticContext.FORMATO_DATA);
                    GregorianCalendar lcld_oldData = DataFormat.setData(lstr_olddata, StaticContext.FORMATO_DATA);
                    GregorianCalendar lcld_Data = DataFormat.rollData(lcld_newData.getTime().getTime(), -1); 
                    lstr_datafinevalid = Misc.nh(DataFormat.convertiData(lcld_Data, StaticContext.FORMATO_DATA));

                    DB_Tariffe lDB_TariffaLast = lent_Tariffe.getTariffaMaxDataCreaz(lDB_Tariffa.getCODE_TARIFFA(), lstr_datafinevalid, "");

                    if ((lDB_TariffaLast != null) && (lDB_TariffaLast.getTIPO_FLAG_PROVVISORIA().equalsIgnoreCase("N")))
                    {
                        lint_Result = lent_Tariffe.updTariffaXDataCreaz(StaticContext.UPDATE,
                                                                            lDB_TariffaLast.getCODE_TARIFFA(),
                                                                            lstr_datafinevalid,
                                                                            lDB_TariffaLast.getDATA_CREAZ_TARIFFA()).intValue();
                    }

                    // Loop di aggiornamento Tariffa
                    String lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);
                    for (int lint_element = 0; lint_element < pvct_Tariffe.size(); lint_element ++)
                    {
                        lstr_Error = "Errore : Errore nell'aggiornamento della Tariffa.";
                        lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(lint_element);
                        lDB_Tariffa.setDATA_CREAZ_MODIF(lstr_Oggi);
                        lDB_Tariffa.setDATA_CREAZ_TARIFFA(lstr_Oggi);

                        if (lcld_newData.getTime().getTime() > lcld_oldData.getTime().getTime())
                        {
                            // Inserisco un record alla volta chiamando il metodo insTariffa della classe Ent_Tariffa
                            lstr_Error = "Errore : Errore nell'inserimento.";

                            // Valorizzo il progressivo della Tariffa da inserire
                            String lstr_oldCODE_PR_TARIFFA = Misc.nh(lDB_Tariffa.getCODE_PR_TARIFFA());
                            lDB_Tariffa.setCODE_PR_TARIFFA(Integer.toString(lint_newprogr));

                            // Valorizzo a null la data di fine validità della tariffa
                            lint_Result = lent_Tariffe.insTariffa(StaticContext.UPDATE, lDB_Tariffa).intValue();
                            lstr_Error = "Errore : Errore nell'aggiornamento di TariffeSconti.";
                            lint_Result = lent_TariffeSconti.updTariffeSconti(StaticContext.UPDATE, lDB_Tariffa.getCODE_TARIFFA(),lDB_Tariffa.getCODE_PR_TARIFFA(),lstr_oldCODE_PR_TARIFFA).intValue();
                        }
                        else
                        {
                            // Modifico un record alla volta chiamando il metodo updTariffa della classe Ent_Tariffa
                            lstr_Error = "Errore : Errore nell'aggiornamento della Tariffa.";
                            lint_Result = lent_Tariffe.updTariffa(StaticContext.UPDATE, lDB_Tariffa).intValue();
                        }

                        lstr_Error = "";
                        // Incremento il progressivo della Tariffa
                        lint_newprogr++;
                    }

                    // Vengono cancellate tutte le tariffe con tipo_flag_provvisoria = 'N'
                    // e data_inizio_tariffa maggiore di quello digitato sulla maschera.
                    lint_Result = lent_Tariffe.delTariffaMagDataInizio(StaticContext.UPDATE,
                                                                        lDB_Tariffa.getCODE_TARIFFA(),
                                                                        lDB_Tariffa.getDATA_INIZIO_TARIFFA()).intValue();

                }
            }
        }
        else
        {
            lstr_Error = "Errore : Nessun record è stato passato per la tariffa .";
        }

        if (lstr_Error == null) {
            lstr_Error = "";
        }
        return lstr_Error;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


/*************
  delTariffa
*************/
public String delTariffa (Vector pvct_Tariffe)
    throws CustomException, RemoteException
{
    int lint_Result;
    String lstr_Error = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_TariffeSconti lent_TariffeSconti = null;
    Ent_TariffeScontiHome lent_TariffeScontiHome = null;
    Ent_Tariffe lent_Tariffe = null;
    Ent_TariffeHome lent_TariffeHome = null;

    try 
    {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();
        
        lstr_Error = this.isRunningBatch(lcls_Contesto,StaticContext.DELETE);
        if (lstr_Error == null)
        {
            // lcls_Contesto = new InitialContext();
            // Istanzio una classe Ent_TariffeSconti
            homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
            lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
            lent_TariffeSconti = lent_TariffeScontiHome.create();

            // Istanzio una classe Ent_Tariffe
            homeObject = lcls_Contesto.lookup("Ent_Tariffe");
            lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
            lent_Tariffe = lent_TariffeHome.create();

            // Se ho una classe Ent_Tariffe ed il controllo sulla Tariffa in questione torna 0....
            if ( lent_TariffeSconti != null )
            {
                DB_Tariffe ldb_Tariffe = null;
                for (int i=0; i<pvct_Tariffe.size(); i++)
                {
                    ldb_Tariffe = (DB_Tariffe)pvct_Tariffe.get(i);
                    lint_Result = lent_TariffeSconti.delTariffeSconti(StaticContext.DELETE,
                                                                        ldb_Tariffe.getCODE_TARIFFA(),
                                                                        ldb_Tariffe.getCODE_PR_TARIFFA()).intValue();
                }


                String lstr_newdata = Misc.nh(ldb_Tariffe.getDATA_INIZIO_TARIFFA());

                GregorianCalendar lcld_newData = DataFormat.setData(lstr_newdata, StaticContext.FORMATO_DATA);
                GregorianCalendar lcld_Data = DataFormat.rollData(lcld_newData.getTime().getTime(), -1); 
                String lstr_datafinevalid = Misc.nh(DataFormat.convertiData(lcld_Data, StaticContext.FORMATO_DATA));

                DB_Tariffe lDB_TariffaLast = lent_Tariffe.getTariffaMaxDataCreaz(ldb_Tariffe.getCODE_TARIFFA(),
                                                                            lstr_datafinevalid,
                                                                            "");

                if (lDB_TariffaLast != null)
                {
                    lint_Result = lent_Tariffe.updTariffaXDataCreaz(StaticContext.UPDATE,
                                                                        lDB_TariffaLast.getCODE_TARIFFA(),
                                                                        "",
                                                                        lDB_TariffaLast.getDATA_CREAZ_TARIFFA()).intValue();
                }


                // Se ho una classe Ent_Tariffe ed il controllo sulla Tariffa in questione torna 0....
                lstr_Error = "Errore : La tariffa non può essere cancellata.";
                if ( lent_Tariffe != null )
                {
                    // Acquisisco la sequence per poter inserire un nuovo Codice Tariffa
                    lstr_Error = "Errore : Errore nel cancellamento della Tariffa.";
                    lint_Result = lent_Tariffe.delTariffa(StaticContext.DELETE,
                                                            ldb_Tariffe.getCODE_TARIFFA(),
                                                            ldb_Tariffe.getDATA_CREAZ_TARIFFA()).intValue();
                    lstr_Error = "";
                }
            }
        }

        return lstr_Error;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}



public String updTariffaXTipoContr (Vector pvct_Tariffe)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = null;
    String lstr_CodiceTipoCausale = null;

    boolean lbln_LeggiErrore = false;
    Context lcls_Contesto = null;
    Object homeObject = null;

    Ent_AssocOggettiFatturazione lent_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lent_AssocOggettiFatturazioneHome = null;
    Ent_OggettiFatturazione lent_OggettiFatturazione = null;
    Ent_OggettiFatturazioneHome lent_OggettiFatturazioneHome = null;
    Ent_Tariffe lent_Tariffe = null;
    Ent_TariffeHome lent_TariffeHome = null;
    Ent_TariffeSconti lent_TariffeSconti = null;
    Ent_TariffeScontiHome lent_TariffeScontiHome = null;

      if ((pvct_Tariffe != null) && (pvct_Tariffe.size() > 0)) {

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Se non risultano elaborazioni Batch in corso....
        lstr_Error = this.isRunningBatch(lcls_Contesto, StaticContext.INSERT);
        if (lstr_Error == null) {

          // Instanzio gli Ejb coinvolti nell'inserimento
          homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
          lent_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
          lent_AssocOggettiFatturazione = lent_AssocOggettiFatturazioneHome.create();

          homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
          lent_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
          lent_OggettiFatturazione = lent_OggettiFatturazioneHome.create();

          homeObject = lcls_Contesto.lookup("Ent_Tariffe");
          lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
          lent_Tariffe = lent_TariffeHome.create();

          homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
          lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
          lent_TariffeSconti = lent_TariffeScontiHome.create();

          // Per ogni tipo causale selezionato esegue i controlli sulle date.
          DB_Tariffe lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(0);
          Vector lvct_CodiciTipiCausale = Misc.split(lDB_Tariffa.getCODE_TIPO_CAUS(), "*");

          for (int i=0; i<lvct_CodiciTipiCausale.size() && (lstr_Error == null); i++) {
              lDB_Tariffa.setCODE_TIPO_CAUS((String)lvct_CodiciTipiCausale.get(i));
              lstr_Error = pri_ChkDate(lent_AssocOggettiFatturazione, lent_OggettiFatturazione, lDB_Tariffa);
          }

          if (lstr_Error == null) {
              // Controllo l'esistenza della struttura tariffaria.
              lstr_Error = pri_ChkTariffeTipoContr(lent_Tariffe,pvct_Tariffe);
          }

          if (lstr_Error == null) {

            String lstr_DataInizioTariffaNew = lDB_Tariffa.getDATA_INIZIO_TARIFFA();
            GregorianCalendar lcld_NewData = DataFormat.setData(lstr_DataInizioTariffaNew, StaticContext.FORMATO_DATA);
            GregorianCalendar lcld_EndData = DataFormat.rollData(lcld_NewData.getTime().getTime(), -1); 
            String lstr_DataFineTariffa = Misc.nh(DataFormat.convertiData(lcld_EndData, StaticContext.FORMATO_DATA));

            // Per ogni record passato dalla pagina.....
            String lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);

            // Per ogni tipologia causale selezionata...
            for (int contaTipiCausale=0; contaTipiCausale<lvct_CodiciTipiCausale.size();contaTipiCausale++) {

              lstr_CodiceTipoCausale=(String)lvct_CodiciTipiCausale.get(contaTipiCausale);
                    
              for (int j=0; j<pvct_Tariffe.size(); j++) {

                lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(j);

                lDB_Tariffa.setCODE_TIPO_CAUS(lstr_CodiceTipoCausale);

                // Chiamo la chkTariffa che in questo caso mi torna tutti i codici pr_ps_pa_contr
                // legati a tariffe che devo aggiornare.
                Vector lvct_PrPsPaContr = lent_Tariffe.getTariffaXTipoContrUpd(StaticContext.UPDATE, lDB_Tariffa);

                // Per ogni record tornato dalla funzione getTariffaXTipoContrUpd.....
                for (int i=0; i<lvct_PrPsPaContr.size(); i++) {
                          
                  DB_Tariffe lDB_TariffaPrPsPaContr = (DB_Tariffe)lvct_PrPsPaContr.get(i);

                  // Prendo l'ultima tariffa esistente che corrisponde a quella che va aggiornata.
                  DB_Tariffe lDB_TariffaUpd = lent_Tariffe.getTariffaMaxDataCreaz(lDB_TariffaPrPsPaContr.getCODE_TARIFFA(), "", lstr_Oggi);
                  GregorianCalendar lcld_OldData = DataFormat.setData(Misc.nh(lDB_TariffaUpd.getDATA_INIZIO_TARIFFA()), StaticContext.FORMATO_DATA);

                  // Get max progressivo tariffa esistente
                  int lint_ProgrTariffa = lent_Tariffe.getTariffaMaxProgr(StaticContext.UPDATE, lDB_TariffaPrPsPaContr.getCODE_TARIFFA()).intValue();

                  DB_Tariffe lDB_TariffaLast = lent_Tariffe.getTariffaMaxDataCreaz(lDB_TariffaPrPsPaContr.getCODE_TARIFFA(),lstr_DataFineTariffa,lstr_Oggi);

                  if ((lDB_TariffaLast != null) && (lDB_TariffaLast.getTIPO_FLAG_PROVVISORIA().equalsIgnoreCase("N"))) {
                      int lint_Result = lent_Tariffe.updTariffaXDataCreaz(StaticContext.UPDATE, lDB_TariffaLast.getCODE_TARIFFA(),
                                                                                             lstr_DataFineTariffa, lDB_TariffaLast.getDATA_CREAZ_TARIFFA()).intValue();
                  }

                  lDB_TariffaUpd.setDATA_CREAZ_MODIF(lstr_Oggi);
                  lDB_TariffaUpd.setDATA_CREAZ_TARIFFA(lstr_Oggi);
                  lDB_TariffaUpd.setCODE_FASCIA(lDB_Tariffa.getCODE_FASCIA());
                  lDB_TariffaUpd.setCODE_PR_FASCIA(lDB_Tariffa.getCODE_PR_FASCIA());
                  lDB_TariffaUpd.setCODE_CLAS_SCONTO(lDB_Tariffa.getCODE_CLAS_SCONTO());
                  lDB_TariffaUpd.setCODE_PR_CLAS_SCONTO(lDB_Tariffa.getCODE_PR_CLAS_SCONTO());
                  lDB_TariffaUpd.setCODE_UTENTE(lDB_Tariffa.getCODE_UTENTE());
                  lDB_TariffaUpd.setCODE_UNITA_MISURA(lDB_Tariffa.getCODE_UNITA_MISURA());
                  lDB_TariffaUpd.setDESC_TARIFFA(lDB_Tariffa.getDESC_TARIFFA());
                  lDB_TariffaUpd.setIMPT_TARIFFA(lDB_Tariffa.getIMPT_TARIFFA());
                  lDB_TariffaUpd.setDATA_INIZIO_TARIFFA(lDB_Tariffa.getDATA_INIZIO_TARIFFA());
                  lDB_TariffaUpd.setDATA_FINE_TARIFFA(lDB_Tariffa.getDATA_FINE_TARIFFA());
                  lDB_TariffaUpd.setCODE_TIPO_OFF(lDB_Tariffa.getCODE_TIPO_OFF());

                  int lint_OldProgrTariffa = Integer.parseInt(lDB_TariffaUpd.getCODE_PR_TARIFFA());
                  if (lcld_NewData.getTime().getTime() > lcld_OldData.getTime().getTime() || 
                     (lcld_NewData.getTime().getTime() <= lcld_OldData.getTime().getTime() && 
                      (lDB_TariffaUpd.getTIPO_FLAG_PROVVISORIA().equalsIgnoreCase("D")))) {
                              
                      lint_ProgrTariffa += 1;
                      lDB_TariffaUpd.setCODE_PR_TARIFFA(Integer.toString(lint_ProgrTariffa));

                      // Insert di record nuovi
                      lent_Tariffe.insTariffa(StaticContext.INSERT,lDB_TariffaUpd);

                      // Update tariffe sconti
                      lent_TariffeSconti.updTariffeSconti(StaticContext.INSERT,
                                                                       lDB_TariffaUpd.getCODE_TARIFFA(),
                                                                       lDB_TariffaUpd.getCODE_PR_TARIFFA(),
                                                                       Integer.toString(lint_OldProgrTariffa));
                  }
                  else {
                      lDB_TariffaUpd.setCODE_PR_TARIFFA(Integer.toString(lint_OldProgrTariffa));

                      // Update sui record attuali
                      lent_Tariffe.updTariffa(StaticContext.UPDATE,lDB_TariffaUpd);
                  }

                  // Controllo se ho terminato di aggiornare le tariffe oppure
                  // se la tariffa attuale è finita
                  if ((j == (pvct_Tariffe.size()-1)) || (!(((DB_Tariffe)pvct_Tariffe.get(j+1)).getCODE_PR_CLAS_SCONTO().equalsIgnoreCase(lDB_Tariffa.getCODE_PR_CLAS_SCONTO())))) {
                      // Vengono cancellate tutte le tariffe con tipo_flag_provvisoria = 'N'
                      // e data_inizio_tariffa maggiore di quello digitato sulla maschera.
                      int lint_Result = lent_Tariffe.delTariffaMagDataInizio(StaticContext.UPDATE,
                                                                          lDB_TariffaPrPsPaContr.getCODE_TARIFFA(),
                                                                          lstr_DataInizioTariffaNew).intValue();

                      // Vengono aggiornate tutte le tariffe con tipo_flag_provvisoria = 'D'
                      // e data_inizio_tariffa maggiore di quello digitato sulla maschera.
                      lint_Result = lent_Tariffe.updTariffaMagDataInizio(StaticContext.UPDATE,
                                                                          lDB_TariffaPrPsPaContr.getCODE_TARIFFA(),
                                                                          lstr_DataInizioTariffaNew).intValue();
                  }
                } // Fine for Per ogni record tornato dalla funzione getTariffaXTipoContrUpd.....
              } // Fine for Per ogni record passato dalla pagina.....
            } // Fine for Per tipologia causale selezionata ....
          }
        }
      }
      else {
        // !((pvct_Tariffe != null) && (pvct_Tariffe.size() > 0))
        lstr_Error = "Il vettore passato come parametro è vuoto.";
      }

      // +-----
      // Gestione degli eventuali errori avvenuti
      // +-----
      if (lstr_Error != null) {
        if (lbln_LeggiErrore) {
          String lstr_AppoErrore = lstr_Error;
          if ((lstr_Error = this.getErrorMessage(lcls_Contesto, lstr_Error)) == null)
                  lstr_Error = "Errore: " + lstr_AppoErrore;
        }
      }
      else
        lstr_Error = "";

      return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
                            	  							 "",
                                               "updTariffaXTipoContr",
                                               this.getClass().getName(),
                                               StaticContext.FindExceptionType(lexc_Exception));
	}
}

private String pri_ChkTariffeTipoContr (Ent_Tariffe pent_Tariffe,
                                            Vector pvct_Tariffe)
    throws Exception
{
    try
    {
    String lstr_Errore = null;

        DB_Tariffe lDB_Tariffa = null;
        for (int i=0; ((i<pvct_Tariffe.size())
                        && (lstr_Errore == null)); i++)
        {
            lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(i);
            Vector lvct_PrPsPaContr = pent_Tariffe.getTariffaXTipoContrUpd(StaticContext.UPDATE,
                                                                                lDB_Tariffa);
            if (lvct_PrPsPaContr.size() == 0)
                lstr_Errore = "Non è possibile aggiornare la struttura tariffaria selezionata, in quanto non è presente in archivio.";
        }

        return (lstr_Errore);
    }
    catch (Exception lexc_Exception)
    {
        throw new Exception(this.getClass().getName() + ".pri_ChkTariffeTipoContr --> " + lexc_Exception.toString());
    }
}

private String pri_ChkDate (Ent_AssocOggettiFatturazione pEnt_AssocOggettiFatturazione,
                                Ent_OggettiFatturazione pEnt_OggettiFatturazione,
                                DB_Tariffe pDB_Tariffa)
    throws Exception
{
    try
    {
    String lstr_Errore = null;


        // Acquisisco il range di date composto dalla data Max di Fine Validità e la data Min di Inizio Validità
        String lstr_DataMinIV = Misc.nh(pEnt_AssocOggettiFatturazione.getMinDataValidaOFPS(StaticContext.INSERT,
                                        pDB_Tariffa.getCODE_TIPO_CONTR(),
                                        pDB_Tariffa.getCODE_CONTR(),
                                        pDB_Tariffa.getCODE_OGG_FATRZ(),
                                        pDB_Tariffa.getCODE_PREST_AGG(),
                                        pDB_Tariffa.getCODE_TIPO_CAUS(),
                                        pDB_Tariffa.getCODE_PS()));

        if (! lstr_DataMinIV.equalsIgnoreCase(""))
        {
            String lstr_DataValidaOF = pEnt_OggettiFatturazione.getDataValidaXOF(StaticContext.INSERT,
                                                                pDB_Tariffa.getCODE_OGG_FATRZ());

            // Se  Num_data_of risulta(lstr_DataValidaOF) >= Num_data_of_ps(lstr_DataMinIV)
            // e se Num_data_inizio(Inizio Tariffa inserita) risulta < Num_data_of(lstr_DataValidaOF)
            if ((DataFormat.setData(lstr_DataValidaOF, StaticContext.FORMATO_DATA).getTime().getTime()
                    >= DataFormat.setData(lstr_DataMinIV, StaticContext.FORMATO_DATA).getTime().getTime())
                &&
                (DataFormat.setData(pDB_Tariffa.getDATA_INIZIO_TARIFFA(), StaticContext.FORMATO_DATA).getTime().getTime()
                    < DataFormat.setData(lstr_DataValidaOF, StaticContext.FORMATO_DATA).getTime().getTime()))
            {
                lstr_Errore = "La data deve essere maggiore della data inizio validita' dell'OF (" + lstr_DataValidaOF + ")";
            }
            else
            {
                // Se Num_data_inizio(Inizio Tariffa inserita) risulta < Num_data_of_ps(lstr_DataMinIV)
                if (DataFormat.setData(pDB_Tariffa.getDATA_INIZIO_TARIFFA(), StaticContext.FORMATO_DATA).getTime().getTime()
                        < DataFormat.setData(lstr_DataMinIV, StaticContext.FORMATO_DATA).getTime().getTime())
                {
                    lstr_Errore = "La data deve essere maggiore della data inizio validita' dell'OF_PS (" + lstr_DataMinIV + ")";
                }
            }
        }

        return (lstr_Errore);
    }
    catch (Exception lexc_Exception)
    {
        throw new Exception(this.getClass().getName() + ".pri_ChkDate --> " + lexc_Exception.toString());
    }
}

public String insTariffaXTipoContr ( String pstr_CodeAccountDaEliminare, Vector pvct_Tariffe )
  throws CustomException, RemoteException {

  int lint_Result;
  String lstr_Error = null;
  Context lcls_Contesto = null;
  Object homeObject = null;
  DB_Tariffe lDB_Tariffa = null;
  DB_Tariffe lDB_Tariffa_Appoggio = null;
  DB_OggettoFatturazione lDB_OggettoFatturazione = null;
  Ent_Tariffe lent_Tariffe = null;
  Ent_TariffeHome lent_TariffeHome = null;
  Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
  Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;
  Ent_AssocOggettiFatturazione lEnt_AssocOggettiFatturazione = null;
  Ent_AssocOggettiFatturazioneHome lEnt_AssocOggettiFatturazioneHome = null;
  Ent_OggettiFatturazione lEnt_OggettiFatturazione = null;
  Ent_OggettiFatturazioneHome lEnt_OggettiFatturazioneHome = null;

  Connection connessione = null;

  int lint_sequence = 0;
  int lint_progr = 0;

  boolean lbln_FlagSequence = false;

  Vector lvct_Tipicausale = null;
  Vector lvct_OFValidiPS = null;
  String lstr_TipoCaus = null;
  String lstr_codiceTipoCausale = "";
  String lstr_Oggi = null;

  //Martino Marangi Nuovo ritorno della funzione
  int intTariffeInserite = 0;

	try {

		if ( pvct_Tariffe != null && pvct_Tariffe.size() > 0 ) {
			
			// Acquisisco il contesto del componente
			lcls_Contesto = new InitialContext();
			// Se ho la classe Ent_Batch e non risultano elaborazioni Batch in corso....
			lstr_Error = this.isRunningBatch(lcls_Contesto,StaticContext.INSERT);

			if (lstr_Error == null) {
				
				// Instanzio gli Ejb coinvolti nell'inserimento
				homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
				lEnt_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
				lEnt_AssocOggettiFatturazione = lEnt_AssocOggettiFatturazioneHome.create();
				
				homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
				lEnt_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
				lEnt_OggettiFatturazione = lEnt_OggettiFatturazioneHome.create();
				
				homeObject = lcls_Contesto.lookup("Ent_Tariffe");
				lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
				lent_Tariffe = lent_TariffeHome.create();

				if ((lent_Tariffe != null ) && (lEnt_AssocOggettiFatturazione != null )) {
					
					// Se ho una classe Ent_Tariffe ed il controllo sulla Tariffa in questione torna 0....
					lDB_Tariffa_Appoggio = (DB_Tariffe)pvct_Tariffe.get(0);
					
					lvct_Tipicausale = Misc.split(lDB_Tariffa_Appoggio.getCODE_TIPO_CAUS(), "*");
					
					lstr_TipoCaus = null;
					
					for ( int lint_tipicaus = 0; ((lstr_Error == null) && (lint_tipicaus < lvct_Tipicausale.size())); lint_tipicaus++) {

						lstr_TipoCaus = Misc.nh((String)lvct_Tipicausale.get(lint_tipicaus));
						lDB_Tariffa_Appoggio.setCODE_TIPO_CAUS(lstr_TipoCaus);
						
						lstr_Error = pri_ChkDate( lEnt_AssocOggettiFatturazione,lEnt_OggettiFatturazione, lDB_Tariffa_Appoggio);
					}
					
					lstr_TipoCaus = null;

					if (lstr_Error == null) {
						
						// per tutte le tipologie causale selezionate ..... 
						for ( int lint_tipicaus = 0; lint_tipicaus < lvct_Tipicausale.size(); lint_tipicaus++) {
							
							lstr_TipoCaus = Misc.nh((String)lvct_Tipicausale.get(lint_tipicaus));
							
							lvct_OFValidiPS = lEnt_AssocOggettiFatturazione.getAssocOggFatturazione(
							                                        StaticContext.INSERT,
							                                        StaticContext.FN_TARIFFA,
							                                        lDB_Tariffa_Appoggio.getCODE_TIPO_CONTR(),
							                                        "", 
							                                        lDB_Tariffa_Appoggio.getCODE_CONTR(),
							                                        lDB_Tariffa_Appoggio.getCODE_PS(),
							                                        lDB_Tariffa_Appoggio.getCODE_PREST_AGG(),
							                                        lstr_TipoCaus,
							                                        lDB_Tariffa_Appoggio.getCODE_OGG_FATRZ(),
							                                        false,
							                                        pstr_CodeAccountDaEliminare);

							// per tutte le associazioni oggetti fatturazione trovate .....
							for ( int lint_ofpsvalid = 0; lint_ofpsvalid < lvct_OFValidiPS.size(); lint_ofpsvalid++) {
								
                                lDB_OggettoFatturazione = (DB_OggettoFatturazione)lvct_OFValidiPS.get(lint_ofpsvalid);
                                lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA_ORA);
				
                                // per tutte le tariffe da inserire ...
                                for (int lint_element = 0; lint_element < pvct_Tariffe.size(); lint_element ++) {
                
									/*
									 * NUOVA VERSIONE
									 * 
									 * 1° caso : La Classe di Sconto è NULL e (il Codice Fascia è NULL oppure il Progressivo Codice Fascia è 3)
									 * 2° caso : il Progressivo Classe di Sconto è 1 oppure 2 e (il Codice Fascia è NULL oppure il Progressivo Codice Fascia è 3)
									 * 
									 */
                                     
                                    lDB_Tariffa = (DB_Tariffe)pvct_Tariffe.get(lint_element);
									
									lbln_FlagSequence = false;
									
									if ("".equalsIgnoreCase(lDB_Tariffa.getCODE_CLAS_SCONTO()) && "".equalsIgnoreCase(lDB_Tariffa.getCODE_FASCIA())) {
										lbln_FlagSequence = true;
									}
									
									if (!"".equalsIgnoreCase(lDB_Tariffa.getCODE_CLAS_SCONTO()) && (lDB_Tariffa.getCODE_PR_CLAS_SCONTO().equalsIgnoreCase("1") || 
									                                                                                                                            lDB_Tariffa.getCODE_PR_CLAS_SCONTO().equalsIgnoreCase("2")) && 
									                                                                                                                             "".equalsIgnoreCase(lDB_Tariffa.getCODE_FASCIA())) {
										lbln_FlagSequence = true;
									}
									
									if ("".equalsIgnoreCase(lDB_Tariffa.getCODE_CLAS_SCONTO()) && !"".equalsIgnoreCase(lDB_Tariffa.getCODE_FASCIA()) &&  lDB_Tariffa.getCODE_PR_FASCIA().equalsIgnoreCase("1")) {
										lbln_FlagSequence = true;
									}
									
									if ((!"".equalsIgnoreCase(lDB_Tariffa.getCODE_CLAS_SCONTO())) && (lDB_Tariffa.getCODE_PR_CLAS_SCONTO().equalsIgnoreCase("1") || 
									                                                                     lDB_Tariffa.getCODE_PR_CLAS_SCONTO().equalsIgnoreCase("2")) && 
										(!"".equalsIgnoreCase(lDB_Tariffa.getCODE_FASCIA())) && (lDB_Tariffa.getCODE_PR_FASCIA().equalsIgnoreCase("1"))) {
										lbln_FlagSequence = true;
									}
									
									if (lbln_FlagSequence) {
										// Acquisisco la sequence per poter inserire un nuovo Codice Tariffa
										lint_sequence = lent_Tariffe.getTariffaSequence(StaticContext.INSERT).intValue();
										// Il Progressivo Tariffa parte da 1
										lint_progr = 1;
									}
									
									// Valorizzo la sequence nella classe tariffa
									lDB_Tariffa.setCODE_TARIFFA(Integer.toString(lint_sequence));
									// Valorizzo il progressivo della Tariffa
									lDB_Tariffa.setCODE_PR_TARIFFA(Integer.toString(lint_progr));
									
									lDB_Tariffa.setDATA_INIZIO_VALID_OF(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF());                 
									lDB_Tariffa.setDATA_INIZIO_VALID_OF_PS(lDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS());
									lDB_Tariffa.setCODE_PR_PS_PA_CONTR(lDB_OggettoFatturazione.getCODE_PR_PS_PA_CONTR());
									
									lDB_Tariffa.setCODE_TIPO_CAUS(lstr_TipoCaus);
									lDB_Tariffa.setDATA_CREAZ_MODIF(lstr_Oggi);
									lDB_Tariffa.setDATA_CREAZ_TARIFFA(lstr_Oggi);
									
									// Inserisco un record alla volta chiamando il metodo insTariffa della classe Ent_Tariffa
									lint_Result = lent_Tariffe.insTariffa(StaticContext.INSERT, lDB_Tariffa).intValue();
									
									// Incremento il progressivo della Tariffa
									lint_progr++;
									
									//Martino Marangi Nuovo ritorno della funzione
									// Incremento il contatore delle Tariffe Inserite
									intTariffeInserite++;

                                } // fine ciclo tariffe da inserire
								
							} // fine ciclo associazioni oggetti fatturazione

						} // fine ciclo tipologie causale 

						if ( 0 == intTariffeInserite ) {
							lstr_Error = "La Struttura tariffaria è già presente in archivio per tutti i gestori .";
						}
						
					} else { // verifica chkDate
						lstr_Error = "Errore : verifica associazione OFPS fallita.";
					}
				
				} else { // istanziazione oggetti  fallita ....
					lstr_Error = "Errore : impossibile selezionare gli oggetti che compongono la struttura tariffaria.";
				}
				
			} else {
				lstr_Error = "Attenzione : impossibile procedere all'inserimento della struttura tariffaria per elaborazioni batch in corso.";
			}
			
		} else {
			lstr_Error = "Errore : Nessun record è stato passato per la tariffa .";
		}
	
	} catch(Exception lexc_Exception) {
	throw new CustomException(lexc_Exception.toString(), "", "insTariffaXTipoContr", 
	                                         this.getClass().getName(), StaticContext.FindExceptionType(lexc_Exception));
	}

    // se lstr_Error è null significa che non si è verificato alcun errore (.. almeno spero ..) quindi 
    // si valorizza con "" per gestirla nelle pagine di competenza
    if (lstr_Error == null) {
        lstr_Error = "";
    }

	return lstr_Error;

  }

  //  delTariffaXTipoContr
  public String delTariffaXTipoContr (  DB_Tariffe pDB_Tariffa )
                                        throws CustomException, RemoteException
  {
    int lint_Result;
    String lstr_Error = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_TariffeSconti lent_TariffeSconti = null;
    Ent_TariffeScontiHome lent_TariffeScontiHome = null;
    Ent_Tariffe lent_Tariffe = null;
    Ent_TariffeHome lent_TariffeHome = null;
    Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
    Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;
      
    try 
    {
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();
        
      lstr_Error = this.isRunningBatch(lcls_Contesto,StaticContext.DELETE);
      if (lstr_Error == null)
      {
        lstr_Error = "Errore : La tariffa non può essere cancellata.";

        // Istanzio una classe Ent_Tariffe
        homeObject = lcls_Contesto.lookup("Ent_Tariffe");
        lent_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
        lent_Tariffe = lent_TariffeHome.create();

        // Istanzio una classe Ent_TariffeSconti
        homeObject = lcls_Contesto.lookup("Ent_TariffeSconti");
        lent_TariffeScontiHome = (Ent_TariffeScontiHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeScontiHome.class);
        lent_TariffeSconti = lent_TariffeScontiHome.create();

        if (( lent_Tariffe != null ) && ( lent_TariffeSconti != null ))
        {
          if ( lent_Tariffe.chkTariffaTipoContrDel(StaticContext.DELETE,pDB_Tariffa).intValue() != 0)
          {
            lint_Result = lent_TariffeSconti.delTariffeScontiTipoContr(StaticContext.DELETE , pDB_Tariffa).intValue();
            // Acquisisco la sequence per poter inserire un nuovo Codice Tariffa
            lint_Result = lent_Tariffe.delTariffaTipoContr( StaticContext.DELETE, pDB_Tariffa).intValue();
            lstr_Error = "";
          }
          else if (( lstr_Error = this.getErrorMessage(lcls_Contesto, "CCB9EU19")) == null)
          {
            lstr_Error = "Errore : Non e' possibile cancellare la struttura tariffaria selezionata, in quanto non e' presente in archivio.";
          }
        }
        else 
        {
          lstr_Error = "Errore : Non e' possibile cancellare la struttura tariffaria selezionata.";
        }
      }
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffaXTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    // se lstr_Error è null significa che non si è verificato alcun errore (.. almeno spero ..) quindi 
    // si valorizza con "" per gestirla nelle pagine di competenza
    if (lstr_Error == null) {
        lstr_Error = "";
    }

   return lstr_Error;
  }

}