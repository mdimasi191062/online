package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipoArrotondamentoHome extends EJBHome 
{
  Ent_TipoArrotondamento create() throws RemoteException, CreateException;
}

