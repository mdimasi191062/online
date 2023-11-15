package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_DownloadParam extends EJBObject 
{
  public DB_DownloadParam getDownloadParam(String codiceFunzione) throws  RemoteException,CustomException;

}
