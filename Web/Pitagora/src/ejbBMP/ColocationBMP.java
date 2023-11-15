package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface ColocationBMP extends EJBObject 
{
  public void setCodeAccount(String stringa)throws RemoteException;
 

  public String getCodeAccount()throws RemoteException;
  

  public void setDescAccount(String stringa)throws RemoteException;
  

  public String getDescAccount()throws RemoteException;
  
  
  public void setDataConsSito(String stringa)throws RemoteException;
  

  public String getDataConsSito()throws RemoteException;

  //public void setNumeroElab(int stringa)throws RemoteException;
  

  //public int getNumeroElab()throws RemoteException;



  public void setDataIniValAcc(String stringa)throws RemoteException;
  

  public String getDataIniValAcc()throws RemoteException;
  


  //metodi prova rosa
 public void setCode_utente(String stringa)throws RemoteException;
  

  public String getCode_utente()throws RemoteException;
  


  public void setSitoSelez(String stringa)throws RemoteException;
  

  public String getSitoSelez()throws RemoteException;
  


  public void setAccountSelez(String stringa)throws RemoteException;
  

  public String getAccountSelez()throws RemoteException;
  

  public void setData_ini(String stringa)throws RemoteException;
  

  public String getData_ini()throws RemoteException;
  
 

  public void setImptar(Double stringa)throws RemoteException;
  


  public Double getImptar()throws RemoteException;
  


  public void setImpcons(Double stringa)throws RemoteException;
  


  public Double getImpcons()throws RemoteException;
  
  

  //metodi prova rosa fine
  
  
  

}