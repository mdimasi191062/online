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


public class Ctr_SpesaComplessivaBean extends AbstractClassicEJB implements SessionBean 
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


// lancioBatch
public String lancioBatch (String pstr_CodeTipoContratto,
                            String pstr_CodeUtente,
                            String pstr_MeseRiferimento,
                            String pstr_AnnoRiferimento,
                            String pstr_DataFinePeriodo,
                            Vector pvct_Account)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    DB_Account ldb_Account = null;
	Object homeObject = null;
    Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        if (pvct_Account.size() > 0)
        {
			// Istanzio una classe Ent_Batch
			homeObject = lcls_Contesto.lookup("Ent_Batch");
			lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
			lEnt_Batch = lEnt_BatchHome.create();

            String lstr_Batch = StaticContext.RIBES_INFR_BATCH_CALCOLO_SPESA_COMPLESSIVA +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size(); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);

                lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI
                                + ldb_Account.getCODE_GEST()
                                + StaticContext.RIBES_SEPARATORE_PARAMETRI
                                + pstr_MeseRiferimento
                                + StaticContext.RIBES_SEPARATORE_PARAMETRI
                                + pstr_AnnoRiferimento
                                + StaticContext.RIBES_SEPARATORE_PARAMETRI
                                + pstr_DataFinePeriodo
                                + StaticContext.RIBES_SEPARATORE_PARAMETRI
                                + pstr_CodeTipoContratto;
            } // Fine for. Per ogni elemento contenuto nel vettore passato in input...

			if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
				lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
			else
				lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
        }
        else
            lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_IMPOSS_ELAB);
        
        return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"lancioBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// delDettaglioSpesaCompl
public String delDettaglioSpesaCompl (String pstr_CodeTestSpesaCompl)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_SpesaComplessiva lEnt_SpesaComplessiva = null;
    Ent_SpesaComplessivaHome lEnt_SpesaComplessivaHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_SpesaComplessiva
        homeObject = lcls_Contesto.lookup("Ent_SpesaComplessiva");
        lEnt_SpesaComplessivaHome = (Ent_SpesaComplessivaHome)PortableRemoteObject.narrow(homeObject, Ent_SpesaComplessivaHome.class);
        lEnt_SpesaComplessiva = lEnt_SpesaComplessivaHome.create();

        lEnt_SpesaComplessiva.delDettSpesaCompl(StaticContext.DELETE,
                                                    pstr_CodeTestSpesaCompl);

        lEnt_SpesaComplessiva.updTotaleSpesaCompl(StaticContext.UPDATE,
                                                    pstr_CodeTestSpesaCompl,
                                                    "",
                                                    "");

        return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delDettaglioSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// salvaDettaglioSpesaCompl
public String salvaDettaglioSpesaCompl (Vector pvct_DettSpesaCompl)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_SpesaComplessiva lEnt_SpesaComplessiva = null;
    Ent_SpesaComplessivaHome lEnt_SpesaComplessivaHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_SpesaComplessiva
        homeObject = lcls_Contesto.lookup("Ent_SpesaComplessiva");
        lEnt_SpesaComplessivaHome = (Ent_SpesaComplessivaHome)PortableRemoteObject.narrow(homeObject, Ent_SpesaComplessivaHome.class);
        lEnt_SpesaComplessiva = lEnt_SpesaComplessivaHome.create();

        String lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA);

        for (int i=0; i<pvct_DettSpesaCompl.size(); i++)
        {
            DB_SpesaComplessiva ldb_SpesaComplessiva = (DB_SpesaComplessiva)pvct_DettSpesaCompl.get(i);
            if (ldb_SpesaComplessiva.getCODE_DETT_SPESA_COMPL().equalsIgnoreCase(""))
            {
                lEnt_SpesaComplessiva.insDettaglioSpesaCompl(StaticContext.INSERT,
                                                                ldb_SpesaComplessiva);            
            }
            else
            {
                lEnt_SpesaComplessiva.updDettaglioSpesaCompl(StaticContext.UPDATE,
                                                                ldb_SpesaComplessiva);            
            }

            if (ldb_SpesaComplessiva.getDESC_VALO_PROC_EMITT().equalsIgnoreCase("TOTALE"))
            {
                lEnt_SpesaComplessiva.updTotaleSpesaCompl(StaticContext.UPDATE,
                                                            ldb_SpesaComplessiva.getCODE_TEST_SPESA_COMPL(),
                                                            ldb_SpesaComplessiva.getIMPT_SPESA_COMPL(),
                                                            lstr_Oggi);
            }
        }

        return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"salvaDettaglioSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// generaDettaglioSpesaCompl
