package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface CmbFunzioniSTL extends EJBObject 
{
public Vector getFunzioni() throws RemoteException, CustomException;

public Vector getFunzioniUpload() throws RemoteException, CustomException;

}