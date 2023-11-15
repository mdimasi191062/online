package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface PeriodoRifBMPHome extends EJBHome 
{
  PeriodoRifBMP create() throws RemoteException, CreateException;
  PeriodoRifBMP findByPrimaryKey(PeriodoRifBMPPK primaryKey)   throws RemoteException, FinderException;
  Collection findValAttSpec1(String CodTipoContr)              throws FinderException, RemoteException;
  Collection findValAttClass(String CodTipoContr)              throws FinderException, RemoteException;
  Collection findAvanzRicClass(String CodTipoContr)            throws FinderException, RemoteException;
  Collection findNotaCreClass(String CodTipoContr)             throws FinderException, RemoteException;
  Collection findRepricClass(String CodTipoContr, String Funz) throws FinderException, RemoteException;
  Collection findNotaCreSpec1(String CodTipoContr)             throws FinderException, RemoteException;
  Collection findValAttSpec2(String CodTipoContr)              throws FinderException, RemoteException;
  Collection findRepSpec2(String CodTipoContr)              throws FinderException, RemoteException;
  Collection findNotaCreSpec2(String CodTipoContr)             throws FinderException, RemoteException;
  PeriodoRifBMP findPerCicloFat(String CodTipoContr,String CodCicloFat) throws FinderException, RemoteException;
  Collection findRepricing(String CodTipoContr, String Funz)   throws FinderException, RemoteException;
  Collection findFattMan(String CodTipoContr)              throws FinderException, RemoteException;
}