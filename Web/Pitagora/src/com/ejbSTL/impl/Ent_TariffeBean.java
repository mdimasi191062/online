package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;


public class Ent_TariffeBean extends AbstractClassicEJB implements SessionBean 
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

  // getListaTariffe
  public Vector getListaTariffe(int pint_OperazioneRichiesta,
                               String pstr_CodeContr,
                               String pstr_CodePs,
                               String pstr_CodePrestAgg,
                               String pstr_CodeTipoCausale,
                               String pstr_CodeOggFatrz)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getListaTariffe" ;
            break;
       }

      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCausale}, 
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz}};


      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getListaTariffe",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

 // getDettaglioTariffa
 public Vector getDettaglioTariffa(int pint_OperazioneRichiesta,
                                   String pstr_CodeTariffa,
                                   String pstr_DataCreazTariffa)
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
     switch (pint_OperazioneRichiesta)
      {
		 case StaticContext.UPDATE :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getDettaglioTariffaRecente";
            break;
         default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getDettaglioTariffa";
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataCreazTariffa}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDettaglioTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // insTariffa
  public Integer insTariffa(int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe ) throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try {
    
       switch (pint_OperazioneRichiesta) 
       {
          case StaticContext.INSERT :
          case StaticContext.UPDATE :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "insTariffa" ;
            break;
       }

       String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_TARIFFA()}, 
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_FASCIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_UNITA_MISURA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_UTENTE()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_VALID_OF_PS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_VALID_OF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_PS_PA_CONTR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_FINE_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDESC_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_CONG_REPR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_CREAZ_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pDB_Tariffe.getIMPT_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_PROVVISORIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_CREAZ_MODIF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_CLAS_SCONTO()}
                  };

      /*
       * tracciatura inserimento tariffe - inizio
       * si visualizza il contenuto della riga di insert delle tariffe 
      
      System.out.println("<CODE_TARIFFA><"+pDB_Tariffe.getCODE_TARIFFA()+">"+
                                "<CODE_PR_TARIFFA><"+pDB_Tariffe.getCODE_PR_TARIFFA()+">"+
                                "<CODE_FASCIA><"+pDB_Tariffe.getCODE_FASCIA()+">"+
                                "<CODE_PR_FASCIA><"+pDB_Tariffe.getCODE_PR_FASCIA()+">"+
                                "<CODE_UNITA_MISURA><"+pDB_Tariffe.getCODE_UNITA_MISURA()+">"+
                                "<CODE_UTENTE><"+pDB_Tariffe.getCODE_UTENTE()+">"+
                                "<DATA_INIZIO_VALID_OF_PS><"+pDB_Tariffe.getDATA_INIZIO_VALID_OF_PS()+">"+
                                "<CODE_OGG_FATRZ><"+pDB_Tariffe.getCODE_OGG_FATRZ()+">"+
                                "<DATA_INIZIO_VALID_OF><"+pDB_Tariffe.getDATA_INIZIO_VALID_OF()+">"+
                                "<CODE_PR_PS_PA_CONTR><"+pDB_Tariffe.getCODE_PR_PS_PA_CONTR()+">"+
                                "<DATA_INIZIO_TARIFFA><"+pDB_Tariffe.getDATA_INIZIO_TARIFFA()+">"+
                                "<DATA_FINE_TARIFFA><"+pDB_Tariffe.getDATA_FINE_TARIFFA()+">"+
                                "<DESC_TARIFFA><"+pDB_Tariffe.getDESC_TARIFFA()+">"+
                                "<TIPO_FLAG_CONG_REPR><"+pDB_Tariffe.getTIPO_FLAG_CONG_REPR()+">"+
                                "<DATA_CREAZ_TARIFFA><"+pDB_Tariffe.getDATA_CREAZ_TARIFFA()+">"+
                                "<IMPT_TARIFFA><"+pDB_Tariffe.getIMPT_TARIFFA()+">"+
                                "<TIPO_FLAG_MODAL_APPL_TARIFFA><"+pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()+">"+
                                "<TIPO_FLAG_PROVVISORIA><"+pDB_Tariffe.getTIPO_FLAG_PROVVISORIA()+">"+
                                "<DATA_CREAZ_MODIF><"+pDB_Tariffe.getDATA_CREAZ_MODIF()+">"+
                                "<CODE_TIPO_CAUS><"+pDB_Tariffe.getCODE_TIPO_CAUS()+">"+
                                "<CODE_TIPO_OFF><"+pDB_Tariffe.getCODE_TIPO_OFF()+">"+
                                "<CODE_CLAS_SCONTO><"+pDB_Tariffe.getCODE_CLAS_SCONTO()+">"+
                                "<CODE_PR_CLAS_SCONTO><"+pDB_Tariffe.getCODE_PR_CLAS_SCONTO()+">");

      *
      */

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception) {

      throw new CustomException(lexc_Exception.toString(), 
                                                 "", 
                                                 "insTariffa", 
                                                 this.getClass().getName(), 
                                                 StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  // chkTariffa
  public Integer chkTariffa(int pint_OperazioneRichiesta,
                            int pint_Funzionalita,
                            DB_Tariffe pDB_Tariffe)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
      Vector lvct_SPReturn = null;
      Integer lint_Return = null;
      switch (pint_Funzionalita)
      {
        case StaticContext.FN_TARIFFA :
           switch (pint_OperazioneRichiesta)
            {
              case StaticContext.INSERT :
                lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffa" ;
               break;

               case StaticContext.UPDATE :
                 lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffa" ;
               break;
           }

           String[][] larr_CallSP1 =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},                   
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_PS_PA_CONTR()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_CLAS_SCONTO()}, 
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()}};

           lvct_SPReturn = this.callSP(larr_CallSP1);
           lint_Return = (Integer)lvct_SPReturn.get(0);
           break;

        case StaticContext.FN_TARIFFA_TIPO_CONTR :
            switch (pint_OperazioneRichiesta)
            {
              case StaticContext.INSERT :
                lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffaTipoContrIns" ;
               break;

              case StaticContext.UPDATE :
                 lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffaTipoContrUpd" ;
               break;
            }
            String[][] larr_CallSP2 =
            {{lstr_StoredProcedureName},
             {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},                   
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()}, 
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
             {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}};

            lvct_SPReturn = this.callSP(larr_CallSP2);

            switch (pint_OperazioneRichiesta)
            {
              case StaticContext.INSERT :
                lint_Return = (Integer)lvct_SPReturn.get(0);
              break;

              case StaticContext.UPDATE :
                Vector lvct_Return= (Vector)lvct_SPReturn.get(0);
                lint_Return = new Integer(lvct_Return.size());
              break;
            }
           
           break;
       }

     return lint_Return;

    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getTariffaXTipoContrUpd
  public Vector getTariffaXTipoContrUpd (int pint_OperazioneRichiesta, DB_Tariffe pDB_Tariffe )
        throws CustomException, RemoteException
  {
   String lstr_StoredProcedureName = "";

    try
    {
      switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffaTipoContrUpd" ;
            break;
       }

      String[][] larr_CallSP =
      {{lstr_StoredProcedureName},
       {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},                   
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()}, 
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_CLAS_SCONTO()},
       {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTariffaXTipoContrUpd",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


  // getTariffaMaxDataCreaz
public DB_Tariffe getTariffaMaxDataCreaz (String pstr_CodeTariffa,
                                            String pstr_DataInizioTariffa,
                                            String pstr_DataCreazTariffa)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getTariffaMaxDataCreaz";

    try
    {
        String[][] larr_CallSP =
        {{lstr_StoredProcedureName},
         {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},                   
         {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
         {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataInizioTariffa},
         {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataCreazTariffa}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        DB_Tariffe lDB_Tariffe = null;
        if (lvct_Return.size() > 0)
            lDB_Tariffe = (DB_Tariffe)lvct_Return.get(0);

        return lDB_Tariffe;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTariffaMaxDataCreaz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // getTariffaSequence
  public Integer getTariffaSequence (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getTariffaSequence" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTariffaSequence",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getTariffaMaxProgr
  public Integer getTariffaMaxProgr (int pint_OperazioneRichiesta,
                                      String pstr_CodeTariffa)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getTariffaMaxProgr" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTariffaMaxProgr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // delTariffa 
  public Integer delTariffa (int pint_OperazioneRichiesta,
                          String pstr_CodeTariffa,
                          String pstr_MaxDataCreazione)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
          case StaticContext.DELETE :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "delTariffa" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_MaxDataCreazione}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }



// updTariffaMagDataInizio
// Viene settata la data_fine_tariffa uguale alla data_inizio_tariffa per tutte le tariffe
// che hanno code_tariffa = pstr_CodeTariffa, data_inizio_tariffa maggiore di 
// pstr_DataInizio e tipo_flag_provvisoria = 'D'. Viene usata principalmente nel caso
// in cui viene inserita una nuova tariffa per tipologia di contratto con data precedente
// a tariffe esistenti.
public Integer updTariffaMagDataInizio (int pint_OperazioneRichiesta,
                                            String pstr_CodeTariffa,
                                            String pstr_DataInizio)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "updTariffaMagDataInizio";
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataInizio}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffaMagDataInizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}



// delTariffaMagDataInizio 
public Integer delTariffaMagDataInizio (int pint_OperazioneRichiesta,
                                            String pstr_CodeTariffa,
                                            String pstr_DataInizio)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "delTariffaMagDataInizio";
                break;
        }

        String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataInizio}};

        Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffaMagDataInizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // updTariffa
  public Integer updTariffa(int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {
    
     switch (pint_OperazioneRichiesta)
      {
          case StaticContext.UPDATE :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "updTariffa" ;
            break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_TARIFFA()}, 
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_FASCIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_UNITA_MISURA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_UTENTE()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_VALID_OF_PS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_VALID_OF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_PS_PA_CONTR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_INIZIO_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_FINE_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDESC_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_CONG_REPR()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_CREAZ_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_DOUBLE, pDB_Tariffe.getIMPT_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_PROVVISORIA()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getDATA_CREAZ_MODIF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PR_CLAS_SCONTO()}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  } 

  // getDettRibaTariffa
  public Vector getDettRibaTariffa (int pint_OperazioneRichiesta,
                                     String pstr_CodeContr,
                                     String pstr_CodePs,
                                     String pstr_CodePrestAgg,
                                     String pstr_CodeTipoCaus,
                                     String pstr_CodeOggFatrz)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
         default :

          lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "getDettRibaTariffa" ;
          break;
       }
       
      String[][] larr_CallSP =
                  {{lstr_StoredProcedureName},
                   {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeContr},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePs},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodePrestAgg},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeOggFatrz},
                   {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoCaus}};

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDettRibaTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // delTariffaXTipoContr 
  public Integer delTariffaTipoContr (int pint_OperazioneRichiesta,
                                       DB_Tariffe pDB_Tariffe)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";

    try
    {
    switch (pint_OperazioneRichiesta)
      {
           default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "delTariffeTipoContr" ;
            break;
       }
       
      String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()}, 
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}
                };         

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delTariffaTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // chkTariffaTipoContrDel
  public Integer chkTariffaTipoContrDel (int pint_OperazioneRichiesta,
                                         DB_Tariffe pDB_Tariffe)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn = null;
      switch (pint_OperazioneRichiesta)
      {
          default :
            lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "chkTariffaTipoContrDel" ;
           break;
          
      }
      String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PS()}, 
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_PREST_AGG()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CONTR()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_OGG_FATRZ()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_CAUS()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getTIPO_FLAG_MODAL_APPL_TARIFFA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_FASCIA()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_CLAS_SCONTO()},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pDB_Tariffe.getCODE_TIPO_OFF()}
                };         

      lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkTariffaTipoContrDel",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }


