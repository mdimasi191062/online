package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import java.util.*;
import java.lang.*;
import com.utl.*;

public interface TariffaXContrBMPHome extends EJBHome 
{
  //TARIFFA_X_CONTR_DETTAGLIO
  TariffaXContrBMP findByPrimaryKey(TariffaXContrBMPPK primaryKey) throws RemoteException, FinderException;
  //TARIFFA_X_CONTR_AGGIORNA
//  void store() throws RemoteException;  
  //TARIFFA_X_CONTR_VER_DISATTIVA
  TariffaXContrBMP findTarXContrVerDisatt(String codTar, String progTar) throws FinderException, RemoteException;        
  //TARIFFA_X_CONTR_VER_PROVV
  TariffaXContrBMP findTarXContrVerProvv(String codTar, String progTar) throws FinderException, RemoteException;          
  //TARIFFA_X_CONTR_VER_ES_ATT
  TariffaXContrBMP findTarXContrVerEsAtt(String codPs, String codOf, String codContr) throws FinderException, RemoteException;    
  //TARIFFA_X_CONTR_MAX_DATA_FINE
  TariffaXContrBMP findTarXContrMaxDataFine(String codPs, String codOf, String codContr) throws FinderException, RemoteException;        
  //ASSOC_OFPS_X_CONTR_VER_DISATTIVA
  TariffaXContrBMP findAssocOfpsXContrDisat(String dataFineValAssOfPs, String codOf, String dataIniValOf, String dataIniValAssOfPs, String codPs, String codContr) throws FinderException, RemoteException;          
  //TARIFFA_X_CONTR_MAX_PRG 
  TariffaXContrBMP findMaxPrgTarXContr(String codTar) throws FinderException, RemoteException;
  //TARIFFA_X_CONTR_VER_ALM_1_PROV 
  TariffaXContrBMP findAlm1TarXContrProvv(String codTar) throws FinderException, RemoteException;
  //TARIFFA_X_CONTR_LEGGI_PROVV
  Collection findTarXContrLeggiProvv(String CodTar) throws FinderException, RemoteException;
  //TARIFFA_X_CONTR_INSERISCI
   TariffaXContrBMP create(String codContr, String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String tipoOpz) throws CreateException, RemoteException;
  //Metodo per il caricamento della lista di dettaglio
  //03-03-03Collection findDettaglio(String CodContr, String CodTar, String CodOf, String CausBill) throws FinderException, RemoteException;
  Collection findDettaglio(String CodContr, String CodTar, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException;
  //Metodo per il caricamento della lista su ListaTariffeXContrSp
  Collection findAll(String CodContr, String CodPs, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException;//03-03-03

  TariffaXContrBMP findNumTarXContr(String codTipoContr,String codeContr ,String codPs) throws FinderException, RemoteException;
  TariffaXContrBMP findCalcolaCodiceXContr() throws FinderException, RemoteException;
  TariffaXContrBMP findOfMaxDataIniOfPsXContr(String codeContr, String codOf, String codPs) throws FinderException, RemoteException;
  TariffaXContrBMP findTariffaXContrGestCanc(String codTar, String progTar) throws FinderException, RemoteException;
  TariffaXContrBMP findTariffaXContrGestDis(String codTar, String progTar, String dataFineTar, String codPs, String codOf, String dataIniValOf, String dataIniValAssOfPs) throws FinderException, RemoteException;
  TariffaXContrBMP findTariffaXContrAggConProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt, int inserimento) throws FinderException, RemoteException;  
  TariffaXContrBMP findTariffaXContrAggNoProvv(String codContr, String codTar, String progTar, String dataFineTarDigitata, String codUM, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String flgMat, String codTipoCaus, String codClSc, String prClSc, String codTipoOf, String dataIniTar, String dataFineTar, String descTar, Double impTar, String causFatt, String flgProvv, String codUt,String codTipoOpz) throws FinderException, RemoteException; //24-02-03

  //Metodo per il caricare la descrizione del Tipo Importo
  TariffaXContrBMP findUnitaMisuraDettXTarXContr(String codTar, String progTar) throws FinderException, RemoteException; //07/03/03

  //Metodi per l'aggiornamento della prima tariffa
  TariffaXContrBMP findTariffaUnicaXContr(String codContr,String codTar) throws  RemoteException, FinderException;
  TariffaXContrBMP findTariffaAggiornaUnicaProvvXContr(String codContr,String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException;
  TariffaXContrBMP findTariffaAggiornaUnicaXContr(String codContr,String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException;
  Collection findTariffa(String CodContr, String CodTar, String CodOf, String CausBill) throws FinderException, RemoteException;
    Collection findTariffaClus(String CodContr, String CodTar, String CodOf, String CausBill,String i_code_contr_listino, String i_code_cluster_listino, String i_tipo_cluster_listino) throws FinderException, RemoteException;
}