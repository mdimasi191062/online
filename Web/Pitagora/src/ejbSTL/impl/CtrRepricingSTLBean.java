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

public class CtrRepricingSTLBean extends AbstractClassicEJB implements SessionBean 
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

// lancioBatch ,,,,
public String lancioBatch (String pstr_CodeTipoContratto,
                            String pstr_CodeUtente,
                            Vector pvct_Account,
                            String code_funz,
                            String code_funz_batch)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    DB_Account ldb_Account = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    EntBatchSTL lEntBatchSTL = null;
    EntBatchSTLHome lEntBatchSTLHome = null;
    EntContrattiSTL lEntContrattiSTL = null;
    EntContrattiSTLHome lEntContrattiSTLHome = null;

        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        if (pvct_Account.size() > 0)
        {
            // Istanzio una classe EntBatchSTL
            homeObject = lcls_Contesto.lookup("EntBatchSTL");
            lEntBatchSTLHome = (EntBatchSTLHome)PortableRemoteObject.narrow(homeObject, EntBatchSTLHome.class);
            lEntBatchSTL = lEntBatchSTLHome.create();

            // Istanzio una classe EntContrattiSTL
            homeObject = lcls_Contesto.lookup("EntContrattiSTL");
            lEntContrattiSTLHome = (EntContrattiSTLHome)PortableRemoteObject.narrow(homeObject, EntContrattiSTLHome.class);
            lEntContrattiSTL = lEntContrattiSTLHome.create();

            String lstr_Batch = code_funz +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";
System.out.println("lstr_Batch  "+lstr_Batch);
            // Per ogni elemento contenuto nel vettore passato in input...
            // Controllo se esistono account non gestibili.
            for (int i=0; i<pvct_Account.size(); i++)
            {
                ldb_Account = (DB_Account)pvct_Account.get(i);

                // Verifico se per il codeAccount in questione esiste un record nella i5_2param_valoriz_sp
                // con dataCong uguale null. Se esiste ne utilizzo il codeParam altrimenti
                // ne inserisco uno e utilizzo il nuovo codeParam generato.
                String lstr_CodeParam = "";
                Vector lvct_CodeParam = lEntContrattiSTL.getAccountStatoProvvisorio(StaticContext.LIST,
                                                                            ldb_Account.getCODE_ACCOUNT(),
																			                                       "",
                                                                            pstr_CodeTipoContratto,
                                                                            code_funz_batch);
                if (lvct_CodeParam.size() == 0)
                {
                    ldb_Account.setTIPO_FLAG_ERR_BLOCC("N");
                    ldb_Account.setTIPO_FLAG_STATO_CONG("N");

                    lstr_CodeParam = lEntBatchSTL.insParamValoriz(StaticContext.INSERT,
                                                                   ldb_Account).toString();
                }
                else
                    lstr_CodeParam = ((DB_Account)lvct_CodeParam.get(0)).getCODE_PARAM();

                lstr_Batch += StaticContext.RIBES_SEPARATORE_PARAMETRI + lstr_CodeParam;
            } // Fine for. Per ogni elemento contenuto nel vettore passato in input...
System.out.println("lstr_Batch 2"+lstr_Batch);
			if (lEntBatchSTL.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
          lstr_Error = "Elaborazione batch avviata correttamente!"; //this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
			else
				lstr_Error = "Errore nel lancio della procedura batch.";//this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
        }
        else
            lstr_Error = "Elaborazione Batch non avviata per mancanza di Account validi!";//this.getErrorMessage(lcls_Contesto, StaticContext.ERR_IMPOSS_ELAB);
      
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


}