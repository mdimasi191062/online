package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.*;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;

public interface ModApplSTL extends EJBObject 
{
 public Vector getLista() 
 throws CustomException, RemoteException;
}