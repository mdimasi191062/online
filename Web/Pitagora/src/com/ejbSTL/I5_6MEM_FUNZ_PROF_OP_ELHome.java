package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_6MEM_FUNZ_PROF_OP_ELHome extends EJBHome 
{
  I5_6MEM_FUNZ_PROF_OP_EL create() throws RemoteException, CreateException;
}