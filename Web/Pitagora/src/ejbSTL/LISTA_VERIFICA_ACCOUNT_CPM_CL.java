package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW;
import java.util.Date;
import com.utl.*;

public interface LISTA_VERIFICA_ACCOUNT_CPM_CL extends EJBObject 
{
  public java.util.Vector findAll(String Code_elab,String Flag_sys,Date DataInizio,Date DataFine) throws RemoteException,CustomException;
}
