package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface SchedBatchSTL extends EJBObject 
{
  public Vector getSchedBatch(String codiceFunzione, String codiceStatoSched, String codiceUtente, String data_sched, String data_ins) throws RemoteException, CustomException;
  public ClassSchedBatchElem loadSched(String idSched) throws RemoteException, CustomException;
  public String deleteSched(String idSched) throws RemoteException,CustomException;
  public String updateSched(ClassSchedBatchElem el) throws RemoteException,CustomException;  
}