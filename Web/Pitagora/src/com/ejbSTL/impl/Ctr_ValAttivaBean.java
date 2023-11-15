package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
import com.ejbSTL.*;

public class Ctr_ValAttivaBean extends AbstractClassicEJB implements SessionBean 
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


// congela
public String congela (String pstr_CodeTipoContratto,
                            String pstr_CodeUtente,
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

            String lstr_Batch = StaticContext.RIBES_CONG_BATCH_VAL_ATTIVA +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size()
                            && lstr_Error.equalsIgnoreCase(""); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);
                if (ldb_Account.getDATA_INIZIO_CICLO_FATRZ().equalsIgnoreCase("")
                    || ldb_Account.getDATA_FINE_CICLO_FATRZ().equalsIgnoreCase("")){
                    lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_ACCOUNT_NON_GEST);
                }

                lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI + ldb_Account.getCODE_PARAM();
            } // Fine for. Per ogni elemento contenuto nel vettore passato in input...

            if (lstr_Error.equalsIgnoreCase(""))
			{
				if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
					lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
				else
					lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
			}
        }
        else
            lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_IMPOSS_ELAB);
        
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

// LancioBatch
public String LancioBatch (Vector pvct_AccountSelezionati,
								String pstr_TipoContratto,     
								String pstr_DataFinePeriodo,
								String pstr_CodeCicloFatrz,
								String pstr_IstanzaCicloFatrz,
								String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ctr_Contratti lCtr_Contratti = null;
	Ctr_ContrattiHome lCtr_ContrattiHome = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
		{
			// Acquisisco il contesto del componente
			lcls_Contesto = new InitialContext();

			// Istanzio una classe Ctr_Contratti
			homeObject = lcls_Contesto.lookup("Ctr_Contratti");
			lCtr_ContrattiHome = (Ctr_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ctr_ContrattiHome.class);
			lCtr_Contratti = lCtr_ContrattiHome.create();

			// Istanzio una classe Ent_Batch
			homeObject = lcls_Contesto.lookup("Ent_Batch");
			lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
			lEnt_Batch = lEnt_BatchHome.create();

			// Acquisisco dati degli "Account" selezionati per la valorizzazione attiva
			Vector lvct_AccountTrovati = null;
			lvct_AccountTrovati = lCtr_Contratti.getAccountValAttiva(pvct_AccountSelezionati,
																		pstr_TipoContratto,
																		pstr_CodeCicloFatrz,
																		pstr_IstanzaCicloFatrz);
			if ( lvct_AccountTrovati != null && lvct_AccountTrovati.size() > 0 )
			{
				String lstr_Batch = StaticContext.RIBES_INFR_BATCH_VAL_ATTIVA +
								  StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
								  StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

				String lstr_DataFinePeriodo = DataFormat.convertiData(DataFormat.setData(pstr_DataFinePeriodo,
																							"dd/mm/yyyy"),
																		"yyyymmdd");

				DB_Account lDB_AccountSelezionato = null;
				String lstr_Param="";
				for (int i=0; i<lvct_AccountTrovati.size() && lstr_Error.equalsIgnoreCase(""); i++)
				{
					lDB_AccountSelezionato = (DB_Account)lvct_AccountTrovati.get(i);
					lstr_Param = lstr_DataFinePeriodo + lDB_AccountSelezionato.getCODE_PARAM();
					lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI + lstr_Param;
				}

				if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
					lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
				else
					lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
			}
			else
				lstr_Error = "Nessun dato dagli account selezionati.";
		}
		else
			lstr_Error = "Nessun account selezionato.";

		return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

}