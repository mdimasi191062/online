package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface AssOfPsVerifEsistBMP extends EJBObject 
{
  public String getCodeTipoContratto() throws RemoteException;
  public void setCodeTipoContratto(String stringa)  throws RemoteException;

  public String getCodeCOf() throws RemoteException;
  public void setCodeCOf(String codeCOf)  throws RemoteException;

  public String getCodePS() throws RemoteException;
  public void setCodePS(String codePS)  throws RemoteException;

  public int getNumOfPs() throws RemoteException;
  public void setNumOfPs(int numero)  throws RemoteException;
}