package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ProdottiServiziHome extends EJBHome 
{
  Ent_ProdottiServizi create() throws RemoteException, CreateException;
}