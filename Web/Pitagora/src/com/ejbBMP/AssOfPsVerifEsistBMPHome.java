package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

public interface AssOfPsVerifEsistBMPHome extends EJBHome 
{
  AssOfPsVerifEsistBMP create() throws RemoteException, CreateException;
  AssOfPsVerifEsistBMP findByPrimaryKey(AssOfPsVerifEsistBMPPK primaryKey) throws RemoteException, FinderException;
  AssOfPsVerifEsistBMP findNumOfPs(String cod_contratto, String cod_of, String cod_ps) throws FinderException, RemoteException;
}
