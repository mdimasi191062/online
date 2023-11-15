package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_Intercompany extends EJBObject{
    
    public Vector<StoredProcedureResult> insertIntercompany( String codiceCliente, String denominazione )throws CustomException, RemoteException;
    public Vector<StoredProcedureResult> eliminaIntercompany( String codice )throws CustomException, RemoteException;
    public Vector getIntercompany() throws CustomException, RemoteException;
}
