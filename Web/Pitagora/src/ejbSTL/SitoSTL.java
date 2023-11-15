package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface SitoSTL extends EJBObject 
{
   public Vector getSito(String CodUtr) throws RemoteException, CustomException;
   public SitoElem getDataImportoSito(String CodeSito,String CodeAccount) throws RemoteException, CustomException;
   public SitoElem getNumModuli(String CodeSito,String CodeAccount) throws RemoteException, CustomException;
   public SitoElem findTarXSito(String codesito,String codeaccount) throws RemoteException, CustomException;

}