package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface UnitaMisuraSTL extends EJBObject 
{
  public Vector getUm() throws RemoteException, CustomException;
}
