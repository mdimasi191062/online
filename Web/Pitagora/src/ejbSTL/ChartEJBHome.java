package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ChartEJBHome extends EJBHome  {
    ChartEJB create() throws RemoteException, CreateException;
}