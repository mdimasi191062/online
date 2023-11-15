package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.rmi.RemoteException;
import com.utl.*;
import com.ejbSTL.*;
import java.util.Vector;


public class Ctr_AssociazioniOfPsBean extends AbstractClassicEJB implements SessionBean 
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

  // chkDisattivaAssociazione
  public String chkDisattivaAssociazione (DB_OggettoFatturazione pDB_OggettoFatturazione)
                            throws CustomException, RemoteException
  {
    String lstr_Error = null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_AssocOggettiFatturazione lEnt_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lEnt_AssocOggettiFatturazioneHome = null;

    try 
    {
      if ( pDB_OggettoFatturazione != null )
      {
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_OggettiFatturazione
      homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
      lEnt_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
      lEnt_AssocOggettiFatturazione = lEnt_AssocOggettiFatturazioneHome.create();

      lstr_Error = "";
      if (lEnt_AssocOggettiFatturazione.chkPreDisattivazioneAssociazione(StaticContext.LIST,pDB_OggettoFatturazione).intValue() > 0)
          if (( lstr_Error = this.getErrorMessage(lcls_Contesto, "3250")) == null)
            lstr_Error = "Errore : L'associzione non può essere disattivata.";
      }
      else
      {
        lstr_Error = "Errore : L'associzione non può essere disattivata.";
      }
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"chkDisattivaAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return lstr_Error;
  }


  // DisattivaAssociazione
  public String DisattivaAssociazione (DB_OggettoFatturazione pDB_OggettoFatturazione)
                                       throws CustomException, RemoteException
  {
    String lstr_Error = null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_AssocOggettiFatturazione lEnt_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lEnt_AssocOggettiFatturazioneHome = null;
    int lint_Result = 0;
    
    try 
    {
      if ( pDB_OggettoFatturazione != null )
      {
        lcls_Contesto = new InitialContext();

        homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
        lEnt_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
        lEnt_AssocOggettiFatturazione = lEnt_AssocOggettiFatturazioneHome.create();

        if ((lint_Result = lEnt_AssocOggettiFatturazione.chkPostDisattivazioneAssociazione(StaticContext.LIST,
                                                  pDB_OggettoFatturazione).intValue()) == 0)
        {
          lint_Result = lEnt_AssocOggettiFatturazione.updAssociazioneOfPs(StaticContext.UPDATE, pDB_OggettoFatturazione).intValue();
          lstr_Error = "";
        }                                 
        else if (( lstr_Error = this.getErrorMessage(lcls_Contesto,Integer.toString(lint_Result))) == null)
        {
          lstr_Error = "Errore : L'associazione non può essere disattivata.";
        }
      }
      else
      {
        lstr_Error = "Errore : L'associazione non può essere disattivata.";
      }
   }
   catch(Exception lexc_Exception)
   {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"DisattivaAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
   }
    return lstr_Error;
  }



// InsAssociazioneOfPsXTipoContr
public String InsAssociazioneOfPsXTipoContr (DB_OggettoFatturazione pDB_OggettoFatturazione,	String pstr_AccountDaEliminare)
    throws CustomException, RemoteException {
    
    Context lcls_Contesto = null;
    Object homeObject = null;

    Ent_OggettiFatturazione lEnt_OggettiFatturazione = null;
    Ent_OggettiFatturazioneHome lEnt_OggettiFatturazioneHome = null;

    Ent_AssocOggettiFatturazione lEnt_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lEnt_AssocOggettiFatturazioneHome = null;

    String lstr_Error = null;
    boolean lbln_LeggiErrore = false;

    Integer numOFPSGiaPresenti = null;
    String lstr_CodeTipoCausale = "";

    String lstr_DataMaxFV = "";
    String lstr_DataMinIV = "";

    try
    {
        lcls_Contesto = new InitialContext();

        // Instanzio gli Ejb coinvolti nell'inserimento
        homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
        lEnt_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
        lEnt_OggettiFatturazione = lEnt_OggettiFatturazioneHome.create();

        homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
        lEnt_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
        lEnt_AssocOggettiFatturazione = lEnt_AssocOggettiFatturazioneHome.create();

        Vector lvct_RangeDate = null;

        Vector lvct_AccountDaEliminare = Misc.split(pstr_AccountDaEliminare, "*");

        Vector lvct_CodiciTipiCausale = Misc.split(pDB_OggettoFatturazione.getCODE_TIPO_CAUS(), "*");
        for (int j=0; j<lvct_CodiciTipiCausale.size() && (lstr_Error == null); j++) 
        {

            lstr_Error = null;
            lstr_CodeTipoCausale = (String)lvct_CodiciTipiCausale.get(j);

            if (lEnt_AssocOggettiFatturazione.countOFPSGiaPresenti(StaticContext.INSERT,
                                                        pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                                        pDB_OggettoFatturazione.getCODE_CONTR(),
                                                        pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                                                        pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                                        lstr_CodeTipoCausale,
                                                        pDB_OggettoFatturazione.getCODE_PS(),
                                                        pstr_AccountDaEliminare).intValue() > 0) {
            
                // Acquisisco il range di date composto dalla data Max di Fine Validità e la data Min di Inizio Validità
                lstr_DataMaxFV = "";
                lstr_DataMinIV = "";

                lvct_RangeDate = null;
                lvct_RangeDate = lEnt_AssocOggettiFatturazione.getMinMaxDateOFPS(StaticContext.INSERT,
                                          pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                          pDB_OggettoFatturazione.getCODE_CONTR(),
                                          pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                                          pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                          lstr_CodeTipoCausale,
                                          pDB_OggettoFatturazione.getCODE_PS(),
                                          pstr_AccountDaEliminare);

                if ((lvct_RangeDate != null) && (lvct_RangeDate.size() > 0))
                {
                    lstr_DataMaxFV = Misc.nh((String)lvct_RangeDate.get(0));    
                    lstr_DataMinIV = Misc.nh((String)lvct_RangeDate.get(1));


                    if (lEnt_AssocOggettiFatturazione.countOFPSAperti(StaticContext.INSERT,
                                                            pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                                            pDB_OggettoFatturazione.getCODE_CONTR(),
                                                            pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                                                            pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                                            lstr_CodeTipoCausale,
                                                            pDB_OggettoFatturazione.getCODE_PS(),
                                                            pstr_AccountDaEliminare).intValue() == 0)
                    {
                        // Se Data Fine Validità inserita a video is null
                        // e Data Inizio Validità a video è <= MAX_DATA_OUT(lstr_DataMaxFV)
                        // viene visualizzato il messaggio code_err ‘3167’
                        if (!lstr_DataMaxFV.equalsIgnoreCase("")) {
                            if ((Misc.nh(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()).equalsIgnoreCase("")) && 
                                ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                                   <= (DataFormat.setData(lstr_DataMaxFV,StaticContext.FORMATO_DATA).getTime().getTime())))
                            {
                                lstr_Error = "3167";
                                lbln_LeggiErrore = true;
                            }
                            else
                            {
                                // Se non si verifica che: la Data Inizio Validità inserita a video
                                // risulta < MAX_DATA_OUT(lstr_DataMaxFV) oppure il campo Data Fine Validità
                                // inserita a video risulta < MIN_DATA_OUT(lstr_DataMinIV) viene visualizzato
                                // il messaggio '3167'
                                if ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                                        >= (DataFormat.setData(lstr_DataMaxFV,StaticContext.FORMATO_DATA).getTime().getTime())
                                    ||
                                    (DataFormat.setData(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                                        >= (DataFormat.setData(lstr_DataMinIV,StaticContext.FORMATO_DATA).getTime().getTime()))
                                {
                                    lstr_Error = "3167";
                                    lbln_LeggiErrore = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        // lEnt_AssocOggettiFatturazione.countOFPSAperti != 0
                        // Se data Fine validità a video is null scatta il messaggio code_err ‘3169’
                        if (Misc.nh(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()).equalsIgnoreCase(""))
                        {
                            lstr_Error = "3169";
                            lbln_LeggiErrore = true;
                        }
                        else
                        {
                            // Se non si verifica che: Data Fine Validità inserita a video
                            // risulta < MIN_DATA_OUT(lstr_DataMinIV) viene visualizzato il messaggio
                            // code_err ‘3169’
                            if ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                                    >= (DataFormat.setData(lstr_DataMinIV,StaticContext.FORMATO_DATA).getTime().getTime()))
                            {
                                lstr_Error = "3169";
                                lbln_LeggiErrore = true;
                            }
                        }
                    }
                }
                else
                {
                    // lEnt_AssocOggettiFatturazione.getMinMaxDateOFPS non ha tornato dati
                    lstr_Error = "Errore nel reperire le date minima e massima delle associazioni OFPS.";
                }
            }
        } // Fine for (int j=0; j<lvct_CodiciTipiCausale.size(); j++)

        // +-----
        // Procedo con l'inserimento.
        // +-----
        if (lstr_Error == null)
        {

            // Richiama la lEnt_OggettiFatturazione.countOFXOggFatrz.
            // Se la count torna > 0 viene interrotta l’azione.
            if (lEnt_OggettiFatturazione.countOFXOggFatrz(StaticContext.INSERT, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()).intValue() == 1)
            {

                Vector lvct_CodiciPrPsPaContr = lEnt_AssocOggettiFatturazione.getCampiInsOFPS(StaticContext.INSERT,
                                                            pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                                            pDB_OggettoFatturazione.getCODE_CONTR(),
                                                            pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                                            pDB_OggettoFatturazione.getCODE_PS(),
                                                            pstr_AccountDaEliminare);
                
                if (lvct_CodiciPrPsPaContr.size() > 0 ) 
                {
                
                    for (int i=0; i<lvct_CodiciPrPsPaContr.size(); i++)
                    {
                        DB_OggettoFatturazione lDB_OggFatt = (DB_OggettoFatturazione)lvct_CodiciPrPsPaContr.get(i);
                        pDB_OggettoFatturazione.setCODE_PR_PS_PA_CONTR((String)lDB_OggFatt.getCODE_PR_PS_PA_CONTR());

                        for (int j=0; j<lvct_CodiciTipiCausale.size(); j++)
                        {
                            pDB_OggettoFatturazione.setCODE_TIPO_CAUS((String)lvct_CodiciTipiCausale.get(j));
                            lEnt_AssocOggettiFatturazione.insAssociazioneOfPs(StaticContext.INSERT, pDB_OggettoFatturazione);
                        }

                    }
                    
                }
                else 
                {
                    // la lista dei codici prpspacontr è 0, l'associazione OFPS esiste per tutti i gestori
                    lstr_Error = "L'oggetto di fatturazione selezionato risulta presente per tutti i gestori.";
                }
            }
            else
            {
                // lEnt_OggettiFatturazione.countOFXOggFatrz > 0
                lstr_Error = "L'oggetto di fatturazione selezionato risulta essere già associato.";
            }
        }
        else
        {
            if (lbln_LeggiErrore)
            {
                if ((lstr_Error = this.getErrorMessage(lcls_Contesto, lstr_Error)) == null)
                    lstr_Error = "Errore : Contratto, PS o OF risultano non validi";
            }
            else
            {
                if (lstr_Error == null)
                    lstr_Error = "Errore : Contratto, PS o OF risultano non validi";
            }
        }

        return (Misc.nh(lstr_Error));
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"InsAssociazioneOfPsXTipoContr",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
}


  // InsAssociazioneOfPs
  public String InsAssociazioneOfPs (DB_OggettoFatturazione pDB_OggettoFatturazione )
         throws CustomException, RemoteException
  {
    String lstr_OutDataDfv = "";   
    String lstr_Error = null;
    Object homeObject = null;
    Context lcls_Contesto = null;
    // Dichiarazione Oggetti per istanziare gli Ejb coinvolti 
    DB_OggettoFatturazione lDB_OggettoFatturazioneTemp = null;
    Ent_OggettiFatturazione lEnt_OggettiFatturazione = null;
    Ent_OggettiFatturazioneHome lEnt_OggettiFatturazioneHome = null;
    Ent_AssocOggettiFatturazione lEnt_AssocOggettiFatturazione = null;
    Ent_AssocOggettiFatturazioneHome lEnt_AssocOggettiFatturazioneHome = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    Ent_ProdottiServizi lEnt_ProdottiServizi = null;
    Ent_ProdottiServiziHome lEnt_ProdottiServiziHome = null;
    int lint_Result = 0;
    
    try 
    {
      if ( pDB_OggettoFatturazione != null )
      {
        lcls_Contesto = new InitialContext();

        // Instanzio gli Ejb coinvolti nell'inserimento
        homeObject = lcls_Contesto.lookup("Ent_OggettiFatturazione");
        lEnt_OggettiFatturazioneHome = (Ent_OggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_OggettiFatturazioneHome.class);
        lEnt_OggettiFatturazione = lEnt_OggettiFatturazioneHome.create();

        homeObject = lcls_Contesto.lookup("Ent_AssocOggettiFatturazione");
        lEnt_AssocOggettiFatturazioneHome = (Ent_AssocOggettiFatturazioneHome)PortableRemoteObject.narrow(homeObject, Ent_AssocOggettiFatturazioneHome.class);
        lEnt_AssocOggettiFatturazione = lEnt_AssocOggettiFatturazioneHome.create();

        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();

        homeObject = lcls_Contesto.lookup("Ent_ProdottiServizi");
        lEnt_ProdottiServiziHome = (Ent_ProdottiServiziHome)PortableRemoteObject.narrow(homeObject, Ent_ProdottiServiziHome.class);
        lEnt_ProdottiServizi = lEnt_ProdottiServiziHome.create();

        // Se ho instanziato correttamente gli Ejb proseguo
        if (( lEnt_OggettiFatturazione != null ) && ( lEnt_Contratti != null ) && ( lEnt_ProdottiServizi != null ))
        {
          // Acquisisco le massime date del Contratto nella tabella Contratti, Prodotti Servizi e Oggetti Fatturazione
          String lstr_MaxDateXContratto = Misc.nh(lEnt_Contratti.getMaxDateXContratto(StaticContext.INSERT, pDB_OggettoFatturazione.getCODE_CONTR()));
          String lstr_MaxDateXPS = Misc.nh(lEnt_ProdottiServizi.getMaxDateXPs(StaticContext.INSERT, pDB_OggettoFatturazione.getCODE_PS()));
          String lstr_MaxDateXOF = Misc.nh(lEnt_OggettiFatturazione.getMaxDateXOF(StaticContext.INSERT, pDB_OggettoFatturazione.getCODE_OGG_FATRZ()));

          // Stabilisco quale delle tre è la maggiore
          String lstr_DataMax = new String();
          if ( DataFormat.setData(lstr_MaxDateXContratto,StaticContext.FORMATO_DATA).getTime().getTime() >
               DataFormat.setData(lstr_MaxDateXPS,StaticContext.FORMATO_DATA).getTime().getTime() )
            lstr_DataMax = lstr_MaxDateXContratto;
          else
            lstr_DataMax = lstr_MaxDateXPS;

          if ( DataFormat.setData(lstr_MaxDateXOF,StaticContext.FORMATO_DATA).getTime().getTime() >
               DataFormat.setData(lstr_DataMax,StaticContext.FORMATO_DATA).getTime().getTime() )
            lstr_DataMax = lstr_MaxDateXOF;

          // Confronto la massima data acquisita con la DATA_INIZIO_VALID_OF_PS digitata a video
          if ( DataFormat.setData(pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime() <DataFormat.setData(lstr_DataMax,StaticContext.FORMATO_DATA).getTime().getTime())
          {
            lstr_Error = "3166";
          }
          else
          {
            if ( lEnt_AssocOggettiFatturazione.countOFPSGiaPresenti(StaticContext.INSERT,
                            pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                            pDB_OggettoFatturazione.getCODE_CONTR(),
                            pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                            pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                            pDB_OggettoFatturazione.getCODE_TIPO_CAUS(),
                            pDB_OggettoFatturazione.getCODE_PS(),
                            "").intValue() > 0 )
            {
              String lstr_DataMaxFV = "";    
              String lstr_DataMinIV = "";
              // Acquisisco il range di deta composto dalla data Max di Fine Validità e la data Minima di Inizio Validità
              Vector lvct_RangeDate = lEnt_AssocOggettiFatturazione.getMinMaxDateOFPS(StaticContext.INSERT,
                                          pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                          pDB_OggettoFatturazione.getCODE_CONTR(),
                                          pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                                          pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                          pDB_OggettoFatturazione.getCODE_TIPO_CAUS(),
                                          pDB_OggettoFatturazione.getCODE_PS(),
                                          "");

              if ( lvct_RangeDate  != null && lvct_RangeDate.size() > 0 )
              {
                lstr_DataMaxFV = Misc.nh((String)lvct_RangeDate.get(0));    
                lstr_DataMinIV = Misc.nh((String)lvct_RangeDate.get(1));
              }

              // Acquisco il numero delle associazioni fra oggetti fatturazione e prodotti servizi 
              if ( lEnt_AssocOggettiFatturazione.countOFPSAperti(StaticContext.INSERT,
                              pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                              pDB_OggettoFatturazione.getCODE_CONTR(),
                              pDB_OggettoFatturazione.getCODE_OGG_FATRZ(),
                              pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                              pDB_OggettoFatturazione.getCODE_TIPO_CAUS(),
                              pDB_OggettoFatturazione.getCODE_PS(),
                              "").intValue() == 0 )
              {
                if ((Misc.nh(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()).equalsIgnoreCase("")) && 
                    ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                       <= (DataFormat.setData(lstr_DataMaxFV,StaticContext.FORMATO_DATA).getTime().getTime())))
                {
                  lstr_Error = "3167";
                }
                else
                {
                  if (
                      ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_INIZIO_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime())
                        >= (DataFormat.setData(lstr_DataMaxFV,StaticContext.FORMATO_DATA).getTime().getTime()))
                      &&
                      ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime()) >=
                       (DataFormat.setData(lstr_DataMinIV,StaticContext.FORMATO_DATA).getTime().getTime()))
                     )
                  {
                    lstr_Error = "3167";
                  }
                }
              }
              else
              {
                if ((Misc.nh(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS()).equalsIgnoreCase("")) || 
                    ((DataFormat.setData(pDB_OggettoFatturazione.getDATA_FINE_VALID_OF_PS(),StaticContext.FORMATO_DATA).getTime().getTime()) >=
                     (DataFormat.setData(lstr_DataMinIV,StaticContext.FORMATO_DATA).getTime().getTime())))
                {
                  lstr_Error = "3169";
                }
              }
            }
          }
        }
        else
        {
          lstr_Error = "3166";
        }

        // Se non ci sono errori ed esiste l'oggetto di fatturazione
        if ((lstr_Error == null) && (lEnt_OggettiFatturazione.countOFXOggFatrz(StaticContext.INSERT,pDB_OggettoFatturazione.getCODE_OGG_FATRZ()).intValue() == 1))
        {
            DB_OggettoFatturazione lDB_OggFatrz = (DB_OggettoFatturazione)lEnt_AssocOggettiFatturazione.getCampiInsOFPS(StaticContext.INSERT,
                                                                        pDB_OggettoFatturazione.getCODE_TIPO_CONTR(),
                                                                        pDB_OggettoFatturazione.getCODE_CONTR(),
                                                                        pDB_OggettoFatturazione.getCODE_PREST_AGG(),
                                                                        pDB_OggettoFatturazione.getCODE_PS(),
                                                                        "").get(0);
            pDB_OggettoFatturazione.setCODE_PR_PS_PA_CONTR(lDB_OggFatrz.getCODE_PR_PS_PA_CONTR());

            // Procede all'inserimento dell'associazione oggetti fatturazione / prodotti servizi
            lint_Result = lEnt_AssocOggettiFatturazione.insAssociazioneOfPs(StaticContext.INSERT,pDB_OggettoFatturazione).intValue();
            lstr_Error = "";
        }
        else
        {
          if (( lstr_Error = this.getErrorMessage(lcls_Contesto, lstr_Error)) == null)
          {
            lstr_Error = "Errore : Contratto, PS o OF risultano non validi";
          }
        }
      }
      else
      {
        lstr_Error = "Errore : I parametri non risultano non validi";
      }
    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"InsAssociazioneOfPs",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

    return lstr_Error;
  }
}