public Vector generaDettaglioSpesaCompl (String pstr_CodeTipoContr,
                                            String pstr_CodeGest)
    throws CustomException, RemoteException
{
    try
    {
    Vector lvct_Return;
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    Ent_SpesaComplessiva lEnt_SpesaComplessiva = null;
    Ent_SpesaComplessivaHome lEnt_SpesaComplessivaHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Contratti
        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();

        // Istanzio una classe Ent_SpesaComplessiva
        homeObject = lcls_Contesto.lookup("Ent_SpesaComplessiva");
        lEnt_SpesaComplessivaHome = (Ent_SpesaComplessivaHome)PortableRemoteObject.narrow(homeObject, Ent_SpesaComplessivaHome.class);
        lEnt_SpesaComplessiva = lEnt_SpesaComplessivaHome.create();

        Vector lvct_Account = lEnt_Contratti.getAccountSpeComAcqImp(StaticContext.LIST,
                                                                        pstr_CodeTipoContr,
                                                                        pstr_CodeGest,
																		"0");
        if (lvct_Account.size() == 1)
        {
            lvct_Return = new Vector();
            lvct_Return.add(this.getErrorMessage(lcls_Contesto, "CCB420032"));
        }
        else
        {
            DB_Account ldb_Account = (DB_Account)lvct_Account.get(lvct_Account.size()-2);
            double ldbl_CCBOld = Double.parseDouble(ldb_Account.getIMPT_SPESA_COMPL());
            double ldbl_TOTOld = Double.parseDouble(ldb_Account.getIMPT_TOT_SPESA_COMPL());

            ldb_Account = (DB_Account)lvct_Account.get(lvct_Account.size()-1);
            double ldbl_CCB = Double.parseDouble(ldb_Account.getIMPT_SPESA_COMPL());
            double ldbl_TOT = (ldbl_TOTOld - ldbl_CCBOld) + ldbl_CCB;

            lvct_Return = lEnt_SpesaComplessiva.getProcedureEmittenti(StaticContext.LIST,
                                                                        pstr_CodeTipoContr,
                                                                        ldb_Account);

            int i;
            for (i=(lvct_Return.size()-1); ((i>=0)
                && (!((DB_SpesaComplessiva)lvct_Return.get(i)).getDESC_VALO_PROC_EMITT().equalsIgnoreCase("TOTALE"))); i--);

            if (i>=0)
                ((DB_SpesaComplessiva)lvct_Return.get(i)).setIMPT_SPESA_COMPL(Double.toString(ldbl_TOT));

            lvct_Return.add(""); // Messaggio d'errore
        }

        return (lvct_Return);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"generaDettaglioSpesaCompl",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// congela
public String congela (String pstr_CodeTipoContratto,
                            Vector pvct_Account)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    DB_Account ldb_Account = null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_SpesaComplessiva lEnt_SpesaComplessiva = null;
    Ent_SpesaComplessivaHome lEnt_SpesaComplessivaHome = null;
    Ent_Tariffe lEnt_Tariffe = null;
    Ent_TariffeHome lEnt_TariffeHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_SpesaComplessiva
        homeObject = lcls_Contesto.lookup("Ent_SpesaComplessiva");
        lEnt_SpesaComplessivaHome = (Ent_SpesaComplessivaHome)PortableRemoteObject.narrow(homeObject, Ent_SpesaComplessivaHome.class);
        lEnt_SpesaComplessiva = lEnt_SpesaComplessivaHome.create();

        // Istanzio una classe Ent_Tariffe
        homeObject = lcls_Contesto.lookup("Ent_Tariffe");
        lEnt_TariffeHome = (Ent_TariffeHome)PortableRemoteObject.narrow(homeObject, Ent_TariffeHome.class);
        lEnt_Tariffe = lEnt_TariffeHome.create();

        String lstr_Oggi = DataFormat.convertiData(DataFormat.setData(), StaticContext.FORMATO_DATA);

        // Per ogni elemento contenuto nel vettore passato in input...
        for (int i=0; i<pvct_Account.size(); i++)
        {
            ldb_Account = (DB_Account)pvct_Account.get(i);

            // Aggiorno il campo dataEstrazioneImpt della tabella i5_2dett_spesa_compl
            // in base al code_test_spesa_compl
            lEnt_SpesaComplessiva.updDataEstrazioneImpt(StaticContext.UPDATE,
                                                            ldb_Account.getCODE_TEST_SPESA_COMPL(),
                                                            lstr_Oggi);

            lEnt_Tariffe.updTariffaSpesaComplessiva(StaticContext.UPDATE,
                                                            pstr_CodeTipoContratto,
                                                            ldb_Account.getCODE_GEST());
        } // Fine for. Per ogni elemento contenuto nel vettore passato in input...

        return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"congela",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// getPeriodiRiferimento
public Vector getPeriodiRiferimento( String pstr_CodeTipoContr )
    throws CustomException, RemoteException
{
    String lstr_Error = null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    DB_ClientiSpeCom lDB_ClientiSpeCom = null;
    Ent_Clienti lEnt_Clienti = null;
    Ent_ClientiHome lEnt_ClientiHome = null;
    Vector lvct_Result = null;
    Vector lvct_Return = null;
    String lstr_AppoDataIns = "";
    try
    {
        lvct_Return = new Vector();

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_OggettiFatturazione
        homeObject = lcls_Contesto.lookup("Ent_Clienti");
        lEnt_ClientiHome = (Ent_ClientiHome)PortableRemoteObject.narrow(homeObject, Ent_ClientiHome.class);
        lEnt_Clienti = lEnt_ClientiHome.create();

        if ((lEnt_Clienti != null)
            && (! Misc.nh(pstr_CodeTipoContr).equalsIgnoreCase("")))
        {
            // Ricerco i periodi di riferimento.
            lvct_Result = lEnt_Clienti.getPeriodiRiferimento(StaticContext.INSERT, pstr_CodeTipoContr);
            if (lvct_Result != null)
            {
                GregorianCalendar lgcl_Data = null;
                for (int ind=0; ind < lvct_Result.size(); ind++)
                {
                    lDB_ClientiSpeCom = (DB_ClientiSpeCom)lvct_Result.get(ind);
                    if ((!lDB_ClientiSpeCom.getDATE_DATA_INS().equalsIgnoreCase(""))
                        && (!lDB_ClientiSpeCom.getDATE_DATA_OR().equalsIgnoreCase("")))
                    {
                        //se la data inserita precedentemente è uguale alla attuale non la inserisco nel vettore di output.
                        if(!lstr_AppoDataIns.equalsIgnoreCase(lDB_ClientiSpeCom.getDATE_DATA_INS()))
                        {
                          String[] larr_PeriodiRif = new String[2];  
                          lgcl_Data = DataFormat.setData(lDB_ClientiSpeCom.getDATE_DATA_INS(), StaticContext.FORMATO_DATA);
                          larr_PeriodiRif[0] = Misc.nh(DataFormat.getMeseInLettere(lgcl_Data)) + " - " +Integer.toString(lgcl_Data.get(GregorianCalendar.YEAR));
                          larr_PeriodiRif[1] = Misc.addZero(Integer.toString(lgcl_Data.get(GregorianCalendar.MONTH) +1)) + Integer.toString(lgcl_Data.get(GregorianCalendar.YEAR));
                          lgcl_Data = DataFormat.setData(lDB_ClientiSpeCom.getDATE_DATA_OR(), StaticContext.FORMATO_DATA);
                          larr_PeriodiRif[1] += '-' + Misc.addZero(Integer.toString(lgcl_Data.get(GregorianCalendar.MONTH) +1)) + Integer.toString(lgcl_Data.get(GregorianCalendar.YEAR));
                          lvct_Return.addElement((Object)larr_PeriodiRif);
                        }
                        lstr_AppoDataIns = lDB_ClientiSpeCom.getDATE_DATA_INS();
                    }
                }
            }
        }

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPeriodiRiferimento",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}




// lancioBatchTLD
public String lancioBatchTLD (String pstr_CodeTipoContratto,
                            String pstr_CodeUtente,
                            String pstr_MeseRiferimento,
                            String pstr_AnnoRiferimento,
                            String pstr_FlagScelta)
    throws CustomException, RemoteException
{
    try
    {
      String lstr_Error = "";
      DB_Account ldb_Account = null;
      Object homeObject = null;
      Context lcls_Contesto = null;
      Ent_Batch lEnt_Batch = null;
      Ent_BatchHome lEnt_BatchHome = null;

      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_Batch
      homeObject = lcls_Contesto.lookup("Ent_Batch");
      lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
      lEnt_Batch = lEnt_BatchHome.create();

      if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      {
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
      }
      else
      {
        String lstr_Batch = StaticContext.RIBES_AUTOMATISMO_TLD +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_MeseRiferimento +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_AnnoRiferimento +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeTipoContratto +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_FlagScelta;
                                    
        if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
          lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
        else
          lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
          
      return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"lancioBatchTLD",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
}


}