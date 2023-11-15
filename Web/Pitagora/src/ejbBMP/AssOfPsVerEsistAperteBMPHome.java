package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

public interface AssOfPsVerEsistAperteBMPHome extends EJBHome 
{
  AssOfPsVerEsistAperteBMP create() throws RemoteException, CreateException;

  AssOfPsVerEsistAperteBMP findByPrimaryKey(AssOfPsVerEsistAperteBMPPK primaryKey) throws RemoteException, FinderException;
  AssOfPsVerEsistAperteBMP findNumAss(String cod_contratto, String cod_of, String cod_ps) throws FinderException, RemoteException;
}