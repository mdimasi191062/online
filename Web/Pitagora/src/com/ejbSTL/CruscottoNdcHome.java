package com.ejbSTL;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.util.Collection;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

public interface CruscottoNdcHome extends EJBHome
{

 CruscottoNdc create() throws RemoteException, CreateException;

}
