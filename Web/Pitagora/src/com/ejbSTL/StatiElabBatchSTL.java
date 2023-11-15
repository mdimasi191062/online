package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

import javax.ejb.FinderException;

public interface StatiElabBatchSTL extends EJBObject 
{
  public Vector getStatiElabBatch(String codiceFunzione, String codiceStatoBatch, String codiceUtente, String data_da, String data_a) throws RemoteException, CustomException;
  public Vector getStatiElabBatchImportFile(String codiceFunzione, String codiceStatoBatch, String codiceUtente, String data_da, String data_a) throws RemoteException, CustomException;  
  public Vector getElencoScartiImportFile(String codiceElab) throws RemoteException, CustomException;
  public Vector getElencoSftpEstrazioni(String codiceElab) throws RemoteException, CustomException;
  public Vector findLstFilesManuali(String[] account) throws RemoteException, FinderException;
  
}