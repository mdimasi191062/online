package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.CustomException;

public interface I5_2FASCIEHome extends EJBHome 
{
  public I5_2FASCIE create() throws RemoteException, CreateException;

  public I5_2FASCIE create(I5_2FASCIEPK newPrimaryKey,String newDataInizio, String txtDescrizioneIntervallo,String txtValoreMinimo, String txtValoreMassimo) throws RemoteException, CreateException;

  public I5_2FASCIE findByPrimaryKey(I5_2FASCIEPK primaryKey) throws RemoteException, FinderException;   
   
  public Collection findAll() throws FinderException, RemoteException,CustomException;

  public Collection findAll(String FiltroCODE_FASCIA) throws FinderException, RemoteException,CustomException;

  public Collection findAllByCodeFascia(String FiltroCODE_FASCIA) throws FinderException, RemoteException,CustomException;  

}