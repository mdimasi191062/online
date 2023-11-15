package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;

public interface I5_3GEST_TLGHome extends EJBHome 
{
  public I5_3GEST_TLG create() throws RemoteException, CreateException;
  
  public I5_3GEST_TLG findByPrimaryKey(String primaryKey) throws RemoteException, FinderException;

  public Collection findAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException;
}