package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Batch extends EJBObject 
{
	// lancioBatch
	Integer lancioBatch (String pstr_Parametri)
		throws CustomException, RemoteException;

    // chkElabBatch
    Integer chkElabBatch (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;

    // chkElabBatchSpecial
    Integer chkElabBatchSpecial (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;

    // chkStatoElaborazioneBatch
    Integer chkStatoElaborazioneBatch (int pint_Funzionalita)
        throws CustomException, RemoteException;

    // getElabBatchXLancio
    Vector getElabBatchXLancio (int pint_OperazioneRichiesta,
                                              String pstr_TipoContratto,
                                              String pstr_CodeAccount,
                                              String pstr_CodeElab,
                                              String pstr_CodeGest)
        throws CustomException, RemoteException;

    // getElabBatchVerifica
    Vector getElabBatchVerifica (int pint_OperazioneRichiesta,
                                String pstr_TipoContratto,
                                String pstr_CodeFunz)
        throws CustomException, RemoteException;

    // getElabBatchVerificaSpeCom
    Vector getElabBatchVerificaSpeCom (int pint_OperazioneRichiesta,
                                     String pstr_CodeTipoContratto,
                                     String pstr_CodeFunz)
        throws CustomException, RemoteException;

    // insParamValoriz
    Integer insParamValoriz(int pint_OperazioneRichiesta, DB_Account pDB_Account )
        throws CustomException, RemoteException;

    // insParamValoriz
    Integer updParamValoriz(int pint_OperazioneRichiesta, DB_Account pDB_Account )
        throws CustomException, RemoteException;
        
    // getElabBatchXRunning
    Vector getElabBatchRunning (int pint_OperazioneRichiesta,
                               String pstr_CodeRibesAttivo,
                               String pstr_CodeRibesPassivo)
        throws CustomException, RemoteException;

    // getCodeParamXAccount
    String getCodeParamXAccount (int pint_OperazioneRichiesta,
                                                String pstr_CodeAccount,
                                                String pstr_CodeFunz)
        throws CustomException, RemoteException;

    // insElabBatch
    Integer insElabBatch(int pint_OperazioneRichiesta, DB_Batch pDB_Batch)
        throws CustomException, RemoteException;

    // getListaBatch
    Vector getListaBatch(int pint_Funzionalita, int pint_OperazioneRichiesta) 
        throws  RemoteException, CustomException, RemoteException;

    // getElabBatchVerificaProvisioning
    Vector getElabBatchVerificaProvisioning(int pint_Funzionalita, int pint_OperazioneRichiesta) 
        throws  RemoteException, CustomException, RemoteException;

    // chkI5_6SysParamXElabBatch
    Vector getI5_6SysParamValue(String pstr_ChiaveSysParam)
        throws  RemoteException, CustomException, RemoteException;

}