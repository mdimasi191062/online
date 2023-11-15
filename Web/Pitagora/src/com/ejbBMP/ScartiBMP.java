package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface ScartiBMP extends EJBObject 
{
  public String getTipo()  throws RemoteException;
  public void setTipo(String tipo)  throws RemoteException;
  public String getMotivo()  throws RemoteException;
  public void setMotivo(String motivo)  throws RemoteException;
  public String getOggetto()  throws RemoteException;
  public void setOggetto(String oggetto)  throws RemoteException;
  public String getCodice()  throws RemoteException;
  public void setCodice(String codice)  throws RemoteException;
 }