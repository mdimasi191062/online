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


public class Ctr_ClassiScontoBean implements SessionBean 
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


// insParamClasSconto
public String insParamClasSconto (Vector pvct_ParamClasSconto)
    throws CustomException, RemoteException
{
    String lstr_Error = "";
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_ClassiSconto lent_ClassiSconto = null;
    Ent_ClassiScontoHome lent_ClassiScontoHome = null;

    try 
    {
        if (pvct_ParamClasSconto != null && pvct_ParamClasSconto.size() > 0)
        {
            // Acquisisco il contesto del componente
            lcls_Contesto = new InitialContext();

            // Istanzio una classe Ent_Tariffe
            homeObject = lcls_Contesto.lookup("Ent_ClassiSconto");
            lent_ClassiScontoHome = (Ent_ClassiScontoHome)PortableRemoteObject.narrow(homeObject, Ent_ClassiScontoHome.class);
            lent_ClassiSconto = lent_ClassiScontoHome.create();

            DB_ClasseSconto ldb_ParamClasSconto;
            for (int i=0; i<pvct_ParamClasSconto.size(); i++)
            {
                ldb_ParamClasSconto = (DB_ClasseSconto)pvct_ParamClasSconto.get(i);
                lent_ClassiSconto.insParamClasSconto(StaticContext.INSERT,
                                                        ldb_ParamClasSconto);
            }
        }
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insParamClasSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lstr_Error;
}


// getAccountSpeComNoCong
public Vector getClassiScontoCalPar (String pstr_CodeTipoContratto,
                                            Vector pvct_AccountSelezionati)
    throws CustomException, RemoteException
{
    Vector lvct_Return = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_ClassiSconto lEnt_ClassiSconto = null;
    Ent_ClassiScontoHome lEnt_ClassiScontoHome = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;

    try 
    {
        if (pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
        {
            // Acquisisco il contesto del componente
            lcls_Contesto = new InitialContext();

            // Istanzio una classe Ent_ClassiSconto
            homeObject = lcls_Contesto.lookup("Ent_ClassiSconto");
            lEnt_ClassiScontoHome = (Ent_ClassiScontoHome)PortableRemoteObject.narrow(homeObject, Ent_ClassiScontoHome.class);
            lEnt_ClassiSconto = lEnt_ClassiScontoHome.create();

            // Istanzio una classe Ent_Contratti
            homeObject = lcls_Contesto.lookup("Ent_Contratti");
            lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
            lEnt_Contratti = lEnt_ContrattiHome.create();
            //estraggo le date del periodo param classe di sconto
            DB_Account lDB_Account = (DB_Account)lEnt_Contratti.getPeriodoParamClasSconto().elementAt(0);
            
            for (int i=0; i<pvct_AccountSelezionati.size(); i++)
            {
                Vector lvct_ClasSconFound = lEnt_ClassiSconto.getClassiScontoCalPar(StaticContext.LIST,
                                                   ((DB_ClasseSconto)pvct_AccountSelezionati.get(i)).getIMPT_MAX_SPESA(),
                                                   ((DB_ClasseSconto)pvct_AccountSelezionati.get(i)).getCODE_GEST(),
                                                   lDB_Account.getDATA_MM_RIF_SPESA_COMPL(),
                                                   lDB_Account.getDATA_AA_RIF_SPESA_COMPL());
                if (lvct_ClasSconFound != null && lvct_ClasSconFound.size() > 0)
                {
                    for (int j=0; j<lvct_ClasSconFound.size(); j++)
                        lvct_Return.add((Object)lvct_ClasSconFound.get(j));
                }
            }
        }

        return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassiScontoCalPar",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

}