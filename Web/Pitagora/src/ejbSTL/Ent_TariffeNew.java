package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public interface Ent_TariffeNew extends EJBObject 
{
  public Vector getListaTariffe(int CodeServizio,int CodeOfferta,
  int CodeProdotto,int CodeComponente,int CodePrestazioneAggiuntiva,int tipoTariffa)throws CustomException, RemoteException;
  public Vector getTariffa(int CODE_TARIFFA,int tipoTariffa)throws CustomException, RemoteException;
  public int updateTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public int updateTariffaListino(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public int insertTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public int getSequenceTariffa(int tipoTariffa)throws CustomException, RemoteException;
  public boolean existTariffa(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException;
  public boolean existTariffaPersonalizzata(DB_TariffeNew lcls_tariffa, DB_RegolaTariffa lcls_regoleTariffa,int tipoTariffa) throws CustomException, RemoteException;  
  public void annullaTariffaFromData(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public void deleteTariffaFromData(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public void deleteTariffa(DB_TariffeNew p_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public Vector getStoricoTariffa(int CODE_TARIFFA,int tipoTariffa )throws CustomException, RemoteException;
  public boolean isDeletable(int CODE_TARIFFA,int tipoTariffa)throws CustomException, RemoteException;
  public Vector getListaTariffeRiferimXPerc(int CodeServizio,int CodeOfferta,
      int CodeClasse,int CodeFascia,int tipoTariffa)throws CustomException, RemoteException;
  public void insertTariffaXTariffaPerc(DB_TariffeNew p_Tariffa,String CodeTariffaRif,int tipoTariffa)throws CustomException, RemoteException;      
  public Vector getListaTariffeRiferimXCode(int CodeTariffaPerc,int tipoTariffa)throws CustomException, RemoteException;


}
