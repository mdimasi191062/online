package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_1Tipo_Contr extends EJBObject 
{
  public String getDesc_Tipo_Contr()  throws RemoteException;
  public void setDesc_Tipo_Contr(String newDesc_Tipo_Contr)  throws RemoteException;
}