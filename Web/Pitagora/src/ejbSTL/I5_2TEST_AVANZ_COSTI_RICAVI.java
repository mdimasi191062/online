package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_2TEST_AVANZ_COSTI_RICAVI extends EJBObject 
{

  public java.util.Vector findAllPC(String CODE_TIPO_CONTR) throws RemoteException;

  public java.util.Vector findAll(String CODE_ELAB,String Flag_Sys) throws RemoteException;

  public String PresenzaAccount(String Code_account,String Flag_Sys,String Mese,String Anno) throws RemoteException;

  public void UpdateDate(String code_stato_avanz_ricavi_update) throws RemoteException;
}