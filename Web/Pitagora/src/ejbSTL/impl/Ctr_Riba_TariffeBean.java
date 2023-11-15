package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;

public class Ctr_Riba_TariffeBean extends AbstractClassicEJB implements SessionBean 
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


// lancioBatch
public String lancioBatch ( String pstr_CodeUtente,
                            String pstr_CodeContrattoOr,
                            String pstr_CodeContrattoDest,
                            String pstr_CodePS,
                            String pstr_CodePrestAgg,
                            String pstr_CodeOggFatrz)
    throws CustomException, RemoteException
{
    try
    {
    String lstr_Error = "";
    Context lcls_Contesto = null;
    Object homeObject = null;
	Ent_Batch lEnt_Batch = null;
	Ent_BatchHome lEnt_BatchHome = null;

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
/* mm01 25/03/2004
 * String lstr_Batch = StaticContext.RIBES_INFR_BATCH_RIBAL_TARIFFE +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + pstr_CodeUtente +
                                    StaticContext.RIBES_SEPARATORE_PARAMETRI + "_";
*/

      String lstr_Batch = StaticContext.RIBES_INFR_BATCH_RIBAL_TARIFFE +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + 
                          pstr_CodeUtente +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + 
                          "_" +
                          StaticContext.RIBES_SEPARATORE_PARAMETRI + 
                          pstr_CodeContrattoOr + 
                          StaticContext.RIBES_SEPARATORE1_PARAMETRI +
                          pstr_CodeContrattoDest;

    /* Se è valorizzato il codice del P/S viene effattuato il ribaltamento per P/S */
    if (!pstr_CodePS.equals("")) {
      lstr_Batch += StaticContext.RIBES_SEPARATORE1_PARAMETRI +
                    pstr_CodePS;
    }

    /* Se è valorizzato il codice del Prestazione Aggiuntiva
     * viene effattuato il ribaltamento per Prestazione Aggiuntiva */
    if (!pstr_CodePrestAgg.equals("")) {
      lstr_Batch += StaticContext.RIBES_SEPARATORE1_PARAMETRI +
                    pstr_CodePrestAgg;
    }

    /* Se è valorizzato il codice dell'Oggetto Di Fatturazione
     * viene effattuato il ribaltamento per Oggetto Di Fatturazione */
    if (!pstr_CodeOggFatrz.equals("")) {
      lstr_Batch += StaticContext.RIBES_SEPARATORE1_PARAMETRI +
                    pstr_CodeOggFatrz;
    }

    System.out.println("lstr_Batch [" + lstr_Batch + "]");
/* mm01 25/03/2004
 */
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
									"lancioBatch",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
}


  // chkRibaTariffa
  public String chkRibaTariffa ( String pstr_CodeContrOri, 
                                  String pstr_CodeContrDest,
                                  String pstr_CodePS, 
                                  String pstr_CodePrestAgg, 
                                  String pstr_CodeOggFattrz )
  throws CustomException, RemoteException
  {
    int lint_Result;
    boolean lbln_NoPSPAOF;
    String lstr_Error = null;
    Context lcls_Contesto = null;
    Object homeObject = null;
    Ent_OggettiFatturazione lent_OggettiFatturazione = null;
    Ent_OggettiFatturazioneHome lent_OggettiFatturazioneHome = null;
    Ent_ProdottiServizi lent_ProdottiServizi = null;
    Ent_ProdottiServiziHome lent_ProdottiServiziHome = null;
    Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
    Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;
    try 
    {
      pstr_CodeContrOri  = Misc.nh(pstr_CodeContrOri);
      pstr_CodeContrDest = Misc.nh(pstr_CodeContrDest);
      pstr_CodePS        = Misc.nh(pstr_CodePS);
      pstr_CodePrestAgg  = Misc.nh(pstr_CodePrestAgg);
      pstr_CodeOggFattrz = Misc.nh(pstr_CodeOggFattrz);

      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      if (( ! pstr_CodeContrOri.equalsIgnoreCase("")) && ( ! pstr_CodeContrDest.equalsIgnoreCase("")))
      {
        homeObject = lcls_Contesto.lookup("Ent_ProdottiServizi");
        lent_ProdottiServiziHome = (Ent_ProdottiServiziHome)PortableRemoteObject.narrow(homeObject, Ent_ProdottiServiziHome.class);
        lent_ProdottiServizi = lent_ProdottiServiziHome.create();
        homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
        lent_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
        lent_OggettiFatturazione = lent_OggettiFatturazioneHome.create();


        lstr_Error = null;
        if ((lent_ProdottiServizi != null) && (lent_OggettiFatturazione != null))
        {
          int num_PSori = 0;
          int num_PSdest = lent_ProdottiServizi.countPSXContratto(StaticContext.LIST,pstr_CodeContrDest,pstr_CodePS,pstr_CodePrestAgg).intValue(); 
          if ((pstr_CodePS.equalsIgnoreCase("")) && (pstr_CodePrestAgg.equalsIgnoreCase("")) && (pstr_CodeOggFattrz.equalsIgnoreCase("")))
          {
            lbln_NoPSPAOF = true;

            num_PSori = lent_ProdottiServizi.countPSXContratto(StaticContext.LIST,pstr_CodeContrOri,pstr_CodePS,pstr_CodePrestAgg).intValue(); 
            if ((num_PSori != num_PSdest) || ( num_PSori == 0)) lstr_Error = "3168";
          }
          else
          {

            lbln_NoPSPAOF = false;
            if ( num_PSdest == 0) lstr_Error = "3168";
          }
          if ( lstr_Error == null )
          {

            int num_AssOfPsOri = lent_OggettiFatturazione.countOFPSValidiXContratto(StaticContext.LIST, pstr_CodeContrOri, pstr_CodePS, pstr_CodePrestAgg, pstr_CodeOggFattrz).intValue();
            int num_AssOfPsDest = lent_OggettiFatturazione.countOFPSXContratto(StaticContext.LIST, pstr_CodeContrDest, pstr_CodePS, pstr_CodePrestAgg, pstr_CodeOggFattrz).intValue();
            if (( num_AssOfPsOri == 0 ) || ( num_AssOfPsDest > 0)) lstr_Error = "3168";
            if (( lstr_Error == null ) && (lbln_NoPSPAOF == true))
            {

              int num_IntersectPS = lent_ProdottiServizi.countIntersectPSXContratto(StaticContext.LIST, pstr_CodeContrOri, pstr_CodeContrDest).intValue();
              if ( num_IntersectPS != num_PSori ) lstr_Error = "3168";
            }
          }
        }
        else
        {
          lstr_Error = "3168";
        }
      }
      else
      {
        lstr_Error = "3168";
      }
      
      if ( lstr_Error != null )
      {
        if (( lstr_Error = this.getErrorMessage(lcls_Contesto, lstr_Error)) == null)
        {
          lstr_Error = "Errore : I parametri Tariffari non possono essere ribaltati sul contratto.";
        }
      }
      else lstr_Error = "";
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkRibaTariffa",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lstr_Error;
 }
}