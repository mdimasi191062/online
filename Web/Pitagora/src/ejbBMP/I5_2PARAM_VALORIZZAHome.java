package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
public interface I5_2PARAM_VALORIZZAHome extends EJBHome 
{
  public I5_2PARAM_VALORIZZA create() throws RemoteException, CreateException;

  public I5_2PARAM_VALORIZZA create(String CODE_PARAM,String VALO_EURIBOR, String DATA_INIZIO_CICLO_FATRZ,String DATA_FINE_CICLO_FATRZ) throws RemoteException, CreateException;

  public I5_2PARAM_VALORIZZA findByPrimaryKey(String primaryKey) throws RemoteException, FinderException;   
   
  public Collection findAll(String DATA_INIZIO_CICLO_FATRZ,String DATA_FINE_CICLO_FATRZ) throws FinderException, RemoteException;

}