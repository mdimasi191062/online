package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Batch extends EJBObject 
{
  // getElabBatchXLancio
  Vector getElabBatchXLancio (String pstr_TipoContratto, 
                              Vector pvct_AccountSelezionati,
                              String pstr_CodeElab)
    throws CustomException, RemoteException;
    
  //LancioBatch_Pref
  String LancioBatch_Pref (String pstr_CodiceFasePref,
                      					String pstr_CodeUtente)
	throws CustomException, RemoteException;
  
  // LancioBatch_Auto
  String LancioBatch_Auto (String pstr_Data,
                                  String pstr_CodeAccount,
                      			  String pstr_CodeUtente)
	throws CustomException, RemoteException;

// LancioBatch_ExportPerSap
String LancioBatch_ExportPerSap (String pstr_Testate,
                                        String pstr_DataInizioCiclo,
                                        String pstr_DataFineCiclo,
                                        String pstr_isRepricing,
										String pstr_CodeUtente)
	throws CustomException, RemoteException;
	
// LancioBatch_ImportPerSap
String LancioBatch_ImportPerSap (String pstr_NomeFileTestata, 
                                                String pstr_NomeFileDettaglio,
                                                String pstr_CodeUtente)
	throws CustomException, RemoteException;
	
// LancioSpaAccorpamento
 String LancioSpaAccorpamento (String pstr_CodeGestPrior,
                                        String pstr_Gestori,
										String pstr_CodeUtente)
	throws CustomException, RemoteException;
	
	// LancioStoricizzazione
 String LancioStoricizzazione (String pstr_CodeTipoContr,
                                        String pstr_TipoStoric,
                                        String pstr_CodeAccount,
										String pstr_CodeUtente)
	throws CustomException, RemoteException;
	
	// Lancio Batch Consuntivo Valorizzazione
	
	String LancioBatch_Consuntivo_Val (String pstr_NomeFile,
												String pstr_Path,
												String pstr_DataFineCiclo,
												String pstr_DataFinePeriodo,
												String pstr_CodeUtente)
	throws CustomException, RemoteException;

  	String LancioBatch_Consuntivo_Rep (String pstr_NomeFile,
												String pstr_Path,
												String pstr_DataCreazione,
												String pstr_CodeUtente)
	  throws CustomException, RemoteException;

	// Lancio Batch Import Provisioning
    String LancioBatch_Import_Provisioning (String pstr_CodiceBatchImport,
                                                                      String pstr_CodeUtente)
	    throws CustomException, RemoteException;

  // LancioBatch_ExportPerSap_SP
 String LancioBatch_ExportPerSap_SP (String pstr_CodeUtente,
                                           String pstr_DataInizioCiclo,
                                           String pstr_DataFineCiclo,
                                           String pstr_isRepricing,
                                           String pstr_isRewrite,
                                           String pstr_TipoBatch,
                                           String pstr_TipoContr)
	throws CustomException, RemoteException;

  // LancioBatch_ExportPerSap_SP
  String LancioBatch_RewriteSap_SP (String pstr_CodeUtente,
                                    String pstr_TipoBatch,
                                    String pstr_TipoContr)
	throws CustomException, RemoteException;

  public String LancioBatch_Import (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException;

  public String LancioBatch_ImportTariffeSp (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException;
        
  public String LancioBatch_ImportTariffeSpCluster (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException;

  public String LancioBatch_ImportPromozioni (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException;
  
  public String LancioBatch_ImportFatture (String pstr_CodeUtente,String NameBatchImport)
  throws CustomException, RemoteException;
}