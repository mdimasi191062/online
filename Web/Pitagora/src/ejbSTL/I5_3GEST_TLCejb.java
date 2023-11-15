package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.*;
import com.utl.CustomException;

public interface I5_3GEST_TLCejb extends EJBObject 
{
  	public Vector findAllNorm(String ragionesociale) throws RemoteException,CustomException;
    public Vector findAllNuovi() throws RemoteException,CustomException;
    public I5_3GEST_TLC_ROW loadGestNorm(String codice) throws RemoteException,CustomException;
    public void updateGestNorm(I5_3GEST_TLC_ROW row) throws RemoteException,CustomException;
    public void associaNuovoGest(String CODE_GEST_ORIG, String FLAG_SYS, String CODE_GEST) throws RemoteException,CustomException;
    public int inserisciNuovoGest(String CODE_GEST_ORIG, String FLAG_SYS, String CODE_GEST) throws RemoteException,CustomException;
}