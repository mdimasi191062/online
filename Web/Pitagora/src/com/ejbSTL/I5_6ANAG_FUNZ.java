package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.RemoteException;
import com.utl.*;
import com.ejbSTL.*;

public interface I5_6ANAG_FUNZ extends EJBObject 
{
  public Vector FindAll(String pCODE_FUNZ) throws  RemoteException,CustomException;
  public I5_6ANAG_FUNZ_ROW loadFunz(String primaryKey) throws  RemoteException,CustomException;
  public void updateFunz(String CODE_FUNZ, String newDESC_FUNZ, String newTIPO_FUNZ,String newFLAG_SYS) throws  RemoteException,CustomException;
  public String creaFunz(String newCODE_FUNZ, String newDESC_FUNZ, String newTIPO_FUNZ,String newFLAG_SYS)  throws RemoteException, CustomException;
  public String DeleteFunz(String codice) throws RemoteException,CustomException; 
}