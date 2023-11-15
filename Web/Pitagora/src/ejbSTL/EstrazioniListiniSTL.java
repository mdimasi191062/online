package com.ejbSTL;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface EstrazioniListiniSTL extends EJBObject
{
    void insertRisorse(Vector risorse) throws CustomException, RemoteException;
}
