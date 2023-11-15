package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

import com.utl.*;

public interface OggFattBMP extends EJBObject 
{
public String getCodeOggFatt()  throws RemoteException;

public void setCodeOggFatt(String codeOggFatt)  throws RemoteException;

public String getDescOggFatt()  throws RemoteException;

public void setDescOggFatt(String descOggFatt)  throws RemoteException;

public String getDataIni()  throws RemoteException;

public void setDataIni(String dataIni)  throws RemoteException;

public String getCodeCOf()  throws RemoteException;

public void setCodeCOf(String codeCOf)  throws RemoteException;

public String getDescClasseOf() throws RemoteException;

public String getTipoFlgAssocB()  throws RemoteException;

public void setTipoFlgAssocB(String tipoFlgAssocB)  throws RemoteException;

public String getDataFine()  throws RemoteException;

public void setDataFine(String dataFine)  throws RemoteException;

public boolean isDisattivabile() throws RemoteException, CustomEJBException;

public boolean isAssOfPs() throws RemoteException, CustomEJBException;

/*
public String getCodeTipoContr()  throws RemoteException;

public void setCodeTipoContr(String codeTipoContr)  throws RemoteException;
*/

}