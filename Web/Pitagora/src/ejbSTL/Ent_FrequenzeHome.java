package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_FrequenzeHome extends EJBHome 
{
  Ent_Frequenze create() throws RemoteException, CreateException;
}