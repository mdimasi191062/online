package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_6MEM_FUNZ_PROF_OP_EL_ROW;
import java.util.Vector;
import com.utl.*;

public interface I5_6MEM_FUNZ_PROF_OP_EL extends EJBObject 
{
  public Vector findAllAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws RemoteException,CustomException;
  public Vector findAllProfili() throws RemoteException,CustomException;
  public Vector findAllFunzioni() throws RemoteException,CustomException;
  public Vector findAllOperazioni() throws RemoteException,CustomException;
  public String modifyAssociazione(String oldCODE_PROF_UTENTE, 
                                String oldCODE_FUNZ, 
                                String oldCODE_OP_ELEM,
                                String newCODE_PROF_UTENTE, 
                                String newCODE_FUNZ, 
                                String newCODE_OP_ELEM) throws RemoteException , CustomException;
  public String insertAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws RemoteException,CustomException;
  public void removeAssociazione(String CODE_PROF_UTENTE, String CODE_FUNZ, String CODE_OP_ELEM) throws RemoteException,CustomException;
  

}