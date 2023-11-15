package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import java.util.*;
import java.lang.*;
import com.utl.*;


public interface TariffaBMPHome extends EJBHome
{
  //Emma TariffaBMP create(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt) throws RemoteException, CreateException;
  TariffaBMP create(String codTar, String progTar, String codUM, String codUt, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String dataIniTar, String dataFineTar, String descTar, Double impTar, String flgMat, String codClSc, String prClSc, String causFatt,String tipoOpz) throws RemoteException, CreateException;//Emma
  TariffaBMP findByPrimaryKey(TariffaBMPPK primaryKey) throws RemoteException, FinderException;
  Collection findListDest(String codTipoContr) throws FinderException, RemoteException;
  Collection findTariffaUnicoXRib(String codTipoContr) throws FinderException, RemoteException;
  Collection findTariffaPersXRib(String codContr, String codTipoContr) throws FinderException, RemoteException;
  TariffaBMP create(String codContr, String contrDest, String codUt, String codOf, String codPs, String codTipoCaus, Integer flgCommit) throws RemoteException, CreateException;
  TariffaBMP findMaxPrgTariffa(String codTar) throws  RemoteException, FinderException; //throws FinderException, RemoteException; //Valeria inizio 02-09-02
  TariffaBMP findAlmeno1TariffaProvv(String codTar) throws  RemoteException, FinderException; //throws FinderException, RemoteException; //Valeria inizio 02-09-02
  Collection findTariffeProvv(String CodTar) throws  RemoteException, FinderException; //throws FinderException, RemoteException; //Valeria inizio 02-09-02
  Collection findListini(String codTipoContr) throws FinderException, RemoteException;
  Collection findTariffaListinoPers(String codContr, String codTipoContr, String Storico) throws FinderException, RemoteException;
  Collection findTariffaListinoUnico(String codTipoContr, String Storico) throws FinderException, RemoteException;
  TariffaBMP findUnitaMisuraDettXTar(String codTar, String progTar) throws FinderException, RemoteException;
  TariffaBMP findCausFattLeggiDett(String codTipoCaus) throws FinderException, RemoteException;
  TariffaBMP findTariffaVerEsAttive(String codPs, String codOf) throws FinderException, RemoteException;
  TariffaBMP findTariffaMaxDataFine(String codPs, String codOf) throws FinderException, RemoteException;
  TariffaBMP findAssocOfpsDisattiva(String dataFineValAssOfPs, String codOf, String dataIniValOf, String dataIniValAssOfPs,String codPs) throws FinderException, RemoteException;
  TariffaBMP findElabBatchInCorsoFatt() throws FinderException, RemoteException;
  TariffaBMP findTariffaVerDisattiva(String codTar, String progTar) throws FinderException, RemoteException;
  TariffaBMP findTariffaVerProvv(String codTar, String progTar) throws FinderException, RemoteException;
  TariffaBMP findCalcolaCodice() throws FinderException, RemoteException;
  TariffaBMP findOfMaxDataIniOfPs(String codOf, String codPs) throws FinderException, RemoteException;
  TariffaBMP findOfMaxDataIniOf(String codOf) throws FinderException, RemoteException;
  TariffaBMP findNumTar(String codTipoContr, String codPs) throws FinderException, RemoteException;
  TariffaBMP findTariffaGestCancella(String codTar, String progTar) throws FinderException, RemoteException;
  TariffaBMP findTariffaGestDisattiva(String codTar, String progTar, String dataFineTar, String codPs, String codOf, String dataIniValOf, String dataIniValAssOfPs) throws FinderException, RemoteException;
  TariffaBMP findTariffaAggiornaConProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt, int inserimento) throws FinderException, RemoteException;
  //boolean findTariffaAggiornaConProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException;
  TariffaBMP findTariffaAggiornaSenzaProvv(String codTar, String codProgTar, String dataFineTarDigitata, String codUM, String dataIniValAssOfPs, String codOf, String dataIniValOf, String codPs, String flgMat, String codTipoCaus, String codClSc, String prClSc, String codTipoOf, String dataIniTar, String dataFineTar, String descTar, Double impTar, String causFatt, String flgProvv, String codUt, String codTipoOpz) throws FinderException, RemoteException;
  void addTariffaRibDaPers(String codContr, String contrDest, String codUt, Collection TarIns)  throws FinderException, RemoteException;
  void addTariffaRibDaUnico(String contrDest, String codUt, Collection TarIns)  throws FinderException, RemoteException;
  Collection findDettaglio(String CodTar, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException;
  Collection findAll(String CodPs, String CodOf, String CausBill, String CodTipoOpz) throws FinderException, RemoteException;
  TariffaBMP findTariffaUnica(String codTar) throws  RemoteException, FinderException; //throws FinderException, RemoteException; //Valeria inizio 02-09-02
  TariffaBMP findTariffaAggiornaUnicaProvv(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException;
  TariffaBMP findTariffaAggiornaUnica(String codTar, String dataIniTarDigitata, String descTar, Double impTar, String codUt) throws FinderException, RemoteException;
  Collection findTariffaPersXRib(String codTipoContr, String codContr, String codContrDest ) throws FinderException, RemoteException;
  Collection findTariffaUnicoXRib(String codTipoContr, String codContrDest) throws FinderException, RemoteException;
  Collection findTariffa(String CodePs, String CodOf, String CausBill) throws FinderException, RemoteException;
  TariffeSpecial addTariffaSpecialNew(String i_code_utente,String i_code_ogg_fatrz,String i_data_inizio_tariffa_s,
                           String i_desc_tariffa,String i_impt_tariffa_s,String i_tipo_flag_modal_appl_tariffa,
                           String i_code_ps,String i_code_unita_di_misura,String i_flag_repricing,
                           String i_code_tipo_caus,String code_contr,String i_desc_listino_applicato) throws FinderException, RemoteException;
  int addPromozioneTariffaSpecialNew(String i_code_promozione,String i_code_contr,String i_code_tariffa,String i_code_pr_tariffa,
                                     String i_flag_attiva,String i_strDataDa,String i_strDataA,String i_strDataDaCan,
                                     String i_strDataACan,String i_strNumMesi,String i_strCodiceProgBill) throws FinderException, RemoteException;

    int addPromozioneTariffaSpecialNewClu(String i_code_promozione,String i_code_contr,String i_code_tariffa,String i_code_pr_tariffa,
                                       String i_flag_attiva,String i_strDataDa,String i_strDataA,String i_strDataDaCan,
                                       String i_strDataACan,String i_strNumMesi,String i_strCodiceProgBill,
                                          String i_code_cluster,
                                          String i_tipo_cluster,
                                          String i_code_tipo_contr) throws FinderException, RemoteException;


     TariffeSpecial addTariffaSpecialNewClus(String i_code_utente,String i_code_ogg_fatrz,String i_data_inizio_tariffa_s,
                           String i_desc_tariffa,String i_impt_tariffa_s,String i_tipo_flag_modal_appl_tariffa,
                           String i_code_ps,String i_code_unita_di_misura,String i_flag_repricing,
                           String i_code_tipo_caus,String code_contr,String i_desc_listino_applicato,String code_cluster, String tipo_cluster, String code_tipo_contr) throws FinderException, RemoteException;
    
    Collection findListiniClus(String codTipoContr) throws FinderException, RemoteException;
    Collection findTariffaListinoPersClus(String codContr, String codTipoContr, String Storico) throws FinderException, RemoteException;
    Collection findListDestClus(String codTipoContr) throws FinderException, RemoteException;
    Collection findProdottiClus(String cotTipoContr) throws FinderException, RemoteException;
    Collection findTariffaPersXRibClus(String codTipoContr, String codContr, String codContrDest, String codeCluster, String tipoCluster, String codeClusterDest, String tipoClusterDest, String prodottoCluster ) throws FinderException, RemoteException;
    Collection findTariffaPersXRibNClus(String codTipoContr, String codContr, String codContrDest, String codeClusterDest, String tipoClusterDest, String prodottoCluster ) throws FinderException, RemoteException;
    Collection findTariffaUnicoXRib(String codTipoContr , String codContrDest,String codeCluster, String tipoCluster, String prodottoCluster) throws FinderException, RemoteException;

    
    void addTariffaRibDaPersClus(String codContr, String contrDest, String codUt, String codeCluster, String tipoCluster, String codeTipoContr, Collection TarIns)  throws FinderException, RemoteException;
    void addTariffaRibDaUnicoCluster(String contrDest, String codUt, String codeCluster, String tipoCluster, String codeTipoContr, Collection TarIns)  throws FinderException, RemoteException;
    void addTariffaRibDaPersClusClus(String codContr, String contrDest, String codUt, String codeClusterSource, String codeClusterDest, String tipoClusterSource, String tipoClusterDest, String codeTipoContr, Collection TarIns)  throws FinderException, RemoteException;
    void addTariffaRibDaPersClusContr(String codContr, String contrDest, String codUt, String codeClusterSource, String tipoClusterSource, String codeTipoContr, Collection TarIns)  throws FinderException, RemoteException;

}