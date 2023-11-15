package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_2RECORD_SCARTATO_CL_ROW;
import com.utl.*;

public interface I5_2RECORD_SCARTATO_CL extends EJBObject 
{
  public java.util.Vector findAll(String Code_Account,String Flag_sys,String Code_elab) throws RemoteException,CustomException;

  public java.util.Vector findAll_CPM(String Code_Account,String Flag_sys,String Code_elab) throws RemoteException,CustomException;  
  
}