package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import java.util.*;

public interface ISTATHome extends EJBHome 
{
  ISTAT create() throws RemoteException, CreateException;

}