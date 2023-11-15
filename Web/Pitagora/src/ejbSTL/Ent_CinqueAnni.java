package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_CinqueAnni extends EJBObject {
    public Vector getServizi() throws CustomException, RemoteException;
    public Vector getAccountByCodeServizio(String codeServizio) throws CustomException, RemoteException;
    public Vector getRisorse() throws CustomException, RemoteException;
    public Vector getDataDa() throws CustomException, RemoteException;
    public Vector getWarningValori(String codeAccount, String dataDa, String risorsa) throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> updateCinqueAnni(String codeRiga,int status)throws CustomException, RemoteException;
}
