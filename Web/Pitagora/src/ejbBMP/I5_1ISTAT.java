package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_1ISTAT extends EJBObject 
{
  
  public void setIndice(Float indice) throws RemoteException;
  public String getAnno() throws RemoteException;
  public Float getIndice() throws RemoteException;


}