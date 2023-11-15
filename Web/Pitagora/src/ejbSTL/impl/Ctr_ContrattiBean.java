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
import java.util.GregorianCalendar;


public class Ctr_ContrattiBean extends AbstractClassicEJB implements SessionBean 
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
  
  // getAccountStatoProvvisorio
  public Vector getAccountStatoProvvisorio (Vector pvct_AccountSelezionati,
                                                String pstr_TipoContratto,
                                                String pstr_CodeFunz)
     throws CustomException, RemoteException
  {
    Vector lvct_ElabAccount = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountFound = null;
    try 
    {
      if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Contratti
        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();

        for (int ind=0; ind < pvct_AccountSelezionati.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)pvct_AccountSelezionati.get(ind);
          lvct_AccountFound = lEnt_Contratti.getAccountStatoProvvisorio(StaticContext.LIST,
                                              lDB_AccountSelezionato.getCODE_ACCOUNT(),
                                              lDB_AccountSelezionato.getCODE_GEST(),
                                              pstr_TipoContratto,
                                              pstr_CodeFunz);
                                              
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
									"getAccountStatoProvvisorio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lvct_ElabAccount;
  }

  // getAccountSpeComNoCong
  public Vector getAccountSpeComNoCong (Vector pvct_AccountSelezionati, String pstr_TipoContratto)
                            throws CustomException, RemoteException
  {
    Vector lvct_ElabAccount = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountFound = null;
    try 
    {
      if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Contratti
        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();

        for (int ind=0; ind < pvct_AccountSelezionati.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)pvct_AccountSelezionati.get(ind);
          lvct_AccountFound = lEnt_Contratti.getAccountSpeComNoCong(StaticContext.LIST,
                                                   pstr_TipoContratto,
                                                   lDB_AccountSelezionato.getCODE_ACCOUNT());
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
									"getAccountSpeComNoCong",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lvct_ElabAccount;
  }

  // getAccountValAttiva
  public Vector getAccountValAttiva (Vector pvct_AccountSelezionati, 
                                     String pstr_TipoContratto,
                                     String pstr_CodeCicloFatrz,
                                     String pstr_IstanzaCicloFatrz)
     throws CustomException, RemoteException
  {
    Vector lvct_ElabAccount = new Vector();
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountFound = null;
    try 
    {
      if ( pvct_AccountSelezionati != null && pvct_AccountSelezionati.size() > 0)
      {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_Contratti
        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();

        for (int ind=0; ind < pvct_AccountSelezionati.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)pvct_AccountSelezionati.get(ind);
          lvct_AccountFound = lEnt_Contratti.getAccountValAttiva(StaticContext.LIST,
                                                                pstr_TipoContratto,
                                                                pstr_CodeCicloFatrz,
                                                                pstr_IstanzaCicloFatrz,
                                                                lDB_AccountSelezionato.getCODE_ACCOUNT());
                                              
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
									"getAccountValAttiva",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    return lvct_ElabAccount;
  }


  // insAccountParamValoriz
  public String insAccountParamValoriz ()
    throws CustomException, RemoteException
  {
    String lstr_Error="";
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    Ent_Batch lEnt_Batch = null;
    Ent_BatchHome lEnt_BatchHome = null;
    DB_Account lDB_AccountSelezionato = null;
    Vector lvct_AccountNotFound = null;
    try 
    {
      // Acquisisco il contesto del componente
      lcls_Contesto = new InitialContext();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Contratti");
      lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
      lEnt_Contratti = lEnt_ContrattiHome.create();

      // Istanzio una classe Ent_Contratti
      homeObject = lcls_Contesto.lookup("Ent_Batch");
      lEnt_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
      lEnt_Batch = lEnt_BatchHome.create();

      lvct_AccountNotFound = lEnt_Contratti.getAccountXParamVal(StaticContext.INSERT);
      if ( lvct_AccountNotFound != null )
      {
        for ( int ind=0; ind < lvct_AccountNotFound.size(); ind++)
        {
          lDB_AccountSelezionato = (DB_Account)lvct_AccountNotFound.get(ind);
          GregorianCalendar lcld_Data = DataFormat.setData(lDB_AccountSelezionato.getDATA_INIZIO_VALID(),
                                                           StaticContext.FORMATO_DATA);

          // Calcolo Data Inizio Ciclo Fatturazione ( = Num_Giorno_Inizio_Ciclo/mm/yyyy )
          lcld_Data = DataFormat.setData(Integer.parseInt(lDB_AccountSelezionato.getVALO_GG_INIZIO_CICLO()),
                                         lcld_Data.get(GregorianCalendar.MONTH)+1,
                                         lcld_Data.get(GregorianCalendar.YEAR));
          lDB_AccountSelezionato.setDATA_INIZIO_CICLO_FATRZ(DataFormat.convertiData(lcld_Data,StaticContext.FORMATO_DATA));

          // Calcolo Data Fine Ciclo Fatturazione ( = Data Inizio Ciclo + 1 mese - 1 giorno )
          lcld_Data = DataFormat.rollData(lcld_Data.getTime().getTime(), 0, 1,-1);
          lDB_AccountSelezionato.setDATA_FINE_CICLO_FATRZ(DataFormat.convertiData(lcld_Data,StaticContext.FORMATO_DATA));

          lDB_AccountSelezionato.setDATA_INIZIO_PERIODO(lDB_AccountSelezionato.getDATA_INIZIO_VALID());
          lDB_AccountSelezionato.setTIPO_FLAG_ERR_BLOCC("N"); //JEFF nella progettazione era a NULL, ma mi sembra più corretto così
          lDB_AccountSelezionato.setTIPO_FLAG_STATO_CONG("N");
          lEnt_Batch.insParamValoriz(StaticContext.INSERT,lDB_AccountSelezionato);            
        }
      }
      else
      {
        lstr_Error = "Errore nel reperire gli Account per inserimento nei parametri di Valorizzazione";
      }
      return (lstr_Error);
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAccountParamValoriz",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}
  }

  // getAccountXCalcoloParametriClassiSconto
  public Vector getAccountXCalcoloParametriClassiSconto ()
                            throws CustomException, RemoteException
  {
    Object homeObject = null;
    Context lcls_Contesto = null;
    Ent_Contratti lEnt_Contratti = null;
    Ent_ContrattiHome lEnt_ContrattiHome = null;
    Vector lvct_Account = null;
    Vector lvct_Periodo = null;
    //Vector lvct_ListaAccountFinale = new Vector();
    Vector lvct_Appoggio = new Vector();
    DB_Account lDB_AccountAppoggio = null;
    try 
    {
        // Acquisisco il contesto del componente
        lcls_Contesto = new InitialContext();
        // Istanzio una classe Ent_Contratti
        homeObject = lcls_Contesto.lookup("Ent_Contratti");
        lEnt_ContrattiHome = (Ent_ContrattiHome)PortableRemoteObject.narrow(homeObject, Ent_ContrattiHome.class);
        lEnt_Contratti = lEnt_ContrattiHome.create();
        //Periodo (esiste sempre un record)

        lvct_Periodo = (Vector)lEnt_Contratti.getPeriodoParamClasSconto();

        // 17032003 Controllo su presenza di periodi 
        if (lvct_Periodo.isEmpty() == true)
          return lvct_Appoggio;
        // ----------------------------------------
        
		
		DB_Account lDB_AccountPeriodo = (DB_Account)lvct_Periodo.elementAt(0);
		        
		/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/		
		
		lvct_Appoggio = lEnt_Contratti.GetlistaAccountParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                      lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL());
		
		return lvct_Appoggio;
		/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/		
				
				
        

		/*
        lvct_Account = (Vector)lEnt_Contratti.getAccountParamClasSconto();
        for (int i=0; i< lvct_Account.size(); i++)
        {
          DB_Account lDB_Account = (DB_Account)lvct_Account.elementAt(i);
          //Per ogni account...controllo quanti gestori ci sono
          Integer lint_CountGestori = (Integer)lEnt_Contratti.countGestoriParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                          lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                          lDB_Account.getCODE_GEST());
          if(lint_CountGestori.intValue()>1)
          {
            Vector lvct_Appoggio = new Vector();


            Double ldbl_Sum = (Double)lEnt_Contratti.getSumTotSpesaParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                     lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                     lDB_Account.getCODE_GEST());
            */
			
			                                                               
            /* 14032003 eliminata in quanto se il vettore di ritorno non è valorizzato all'elemento 0, va in eccezione 
            lDB_AccountAppoggio = (DB_Account)lEnt_Contratti.GetlistaAccountParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                          lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                          lDB_Account.getCODE_GEST(),
                                                                                          null).elementAt(0);*/
            
			/*
            lvct_Appoggio = lEnt_Contratti.GetlistaAccountParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                          lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                          lDB_Account.getCODE_GEST(),
                                                                                     null);
			*/
			
			
			/*
            if (lvct_Appoggio.isEmpty() == false)
            {
                lDB_AccountAppoggio = (DB_Account) lvct_Appoggio.elementAt(0); 
                lDB_AccountAppoggio.setIMPT_TOT_SPESA_COMPL(ldbl_Sum.toString());
                lvct_ListaAccountFinale.addElement(lDB_AccountAppoggio);
            }
           
            
          }else //= 1
          {
            Vector lvct_Appoggio = new Vector();
			*/
            /* 14032003 eliminata in quanto se il vettore di ritorno non è valorizzato all'elemento 0, va in eccezione 
            lDB_AccountAppoggio = (DB_Account)lEnt_Contratti.GetlistaAccountParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                          lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                          lDB_Account.getCODE_GEST(),
                                                                                          null).elementAt(0);
            */
			/*
            lvct_Appoggio = lEnt_Contratti.GetlistaAccountParamClasSconto(lDB_AccountPeriodo.getDATA_MM_RIF_SPESA_COMPL(),
                                                                                          lDB_AccountPeriodo.getDATA_AA_RIF_SPESA_COMPL(),
                                                                                          lDB_Account.getCODE_GEST(),
                                                                                          null);
            if (lvct_Appoggio.isEmpty() == false)
            {
                lDB_AccountAppoggio = (DB_Account) lvct_Appoggio.elementAt(0); 
                lvct_ListaAccountFinale.addElement(lDB_AccountAppoggio);
            }
          }*/
          //aggiungo il databean al vettore finale
//           lvct_ListaAccountFinale.addElement(lDB_AccountAppoggio);
        //}
        
    }
    catch(Exception lexc_Exception)
    {
		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountXCalcoloParametriClassiSconto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
	}

    //return lvct_ListaAccountFinale;
	//return lvct_Appoggio;
  }


}