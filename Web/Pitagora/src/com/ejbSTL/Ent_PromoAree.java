package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_PromoAree extends EJBObject{
    
    public Vector getAreeRaccoltaAccount(String codeAccount, String codeAreaRaccolta) throws CustomException, RemoteException;
    public Vector getServizi() throws CustomException, RemoteException;
    public Vector getAreeRaccolta() throws CustomException, RemoteException;
    public Vector getAccountByCodeTipoContr(String codeTipoContr) throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> insertAreaRaccoltaAccount(String codeUtente,String codeArea)throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> eliminaAreaRaccoltaAccount(String codeUtente,String codeArea)throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> insertAllAreaRaccoltaAccount(String codeUtente)throws CustomException, RemoteException;

}
