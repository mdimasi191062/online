package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface CsvBMPHome extends EJBHome 
{
   CsvBMP create() throws RemoteException, CreateException;
   CsvBMP findCsvSP(String Account, String CicloIni) throws RemoteException, FinderException;
   CsvBMP findCsvXDSL(String Account, String CicloIni) throws RemoteException, FinderException;
   CsvBMP findCsvSPNC(String Account) throws RemoteException, FinderException;
   CsvBMP findCsvXDSLNC(String Account) throws RemoteException, FinderException;
   CsvBMP findAccountSenzaPS(String CodeElab, String Account) throws RemoteException, FinderException;
   CsvBMP findByPrimaryKey(CsvBMPPK primaryKey) throws RemoteException, FinderException;
   Collection findAccountLstSP(String CodeElab) throws RemoteException, FinderException;
   Collection findAccountLstXDSL(String CodeElab) throws RemoteException, FinderException;
   Collection findAccountLstNC(String CodeElab) throws RemoteException, FinderException;
   Collection findAccountLstXDSLNC(String CodeElab) throws RemoteException, FinderException;

}
