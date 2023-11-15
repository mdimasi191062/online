package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;
public interface I5_2PARAM_VALORIZZA extends EJBObject 
{
  public String getCODE_PARAM()  throws RemoteException;
  public void setCODE_PARAM(String CODE_PARAM)  throws RemoteException;
  public String getDATA_CONCAT()  throws RemoteException;
  public void setDATA_CONCAT(String newDATA_CONCAT)  throws RemoteException;  
  public Float getVALO_EURIBOR()  throws RemoteException;
  public void setVALO_EURIBOR(Float newVALO_EURIBOR)  throws RemoteException;
  public java.util.Date getDATA_INIZIO_CICLO_FATRZ()  throws RemoteException;
  public void setDATA_INIZIO_CICLO_FATRZ(java.util.Date newDATA_INIZIO_CICLO_FATRZ)  throws RemoteException;
  public java.util.Date getDATA_FINE_CICLO_FATRZ()  throws RemoteException;
  public void setDATA_FINE_CICLO_FATRZ(java.util.Date newDATA_FINE_CICLO_FATRZ)  throws RemoteException;
  public Integer getControllaValid()  throws RemoteException;
  public int controllaIns(String CODE_PARAM)  throws RemoteException;
  public int controllaAgg(String CODE_PARAM)  throws RemoteException;  
  public int controllaElab()  throws RemoteException;  
}
