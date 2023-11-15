package com.ejbSTL;
import javax.ejb.EJBObject;

import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
public interface BatchSTL extends EJBObject 
{
 public BatchElem getCodeFunzFlag(String codeTipoContr,String codeTipoBatch, String codeFunzXRep, String flagSys)
 throws CustomException, RemoteException;

}