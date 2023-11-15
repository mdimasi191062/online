package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.CustomException;

public interface I5_2Elab_BatchHome extends EJBHome 
{
  public I5_2Elab_Batch create() throws RemoteException, CreateException;

  public I5_2Elab_Batch findByPrimaryKey(I5_2Elab_BatchPK primaryKey) throws RemoteException, FinderException;

  public Collection findAll_CPM(Date DataInizioCiclo,Date DataFineCiclo) throws FinderException, RemoteException,CustomException;

  public Collection findAllSar(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException;

  public Collection findAll(String FiltroCODE_TIPO_CONTR) throws FinderException, RemoteException,CustomException;
}