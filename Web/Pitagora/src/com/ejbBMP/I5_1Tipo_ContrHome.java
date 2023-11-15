package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;

public interface I5_1Tipo_ContrHome extends EJBHome 
{
  I5_1Tipo_Contr create() throws RemoteException, CreateException;

  I5_1Tipo_Contr findByPrimaryKey(I5_1Tipo_ContrPK primaryKey) throws RemoteException, FinderException;

  public Collection findAll(int bSelezione) throws FinderException, RemoteException;
}