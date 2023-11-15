package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface DoppioListinoBMPHome extends EJBHome 
{
  DoppioListinoBMP create() throws RemoteException, CreateException;
  DoppioListinoBMP findNrgListiniSP(String Account) throws RemoteException, FinderException;
  DoppioListinoBMP findNrgListiniXDSL(String Account) throws RemoteException, FinderException;
  DoppioListinoBMP findByPrimaryKey(DoppioListinoBMPPK primaryKey) throws RemoteException, FinderException;
  Collection findAccountLstSP(String CodeElab) throws RemoteException, FinderException;
  Collection findAccountLstXDSL(String CodeElab) throws RemoteException, FinderException;
  DoppioListinoBMP findCodeParam(String Account) throws RemoteException, FinderException;
  DoppioListinoBMP findCodeParamNC(String Account,String CodeBatch) throws RemoteException, FinderException;
  Collection findAccountLstNC(String CodeElab) throws RemoteException, FinderException;
  Collection findAccountLstXDSLNC(String CodeElab) throws RemoteException, FinderException;
  Collection findAccountLstRPC(String CodeElab) throws RemoteException, FinderException;

}
