package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public interface Ent_Servizi extends EJBObject 
{
public Vector getServizi()throws CustomException, RemoteException;
public String getServiziXml()throws CustomException, RemoteException;

}