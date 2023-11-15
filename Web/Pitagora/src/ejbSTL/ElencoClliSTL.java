package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface ElencoClliSTL extends EJBObject 
{
public Vector getAllCLLI(String lettera) throws RemoteException, CustomException;
public Vector getAllCLLIdaProg(String prog,String anno) throws RemoteException, CustomException;
public Vector getAnniEstrazione() throws RemoteException, CustomException;
public Vector getAnniEstrazioneTipoContr(String anno) throws RemoteException, CustomException;

}