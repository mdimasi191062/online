package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface ElaborBatchBMP extends EJBObject 
{
  public int getElabBatch()  throws RemoteException;
  public void setElabBatch(int numElab)  throws RemoteException;
  public int getElabUguali()  throws RemoteException;
  public void setElabUguali(int elabUguali)  throws RemoteException;
  public String getStato()  throws RemoteException;
  public void setStato(String stato)  throws RemoteException;
  public String getDataFine()  throws RemoteException;
  public void setDataFine(String dataFine)  throws RemoteException;
  public String getDataIni()  throws RemoteException;
  public void setDataIni(String dataIni)  throws RemoteException;
  public String getNPS()  throws RemoteException;
  public void setNPS(String nps)  throws RemoteException;
  public String getCodeElab()  throws RemoteException;
  public void setCodeElab(String codeElab)  throws RemoteException;
  public String getCodeStato()  throws RemoteException;
  public void setCodeStato(String codeStato)  throws RemoteException;
 }