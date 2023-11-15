package com.ejbSTL;
import javax.ejb.EJBHome;
import com.ejbSTL.LISTA_VERIFICA_ACCOUNT_CPM_CL;
import java.rmi.RemoteException;
import javax.ejb.CreateException; 

public interface LISTA_VERIFICA_ACCOUNT_CPM_CLHome extends EJBHome 
{
  LISTA_VERIFICA_ACCOUNT_CPM_CL create() throws RemoteException, CreateException;
}