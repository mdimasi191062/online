package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import com.utl.*;
import com.ejbSTL.*;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;

public class Ctr_FattureBean extends AbstractClassicEJB implements SessionBean 
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


  // delFattureProvvisorie
  public String delFattureProvvisorie (Vector pvct_AccountFattProvv)
    throws CustomException, RemoteException
  {
    String lstr_Error="";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Fatture lEnt_Fatture = null;
    Ent_FattureHome lEnt_FattureHome = null;
    DB_Account lDB_Account = null;
    try 
    {
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Fatture");
      lEnt_FattureHome = (Ent_FattureHome)PortableRemoteObject.narrow(homeObject, Ent_FattureHome.class);
      lEnt_Fatture = lEnt_FattureHome.create();

      if ( pvct_AccountFattProvv != null )
      {
        for ( int ind=0; ind < pvct_AccountFattProvv.size(); ind++)
        {
          lDB_Account = (DB_Account)pvct_AccountFattProvv.get(ind);
          if (! lDB_Account.getCODE_DOC_FATTURA().equalsIgnoreCase(""))
          {
            lEnt_Fatture.delDettDocFattura(StaticContext.DELETE,lDB_Account.getCODE_DOC_FATTURA());
            lEnt_Fatture.delTestDocFattura(StaticContext.DELETE,lDB_Account.getCODE_DOC_FATTURA());
          }
        }
      }
      else
      {
        lstr_Error = "Errore nel reperire gli Account per la cancellazione delle Fatture Provvisorie";
      }
       return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delFattureProvvisorie",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // CambioCicloFatturazione
  public String CambioCicloFatturazione (Vector pvct_AccountFatt,
                                         String pstr_TipoContratto,
                                         String pstr_CodeCicloFatrz,
                                         String pstr_IstanzaCiclo)
    throws CustomException, RemoteException
  {
    String lstr_Error="";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    Ent_Fatture lEnt_Fatture = null;
    Ent_FattureHome lEnt_FattureHome = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;
    DB_Account lDB_Account = null;
    GregorianCalendar lcld_Data = null;
    DB_Account lDB_AccountNew = new DB_Account();
    DB_Fatture lDB_Fattura = new DB_Fatture();
    DB_Batch lDB_Batch = new DB_Batch();
    Vector lvct_Account = null;
    try 
    {
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Contratti");
      lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
      lEnt_Contratti = lEnt_ContrattiHome.create();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Fatture");
      lEnt_FattureHome = (Ent_FattureHome)PortableRemoteObject.narrow(homeObject, Ent_FattureHome.class);
      lEnt_Fatture = lEnt_FattureHome.create();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Batch");
      lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
      lEnt_Batch = lEnt_BatchHome.create();

      if ( pvct_AccountFatt != null )
      {
        for ( int ind=0; ind < pvct_AccountFatt.size(); ind++)
        {
          // Crea testate fattura per gli account relativi alle fatture definitive non congelate
          lDB_Account = (DB_Account)pvct_AccountFatt.get(ind);
          lDB_Fattura.setCODE_ACCOUNT(lDB_Account.getCODE_ACCOUNT());
          lDB_Fattura.setCODE_PARAM(lDB_Account.getCODE_PARAM());
          lDB_Fattura.setIMPT_TOT_FATTURA("0");
          lDB_Fattura.setDATA_CREAZ_FATTURA(DataFormat.convertiData(DataFormat.setData(),StaticContext.FORMATO_DATA_ORA));
          lDB_Fattura.setTIPO_FLAG_FUNZIONE_CREAZ_IMPT("V");
          lDB_Fattura.setTIPO_FLAG_STATO_IMPT("D");
          // Inserisco testata fattura
          lEnt_Fatture.insTestDocFattura(StaticContext.INSERT,lDB_Fattura);
        }

        lDB_Batch.setCODE_FUNZ(StaticContext.RIBES_INFR_BATCH_VAL_ATTIVA);
        lDB_Batch.setCODE_STATO_BATCH("SUCC");
        lDB_Batch.setCODE_UTENTE("SU");
        lDB_Batch.setCODE_USCITA("0");
        lDB_Batch.setDATA_ORA_FINE_ELAB_BATCH(DataFormat.convertiData(DataFormat.setData(),StaticContext.FORMATO_DATA_ORA));
        lDB_Batch.setDATA_ORA_INIZIO_ELAB_BATCH(lDB_Batch.getDATA_ORA_FINE_ELAB_BATCH());
        lDB_Batch.setVALO_NR_PS_ELAB("0");
        // Inserisco nuova elaborazione Batch
        lDB_Batch.setCODE_ELAB(lEnt_Batch.insElabBatch(StaticContext.INSERT,
														lDB_Batch).toString());

        lvct_Account = lEnt_Contratti.getAccountValAttiva(StaticContext.LIST,
															pstr_TipoContratto,
															pstr_CodeCicloFatrz,
															pstr_IstanzaCiclo,
															null);

        for ( int ind=0; ind < lvct_Account.size(); ind++)
        {
          // Ricevo tutti gli account che hanno tipo_flag_stato_cong != R e data_cong = null
          lDB_Account = (DB_Account)lvct_Account.get(ind);
          // Elaboro quelli che hanno tipo_flag_stato_cong = N
          if ( lDB_Account.getTIPO_FLAG_STATO_CONG().equalsIgnoreCase("N") )
          {
            lDB_Account.setCODE_ELAB(lDB_Batch.getCODE_ELAB());
            lDB_Account.setDATA_CONG(DataFormat.convertiData(DataFormat.setData(),StaticContext.FORMATO_DATA));
            // Calcolo Data Fine Periodo Fatturazione ( = Data Inizio Periodo + 1 giorno )
            lDB_Account.setDATA_FINE_PERIODO(DataFormat.ConvertiRollData(lDB_Account.getDATA_INIZIO_PERIODO(),
																			StaticContext.FORMATO_DATA,
																			0,
																			0,
																			1));
            lDB_Account.setTIPO_FLAG_STATO_CONG("C");
            lDB_Account.setVALO_NR_SCARTI_NB("0");
            // Aggiorno Param Valoriz per il nuovo code elab
            lEnt_Batch.updParamValoriz(StaticContext.UPDATE,lDB_Account);

            lDB_AccountNew.setCODE_ACCOUNT(lDB_Account.getCODE_ACCOUNT());
            // Calcolo Data Inizio Periodo Fatturazione ( = Data Fine Periodo precedente + 1 giorno )
            lDB_AccountNew.setDATA_INIZIO_PERIODO(DataFormat.ConvertiRollData(lDB_Account.getDATA_FINE_PERIODO(),
																				StaticContext.FORMATO_DATA,
																				0,
																				0,
																				1));
            // Calcolo Data Inizio Ciclo Fatturazione ( = Data Fine Ciclo precedente + 1 giorno )
            lDB_AccountNew.setDATA_INIZIO_CICLO_FATRZ(DataFormat.ConvertiRollData(lDB_Account.getDATA_FINE_CICLO_FATRZ(),
																					StaticContext.FORMATO_DATA,
																					0,
																					0,
																					1));
            // Calcolo Data Fine Ciclo Fatturazione ( = Data Inizio Nuovo Ciclo + 1 mese - 1 giorno)
            lDB_AccountNew.setDATA_FINE_CICLO_FATRZ(DataFormat.ConvertiRollData(lDB_AccountNew.getDATA_INIZIO_CICLO_FATRZ(),
																					StaticContext.FORMATO_DATA,
																					0,
																					1,
																					-1));
            lDB_AccountNew.setVALO_NR_SCARTI_NB("0");
            lDB_AccountNew.setTIPO_FLAG_ERR_BLOCC("N");
            lDB_AccountNew.setTIPO_FLAG_STATO_CONG("N");
           
            // Inserisco nuovi Param Valoriz per la nuova elaborazione
            lEnt_Batch.insParamValoriz(StaticContext.INSERT,lDB_AccountNew);
          }
        }
      }
      else
      {
        lstr_Error = "Errore nel reperire gli Account il cambio del ciclo di Fatturazione";
      }
      return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"CambioCicloFatturazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

}