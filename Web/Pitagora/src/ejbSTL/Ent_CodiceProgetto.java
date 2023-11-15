package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_CodiceProgetto extends EJBObject{
    
    public Vector getCodeProgettoTable(int codeServizioLogico, String codeProgetto, int codeAccount) throws CustomException, RemoteException;
    public Vector getServiziLogici() throws CustomException, RemoteException;
    public Vector getAccountByCodeServizioLogico(String codeServizioLogico) throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> insertCodiceProgetto( int codeServizioLogico, int codeAccount, int tipologia, String codeProgetto, String dataDiRiferimento )throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> eliminaCodiceProgetto( String codeProgetto )throws CustomException, RemoteException;
    public Vector getAnagraficaTipologia() throws CustomException, RemoteException;
}
