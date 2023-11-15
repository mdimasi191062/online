package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Catalogo extends EJBObject 
{
  Vector getPreCatalogo() throws CustomException, RemoteException ;
  String insServizioLogico(DB_PreServiziLogici newServizio) throws RemoteException, CustomException;
  String insOfferta(DB_CAT_Offerta offerta) throws RemoteException, CustomException;
  String insServizio(DB_CAT_Servizio servizio) throws RemoteException, CustomException;  
  String getCodiceOfferta() throws RemoteException, CustomException;
  String getCodiceServizio() throws RemoteException, CustomException;
  String getCodiceServizioLogico() throws RemoteException, CustomException;  
  Vector getGruppiOfferte() throws CustomException, RemoteException;
  String getPreOfferteXml(int Servizio,int Prodotto)throws CustomException, RemoteException;
  String getPreOfferteXml()throws CustomException, RemoteException;
  String getPreServiziXml() throws CustomException, RemoteException;
  Vector getPreServiziLogici() throws CustomException, RemoteException;
  Vector getPreServizioLogico(String code_servizio) throws CustomException, RemoteException;
  String getPreServiziLogiciXml() throws CustomException, RemoteException;
  Vector getPreOfferte()throws CustomException, RemoteException;
  Vector getPreOfferte(String code_offerta)throws CustomException, RemoteException;
  String getPreCaratteristicheXml() throws CustomException, RemoteException;
  String getCodiceProdotto() throws CustomException, RemoteException;
  String getCodiceComponente() throws CustomException, RemoteException;
  String getCodicePrestazione() throws CustomException, RemoteException;
  Vector getAssOffServ() throws CustomException, RemoteException;
  Vector getAssOffServ_codiceServizio(String codice_servizio) throws CustomException, RemoteException;
  Vector getAssOffServ_codServOff(String codice_servizio, String codice_offerta) throws CustomException, RemoteException;
  String insAssociazione(DB_Offerta OffServ, int val_fre_cicli_cs) throws RemoteException, CustomException;
  String getCodiceClassOff() throws RemoteException, CustomException;
  String insClassOff(String codeClassOff, String descClassOff) throws RemoteException, CustomException;
  Vector getClassOffFiltro(String descClassOff) throws CustomException, RemoteException;
  Vector getGestoriFiltro(String codeGest, String descGest) throws CustomException, RemoteException;
  Vector getPreGestori_codGest(String codeGest)throws CustomException, RemoteException;
  String insGestore(DB_Gestori gestori) throws RemoteException, CustomException;
  Vector getAlberoPreCatalogo() throws CustomException, RemoteException ;
  Vector getAlberoPreCatalogoOfferta(String strCodeOfferta) throws CustomException, RemoteException ;
  String getPercorsoXml () throws CustomException, RemoteException ;
  String getPercorsoXml(String codeId) throws CustomException, RemoteException ;
  String insProdotto(String code_prodotto,String desc_prodotto) throws RemoteException, CustomException;
  String insComponente(DB_Componente componente) throws RemoteException, CustomException;
  String insPrestAgg(DB_PrestazioneAggiuntiva prestAgg) throws RemoteException, CustomException;
  Vector getAlberoPreCatalogoProdotti(String strCodeOfferta, String strCodeServizio) throws CustomException, RemoteException ;
  Vector getAlberoPreCatalogoComponenti(String strCodeProdotto) throws CustomException, RemoteException ;
  Vector getAlberoPreCatalogoPrestazioni(String strCodeProdotto , String strCodeComponente) throws CustomException, RemoteException ;
  Vector getVisualizzaInfo(String Elemento, String strCodeOfferta, String strCodeServizio, String strCodeProdotto, String strCodeComponente , String strCodePrestAgg ) throws CustomException, RemoteException;
  Vector getModalApplTempoNol() throws CustomException, RemoteException;
  Vector getPreOfferteAll() throws CustomException, RemoteException;
	int inserisciProdottoAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strSpesaCompl , String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException;   
	int inserisciComponenteAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strSpesaCompl ,String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException;
	int inserisciPrestazioneAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strCodePrestazione, String strSpesaCompl ,String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException;
  Vector getOfferteFiltro(String codeOff, String descOff) throws CustomException, RemoteException;
  Vector getServiziFiltro(String codeServ, String descServ) throws CustomException, RemoteException;
  Vector getServiziLogiciFiltro(String codeServLog, String descServLog, String descBreve, String codeServ) throws CustomException, RemoteException;
  Vector getProdottiFiltro(String codeProd, String descProd) throws CustomException, RemoteException;
  Vector getComponentiFiltro(String codeCompo, String descCompo) throws CustomException, RemoteException;
  Vector getPrestazioniFiltro(String codePrestAgg, String descPrestAgg) throws CustomException, RemoteException;
  Vector getTipoCausFiltro(String codeCaus, String descCaus) throws CustomException, RemoteException;
  String getCodiceTipoCaus() throws CustomException, RemoteException;
  String insTipoCaus(DB_TipoCausaleNew tipoCaus) throws RemoteException, CustomException;
  String insCaratteristica(DB_PreCaratteristiche caratteristica) throws RemoteException, CustomException;
  Vector getCaratteristicheFiltro(String codeCarat,String codeTipoCarat, String descCarat, String descTipoCarat) throws CustomException, RemoteException;
  String getCodiceCaratteristica() throws CustomException, RemoteException;
  String getTipoCaratteristicheXml() throws CustomException, RemoteException;
  Vector getAccountFiltro(String codeAcc, String descAcc) throws CustomException, RemoteException;
  Vector getPreAccount(String codeAcc) throws CustomException, RemoteException;
  Vector getPreProdotto(String codeProd) throws CustomException, RemoteException;
  Vector getPreComponente(String codeCompo) throws CustomException, RemoteException;
  String getPreGestoriXml() throws CustomException, RemoteException;
  String getCodiceAccount() throws CustomException, RemoteException;
  String insAccount(DB_CAT_Account newAccount) throws RemoteException, CustomException;
  Vector getPreServizi()throws CustomException, RemoteException;
  Vector getPreAccorpanti(String code_servizio,String code_gestore)throws CustomException, RemoteException;
  Vector getPreDisponibili(String code_servizio, String code_accorpante)throws CustomException, RemoteException;
  Vector getPreAccorpati(String code_accorpante)throws CustomException, RemoteException;   
  int insAccorpamenti(String str_Servizi,String str_AccountAccorpante,String[] str_AccountAccorpati,String data_accorpamento) throws CustomException, RemoteException;
  int deleteAccorpamento(String str_Servizi,String str_AccountAccorpante,String str_AccountAccorpato) throws CustomException, RemoteException;  
  Vector getPreGestori()throws CustomException, RemoteException;
  Vector getPreGestori(String code_servizio)throws CustomException, RemoteException;
  int determinaAssenzaCaratt(String strProdotto, String strComponente, String strPrestazione) throws RemoteException, CustomException;
  String getDescServizio(String strCodeServizio) throws RemoteException, CustomException;
  String getDescOfferta(String strCodeOfferta) throws RemoteException, CustomException;
  String getDescProdotto(String strCodeProdotto) throws RemoteException, CustomException;
  String getDescComponente(String strCodeComponente) throws RemoteException, CustomException;
  String getDescPrestazione(String strCodePrestazione) throws RemoteException, CustomException;
  Vector getPreCaratteristiche () throws CustomException, RemoteException;
  int insCaratt_x_elem(String elementi,String tipo, String code_caratt,String colocata, String trasmissiva, String ProdottoRif,String ComponenteRif) throws CustomException, RemoteException;
  int checkGestoreSap(String code_gestore, String code_gestore_sap) throws CustomException, RemoteException;
  Vector getClassOff_codeClasOff(String code_classe_offerta) throws CustomException, RemoteException;  
  /* FASE AGGIORNAMENTO/CANCELLAZIONE - INIZIO */
  String aggiorna_servizio_logico(DB_PreServiziLogici servizio_logico) throws CustomException, RemoteException;
  String cancella_servizio_logico(String code_servizio_logico) throws CustomException, RemoteException;
  String aggiorna_offerta(DB_CAT_Offerta offerta) throws RemoteException, CustomException;
  String aggiorna_associazione(DB_Offerta OffServ, int val_fre_cicli_cs) throws RemoteException, CustomException;
  //QS 4.9 Aggiunto campo  String strFlagModificaDescrizione
 String aggiorna_classe_offerta(String code_classe_offerta, String desc_classe_offerta, String strFlagModificaDescrizione) throws CustomException, RemoteException;

  String aggiorna_gestore(DB_Gestori gestore) throws CustomException, RemoteException;
  String cancella_offerta(String code_offerta) throws CustomException, RemoteException;
  String delAssociazione(String code_offerta,String codice_servizio) throws RemoteException, CustomException;  
  String cancella_classe_offerta(String code_classe_offerta) throws CustomException, RemoteException;
  String cancella_gestore(String code_gestore) throws CustomException, RemoteException;
  String cancella_account(String code_account) throws CustomException, RemoteException;
  String cancella_prestazione(String code_prestazione) throws CustomException, RemoteException;
  String cancella_caratteristica(String code_caratteristica) throws CustomException, RemoteException;
  String cancella_prodotto(String code_prodotto) throws CustomException, RemoteException;
  String cancella_componente(String code_componente) throws CustomException, RemoteException;
  String aggiorna_prestazione(DB_PrestazioneAggiuntiva PrestAgg) throws CustomException, RemoteException;
  String aggiorna_caratteristica(DB_PreCaratteristiche caratteristica) throws CustomException, RemoteException;
  String aggiorna_Account(DB_CAT_Account account) throws CustomException, RemoteException;
  String aggiorna_prodotto(DB_Prodotto prodotto) throws CustomException, RemoteException;
  String aggiorna_componente(DB_Componente componente) throws CustomException, RemoteException;
  /* FASE AGGIORNAMENTO/CANCELLAZIONE - FINE */  
   int eliminaProdottoAssociato (String Offerta , String Servizio , String Prodotto) throws CustomException, RemoteException;
   int eliminaComponenteAssociato (String Offerta , String Servizio , String Prodotto, String Componente) throws CustomException, RemoteException;
   int eliminaPrestazioneAssociata (String Offerta , String Servizio , String Prodotto, String Componente, String Prestazione) throws CustomException, RemoteException;
   int aggiornaProdCompPrest (String Offerta , String Servizio , String Prodotto, String Componente, String Prestazione, String strModalApplEur, String strValoPrimoNol, String strValoPreaNol, String strValoRinnNol,String strDataFineNoleggio, String strSpesa, String strEuribor) throws CustomException, RemoteException;
   int getApplicabilitaEuribor(String codeprodotto,String codecomponente, String codeprestagg) throws CustomException, RemoteException;
   Vector getTempoNol(String strCodeOfferta, String strCodeServizio, String strCodeProdotto) throws CustomException, RemoteException;
   /*QS - AP Aggiunta funzione */
   Vector getCaratteristica(String codeCarat) throws CustomException, RemoteException;

}




