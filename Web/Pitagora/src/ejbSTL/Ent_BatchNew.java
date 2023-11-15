package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_BatchNew extends EJBObject 
{
  public boolean chkElabBatch (String strParCodeFunz) throws CustomException, RemoteException;
}