package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.*;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;

public interface FunzionalitaSTL extends EJBObject 
{
 public Vector getOfs(String CodTipoContr, String sys) 
 throws CustomException, RemoteException;
}