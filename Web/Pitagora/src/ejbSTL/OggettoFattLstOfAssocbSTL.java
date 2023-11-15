package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface OggettoFattLstOfAssocbSTL extends EJBObject 
{
  public Vector getDesc(String codeTipoContratto, String codeCOf) throws RemoteException,CustomException;
}