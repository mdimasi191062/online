package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.utl.CustomException;
public interface I5_1ACCOUNT extends EJBObject 
{
  public String getDesc_Account()  throws RemoteException;
  public void setDesc_Account(String newDesc_Account)  throws RemoteException;
  public int getControlloBatch()  throws RemoteException;
  public int getControlloBatch_CPM(java.util.Date DataInizale,java.util.Date DataFinale) throws RemoteException,CustomException; 

}