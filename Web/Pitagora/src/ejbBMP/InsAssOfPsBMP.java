package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;


public interface InsAssOfPsBMP extends EJBObject 
{
  public void setDataIni(String dataIni) throws RemoteException;
  public String getDataIni() throws RemoteException;
  public void setDataFine(String dataFine) throws RemoteException;
  public String getDataFine() throws RemoteException;
  public void setDataIniOf(String dataIniOf) throws RemoteException;
  public String getDataIniOf() throws RemoteException;
  public void setDataIniValidMin(String dataIniOf) throws RemoteException;
  public String getDataIniValidMin() throws RemoteException;
  public void setDataFineValidMax(String dataFineOf) throws RemoteException;
  public String getDataFineValidMax() throws RemoteException;

}