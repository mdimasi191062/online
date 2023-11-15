package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Ent_TipiServizio extends EJBObject 
{
  
  Vector getTipiServiziAssurance() throws CustomException, RemoteException;
  
  Vector getTipiGestoreAssurance() throws CustomException, RemoteException;
  
  Vector getTipiServiziAssuranceXDSL() throws CustomException, RemoteException;

  Vector getTipiServiziAssuranceReg() throws CustomException, RemoteException;
}