package com.ejbBMP;
import javax.ejb.EJBObject;
import javax.ejb.*;
import java.rmi.*;

import com.utl.*;

public interface AssOfPsXContrBMPClus extends EJBObject 
{
 public void disattiva(String dataFineOfPs) throws RemoteException,CustomEJBException; 

 public String getCodePs() throws RemoteException;
 
 public String getDescPs() throws RemoteException;
 
 public String getDataIni() throws RemoteException;
  
 public String getDataFine() throws RemoteException;
  
 public String getCodeOf() throws RemoteException;
   
 public String getDescOf() throws RemoteException;
  
 public String getDataIniOf() throws RemoteException;
 
 public String getDataFineOf() throws RemoteException;
 
 public String getCodeCOf() throws RemoteException;
 
 public String getDescCOf() throws RemoteException;
 
 public String getDataIniOfPs() throws RemoteException;
  
 public String getDataFineOfPs() throws RemoteException;
 
 public String getCodeFreq() throws RemoteException;
 
 public String getDescFreq() throws RemoteException;
 
 public String getCodeModal() throws RemoteException;
 
 public String getDescModal() throws RemoteException;
 
 public String getTipoFlgAP() throws RemoteException;
 
 public int getQntaShiftCanoni() throws RemoteException;
 
 public String getCodeTipoContr() throws RemoteException;
 
 public String getFlagSys() throws RemoteException;
 
 public String getCodeContr() throws RemoteException;
 
 public String getDescContr() throws RemoteException;
 
 public String getDataIniContr() throws RemoteException;

 public String getTipoCluster() throws RemoteException;  

 public String getCodeCluster() throws RemoteException;
 
}