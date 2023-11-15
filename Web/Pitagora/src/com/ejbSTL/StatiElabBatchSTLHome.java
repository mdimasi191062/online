package com.ejbSTL;

import com.utl.CustomException;

import javax.ejb.EJBHome;
import java.rmi.*;

import java.util.Vector;

import javax.ejb.*;
import javax.ejb.CreateException;

public interface StatiElabBatchSTLHome extends EJBHome 
{
  StatiElabBatchSTL create() throws RemoteException, CreateException;
  
}