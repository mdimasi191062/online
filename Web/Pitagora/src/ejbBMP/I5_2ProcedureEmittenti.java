package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_2ProcedureEmittenti extends EJBObject 
{

  public String getCODE_PROC_EMITT()  throws RemoteException;
  public void setCODE_PROC_EMITT(String newCODE_PROC_EMITT)  throws RemoteException;
  public String getDESC_PROC_EMITT()  throws RemoteException;
  public void setDESC_PROC_EMITT(String newDESC_PROC_EMITT)  throws RemoteException;
  public String getDESC_VALO_PROC_EMITT()  throws RemoteException;
  public void setDESC_VALO_PROC_EMITT(String newDESC_VALO_PROC_EMITT)  throws RemoteException;
  public java.util.Date getDATA_CREAZ()  throws RemoteException;
  public void setDATA_CREAZ(java.util.Date newDATA_CREAZ)  throws RemoteException;
  public Integer getCasiParticolari()  throws RemoteException;
}