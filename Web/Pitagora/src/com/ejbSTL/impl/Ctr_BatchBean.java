package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import com.utl.*;
import com.ejbSTL.*;
import java.rmi.RemoteException;
import java.util.Vector;


public class Ctr_BatchBean extends AbstractClassicEJB implements SessionBean 
{
  public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }

  // getElabBatchXLancio
  public Vector getElabBatchXLancio (String pstr_TipoContratto, Vector pvct_AccountSelezionati, String pstr_CodeElab)
                            throws CustomException, RemoteException
  {
    Vector lvct_ElabAccount = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountFound = null;
    try 
    {
      if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Batch
        homeObject = lcls_Contesto.lookup("Ent_Batch");
        lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
        lEnt_Batch = lEnt_BatchHome.create();

        for (int ind=0; ind < pvct_AccountSelezionati.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)pvct_AccountSelezionati.get(ind);
          lvct_AccountFound = lEnt_Batch.getElabBatchXLancio(StaticContext.LIST,
                                              pstr_TipoContratto,
                                              lDB_AccountSelezionato.getCODE_ACCOUNT(),
                                              pstr_CodeElab,
											  lDB_AccountSelezionato.getCODE_GEST());
                                              
          if ( lvct_AccountFound!=null && lvct_AccountFound.size() > 0 )
          {
            lvct_ElabAccount.addElement((Object)lvct_AccountFound.get(0));
          }
        }
      }
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getElabBatchXLancio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return lvct_ElabAccount;
  }

