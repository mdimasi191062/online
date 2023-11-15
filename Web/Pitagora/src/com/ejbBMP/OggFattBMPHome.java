package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import com.utl.CustomEJBException;
import javax.ejb.*;
import java.util.Collection;

public interface OggFattBMPHome extends EJBHome 
{
  OggFattBMP create(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine) throws RemoteException, CreateException, CustomEJBException;
  OggFattBMP create(String dataIni, String codeCOf, String descrizione, String tipoFlgAssocB, String dataFine, String codeTipoContr) throws RemoteException, CreateException, CustomEJBException;
  OggFattBMP findByPrimaryKey(OggFattBMPPK primaryKey) throws FinderException, RemoteException, CustomEJBException;
  Collection findAll(String CodTipoContr, boolean solo_attivi) throws RemoteException,FinderException;
  Collection findAllCla(boolean solo_attivi) throws FinderException, RemoteException;
  Collection findOggFattTar(String cod_ps) throws FinderException, RemoteException;
  Collection findOggFatt(String cod_ps) throws FinderException, RemoteException;
  Collection findOggFattAssPs(String CodPs, String CodTipoContr) throws FinderException, RemoteException;
  Collection findOggFatt(String codContr, String cod_ps) throws FinderException, RemoteException;
  //Valeria inizio 02-09-02
  OggFattBMP findOggFattMaxDataIni(String codeOf) throws FinderException, RemoteException;
  //Valeria fine 02-09-02
  Collection findOggFattAssPsXContr(String CodTipoContr,String CodContr,String CodPs) throws FinderException, RemoteException;

  Collection findOFPSXTariffa(String CodPs, String CodTipoContr) throws FinderException, RemoteException;
  Collection findOFPSXContrXTariffa(String CodPs, String CodContr,String CodTipoContr) throws FinderException, RemoteException;
    Collection findOFPSXContrXTariffaClus(String CodPs, String CodContr,String CodTipoContr,String codeCluster, String tipoCluster) throws FinderException, RemoteException;

}