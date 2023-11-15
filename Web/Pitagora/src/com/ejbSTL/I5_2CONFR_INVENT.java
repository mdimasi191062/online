package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_2CONFR_INVENT_ROW;
import com.utl.CustomException;

public interface I5_2CONFR_INVENT extends EJBObject 
{
  public java.util.Vector findAllByCode_elab(String Code_elab,String Flag_sys) throws RemoteException,CustomException;
}
