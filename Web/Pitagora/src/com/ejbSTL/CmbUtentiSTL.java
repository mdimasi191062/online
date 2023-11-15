package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface CmbUtentiSTL extends EJBObject 
{
  public Vector getUtenti() throws RemoteException, CustomException;
}