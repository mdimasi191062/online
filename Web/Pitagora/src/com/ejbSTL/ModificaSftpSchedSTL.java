package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.*;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;

public interface ModificaSftpSchedSTL extends EJBObject 
{
  public int modifica(String azione,String idMessag,String dataSched)throws CustomException, RemoteException;
}