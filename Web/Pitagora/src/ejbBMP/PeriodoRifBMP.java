package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;

public interface PeriodoRifBMP extends EJBObject 
{
  public String getCode()  throws RemoteException;
  public void setCode(String code)  throws RemoteException;
  public String getDesc()  throws RemoteException;
  public void setDesc(String desc)  throws RemoteException;
//gianluca 09/092002-inizio-16.51
  public String getDataIniCiclo()  throws RemoteException;
  public void setDataIniCiclo(String desc)  throws RemoteException;
  public String getDataFineCiclo()  throws RemoteException;
  public void setDataFineCiclo(String desc)  throws RemoteException;
  public String getPeriodoFat()  throws RemoteException;
  public void setPeriodoFat(String desc)  throws RemoteException;
//gianluca 09/092002-fine-16.51  
}