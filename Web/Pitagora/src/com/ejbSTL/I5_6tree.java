package com.ejbSTL;
import java.util.Vector;
import java.rmi.RemoteException;
import javax.ejb.EJBObject;
import com.utl.CustomException;

public interface I5_6tree extends EJBObject 
{

	public Vector findAllTreeByProfile(String sProfile) throws CustomException,RemoteException;

}