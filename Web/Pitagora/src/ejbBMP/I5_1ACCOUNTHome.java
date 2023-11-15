package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.CustomException;

public interface I5_1ACCOUNTHome extends EJBHome 
{
  public I5_1ACCOUNT create() throws RemoteException, CreateException;

  public Collection findAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException;

  public Collection findAll_CPM(String FiltroCODE_TIPO_CONTR,java.util.Date DataInizale) throws FinderException, RemoteException,CustomException;

  public Collection findAll_CPM_anomali(String FiltroCODE_TIPO_CONTR,java.util.Date DataInizale) throws FinderException, RemoteException,CustomException;

  public Collection findAll_SAR(String FiltroCODE_TIPO_CONTR,String Anno,String Mese) throws FinderException, RemoteException,CustomException;

  public I5_1ACCOUNT findByPrimaryKey(I5_1ACCOUNTPK primaryKey) throws RemoteException, FinderException;
}