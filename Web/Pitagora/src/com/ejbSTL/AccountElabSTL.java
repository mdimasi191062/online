package com.ejbSTL;
import javax.ejb.EJBObject;

import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
public interface AccountElabSTL extends EJBObject 
{
 public Vector getLstAcc(String Code) throws CustomException, RemoteException;
 public Vector getLstAccReport(String Code) throws CustomException, RemoteException;
 public Vector getLstAccNC(String Code, String Contr) throws CustomException, RemoteException;
 public Vector getLstAccRepricing(String Code, String Contr,String Flag) throws CustomException, RemoteException;
 public Vector getLstAccRepricingSpecial(String TipoContr) throws CustomException, RemoteException;
 public Vector getLstAccXCongRepricing(String CodeElab) throws CustomException, RemoteException;
 public boolean controllaAccountRepricing(String CodeTipoContr) throws CustomException, RemoteException;
 public Vector getLstServiziDaCongelare(String tipo_batch) throws CustomException, RemoteException;
 public Vector getLstServiziResocontoSap(String tipo_sistema) throws CustomException, RemoteException;
 public Vector getLstAccCongSpecial(String TipoContr) throws CustomException, RemoteException;
 public Vector getLstAccLanCongSpecial(String TipoContr) throws CustomException, RemoteException;
}