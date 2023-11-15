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

public class Ctr_RepricingBean extends AbstractClassicEJB implements SessionBean 
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
                            Vector pvct_Account)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    DB_Account ldb_Account = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        if (pvct_Account.size() > 0)
        {
            // Istanzio una classe Ent_Batch
            homeObject = lcls_Contesto.lookup("Ent_Batch");
            lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
            lEnt_Batch = lEnt_BatchHome.create();

            // Istanzio una classe Ent_Contratti
            homeObject = lcls_Contesto.lookup("Ent_Contratti");
            lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
            lEnt_Contratti = lEnt_ContrattiHome.create();

            String lstr_Batch = StaticContext.RIBES_INFR_BATCH_CAMBI_TARIFFA +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size(); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);

                // Verifico se per il codeAccount in questione esiste un record nella i5_2param_valoriz_cl
                // con dataCong uguale null. Se esiste ne utilizzo il codeParam altrimenti
                // ne inserisco uno e utilizzo il nuovo codeParam generato.
                String lstr_CodeParam = "";
                Vector lvct_CodeParam = lEnt_Contratti.getAccountStatoProvvisorio(StaticContext.LIST,
                                                                            ldb_Account.getCODE_ACCOUNT(),
																			"",
                                                                            pstr_CodeTipoContratto,
                                                                            StaticContext.RIBES_INFR_BATCH_CAMBI_TARIFFA);
                if (lvct_CodeParam.size() == 0)
                {
                    ldb_Account.setTIPO_FLAG_ERR_BLOCC("N");
                    ldb_Account.setTIPO_FLAG_STATO_CONG("N");

                    lstr_CodeParam = lEnt_Batch.insParamValoriz(StaticContext.INSERT,
                                                                   ldb_Account).toString();
                }
                else
                    lstr_CodeParam = ((DB_Account)lvct_CodeParam.get(0)).getCODE_PARAM();

                lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI + lstr_CodeParam;
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
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

		// Istanzio una classe Ent_Batch
		homeObject = lcls_Contesto.lookup("Ent_Batch");
		lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
		lEnt_Batch = lEnt_BatchHome.create();

        if (pvct_Account.size() > 0)
        {
            String lstr_Batch = StaticContext.RIBES_CONG_BATCH_CAMBI_TARIFFA +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size(); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);
                lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI + ldb_Account.getCODE_PARAM();
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
									"congela",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

}