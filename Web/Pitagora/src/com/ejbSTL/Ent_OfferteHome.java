package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_OfferteHome extends EJBHome 
{
  Ent_Offerte create() throws RemoteException, CreateException;
}