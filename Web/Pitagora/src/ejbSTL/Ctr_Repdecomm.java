package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Repdecomm extends EJBObject 
{
  public Vector getlistaFile() throws CustomException, RemoteException;  
  public Vector getlistaOAO() throws CustomException, RemoteException;  
  public Vector getlistaFileByFilter(String strlistaOAO,String istatComune) throws CustomException, RemoteException;    
}