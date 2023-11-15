package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.CustomException;

public interface I5_2ProcedureEmittentiHome extends EJBHome 
{
  public I5_2ProcedureEmittenti create() throws RemoteException, CreateException;

  public I5_2ProcedureEmittenti create(String newDESC_PROC_EMITT, String newDESC_VALO_PROC_EMITT) throws RemoteException, CreateException;

  public I5_2ProcedureEmittenti findByPrimaryKey(String primaryKey) throws RemoteException, FinderException;

  public Collection findAll() throws FinderException, RemoteException,CustomException;

  public Collection findAll(String FiltroDESC_VALO_PROC_EMITT) throws FinderException, RemoteException,CustomException;
}