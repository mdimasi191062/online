package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface AssOfPsBMPClus extends EJBObject 
{

public String getCodePs()  throws RemoteException;

public void setCodePs(String codePs)  throws RemoteException;

public String getDescPs()  throws RemoteException;

public void setDescPs(String descPs)  throws RemoteException;

public String getDataIniPs()  throws RemoteException;

public void setDataIniPs(String dataIniPs)  throws RemoteException;

public String getDataFinePs()  throws RemoteException;

public void setDataFinePs(String dataFinePs)  throws RemoteException;

public String getCodeTipo()  throws RemoteException;

public void setCodeTipo(String codeTipo)  throws RemoteException;

public String getDescTipo()  throws RemoteException;

public void setDescTipo(String descTipo)  throws RemoteException;

public String getCodeOf()  throws RemoteException;

public void setCodeOf(String codeOf)  throws RemoteException;

public String getDescOf()  throws RemoteException;

public void setDescOf(String descOf)  throws RemoteException;

public String getDataIniOf()  throws RemoteException;

public void setDataIniOf(String dataIniOf)  throws RemoteException;

public String getCodeCOf()  throws RemoteException;

public void setCodeCOf(String codeCOf)  throws RemoteException;

public String getDescCOf()  throws RemoteException;

public void setDescCOf(String descCOf)  throws RemoteException;

public String getDataIniAssOf()  throws RemoteException;

public void setDataIniAssOf(String dataIniAssOf)  throws RemoteException;

public String getDataFineAssOf()  throws RemoteException;

public void setDataFineAssOf(String dataFineAssOf)  throws RemoteException;

public String getCodeFreq()  throws RemoteException;

public void setCodeFreq(String codeFreq)  throws RemoteException;

public String getCodeModal()  throws RemoteException;

public void setCodeModal(String codeModal)  throws RemoteException;

public String getTipoFlgAssocB()  throws RemoteException;

public void setTipoFlgAssocB(String tipoFlgAssocB)  throws RemoteException;

public int getQntaShiftCanoni()  throws RemoteException;

public void setQntaShiftCanoni(int qntaShiftCanoni)  throws RemoteException;

public String getCodeTipoContr()  throws RemoteException;

public void setCodeTipoContr(String codeTipoContr)  throws RemoteException;

public String getTipoCluster()  throws RemoteException;

public void setTipoCluster(String tipoCluster)  throws RemoteException;

public String getCodeCluster()  throws RemoteException;

public void setCodeCluster(String codeCluster)  throws RemoteException;

//public String getDataIni()  throws RemoteException;
//public void setDataIni(String dataIni)  throws RemoteException;


}