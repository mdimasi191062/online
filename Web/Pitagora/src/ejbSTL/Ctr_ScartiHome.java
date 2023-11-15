package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import java.util.Vector;
import com.utl.*;
import javax.ejb.*;


public interface Ctr_ScartiHome extends EJBHome 
{
  Ctr_Scarti create() throws RemoteException, CreateException;
}