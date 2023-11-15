package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import java.util.*;
import javax.ejb.*;
import com.utl.CustomException;

public interface ISTAT extends EJBObject 
{
  public Vector ElencoIndici(String sAnno) throws RemoteException,CustomException;
  public void AggTariffePerSito(String newANNO, Float newIndice_Istat, String pCode_Utente)  throws RemoteException, CreateException,CustomException;
  public void InsTabellaIstat(String newANNO, Float newIndice_Istat)  throws RemoteException, CreateException,CustomException;
  public int checkBatch() throws RemoteException,CustomException;
  public int checkTipoFlag(String pAnno) throws RemoteException,CustomException;
  public void RemoveIstat(String pAnno)throws RemoteException,CustomException; 
  public void RemoveTariffaXSito(String pAnno) throws RemoteException,CustomException;
}
