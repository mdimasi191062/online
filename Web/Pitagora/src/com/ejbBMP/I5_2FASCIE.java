package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.utl.CustomException;

public interface I5_2FASCIE extends EJBObject 
{
  public int AssociazioneTariffe()  throws RemoteException,CustomException;
  public String getDESC_FASCIA()  throws RemoteException;
  public void setDESC_FASCIA(String newDESC_FASCIA)  throws RemoteException;
  public int getVALO_LIM_MAX()  throws RemoteException;
  public void setVALO_LIM_MAX(int newVALO_LIM_MAX)  throws RemoteException;
  public int getVALO_LIM_MIN()  throws RemoteException;
  public void setVALO_LIM_MIN(int newVALO_LIM_MIN)  throws RemoteException;
  public java.util.Date getDATA_INIZIO_VALID()  throws RemoteException;
  public void setDATA_INIZIO_VALID(java.util.Date newDATA_INIZIO_VALID)  throws RemoteException;
}