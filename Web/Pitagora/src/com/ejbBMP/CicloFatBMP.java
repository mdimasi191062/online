package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface CicloFatBMP extends EJBObject 
{
    public String getCodeCicloFat()  throws RemoteException;
    public void setCodeCicloFat(String codeCicloFat)  throws RemoteException;
    public String getDescCicloFat()  throws RemoteException;
    public void setDescCicloFat(String descCicloFat)  throws RemoteException;
}