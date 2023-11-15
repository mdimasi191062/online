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

public class Ctr_NoteCreditoBean extends AbstractClassicEJB implements SessionBean 
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
                            String pstr_DataFinePeriodo,
                            Vector pvct_Account)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    DB_Account ldb_Account = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        if (pvct_Account.size() > 0)
        {
            // Istanzio una classe Ent_Contratti
            homeObject = lcls_Contesto.lookup("Ent_Contratti");
            lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
            lEnt_Contratti = lEnt_ContrattiHome.create();

			// Istanzio una classe Ent_Batch
			homeObject = lcls_Contesto.lookup("Ent_Batch");
			lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
			lEnt_Batch = lEnt_BatchHome.create();

            String lstr_Batch = StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size(); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);

                // Verifico se per il codeAccount in questione esiste un record nella i5_2param_valoriz_cl
                // con dataCong uguale null.
                String lstr_CodeParam = "";
                Vector lvct_CodeParam = lEnt_Contratti.getAccountStatoProvvisorio(StaticContext.LIST,
                                                                            ldb_Account.getCODE_ACCOUNT(),
																			"",
                                                                            pstr_CodeTipoContratto,
                                                                            StaticContext.RIBES_INFR_BATCH_NOTE_CREDITO);
                if (lvct_CodeParam.size() == 0)
                {
                    lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI
                                    + "I"
                                    + ldb_Account.getCODE_ACCOUNT()
                                    + StaticContext.RIBES_SEPARATORE1_PARAMETRI
                                    + pstr_DataFinePeriodo;
                }
                else
                {
                    lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI
                                    + "U"
                                    + ldb_Account.getCODE_ACCOUNT()
                                    + StaticContext.RIBES_SEPARATORE1_PARAMETRI
                                    + pstr_DataFinePeriodo;
                }
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

            String lstr_Batch = StaticContext.RIBES_CONG_BATCH_NOTE_CREDITO +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";

            // Per ogni elemento contenuto nel vettore passato in input...
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