// LancioBatch_Pref
public String LancioBatch_Pref (String pstr_CodiceFasePref,
                      					String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = StaticContext.RIBES_TOOL_PREFATTURAZIONE +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodiceFasePref +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;

      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_Pref",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}



  // LancioBatch_Auto
public String LancioBatch_Auto (String pstr_Data,
                                String pstr_CodeAccount,
                      					String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      if(pstr_CodeAccount.equalsIgnoreCase(""))
      {
        pstr_CodeAccount = "ALL";
      }
      String lstr_Batch = StaticContext.RIBES_TOOL_AUTOMATISMO +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeAccount + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_Data +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;

      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_Auto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}



// LancioBatch_ExportPerSap
public String LancioBatch_ExportPerSap (String pstr_CodeUtente,
                                        String pstr_Testate,
                                        String pstr_DataInizioCiclo,
                                        String pstr_DataFineCiclo,
                                        String pstr_DataFinePeriodo)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      lstr_Batch = StaticContext.RIBES_EXPORT_PER_SAP +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_Testate + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      if(pstr_Testate.equalsIgnoreCase("1"))
      {
        lstr_Batch += pstr_DataInizioCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFineCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFinePeriodo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      }
      

      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ExportPerSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// LancioBatch_ImportPerSap
  public String LancioBatch_Import (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      lstr_Batch = StaticContext.RIBES_IMPORT_PER_PS_SAP_SP +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + NameBatchImport ;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ImportPsSapSpecial",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}




// LancioBatch_ImportPerSap
public String LancioBatch_ImportPerSap (String pstr_NomeFileTestata,
                                                          String pstr_NomeFileDettaglio,
                                                          String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      lstr_Batch = StaticContext.RIBES_IMPORT_PER_SAP +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_NomeFileTestata +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_NomeFileDettaglio;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ImportPerSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// LancioSpaAccorpamento
public String LancioSpaAccorpamento (String pstr_CodeGestPrior,
                                        String pstr_Gestori,
                                        String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
  String lstr_NumeroGestori = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {


      Vector vctGestori = (Vector)Misc.split(pstr_Gestori,"|");
      lstr_NumeroGestori = Integer.toString(vctGestori.size()); //deve x forza essere compreso tra 2 e 6!!!
      
      
      String lstr_Batch = "";

      lstr_Batch = StaticContext.RIBES_LANCIO_PKG +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
						              StaticContext.RIBES_SEPARATORE_PARAMETRI + StaticContext.PKG_ACCORP_X_SAP +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + lstr_NumeroGestori + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeGestPrior +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      for (int i = 0;i < vctGestori.size();i++)
      {
        Vector vctDettGestore = (Vector)Misc.split((String)vctGestori.elementAt(i),"$");
        //if (!(vctGestori.elementAt(i).equals(pstr_CodeGestPrior))){
        if (!(vctDettGestore.elementAt(0).equals(pstr_CodeGestPrior))){
          lstr_Batch += vctDettGestore.elementAt(0) + StaticContext.RIBES_SEPARATORE_PARAMETRI;
        }
      }
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioSpaAccorpamento",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// LancioStoricizzazione
public String LancioStoricizzazione (String pstr_CodeTipoContr,
                                     String pstr_TipoStoric,
                                     String pstr_CodeAccount,
										                 String pstr_CodeUtente)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
    String lstr_NumeroGestori = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

  if (pstr_CodeAccount.length()==0)
  {
    pstr_CodeAccount = "tutti";
  } 

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";

      lstr_Batch = StaticContext.RIBES_STORICIZ_NDC_FATT +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeTipoContr + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_TipoStoric +
						              StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeAccount +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioStoricizzazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// Lancio Consuntivo valorizzazione
public String LancioBatch_Consuntivo_Val (String pstr_NomeFile,
                                          String pstr_Path,
										  String pstr_DataFineCiclo,
										  String pstr_DataFinePeriodo,
                                          String pstr_CodeUtente)
									  
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {      
      String lstr_Batch = "";

      lstr_Batch = StaticContext.RIBES_LANCIO_PKG +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + 
			  StaticContext.PKG_VAL_CONSUNTIVO +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_NomeFile + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_Path +
						  StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFineCiclo +
						  StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFinePeriodo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_Consuntivo_Val",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


// Lancio Consuntivo repricing
public String LancioBatch_Consuntivo_Rep (String pstr_NomeFile,
                                                             String pstr_Path,
                                                             String pstr_DataCreazione,
                                                             String pstr_CodeUtente)
									  
	throws CustomException, RemoteException {

        String lstr_Error = "";
        Object homeObject = null;
        Context lcls_Contesto = null;
        Ent_Batch lEnt_Batch = null;
        Ent_BatchHome lEnt_BatchHome = null;

        try {

            // Acquisisco il contesto del componente
            lcls_Contesto = new InitialContext();

            // Istanzio una classe Ent_Batch
            homeObject = lcls_Contesto.lookup("Ent_Batch");
            lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
            lEnt_Batch = lEnt_BatchHome.create();

            if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
              lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
            else {      
                String lstr_Batch = "";

                lstr_Batch = StaticContext.RIBES_LANCIO_PKG +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI +
                              StaticContext.PKG_REP_CONSUNTIVO +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_NomeFile + 
                              StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_Path +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataCreazione +
                              StaticContext.RIBES_SEPARATORE_PARAMETRI;
      
                if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
                    lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
                else
                    lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
                }
        
                return (lstr_Error);
            }
            catch(Exception lexc_Exception)
            {
                throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_Consuntivo_Rep",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
            }
    }

    // Lancio Import Provisioning
    public String LancioBatch_Import_Provisioning (String pstr_CodiceBatchImport,
                                                                      String pstr_CodeUtente)
	    throws CustomException, RemoteException {

        String lstr_Error = "";
        String lstr_Batch = "";
        Object homeObject = null;
        Context lcls_Contesto = null;
        Ent_Batch lEnt_Batch = null;
        Ent_BatchHome lEnt_BatchHome = null;

        try {

            // Acquisisco il contesto del componente
            lcls_Contesto = new InitialContext();

            // Istanzio una classe Ent_Batch
            homeObject = lcls_Contesto.lookup("Ent_Batch");
            lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
            lEnt_Batch = lEnt_BatchHome.create();

            if (lEnt_Batch.chkStatoElaborazioneBatch(StaticContext.FN_PROVISIONING).intValue() > 0)
              lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
            else {      

                lstr_Batch = pstr_CodiceBatchImport + 
                                  StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                  StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                                  StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodiceBatchImport + 
                                  StaticContext.RIBES_SEPARATORE_PARAMETRI;
      
                if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
                    lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
                else
                    lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
                }
        
                return (lstr_Error);
            }
            catch(Exception lexc_Exception)
            {
                throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_Import_Provisioning : " + pstr_CodiceBatchImport,
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
            }
    }

// LancioBatch_ExportPerSap
public String LancioBatch_ExportPerSap_SP (String pstr_CodeUtente,
                                           String pstr_DataInizioCiclo,
                                           String pstr_DataFineCiclo,
                                           String pstr_isRepricing,
                                           String pstr_isRewrite,
                                           String pstr_TipoBatch,
                                           String pstr_TipoContr)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
  String eseguibile = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;
  if(pstr_DataInizioCiclo.compareTo("")==0)
    pstr_DataInizioCiclo="0";
  if(pstr_DataFineCiclo.compareTo("")==0)
    pstr_DataFineCiclo="0";
  if(pstr_isRepricing.compareTo("")==0)
    pstr_isRepricing="V";
    if(pstr_isRewrite.compareTo("")==0)
    pstr_isRepricing="N";
	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      if(pstr_TipoBatch.equals("XDSL")){
      
        if(pstr_TipoContr.equals("99"))
        {
        pstr_TipoContr="";
          Ent_TipiContrattoBean Contratti =new Ent_TipiContrattoBean();
          Vector lvct_TipiContratto = Contratti.getTipiContrattoPS();
          if (lvct_TipiContratto!=null)
          {
                DB_TipiContratto objDBTipoContratto = new DB_TipiContratto();
                objDBTipoContratto=(DB_TipiContratto)lvct_TipiContratto.elementAt(0);
                
                for(int i=0;i < lvct_TipiContratto.size();i++)
                {
                  objDBTipoContratto = new DB_TipiContratto();
                  objDBTipoContratto=(DB_TipiContratto)lvct_TipiContratto.elementAt(i);
                  pstr_TipoContr=pstr_TipoContr+" "+objDBTipoContratto.getCODE_TIPO_CONTR();
        
                }
                
               pstr_TipoContr.subSequence(0,pstr_TipoContr.length()-1);
          }
        }
        
      if(!pstr_isRewrite.equals("R")){
        eseguibile = StaticContext.RIBES_SAP_XDSL;
              lstr_Batch = eseguibile +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataInizioCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFineCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_isRepricing +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_isRewrite +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_TipoContr +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      }else
      {
        eseguibile = StaticContext.RIBES_REWRITE_SAP_XDSL;
        
   
        
              lstr_Batch = eseguibile +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_isRepricing +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_TipoContr +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      }
      
      } else {
        eseguibile = StaticContext.RIBES_SAP_REG;   
              lstr_Batch = eseguibile +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataInizioCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_DataFineCiclo +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_isRepricing +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_TipoContr +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      }

      

      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ExportPerSap_SP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

// LancioBatch_RewriteSap_SP
public String LancioBatch_RewriteSap_SP (String pstr_CodeUtente,
                                         String pstr_TipoBatch,
                                         String pstr_TipoContr)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
  String eseguibile = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatch(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      if(pstr_TipoBatch.equals("XDSL")){
        eseguibile = StaticContext.RIBES_REWRITE_SAP_XDSL;
      } else {
        eseguibile = StaticContext.RIBES_REWRITE_SAP_REG;        
      }
      lstr_Batch = eseguibile +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_TipoContr +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI;
      

      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_RewriteSap_SP",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


public String LancioBatch_ImportTariffeSp (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatchSpecial(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      lstr_Batch = StaticContext.RIBES_IMPORT_TARIFFE_SP +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + NameBatchImport ;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ImportTariffeSp",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

    public String LancioBatch_ImportTariffeSpCluster (String pstr_CodeUtente,String NameBatchImport)
            throws CustomException, RemoteException
    {
            String lstr_Error = "";
            Object homeObject = null;
            Context lcls_Contesto = null;
            Ent_Batch lEnt_Batch = null;
            Ent_BatchHome lEnt_BatchHome = null;

            try 
            {
                    
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Batch
        homeObject = lcls_Contesto.lookup("Ent_Batch");
        lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
        lEnt_Batch = lEnt_BatchHome.create();

        if (lEnt_Batch.chkElabBatchSpecial(StaticContext.LIST).intValue() > 0)
          lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
        else
        {
          String lstr_Batch = "";
          lstr_Batch = StaticContext.RIBES_IMPORT_TARIFFE_SP_CLUS +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                            StaticContext.RIBES_SEPARATORE_PARAMETRI + NameBatchImport ;
          
          if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
            lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
          else
            lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
          }
            
        return (lstr_Error);
            }
            catch(Exception lexc_Exception)
            {
                    throw new CustomException(lexc_Exception.toString(),
                                                                            "",
                                                                            "LancioBatch_ImportTariffeSp",
                                                                            this.getClass().getName(),
                                                                            StaticContext.FindExceptionType(lexc_Exception));
            }
    }


public String LancioBatch_ImportPromozioni (String pstr_CodeUtente,String NameBatchImport)
	throws CustomException, RemoteException
{
	String lstr_Error = "";
	Object homeObject = null;
	Context lcls_Contesto = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

	try 
	{
		
    // Acquisisco il contesto del componente
    lcls_Contesto = new InitialContext();

    // Istanzio una classe Ent_Batch
    homeObject = lcls_Contesto.lookup("Ent_Batch");
    lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
    lEnt_Batch = lEnt_BatchHome.create();

    if (lEnt_Batch.chkElabBatchSpecial(StaticContext.LIST).intValue() > 0)
      lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
    else
    {
      String lstr_Batch = "";
      lstr_Batch = StaticContext.RIBES_IMPORT_PROMOZIONI +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                        StaticContext.RIBES_SEPARATORE_PARAMETRI + NameBatchImport ;
      
      if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
      else
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
      }
        
    return (lstr_Error);
	}
	catch(Exception lexc_Exception)
	{
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"LancioBatch_ImportPromozioni",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}

  public String LancioBatch_ImportFatture (String pstr_CodeUtente,String NameBatchImport)
    throws CustomException, RemoteException
  {
    String lstr_Error = "";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;

    try 
    {
      
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_Batch
      homeObject = lcls_Contesto.lookup("Ent_Batch");
      lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
      lEnt_Batch = lEnt_BatchHome.create();

      if (lEnt_Batch.chkElabBatchSpecial(StaticContext.LIST).intValue() > 0)
        lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.RUNNING_BATCH);
      else
      {
        String lstr_Batch = "";
        lstr_Batch = StaticContext.RIBES_IMPORT_FATTURE +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + "_" + 
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + NameBatchImport ;
        
        if (lEnt_Batch.lancioBatch(lstr_Batch).intValue() == StaticContext.RIBES_INFR_OK)
          lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_OK);
        else
          lstr_Error = this.getErrorMessage(lcls_Contesto, StaticContext.ERR_LANCIO_BATCH_NOT_OK);
        }
          
      return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "LancioBatch_ImportFatture",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
    
}