package com.ejbSTL;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;
import javax.ejb.FinderException;

public interface SelectGestore extends EJBObject
{
    public Vector findGest( String codGest, String codAccount, String descAccount ) throws FinderException, RemoteException,CustomException;
    public Vector findGest_cla( String codGest, String codAccount, String descAccount ) throws FinderException, RemoteException,CustomException;

}