// updTariffaSpesaComplessiva 
public Integer updTariffaSpesaComplessiva (int pint_OperazioneRichiesta,
                                                String pstr_CodeTipoContr,
                                                String pstr_CodeGest)
    throws CustomException, RemoteException
{
    String lstr_StoredProcedureName = "";

    try
    {      
        switch (pint_OperazioneRichiesta)
        {
            default:
                lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "updTariffaSpesaComplessiva" ;
                break;
        }

        String[][] larr_CallSP =
                {{lstr_StoredProcedureName},
                 {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTipoContr},
                 {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeGest}
                };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lint_Return = (Integer)lvct_SPReturn.get(0);

        return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffaSpesaComplessiva",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // updTariffaXDataCreaz 
  public Integer updTariffaXDataCreaz (int pint_OperazioneRichiesta,
                                       String pstr_CodeTariffa,
                                       String pstr_DataFineTariffa,
                                       String pstr_DataCreazioneTariffa)
        throws CustomException, RemoteException
  {
    String lstr_StoredProcedureName = "";
    try
    {      
      Vector lvct_SPReturn = null;
          
      lstr_StoredProcedureName = StaticContext.PKG_TARIFFE + "updTariffaXDataCreaz" ;
              
      String[][] larr_CallSP =
              {{lstr_StoredProcedureName},
               {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_CodeTariffa},    
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataFineTariffa},    
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, pstr_DataCreazioneTariffa}};      

      lvct_SPReturn = this.callSP(larr_CallSP, DB_Tariffe.class);
      Integer lint_Return = (Integer)lvct_SPReturn.get(0);

      return lint_Return;
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"updTariffaXDataCreaz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int checkTariffaRepricing(String code_tariffa,String code_pr_tariffa,String data_inizio_validita,String data_inizio_validita_old, String code_ogg_fatrz) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_BATCH_NEW + "checkTariffaRepricing";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_tariffa},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_pr_tariffa},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, data_inizio_validita},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, data_inizio_validita_old},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_ogg_fatrz}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"checkTariffaRepricing",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }
}