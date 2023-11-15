package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface CmbStatiBatchSTL extends EJBObject 
{
  public Vector getStatiBatch() throws RemoteException, CustomException;
}