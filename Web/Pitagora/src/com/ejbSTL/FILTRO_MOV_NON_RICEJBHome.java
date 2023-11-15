package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import java.util.*;

public interface FILTRO_MOV_NON_RICEJBHome extends EJBHome 
{
  FILTRO_MOV_NON_RICEJB create() throws RemoteException, CreateException;

}