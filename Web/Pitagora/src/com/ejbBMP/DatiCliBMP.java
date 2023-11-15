package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface DatiCliBMP extends EJBObject 
{
  public String getAccount()  throws RemoteException;
  public void setAccount(String account)  throws RemoteException;

  public String getDesc()  throws RemoteException;
  public void setDesc(String desc)  throws RemoteException;

  public String getCodElabBatch()  throws RemoteException;
  public void setCodElabBatch(String codElabBatch)  throws RemoteException;
  
//Tommaso 0909
  public Integer getNumFattLisUn()  throws RemoteException;
  public void setNumFattLisUn(Integer NumFattLisUn)  throws RemoteException;
//fine Tommaso 0909

//gianluca-inizio-11/09/2002
  public String getDataIniPerFatt()  throws RemoteException;
  public void setDataIniPerFatt(String dataI)  throws RemoteException;
  public String getDataFinePerFatt()  throws RemoteException;
  public void setDataFinePerFatt(String dataF)  throws RemoteException;
  public String getCodeParam()  throws RemoteException;
  public void setCodeParam(String code_param)  throws RemoteException;
  public String getCodeDocFatt()  throws RemoteException;
  public void setCodeDocFatt(String code_doc_fatt)  throws RemoteException;
//gianluca-fine-11/09/2002
  public String getMaxDataFine()  throws RemoteException;
  public void setMaxDataFine(String dataF)  throws RemoteException;

}