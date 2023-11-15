package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_PromoProgetto extends EJBObject{
    
    public Vector getCodeProgettoAccount(String codeAccount, String codeProgetto, String codeServizio) throws CustomException, RemoteException; 
    public Vector getCodeProgettoAccountNew(String codeAccount, String codeProgetto, String codeServizio, String codePromozione) throws CustomException, RemoteException; 
    public Vector getServizi() throws CustomException, RemoteException;
    public Vector getPromozioni() throws CustomException, RemoteException;
    public Vector getAccountByCodeTipoContr(String codeTipoContr) throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> insertPromozioneProgetto(String codeAccount,String codeProgetto)throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> insertPromozioneProgettoNew(String codeAccount,String codeProgetto,String codePromozione, String dataIni, String dataFin)throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> eliminaPromozioneProgetto(String codeAccount,String codeProgetto)throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> eliminaPromozioneProgettoNew(String codeAccount,String codeProgetto,String codePromozione)throws CustomException, RemoteException;
}
