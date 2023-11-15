package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;

public interface UnTerReteSTL extends EJBObject 
{
  public Vector getUTR() throws RemoteException;
}