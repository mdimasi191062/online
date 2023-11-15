package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Scarti extends EJBObject 
{
  // updScarti
  String updScarti (Vector pvct_Scarti)
        throws CustomException, RemoteException;


}