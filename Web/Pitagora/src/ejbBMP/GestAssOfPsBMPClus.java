package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface GestAssOfPsBMPClus extends EJBObject 
{
  public int getNumTariffe() throws RemoteException;

  public String getCodeOf() throws RemoteException;
  public void setCodeOf(String stringa) throws RemoteException;

  public String getDescOf() throws RemoteException;
  public void setDescOf(String stringa) throws RemoteException;

  public String getCodePs() throws RemoteException;
  public void setCodePs(String stringa) throws RemoteException;

  public String getDescPs() throws RemoteException;
  public void setDescPs(String stringa) throws RemoteException;

  public String getCodeCOf() throws RemoteException;
  public void setCodeCOf(String stringa) throws RemoteException;

  public String getDescCOf() throws RemoteException;
  public void setDescCOf(String stringa) throws RemoteException;

  public String getCodModalAppl() throws RemoteException;
  public void setCodModalAppl(String stringa) throws RemoteException;

  public String getDescModalAppl() throws RemoteException;
  public void setDescModalAppl(String stringa) throws RemoteException;

  public String getFlag() throws RemoteException;
  public void setFlag(String stringa) throws RemoteException;

  public String getCodFreq() throws RemoteException;
  public void setCodFreq(String stringa) throws RemoteException;

  public String getDescFreq() throws RemoteException;
  public void setDescFreq(String stringa) throws RemoteException;

  public String getDataMin() throws RemoteException;
  public void setDataMin(String stringa) throws RemoteException;

  public String getDataIni() throws RemoteException;
  public void setDataIni(String stringa) throws RemoteException;

  public String getDataIniOf() throws RemoteException;
  public void setDataIniOf(String stringa) throws RemoteException;

  public String getDataFineOfPs() throws RemoteException;
  public void setDataFineOfPs(String stringa) throws RemoteException;

  public String getDataFineOf() throws RemoteException;
  public void setDataFineOf(String stringa) throws RemoteException;

  public String getTipoCluster() throws RemoteException;  
  public void setTipoCluster(String stringa) throws RemoteException;

  public String getCodeCluster() throws RemoteException;
  public void setCodeCluster(String stringa) throws RemoteException;

  public String getCodeTipoContr()  throws RemoteException;
  public void setCodeTipoContr(String stringa) throws RemoteException;

}