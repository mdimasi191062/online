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
import java.sql.*;

public class Ctr_InventariBean extends AbstractClassicEJB implements SessionBean 
{
  int isCompoModif ;
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

  private int isComponenteTerminazione (Vector vct_ParInventariAnag, String strParCodeInvent, String strpropagaDesc1, int eMODIFICATO )  {
     int isTerminazione = 0;
     Object objAbsAnag = null;
       if (vct_ParInventariAnag!=null){
          for (int a = 0;a < vct_ParInventariAnag.size();a++){
                    
          objAbsAnag = vct_ParInventariAnag.get(a);
          
          if (objAbsAnag instanceof  DB_Invent_RPVD   ) {
             DB_Invent_RPVD data_inventarioRPVD = (DB_Invent_RPVD) vct_ParInventariAnag.get(a);
             // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioRPVD.getCODE_INVENT()) ) {
                  if (data_inventarioRPVD.getDESC_FLUSSO_TERMINAZ().equalsIgnoreCase("T") && !strpropagaDesc1.equals("0")  && eMODIFICATO !=1 ){
                    isTerminazione= 1;
                  }
     
              }
            }
          }
       } 
        return isTerminazione;     
   }            

 
    private int trovaTipoCausaliNoVariazione ( String strCodeTipoCausale, Vector vct_TipoCausaliNoVariazione )  {

        int locCompo = -1;
       DB_Servizio localTipoCausaliNoVariazione;
        for (int a = 0;a < vct_TipoCausaliNoVariazione.size();a++){
         localTipoCausaliNoVariazione= (DB_Servizio) vct_TipoCausaliNoVariazione.get(a);
            if ( strCodeTipoCausale.equals(localTipoCausaliNoVariazione.getDESC_SERVIZIO() )) locCompo = a; 
        }

        return locCompo;
    }
 
  private int trovaComponente ( String strCodeIstanzaCompo, Vector vct_InventariCompo )  {

      DB_InventCompo localCompo;
      int locCompo = -1;
      for (int a = 0;a < vct_InventariCompo.size();a++){
        localCompo = (DB_InventCompo) vct_InventariCompo.get(a);
        if ( strCodeIstanzaCompo.equals(localCompo.getCODE_ISTANZA_COMPO()) ) locCompo = a; 
      }

      return locCompo;
  }

  private int trovaPrestazione ( String strCodeIstanzaPrest, Vector vct_InventariPrest )  {

      DB_InventPrest localPrest;
      int locPrest = -1;
      for (int a = 0;a < vct_InventariPrest.size();a++){
        localPrest = (DB_InventPrest) vct_InventariPrest.get(a);
        if ( strCodeIstanzaPrest.equals(localPrest.getCODE_ISTANZA_PREST_AGG())) locPrest = a; 
      }
      //if (locPrest == 0)
        //locPrest = 1;
      return locPrest;
  }

  private Vector trovaPrestazioneByCodeIstanzaCompo ( String strCodeIstanzaCompo, Vector vct_InventariPrest )  {

      DB_InventPrest localPrest;
      Vector locPrest = new Vector();
      for (int a = 0;a < vct_InventariPrest.size();a++){
        localPrest = (DB_InventPrest) vct_InventariPrest.get(a);
        if ( strCodeIstanzaCompo.equals(localPrest.getCODE_ISTANZA_COMPO())) {
         Integer appo = new Integer(a);
         locPrest.add(appo);
        }
      }

      return locPrest;
  }

  private Integer inserisciProdotto (Ent_Inventari lEnt_ParInventari , 
  Vector vct_InventariProd, Vector vct_InventariAnag,Vector p_vct_InventariCompo_x_insprodotto, Integer intParID_Evento,String strpropagaDesc1 )
  throws CustomException, RemoteException{
        Integer lrs_Esecuzione = new Integer(0);
        Integer intReturnAnag = new Integer(0);

        try {
          DB_InventProd data_InvProdotto = (DB_InventProd) vct_InventariProd.get(0);
          DB_PreinventarioProdotti locProdotto = new DB_PreinventarioProdotti();

          /* Se la componente non ha subito modifiche si tratta di una rettifica di un attivazione o cessazione */
          if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("-1") )  {
              if ( data_InvProdotto.getCODE_STATO_ELEM().equals("2")) {
                locProdotto.setCODE_EVENTO("4");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_CES());    
              } else if ( data_InvProdotto.getCODE_STATO_ELEM().equals("1") || data_InvProdotto.getCODE_STATO_ELEM().equals("5")) {
                locProdotto.setCODE_EVENTO("1");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
              }
          /*MoS 18/11/2010 Se è Cessazione CODE_EVENTO("4") a prescindere dallo stato CODE_STATO_ELEM_PREC */
          //========================================================================== 
        }else if ( data_InvProdotto.getCODE_STATO_ELEM().equals("2")) {
            locProdotto.setCODE_EVENTO("4");
            locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_CES());    
          }
                 /*MoS 19/10/2010 Anomalia Rettifica Cessazione */
       //==========================================================================
          else  if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("2") ) {
              locProdotto.setCODE_EVENTO("4");
              locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_CES());
          } 
       //==========================================================================
        //Variaione per cessazione 19/11/2010
        else  if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("3") && data_InvProdotto.getCODE_STATO_ELEM().equals("1")) {
              locProdotto.setCODE_EVENTO("2");
              locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
        }
          else  if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("3") ) {
              locProdotto.setCODE_EVENTO("2");
              locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          } 
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("1") ) {
                locProdotto.setCODE_EVENTO("1");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          } 
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("5") ) {
                locProdotto.setCODE_EVENTO("5");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("7") ) {
                locProdotto.setCODE_EVENTO("1");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("4") ) {
                locProdotto.setCODE_EVENTO("3");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("10") ) {
                locProdotto.setCODE_EVENTO("1");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("9") ) {
                locProdotto.setCODE_EVENTO("2");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }
          else if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("8") ) {
                locProdotto.setCODE_EVENTO("4");
                locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());
          }       
         //MoS anomalia TIPO CAUSALI NO VARIAZIONE
         //17/06/2011
         //se NON è Mercato e se causale della componente rientra nelle causali contenute
         // nella table TIPO_CAUSALI_NO_VARIAZIONI impongo al prodotto la causale della componente
         //=============================================================
         if (p_vct_InventariCompo_x_insprodotto != null){
         if (!data_InvProdotto.getCODE_OFFERTA().equalsIgnoreCase("52")){
             Vector vct_TipoCausaliNoVariazione= lEnt_ParInventari.getTipoCausaliNoVariazione();
             String compoCausale ="";
              for ( int z = 0;z < p_vct_InventariCompo_x_insprodotto.size();z++) {
                     
                  DB_InventCompo data_inventarioCompo = (DB_InventCompo) p_vct_InventariCompo_x_insprodotto.get(z);            
                  if (data_inventarioCompo.eMODIFICATO()==1){
                     compoCausale = data_inventarioCompo.getTIPO_CAUSALE_ATT();                
                    if (trovaTipoCausaliNoVariazione(compoCausale,vct_TipoCausaliNoVariazione)!=-1){
                        locProdotto.setCODE_TIPO_EVENTO           (data_inventarioCompo.getTIPO_CAUSALE_ATT());
                    }
                  }           
              } 
         }
         }
          //=============================================================          
          //valorizzo i campi da popolare per il preinventario prodotti
          locProdotto.setID_SISTEMA_MITTENTE        ("GENEVENTI_BILL");    
          locProdotto.setID_EVENTO                  ("HD"+intParID_Evento.intValue());    
          locProdotto.setID_TRANSAZIONE             (""); 
//          locProdotto.setCODE_TIPO_EVENTO           (data_InvProdotto.getTIPO_CAUSALE_ATT());    
          locProdotto.setCODE_TIPO_EVENTO_HD        ("1");    
          locProdotto.setTIPO_ELAB                  ("H");    
          locProdotto.setCODE_ACCOUNT               (data_InvProdotto.getCODE_ACCOUNT());    
          locProdotto.setCODE_OFFERTA               (data_InvProdotto.getCODE_OFFERTA());    
          locProdotto.setCODE_SERVIZIO              (data_InvProdotto.getCODE_SERVIZIO());    
          locProdotto.setCODE_PRODOTTO              (data_InvProdotto.getCODE_PRODOTTO());    
          locProdotto.setCODE_ISTANZA_PROD          (data_InvProdotto.getCODE_ISTANZA_PROD());    
          //MoS 17/11/2010
          //NEL CASO DI CESSAZIONE 
           if  ( data_InvProdotto.getCODE_STATO_ELEM().equals("2") ) {
             locProdotto.setDATA_EFFETTIVA_EVENTO      (data_InvProdotto.getDATA_CESSAZ());    
           }else {
             locProdotto.setDATA_EFFETTIVA_EVENTO      (data_InvProdotto.getDATA_INIZIO_FATRZ());    
           }
        
      
          locProdotto.setDATA_RICEZIONE_ORDINE      (data_InvProdotto.getDATA_DRO());    
     
          locProdotto.setDATA_RICHIESTA_CESSAZ      (data_InvProdotto.getDATA_CESSAZ());    
          locProdotto.setDATA_CREAZ                 (data_InvProdotto.getDATA_CREAZ());    
          locProdotto.setDATA_ULTIMA_FATRZ          ("");    
          locProdotto.setQNTA_VALO                  (data_InvProdotto.getQNTA_VALO());    
          if  ( data_InvProdotto.getCODE_STATO_ELEM_PREC().equals("-1") && data_InvProdotto.getCODE_STATO_ELEM().equals("5") )  {
               locProdotto.setTIPO_FLAG_CONSISTENZA      ("N");          
          }else{
               locProdotto.setTIPO_FLAG_CONSISTENZA      ("S");    
          }
          locProdotto.setDATA_INIZIO_NOL_ORIGINALE  (data_InvProdotto.getDATA_DIN());    
          locProdotto.setCODICE_PROGETTO            (data_InvProdotto.getCODICE_PROGETTO()); 
          
          //Mos 26/07/2011
          locProdotto.setINVARIANT_ID            (data_InvProdotto.getINVARIANT_ID());
          // inserimento nel preinventario prodotti
          lEnt_ParInventari.insPreinventarioProdotti(locProdotto);
          intReturnAnag = inserisciAnagrafica(vct_InventariAnag, 
                              lEnt_ParInventari,
                              data_InvProdotto.getCODE_SERVIZIO(),
                              data_InvProdotto.getCODE_ISTANZA_PROD(),
                              data_InvProdotto.getCODE_INVENT(),
                              "P",
                              intParID_Evento,
                              data_InvProdotto.getCODE_STATO_ELEM(),
                               strpropagaDesc1,0);
        }
        catch(RemoteException lexc_Exception){
          throw new RemoteException("inserisciProdotto" + lexc_Exception.getMessage());
        }
        catch(Exception lexc_Exception){
          throw new CustomException(lexc_Exception.toString(),
                      "",
                    "inserisciProdotto",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
      }
        
      return lrs_Esecuzione;
  };

  private Integer inserisciComponente (Ent_Inventari lEnt_ParInventari , 
  Vector vct_InventarioProd, Vector vct_InventariCompo, 
  Vector vct_InventariAnag, Integer intParID_Evento , int i, boolean spalmaDIF,Vector vPropagaElem,String strpropagaDesc1)
  throws CustomException, RemoteException{
          Integer lrs_Esecuzione = new Integer(0);
          Integer intReturnAnag = new Integer(0);
      


          try {
             DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(i);
             DB_InventProd data_inventarioProd = (DB_InventProd) vct_InventarioProd.get(0);
             DB_PreinventarioComponenti locaCompo = new DB_PreinventarioComponenti();
           if (data_inventarioCompo.getINSERITO() == 0){ 
                  // Se la componente non ha subito modifiche si tratta di una rettifica di un attivazione o cessazione 
                  if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("-1") )  {
                          if ( data_inventarioCompo.getCODE_STATO_ELEM().equals("2")) {
                            locaCompo.setCODE_EVENTO("4");
                          } else {
                            locaCompo.setCODE_EVENTO("1");
                          }
                }  else if ( data_inventarioCompo.getCODE_STATO_ELEM().equals("2")) {
                     /*MoS 18/11/2010 Se è Cessazione CODE_EVENTO("4") a prescindere dallo stato CODE_STATO_ELEM_PREC */
                      //========================================================================== 
                      locaCompo.setCODE_EVENTO("4");
               
                 } else  if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("3") ) {
                      locaCompo.setCODE_EVENTO("2");
                  } 
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("1") ) {
                        locaCompo.setCODE_EVENTO("1");
                  } 
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("5") ) {
                        locaCompo.setCODE_EVENTO("5");
                  }
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("7") ) {
                        locaCompo.setCODE_EVENTO("1");
                  }
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("4") ) {
                        locaCompo.setCODE_EVENTO("3");
                  }
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("10") ) {
                        locaCompo.setCODE_EVENTO("1");
                  }
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("9") ) {
                        locaCompo.setCODE_EVENTO("2");
                  }
                  else if  ( data_inventarioCompo.getCODE_STATO_ELEM_PREC().equals("8") ) {
                        locaCompo.setCODE_EVENTO("4");
                  }
    
                  //valorizzo i campi da popolare per il preinventario componenti
                  locaCompo.setID_SISTEMA_MITTENTE               ("GENEVENTI_BILL");    
                  locaCompo.setID_EVENTO                         ("HD"+intParID_Evento.intValue());    
                  //locaCompo.setCODE_PRODOTTO                     (data_inventarioCompo.getCODE_PRODOTTO());
                   //PROPAGO PRODOTTO
    //               if ("1"==vPropagaElem.get(0)){
                  locaCompo.setCODE_PRODOTTO                     (data_inventarioProd.getCODE_PRODOTTO());
     //              }
                  locaCompo.setCODE_COMPONENTE                   (data_inventarioCompo.getCODE_COMPONENTE());    
                  locaCompo.setCODE_ISTANZA_PROD                 (data_inventarioCompo.getCODE_ISTANZA_PROD());    
                  locaCompo.setCODE_ISTANZA_COMPO                (data_inventarioCompo.getCODE_ISTANZA_COMPO());    
    
                  locaCompo.setDATA_EFFETTIVA_EVENTO      (data_inventarioCompo.getDATA_DEE());    
    
                
                /*MS se la modifica del prodotto è stata spalmata su questa componente */
                  if (spalmaDIF) {
                     locaCompo.setDATA_EFFETTIVA_EVENTO(data_inventarioProd.getDATA_INIZIO_FATRZ());
                 }else if ("1"==vPropagaElem.get(2)){
                     locaCompo.setDATA_EFFETTIVA_EVENTO(data_inventarioProd.getDATA_INIZIO_FATRZ());
                     //MoS 17/11/2010 NEL CASO DI CESSAZIONE    
                 }else if (data_inventarioCompo.getCODE_STATO_ELEM().equals("2") ) {
                       locaCompo.setDATA_EFFETTIVA_EVENTO      (data_inventarioCompo.getDATA_CESSAZ());    
                 }else{
                    
                       locaCompo.setDATA_EFFETTIVA_EVENTO(data_inventarioCompo.getDATA_INIZIO_FATRZ());   
                     }
                   
    
                 
                   
                //PROPAGO DATA RICEZIONE ORDINE
                if ("1"==vPropagaElem.get(1)){ 
                  locaCompo.setDATA_RICEZIONE_ORDINE             (data_inventarioProd.getDATA_DRO());     
                }else {
                  locaCompo.setDATA_RICEZIONE_ORDINE             (data_inventarioCompo.getDATA_DRO());    
                }
    
                  locaCompo.setDATA_RICHIESTA_CESSAZ             (data_inventarioCompo.getDATA_CESSAZ());    
                  locaCompo.setDATA_ULTIMA_FATRZ                 ("");    
                  locaCompo.setQNTA_VALO                         (data_inventarioCompo.getQNTA_VALO());    
                  locaCompo.setDATA_INIZIO_NOL_ORIGINALE         (data_inventarioCompo.getDATA_DIN()); 
                  
                //Mos 26/07/2011
                 locaCompo.setINVARIANT_ID            (data_inventarioCompo.getINVARIANT_ID());
                  
                  
                   
                   
                  data_inventarioCompo.eMODIFICATO();
                  
                  
                  data_inventarioCompo.annullaModifica();
    
                  data_inventarioCompo.setINSERITO();
    
                  // Inserisco la componente
                  lEnt_ParInventari.insPreinventarioComponenti(locaCompo);
            
            } // getINSERITO
                  intReturnAnag = inserisciAnagrafica(vct_InventariAnag, 
                                                      lEnt_ParInventari,
                                                      data_inventarioCompo.getCODE_SERVIZIO(),
                                                      data_inventarioCompo.getCODE_ISTANZA_PROD(),
                                                      data_inventarioCompo.getCODE_INVENT(),
                                                      "C",
                                                      intParID_Evento,
                                                      data_inventarioCompo.getCODE_STATO_ELEM(),
                                                      strpropagaDesc1,
                                                      isCompoModif);
          
            

          }
        catch(RemoteException lexc_Exception){
          throw new RemoteException("inserisciComponente" + lexc_Exception.getMessage());
        }
        catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "inserisciComponente",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
      }
        
      return lrs_Esecuzione;
  };

  private Integer inserisciPrestazioneAggiuntiva (Ent_Inventari lEnt_ParInventari ,
  Vector vct_InventariProd, Vector vct_InventariPrestAgg, Vector vct_InventariAnag, 
  Integer intParID_Evento, int i ,Vector vPropagaElem,String strpropagaDesc1 ,String propagaCodeCompo)
  throws CustomException, RemoteException{
          Integer lrs_Esecuzione = new Integer(0);
          Integer intReturnAnag  = new Integer(0);

    try {
      if(vct_InventariPrestAgg.size() > 0)
        System.out.println("vct_InventariPrestAgg.size() => " +vct_InventariPrestAgg.size());
      //DB_InventPrest data_inventarioPrest = (DB_InventPrest) vct_InventariPrestAgg.get(0);
      DB_InventPrest data_inventarioPrest = (DB_InventPrest) vct_InventariPrestAgg.get(i);
      DB_PreinventarioPrestAgg locaPrest = new DB_PreinventarioPrestAgg();
      DB_InventProd data_inventarioProd = (DB_InventProd) vct_InventariProd.get(0);
    if (data_inventarioPrest.getINSERITO() == 0){             
      // Se la componente non ha subito modifiche si tratta di una rettifica di un attivazione o cessazione 
      if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("-1") )  {
              if ( data_inventarioPrest.getCODE_STATO_ELEM().equals("2")) {
                locaPrest.setCODE_EVENTO("4");
              } else {
                locaPrest.setCODE_EVENTO("1");
              }
      }  else if ( data_inventarioPrest.getCODE_STATO_ELEM().equals("2")) {
             /*MoS 18/11/2010 Se è Cessazione CODE_EVENTO("4") a prescindere dallo stato CODE_STATO_ELEM_PREC */
              //========================================================================== 
              locaPrest.setCODE_EVENTO("4");
  
      }  else  if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("3") ) {
          locaPrest.setCODE_EVENTO("2");
      } 
      else if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("1") ) {
            locaPrest.setCODE_EVENTO("1");
      } 
      else if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("5") ) {
            locaPrest.setCODE_EVENTO("5");
      }
      else if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("7") ) {
            locaPrest.setCODE_EVENTO("1");
      }
      else if  ( data_inventarioPrest.getCODE_STATO_ELEM_PREC().equals("4") ) {
            locaPrest.setCODE_EVENTO("3");
      }

      //valorizzo i campi da popolare per il preinventario componenti
      locaPrest.setID_SISTEMA_MITTENTE               ("GENEVENTI_BILL");    
      locaPrest.setID_EVENTO                         ("HD"+intParID_Evento.intValue());    
      //locaPrest.setCODE_PRODOTTO                     (data_inventarioPrest.getCODE_PRODOTTO());
      locaPrest.setCODE_PRODOTTO                     (data_inventarioProd.getCODE_PRODOTTO());
     if (!propagaCodeCompo.equals("")){
      locaPrest.setCODE_COMPONENTE                   (propagaCodeCompo);    
     }else
     {
       locaPrest.setCODE_COMPONENTE                   (data_inventarioPrest.getCODE_COMPONENTE());    
     }
      locaPrest.setCODE_PREST_AGG                    (data_inventarioPrest.getCODE_PREST_AGG());  
      locaPrest.setCODE_ISTANZA_PROD                 (data_inventarioPrest.getCODE_ISTANZA_PROD());    
      locaPrest.setCODE_ISTANZA_COMPO                (data_inventarioPrest.getCODE_ISTANZA_COMPO());
      locaPrest.setCODE_ISTANZA_PREST_AGG            (data_inventarioPrest.getCODE_ISTANZA_PREST_AGG());

      locaPrest.setDATA_EFFETTIVA_EVENTO             (data_inventarioPrest.getDATA_DEE());    

       
        //PROPAGO DATA EFFETTIVO EVENTO
        if ("1"==vPropagaElem.get(2)){
            locaPrest.setDATA_EFFETTIVA_EVENTO      (data_inventarioProd.getDATA_INIZIO_FATRZ());    
        }else if  ( data_inventarioPrest.getCODE_STATO_ELEM().equals("2") ) {
            locaPrest.setDATA_EFFETTIVA_EVENTO      (data_inventarioPrest.getDATA_CESSAZ());   
        }else{
         
            locaPrest.setDATA_EFFETTIVA_EVENTO             (data_inventarioPrest.getDATA_INIZIO_FATRZ());    
         
        }

        //PROPAGO DATA RICEZIONE ORDINE
        if ("1"==vPropagaElem.get(1)){ 
          locaPrest.setDATA_RICEZIONE_ORDINE             (data_inventarioProd.getDATA_DRO());    
        }else{
          locaPrest.setDATA_RICEZIONE_ORDINE             (data_inventarioPrest.getDATA_DRO());    
        }

      locaPrest.setDATA_RICHIESTA_CESSAZ             (data_inventarioPrest.getDATA_CESSAZ());    
      locaPrest.setDATA_ULTIMA_FATRZ                 ("");    
      locaPrest.setQNTA_VALO                         (data_inventarioPrest.getQNTA_VALO());    
      locaPrest.setDATA_INIZIO_NOL_ORIGINALE         (data_inventarioPrest.getDATA_DIN()); 
      locaPrest.setINVARIANT_ID                      (data_inventarioPrest.getINVARIANT_ID()); 
      
      data_inventarioPrest.annullaModifica();

      data_inventarioPrest.setINSERITO();
      // Inserisco la componente
      lEnt_ParInventari.insPreinventarioPrestazioni      ( locaPrest );
    
    }//END GETINSERITO
      intReturnAnag = inserisciAnagrafica(vct_InventariAnag, 
                                          lEnt_ParInventari,
                                          data_inventarioPrest.getCODE_SERVIZIO(),
                                          data_inventarioPrest.getCODE_ISTANZA_PROD(),
                                          data_inventarioPrest.getCODE_INVENT(),
                                          "C",
                                          intParID_Evento,
                                          data_inventarioPrest.getCODE_STATO_ELEM(),
                                          strpropagaDesc1,
                                          0);
          
      }
      catch(RemoteException lexc_Exception){
        throw new RemoteException("inserisciPrestazioneAggiuntiva" + lexc_Exception.getMessage());
      }
      catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                  "inserisciPrestazioneAggiuntiva",
                  this.getClass().getName(),
                  StaticContext.FindExceptionType(lexc_Exception));
      }
        
      return lrs_Esecuzione;
  }
  
  private Integer inserisciAnagrafica ( Vector vct_ParInventariAnag, Ent_Inventari lEnt_ParInventari, 
  String strParServizio,String strCodeIstanzaProd, String strParCodeInvent, 
  String strParElemento, Integer intParID_Evento, String code_stato_elem, String strpropagaDesc1 , int isCompoModif)  
  throws CustomException, RemoteException{

        Object objAbsAnag = null;
        Integer lrs_Esecuzione = new Integer(0);
    DB_Invent_PP data_InventariAnagPP = null;
    DB_Invent_MP data_InventariAnagMP = null;    
    DB_Invent_RPVD data_InventariAnagRPVD = null;
    DB_Invent_ITC data_InventariAnagITC = null;    
    DB_Invent_ITC_REV data_InventariAnagITCREV = null;
    DB_Invent_ATM data_InventariAnagATM = null;    
    String stDescSedeCentrale1="";
        

        // Stacco una sequence per l'evento da elaborare
        //Integer intReturn = lEnt_ParInventari.getNewSequencePreinv();
        System.out.println("strParCodeInvent [" + strParCodeInvent + "]");
        System.out.println("strParElemento [" + strParElemento + "]");
        System.out.println("il valore della sequence estratta [" + intParID_Evento.intValue() + "]");
        try {
          //reperisco le informazioni anagrafiche della componente modificata
          if ( vct_ParInventariAnag == null )  {
              if (strParServizio.equals("3") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoRPVD(strCodeIstanzaProd);
              else if (strParServizio.equals("2") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoMP(strCodeIstanzaProd);
              else if (strParServizio.equals("1") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoPP(strCodeIstanzaProd);
              else if (strParServizio.equals("4") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoATM(strCodeIstanzaProd);
              else if (strParServizio.equals("5") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoITC(strCodeIstanzaProd);
              else if (strParServizio.equals("6") )
                vct_ParInventariAnag =  lEnt_ParInventari.getInventarioAnagraficoITCREV(strCodeIstanzaProd);
          }
        
          for (int a = 0;a < vct_ParInventariAnag.size();a++){
            objAbsAnag = vct_ParInventariAnag.get(a);
            
            if (objAbsAnag instanceof  DB_Invent_RPVD   ) {
              DB_Invent_RPVD data_inventarioRPVD = (DB_Invent_RPVD) objAbsAnag;


              // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioRPVD.getCODE_INVENT()) ) {
              

                DB_PreinventarioRPVD localRPVD = new DB_PreinventarioRPVD();
                
     /*           if (data_inventarioRPVD.getDESC_FLUSSO_TERMINAZ().equalsIgnoreCase("T") && !strpropagaDesc1.equals("0") && data_inventarioRPVD.getTAB().equalsIgnoreCase("C") ){
                    System.out.println("E' Terminazione non inserita");
                }else{
     */           
                //valorizzo i campi da popolare per il preinventario RPVD
                //MS 16/09/2011 DOPPIA MODIFICA==================================================
                System.out.println("INSERITO" +data_inventarioRPVD.getINSERITO() + " --- "  + data_inventarioRPVD.getCOMPO() );
                if (data_inventarioRPVD.getINSERITO().compareTo("")!=0){
                  //Delete da preinventario con parmetro data_inventarioRPVD.getINSERITO()
                   lEnt_ParInventari.removepreinvent(data_inventarioRPVD.getINSERITO());
                }else{
                 data_inventarioRPVD.setINSERITO("HD"+intParID_Evento.intValue()+ "@" + data_inventarioRPVD.getPROD() + "@" + data_inventarioRPVD.getCOMPO() + "@" + data_inventarioRPVD.getPREST_AGG()+ "@" + "RPVD");
                }
                //MS 16/09/2011 DOPPIA MODIFICA========
                localRPVD.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localRPVD.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localRPVD.setCODE_ISTANZA_PROD              (data_inventarioRPVD.getPROD());
                localRPVD.setCODE_ISTANZA_COMPO             (data_inventarioRPVD.getCOMPO());
                localRPVD.setCODE_ISTANZA_PREST_AGG         (data_inventarioRPVD.getPREST_AGG());
                if (code_stato_elem.equals("2")){
                  localRPVD.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localRPVD.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioRPVD.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{
                  localRPVD.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioRPVD.getDESC_NUM_ORDINE_CLIENTE());
                  localRPVD.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioRPVD.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                localRPVD.setDESC_FLUSSO_TERMINAZ           (data_inventarioRPVD.getDESC_FLUSSO_TERMINAZ());
                localRPVD.setDESC_TIPO_RETE                 (data_inventarioRPVD.getDESC_TIPO_RETE());

                localRPVD.setDESC_IMPIANTO_SEDE_1           (data_inventarioRPVD.getDESC_IMPIANTO_SEDE_1());
                localRPVD.setDESC_COMUNE_SEDE_1             (data_inventarioRPVD.getDESC_COMUNE_SEDE_1());
                localRPVD.setDESC_PROVINCIA_SEDE_1          (data_inventarioRPVD.getDESC_PROVINCIA_SEDE_1());
                localRPVD.setDESC_DTRT_SEDE_1               (data_inventarioRPVD.getDESC_DTRT_SEDE_1());
                
                if (!strpropagaDesc1.equals("0") && isCompoModif !=1 && strParElemento != "P" )
                {
                
                /* SOLO per RPVD PROPAGO ANCHE DESC SEDE 1*/
                 Vector vctParams = Misc.split(strpropagaDesc1,"@");
                      String strParam0 = "";
                      String strParam1 = "";
                      strParam0 = (String)vctParams.get(0);
                      strParam1 = (String)vctParams.get(1);
               
                  localRPVD.setDESC_SEDE_1                    (strParam0);
                  localRPVD.setDESC_CENTRALE_SEDE_1           (strParam1);
                }
                else{
                    localRPVD.setDESC_SEDE_1                    (data_inventarioRPVD.getDESC_SEDE_1());
                    localRPVD.setDESC_CENTRALE_SEDE_1           (data_inventarioRPVD.getDESC_CENTRALE_SEDE_1());
                }
                localRPVD.setDESC_SEDE_2                    (data_inventarioRPVD.getDESC_SEDE_2());
                localRPVD.setDESC_IMPIANTO_SEDE_2           (data_inventarioRPVD.getDESC_IMPIANTO_SEDE_2());
                localRPVD.setDESC_COMUNE_SEDE_2             (data_inventarioRPVD.getDESC_COMUNE_SEDE_2());
                localRPVD.setDESC_PROVINCIA_SEDE_2          (data_inventarioRPVD.getDESC_PROVINCIA_SEDE_2());
                localRPVD.setDESC_DTRT_SEDE_2               (data_inventarioRPVD.getDESC_DTRT_SEDE_2());
                localRPVD.setDESC_CENTRALE_SEDE_2           (data_inventarioRPVD.getDESC_CENTRALE_SEDE_2());
                data_inventarioRPVD.annullaModifica();

                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioRPVD(localRPVD);
                
//                }// END IF PER PROPAGAZIONE SOLO SU FLUSSO
                
              }
                          
            } else if (objAbsAnag instanceof  DB_Invent_PP   ) {
              System.out.println("Servizio PP");

              DB_Invent_PP data_inventarioPP = (DB_Invent_PP) objAbsAnag;

              // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioPP.getCODE_INVENT()) ) {
                DB_PreinventarioPP localPP = new DB_PreinventarioPP();
   
                //MS 16/09/2011 DOPPIA MODIFICA==================================================
                 System.out.println("INSERITO" +data_inventarioPP.getINSERITO() + " --- "  + data_inventarioPP.getCOMPO() );
                if (data_inventarioPP.getINSERITO().compareTo("")!=0){
                   //Delete da preinventario con parmetro data_inventarioPP.getINSERITO()
                    lEnt_ParInventari.removepreinvent(data_inventarioPP.getINSERITO());
                
                }else{
                   data_inventarioPP.setINSERITO("HD"+intParID_Evento.intValue()+ "@"+ data_inventarioPP.getPROD() + "@"+ data_inventarioPP.getCOMPO() + "@" + data_inventarioPP.getPREST_AGG()+ "@" + "PP");
                }
                //MS 16/09/2011 DOPPIA MODIFICA==================================================
                
                //valorizzo i campi da popolare per il preinventario PP
                localPP.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localPP.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localPP.setCODE_ISTANZA_PROD              (data_inventarioPP.getPROD());
                localPP.setCODE_ISTANZA_COMPO             (data_inventarioPP.getCOMPO());
                localPP.setCODE_ISTANZA_PREST_AGG         (data_inventarioPP.getPREST_AGG());
                if (code_stato_elem.equals("2")){
                  localPP.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localPP.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioPP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{  
                  localPP.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioPP.getDESC_NUM_ORDINE_CLIENTE());
                  localPP.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioPP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                localPP.setDESC_TIPO_TERMINAZIONE         (data_inventarioPP.getDESC_TIPO_TERMINAZIONE());
                localPP.setDESC_FRAZIONAMENTO             (data_inventarioPP.getDESC_FRAZIONAMENTO());
                localPP.setDESC_SEDE_1                    (data_inventarioPP.getDESC_SEDE_1());
                localPP.setDESC_TIPO_RETE_SEDE_1          (data_inventarioPP.getDESC_TIPO_RETE_SEDE_1());
                localPP.setDESC_IMPIANTO_SEDE_1           (data_inventarioPP.getDESC_IMPIANTO_SEDE_1());
                localPP.setDESC_COMUNE_SEDE_1             (data_inventarioPP.getDESC_COMUNE_SEDE_1());
                localPP.setDESC_PROVINCIA_SEDE_1          (data_inventarioPP.getDESC_PROVINCIA_SEDE_1());
                localPP.setDESC_DTRT_SEDE_1               (data_inventarioPP.getDESC_DTRT_SEDE_1());
                if (!strpropagaDesc1.equals("0") )
                {
                /*  for (int i = 0;i < vct_ParInventariAnag.size();i++){
                  data_InventariAnagPP = (DB_Invent_PP)vct_ParInventariAnag.get(i);
                  if (data_InventariAnagPP.getTAB().equals("P"))
                        stDescSedeCentrale1 = data_InventariAnagPP.getDESC_CENTRALE_SEDE_1();
                  } 
                 */ 
                  localPP.setDESC_CENTRALE_SEDE_1           (strpropagaDesc1);
                }
                else{
                localPP.setDESC_CENTRALE_SEDE_1           (data_inventarioPP.getDESC_CENTRALE_SEDE_1());
                }
                localPP.setDESC_SEDE_2                    (data_inventarioPP.getDESC_SEDE_2());
                localPP.setDESC_TIPO_RETE_SEDE_2          (data_inventarioPP.getDESC_TIPO_RETE_SEDE_2());
                localPP.setDESC_IMPIANTO_SEDE_2           (data_inventarioPP.getDESC_IMPIANTO_SEDE_2());
                localPP.setDESC_COMUNE_SEDE_2             (data_inventarioPP.getDESC_COMUNE_SEDE_2());
                localPP.setDESC_PROVINCIA_SEDE_2          (data_inventarioPP.getDESC_PROVINCIA_SEDE_2());
                localPP.setDESC_DTRT_SEDE_2               (data_inventarioPP.getDESC_DTRT_SEDE_2());
                localPP.setDESC_CENTRALE_SEDE_2           (data_inventarioPP.getDESC_CENTRALE_SEDE_2());
                data_inventarioPP.annullaModifica();

                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioPP(localPP);
              }

            } else if (objAbsAnag instanceof  DB_Invent_MP   ) {
              System.out.println("Servizio MP");
              DB_Invent_MP data_inventarioMP = (DB_Invent_MP) objAbsAnag;

              // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioMP.getCODE_INVENT()) ) {
                                
                DB_PreinventarioMP localMP = new DB_PreinventarioMP();

                //valorizzo i campi da popolare per il preinventario MP
                 //MS 16/09/2011 DOPPIA MODIFICA==================================================
                  System.out.println("INSERITO" +data_inventarioMP.getINSERITO() + " --- "  + data_inventarioMP.getCOMPO() );
                 if (data_inventarioMP.getINSERITO().compareTo("")!=0){
                    //Delete da preinventario con parmetro data_inventarioMP.getINSERITO()
                     lEnt_ParInventari.removepreinvent(data_inventarioMP.getINSERITO());
                 }else{
                   data_inventarioMP.setINSERITO("HD"+intParID_Evento.intValue()+ "@" + data_inventarioMP.getPROD() + "@" + data_inventarioMP.getCOMPO() + "@" + data_inventarioMP.getPREST_AGG()+ "@" + "MP");
                 }
                 //MS 16/09/2011 DOPPIA MODIFICA==================================================
                localMP.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localMP.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localMP.setCODE_ISTANZA_PROD              (data_inventarioMP.getPROD());
                localMP.setCODE_ISTANZA_COMPO             (data_inventarioMP.getCOMPO());
                localMP.setCODE_ISTANZA_PREST_AGG         (data_inventarioMP.getPREST_AGG());
                if (code_stato_elem.equals("2")){
                  localMP.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localMP.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioMP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{
                  localMP.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioMP.getDESC_NUM_ORDINE_CLIENTE());
                  localMP.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioMP.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                localMP.setDESC_TIPO_RETE                 (data_inventarioMP.getDESC_TIPO_RETE());
                localMP.setDESC_SEDE_1                    (data_inventarioMP.getDESC_SEDE_1());
                localMP.setDESC_IMPIANTO_SEDE_1           (data_inventarioMP.getDESC_IMPIANTO_SEDE_1());
                localMP.setDESC_COMUNE_SEDE_1             (data_inventarioMP.getDESC_COMUNE_SEDE_1());
                localMP.setDESC_PROVINCIA_SEDE_1          (data_inventarioMP.getDESC_PROVINCIA_SEDE_1());
                localMP.setDESC_DTRT_SEDE_1               (data_inventarioMP.getDESC_DTRT_SEDE_1());
                if (!strpropagaDesc1.equals("0") )
                {
               /*   for (int i = 0;i < vct_ParInventariAnag.size();i++){
                  data_InventariAnagMP = (DB_Invent_MP)vct_ParInventariAnag.get(i);
                  if (data_InventariAnagMP.getTAB().equals("P"))
                        stDescSedeCentrale1 = data_InventariAnagMP.getDESC_CENTRALE_SEDE_1();
                  } 
                */  
                  localMP.setDESC_CENTRALE_SEDE_1           (strpropagaDesc1);
                  
                }
                else{
                localMP.setDESC_CENTRALE_SEDE_1           (data_inventarioMP.getDESC_CENTRALE_SEDE_1());
                }
                localMP.setDESC_SEDE_2                    (data_inventarioMP.getDESC_SEDE_2());
                localMP.setDESC_IMPIANTO_SEDE_2           (data_inventarioMP.getDESC_IMPIANTO_SEDE_2());
                localMP.setDESC_COMUNE_SEDE_2             (data_inventarioMP.getDESC_COMUNE_SEDE_2());
                localMP.setDESC_PROVINCIA_SEDE_2          (data_inventarioMP.getDESC_PROVINCIA_SEDE_2());
                localMP.setDESC_DTRT_SEDE_2               (data_inventarioMP.getDESC_DTRT_SEDE_2());
                localMP.setDESC_CENTRALE_SEDE_2           (data_inventarioMP.getDESC_CENTRALE_SEDE_2());
                data_inventarioMP.annullaModifica();

                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioMP(localMP);
              }
            } else if (objAbsAnag instanceof  DB_Invent_ATM   ) {
              System.out.println("Servizio ATM");
              DB_Invent_ATM data_inventarioATM = (DB_Invent_ATM) objAbsAnag;
              // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioATM.getCODE_INVENT()) ) {
                DB_PreinventarioATM localATM = new DB_PreinventarioATM();

                //valorizzo i campi da popolare per il preinventario PP
                 //MS 16/09/2011 DOPPIA MODIFICA==================================================
                  System.out.println("INSERITO" +data_inventarioATM.getINSERITO() + " --- "  + data_inventarioATM.getCOMPO() );
                 if (data_inventarioATM.getINSERITO().compareTo("")!=0){
                    //Delete da preinventario con parmetro data_inventarioATM.getINSERITO()
                     lEnt_ParInventari.removepreinvent(data_inventarioATM.getINSERITO());
                 }else{
                   data_inventarioATM.setINSERITO("HD"+intParID_Evento.intValue()+ "@" + data_inventarioATM.getPROD() + "@" + data_inventarioATM.getCOMPO() + "@" + data_inventarioATM.getPREST_AGG()+ "@" + "ATM");
                 }
                 //MS 16/09/2011 DOPPIA MODIFICA==================================================
                
                
                localATM.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localATM.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localATM.setCODE_ISTANZA_PROD              (data_inventarioATM.getPROD());
                localATM.setCODE_ISTANZA_COMPO             (data_inventarioATM.getCOMPO());
                localATM.setCODE_ISTANZA_PREST_AGG         (data_inventarioATM.getPREST_AGG());
                if (code_stato_elem.equals("2")){
                  localATM.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localATM.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioATM.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{
                  localATM.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioATM.getDESC_NUM_ORDINE_CLIENTE());
                  localATM.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioATM.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                localATM.setDESC_TIPO_TERMINAZIONE         (data_inventarioATM.getDESC_TIPO_TERMINAZIONE());
                localATM.setDESC_FRAZIONAMENTO             (data_inventarioATM.getDESC_FRAZIONAMENTO());
                localATM.setDESC_SEDE_1                    (data_inventarioATM.getDESC_SEDE_1());
                localATM.setDESC_TIPO_RETE_SEDE_1          (data_inventarioATM.getDESC_TIPO_RETE_SEDE_1());
                localATM.setDESC_IMPIANTO_SEDE_1           (data_inventarioATM.getDESC_IMPIANTO_SEDE_1());
                localATM.setDESC_COMUNE_SEDE_1             (data_inventarioATM.getDESC_COMUNE_SEDE_1());
                localATM.setDESC_PROVINCIA_SEDE_1          (data_inventarioATM.getDESC_PROVINCIA_SEDE_1());
                localATM.setDESC_DTRT_SEDE_1               (data_inventarioATM.getDESC_DTRT_SEDE_1());
                if (!strpropagaDesc1.equals("0") )
                {
                 /* for (int i = 0;i < vct_ParInventariAnag.size();i++){
                  data_InventariAnagATM = (DB_Invent_ATM)vct_ParInventariAnag.get(i);
                  if (data_InventariAnagATM.getTAB().equals("P"))
                        stDescSedeCentrale1 = data_InventariAnagATM.getDESC_CENTRALE_SEDE_1();
                  }
                */  
                  localATM.setDESC_CENTRALE_SEDE_1           (strpropagaDesc1);
                  
                }
                else{
                localATM.setDESC_CENTRALE_SEDE_1           (data_inventarioATM.getDESC_CENTRALE_SEDE_1());
                }
                localATM.setDESC_SEDE_2                    (data_inventarioATM.getDESC_SEDE_2());
                localATM.setDESC_TIPO_RETE_SEDE_2          (data_inventarioATM.getDESC_TIPO_RETE_SEDE_2());
                localATM.setDESC_IMPIANTO_SEDE_2           (data_inventarioATM.getDESC_IMPIANTO_SEDE_2());
                localATM.setDESC_COMUNE_SEDE_2             (data_inventarioATM.getDESC_COMUNE_SEDE_2());
                localATM.setDESC_PROVINCIA_SEDE_2          (data_inventarioATM.getDESC_PROVINCIA_SEDE_2());
                localATM.setDESC_DTRT_SEDE_2               (data_inventarioATM.getDESC_DTRT_SEDE_2());
                localATM.setDESC_CENTRALE_SEDE_2           (data_inventarioATM.getDESC_CENTRALE_SEDE_2());
                data_inventarioATM.annullaModifica();
                                                

                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioATM(localATM);
              }
            } else if (objAbsAnag instanceof  DB_Invent_ITC) {
              System.out.println("Servizio ITC");
              DB_Invent_ITC data_inventarioITC = (DB_Invent_ITC) objAbsAnag;
              
                   //=================================================================
              if ( strParCodeInvent.equals(data_inventarioITC.getCODE_INVENT()) ) {

     
     
                DB_PreinventarioITC localITC = new DB_PreinventarioITC();
                // se è l'elemento che è stata modificato
                //MS 16/09/2011 DOPPIA MODIFICA==================================================
                 System.out.println("INSERITO" +data_inventarioITC.getINSERITO() + " --- "  + data_inventarioITC.getCOMPO() );
                if (data_inventarioITC.getINSERITO().compareTo("")!=0){
                   //Delete da preinventario con parmetro data_inventarioITC.getINSERITO()
                    lEnt_ParInventari.removepreinvent(data_inventarioITC.getINSERITO());
                }else{
                  data_inventarioITC.setINSERITO("HD"+intParID_Evento.intValue()+ "@" + data_inventarioITC.getPROD() + "@" + data_inventarioITC.getCOMPO() + "@" + data_inventarioITC.getPREST_AGG()+ "@" + "ITC");
                }
                //MS 16/09/2011 DOPPIA MODIFICA==================================================
                //valorizzo i campi da popolare per il preinventario PP
                localITC.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localITC.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localITC.setCODE_ISTANZA_PROD              (data_inventarioITC.getPROD());
                localITC.setCODE_ISTANZA_COMPO             (data_inventarioITC.getCOMPO());
                localITC.setCODE_ISTANZA_PREST_AGG         (data_inventarioITC.getPREST_AGG());

                if (code_stato_elem.equals("2")){
                  localITC.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localITC.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioITC.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{
                  localITC.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioITC.getDESC_NUM_ORDINE_CLIENTE());
                  localITC.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioITC.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                localITC.setDESC_TIPO_TERMINAZIONE         (data_inventarioITC.getDESC_TIPO_TERMINAZIONE());
                localITC.setDESC_FRAZIONAMENTO             (data_inventarioITC.getDESC_FRAZIONAMENTO());
                localITC.setDESC_SEDE_1                    (data_inventarioITC.getDESC_SEDE_1());
                localITC.setDESC_TIPO_RETE_SEDE_1          (data_inventarioITC.getDESC_TIPO_RETE_SEDE_1());
                localITC.setDESC_IMPIANTO_SEDE_1           (data_inventarioITC.getDESC_IMPIANTO_SEDE_1());
                localITC.setDESC_TIPO_IMPIANTO_SEDE_1      (data_inventarioITC.getDESC_TIPO_IMPIANTO_SEDE_1());                                                  
                localITC.setDESC_COMUNE_SEDE_1             (data_inventarioITC.getDESC_COMUNE_SEDE_1());
                localITC.setDESC_PROVINCIA_SEDE_1          (data_inventarioITC.getDESC_PROVINCIA_SEDE_1());
                localITC.setDESC_DTRT_SEDE_1               (data_inventarioITC.getDESC_DTRT_SEDE_1());
                if (!strpropagaDesc1.equals("0") )
                {
                 /* for (int i = 0;i < vct_ParInventariAnag.size();i++){
                  data_InventariAnagITC = (DB_Invent_ITC)vct_ParInventariAnag.get(i);
                  if (data_InventariAnagITC.getTAB().equals("P"))
                        stDescSedeCentrale1 = data_InventariAnagITC.getDESC_CENTRALE_SEDE_1();
                  }
                  */
                  localITC.setDESC_CENTRALE_SEDE_1           (strpropagaDesc1);
                }
                else{
                localITC.setDESC_CENTRALE_SEDE_1           (data_inventarioITC.getDESC_CENTRALE_SEDE_1());
                }
                localITC.setDESC_SEDE_2                    (data_inventarioITC.getDESC_SEDE_2());
                localITC.setDESC_TIPO_RETE_SEDE_2          (data_inventarioITC.getDESC_TIPO_RETE_SEDE_2());
                localITC.setDESC_IMPIANTO_SEDE_2           (data_inventarioITC.getDESC_IMPIANTO_SEDE_2());
                localITC.setDESC_TIPO_IMPIANTO_SEDE_2           (data_inventarioITC.getDESC_TIPO_IMPIANTO_SEDE_2());                                                  
                localITC.setDESC_COMUNE_SEDE_2             (data_inventarioITC.getDESC_COMUNE_SEDE_2());
                localITC.setDESC_PROVINCIA_SEDE_2          (data_inventarioITC.getDESC_PROVINCIA_SEDE_2());
                localITC.setDESC_DTRT_SEDE_2               (data_inventarioITC.getDESC_DTRT_SEDE_2());
                localITC.setDESC_CENTRALE_SEDE_2           (data_inventarioITC.getDESC_CENTRALE_SEDE_2());
                data_inventarioITC.annullaModifica();
                                                
                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioITC(localITC);
              }
            } else if (objAbsAnag instanceof  DB_Invent_ITC_REV   ) {
              System.out.println("Servizio ITC_REV");
              DB_Invent_ITC_REV data_inventarioITCREV = (DB_Invent_ITC_REV) objAbsAnag;
              // se è l'elemento che è stata modificato
              if ( strParCodeInvent.equals(data_inventarioITCREV.getCODE_INVENT()) ) {

                DB_PreinventarioITCREV localITCREV = new DB_PreinventarioITCREV();

                //valorizzo i campi da popolare per il preinventario PP
               //MS 16/09/2011 DOPPIA MODIFICA==================================================
                  System.out.println("INSERITO" +data_inventarioITCREV.getINSERITO() + " --- "  + data_inventarioITCREV.getCOMPO() );
                 if (data_inventarioITCREV.getINSERITO().compareTo("")!=0){
                    //Delete da preinventario con parmetro data_inventarioITCREV.getINSERITO()
                     lEnt_ParInventari.removepreinvent(data_inventarioITCREV.getINSERITO());
                 }else{
                   data_inventarioITCREV.setINSERITO("HD"+intParID_Evento.intValue()+ "@" + data_inventarioITCREV.getPROD() + "@" + data_inventarioITCREV.getCOMPO() + "@" + data_inventarioITCREV.getPREST_AGG()+ "@" + "ITCREV");
                 }
                 //MS 16/09/2011 DOPPIA MODIFICA==================================================
                localITCREV.setID_SISTEMA_MITTENTE            ("GENEVENTI_BILL"); 
                localITCREV.setID_EVENTO                      ("HD"+intParID_Evento.intValue()); 
                localITCREV.setCODE_ISTANZA_PROD              (data_inventarioITCREV.getPROD());
                localITCREV.setCODE_ISTANZA_COMPO             (data_inventarioITCREV.getCOMPO());
                localITCREV.setCODE_ISTANZA_PREST_AGG         (data_inventarioITCREV.getPREST_AGG());

                if (code_stato_elem.equals("2")){
                  localITCREV.setDESC_NUM_ORDINE_CLIENTE        ("");
                  localITCREV.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioITCREV.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }else{
                  localITCREV.setDESC_NUM_ORDINE_CLIENTE        (data_inventarioITCREV.getDESC_NUM_ORDINE_CLIENTE());
                  localITCREV.setDESC_NUM_ORDINE_CLIENTE_CESSAZ (data_inventarioITCREV.getDESC_NUM_ORDINE_CLIENTE_CESSAZ());
                }
                
                localITCREV.setDESC_TIPO_TERMINAZIONE         (data_inventarioITCREV.getDESC_TIPO_TERMINAZIONE());
                localITCREV.setDESC_FRAZIONAMENTO             (data_inventarioITCREV.getDESC_FRAZIONAMENTO());
                localITCREV.setDESC_SEDE_1                    (data_inventarioITCREV.getDESC_SEDE_1());
                localITCREV.setDESC_TIPO_RETE_SEDE_1          (data_inventarioITCREV.getDESC_TIPO_RETE_SEDE_1());
                localITCREV.setDESC_IMPIANTO_SEDE_1           (data_inventarioITCREV.getDESC_IMPIANTO_SEDE_1());
                localITCREV.setDESC_TIPO_IMPIANTO_SEDE_1           (data_inventarioITCREV.getDESC_TIPO_IMPIANTO_SEDE_1());                                                  
                localITCREV.setDESC_COMUNE_SEDE_1             (data_inventarioITCREV.getDESC_COMUNE_SEDE_1());
                localITCREV.setDESC_PROVINCIA_SEDE_1          (data_inventarioITCREV.getDESC_PROVINCIA_SEDE_1());
                localITCREV.setDESC_DTRT_SEDE_1               (data_inventarioITCREV.getDESC_DTRT_SEDE_1());
                if (!strpropagaDesc1.equals("0") )
                {
                 /* for (int i = 0;i < vct_ParInventariAnag.size();i++){
                  data_InventariAnagITCREV = (DB_Invent_ITC_REV)vct_ParInventariAnag.get(i);
                  if (data_InventariAnagITCREV.getTAB().equals("P"))
                        stDescSedeCentrale1 = data_InventariAnagITCREV.getDESC_CENTRALE_SEDE_1();
                  }
                  */
                  localITCREV.setDESC_CENTRALE_SEDE_1           (strpropagaDesc1);
                }
                else{
                localITCREV.setDESC_CENTRALE_SEDE_1           (data_inventarioITCREV.getDESC_CENTRALE_SEDE_1());
                }
                localITCREV.setDESC_SEDE_2                    (data_inventarioITCREV.getDESC_SEDE_2());
                localITCREV.setDESC_TIPO_RETE_SEDE_2          (data_inventarioITCREV.getDESC_TIPO_RETE_SEDE_2());
                localITCREV.setDESC_IMPIANTO_SEDE_2           (data_inventarioITCREV.getDESC_IMPIANTO_SEDE_2());
                localITCREV.setDESC_TIPO_IMPIANTO_SEDE_2           (data_inventarioITCREV.getDESC_TIPO_IMPIANTO_SEDE_2());                                                  
                localITCREV.setDESC_COMUNE_SEDE_2             (data_inventarioITCREV.getDESC_COMUNE_SEDE_2());
                localITCREV.setDESC_PROVINCIA_SEDE_2          (data_inventarioITCREV.getDESC_PROVINCIA_SEDE_2());
                localITCREV.setDESC_DTRT_SEDE_2               (data_inventarioITCREV.getDESC_DTRT_SEDE_2());
                localITCREV.setDESC_CENTRALE_SEDE_2           (data_inventarioITCREV.getDESC_CENTRALE_SEDE_2());
                data_inventarioITCREV.annullaModifica();
                                                

                // Inserisco anagrafica della componente
                lEnt_ParInventari.insPreinventarioITCREV(localITCREV);
              }
            }
          }
        }
      catch(RemoteException lexc_Exception){
          throw new RemoteException("inserisciAnagrafica" + lexc_Exception.getMessage());
      }
      catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserisciAnagrafica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
    return lrs_Esecuzione;
  }

  public int inserimentoRettifica(String strCodeUtente, Vector vct_InventariProd,
  Vector vct_InventariCompo, Vector vct_InventariPrest, Vector vct_InventariAnag
    ,Vector vct_InventariCompoDIF, String strpropagaDesc1,Vector vctpropagaCompo,Vector vPropagaElem,
    Vector vct_InventariCompoC_A,Vector vct_InventariCompo_x_insprodotto,
    String strNoteRettificaRipristino ) 
  throws CustomException, RemoteException
  {
      int lrs_Esecuzione = 0;

      try   {
        Ent_Inventari lEnt_Inventari = null;
        Ent_InventariHome lEnt_InventariHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;
        Object  objAbsAnag = null;
        Vector  vctPreinvProd = null;
        Vector  vctPreinvCompo = null;
        Vector  vctPreinvPrest = null;
        Vector  vctPreinvAnag = null;
        DB_InventProd data_inventarioProd = (DB_InventProd) vct_InventariProd.get(0);
        boolean blProdottoInserito = false;
        boolean elaborazioniInCorso = false;
        boolean bllInserisciTutto =false;
        Integer intReturnAnag ;
        Integer intReturnProd ;
        Integer intReturnCompo ;
        Integer intReturnPrest ;
        int     intElaborazioneBatch = 0;
        int     intElemElaborati = 0;
        int     intCodeComponente = 0;
        int     intCodePrest = 0;
        Vector  vctCodePrest = null;
        String  code_istanza_compo ="";
        boolean  spalmaDIF = false;
        boolean  spalmaC_A = false;
        String appo_propagaCodeCompo ="";
        
        Ent_BatchNew lEnt_Batch = null;
        Ent_BatchNewHome lEnt_BatchHome = null;
        Object homeObjectBatch = null;
        String strtypeLoad = null;
        DB_InventCompo DIFdata_inventarioCompo =null;
        Vector v = new Vector();
        Vector v1 = new Vector();
       

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();

        // Istanzio una classe Ent_BatchNew
        homeObject = lcls_Contesto.lookup("Ent_BatchNew");
        lEnt_BatchHome = (Ent_BatchNewHome)PortableRemoteObject.narrow(homeObject, Ent_BatchNewHome.class);
        lEnt_Batch = lEnt_BatchHome.create();

        // Effettuo il controllo se ci sono elaborazioni in corso che inficiano con la generazione
        // di una rettifica degli elementi
        elaborazioniInCorso = lEnt_Batch.chkElabBatch(StaticContext.RIBES_J2_GENERATORE_EVENTI);

        if ( !elaborazioniInCorso ) {

        // Istanzio una classe Ent_Inventari
        homeObject = lcls_Contesto.lookup("Ent_Inventari");
        lEnt_InventariHome = (Ent_InventariHome)PortableRemoteObject.narrow(homeObject, Ent_InventariHome.class);
        lEnt_Inventari = lEnt_InventariHome.create();

        // Inserisco un occorrenza nella Elab batch
        intElaborazioneBatch = lEnt_Inventari.inserisciElabBatch(StaticContext.RIBES_J2_GENERATORE_EVENTI, strCodeUtente,"RUNN");

        // Stacco una sequence per l'evento da elaborare
        Integer intReturn = lEnt_Inventari.getNewSequencePreinv();
        System.out.println("il valore della sequence estratta [" + intReturn.intValue() + "]");

        /*MoS  inserimento note j2_motivazione_evento*/
        if (Misc.nh(strNoteRettificaRipristino).compareTo("")!=0)  {
            lEnt_Inventari.inserimentoNoteRettificaRipristino(data_inventarioProd.getCODE_ISTANZA_PROD(),"HD"+intReturn.toString(),strNoteRettificaRipristino);
        }  
        // Controllo se ci sono modifiche di servizio, offerta, account, prodotto etc etc...
        if ( 1 == data_inventarioProd.getModificaFigli()  ) {
      	  bllInserisciTutto = true;
          if ( vct_InventariCompo == null ) 
          {
              vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());
   
          }
          if ( vct_InventariPrest == null ){
              vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioProd.getCODE_ISTANZA_PROD());
    
          }
          //MoS 
           //19/11/2010
          //=========================================================== 
          
              int s;
             
              for (s = 0;s < vct_InventariCompo.size();s++){
                  DB_InventCompo data_inventarioCompo_ctrl = (DB_InventCompo)vct_InventariCompo.get(s);  
   
              // PRODOTTO ATTIVO COMPOENTE ATTIVA allora PROPAGO
              if ( data_inventarioProd.getCODE_STATO_ELEM().equals("1") &&  data_inventarioCompo_ctrl.getCODE_STATO_ELEM().equals("1")){
                    // ctrl_vct_InventariCompo.remove(s);              
                     v.add(data_inventarioCompo_ctrl); 
          
              }
              }
             if (v.size() > 0) vct_InventariCompo = v;
            
    
          
          for (s = 0;s < vct_InventariPrest.size();s++){
              DB_InventPrest data_inventarioPrest_ctrl = (DB_InventPrest)vct_InventariPrest.get(s);  
          
            // PRODOTTO ATTIVO PREST AGG ATTIVA allora PROPAGO
           if  ( data_inventarioProd.getCODE_STATO_ELEM().equals("1") &&  data_inventarioPrest_ctrl.getCODE_STATO_ELEM().equals("1")){
                v1.add(data_inventarioPrest_ctrl);               
              
              }
          }
          //=========================================================== 
         
          
           if (v1.size() > 0) vct_InventariPrest = v1; 
        }else{
          
          /*MoS 
           * Propago l'elenco dell'utente
           * quindi carico il vettore delle componenti 
           * e alzo il flag eModificato
           * devo propragare solo le DIF e la causale
           * 
           * verifico se la componente deve essere propagata la DIF*/
          //===================================================================
           if (vct_InventariCompoDIF!=null || vct_InventariCompoC_A!=null )
          
               vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());

           if (vct_InventariCompoDIF!=null){
 

             for ( int z = 0;z < vct_InventariCompo.size();z++) {
                    
                 DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(z);            
                 code_istanza_compo = data_inventarioCompo.getCODE_ISTANZA_COMPO();                
                 for ( int j = 0;j < vct_InventariCompoDIF.size();j++) {
    
                   DIFdata_inventarioCompo = (DB_InventCompo) vct_InventariCompoDIF.get(j);
                   if (code_istanza_compo.equals(DIFdata_inventarioCompo.getCODE_ISTANZA_COMPO())){
                     data_inventarioCompo.Modifica();
                   }
              
                 }
              
             }
           }
          /*MoS verifico se la componente deve essere propagata la C_A*/           
          if (vct_InventariCompoC_A!=null){
             for ( int z = 0;z < vct_InventariCompo.size();z++) {
                    
                 DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(z);            
                 code_istanza_compo = data_inventarioCompo.getCODE_ISTANZA_COMPO();                
                 for ( int j = 0;j < vct_InventariCompoC_A.size();j++) {
          
                   DIFdata_inventarioCompo = (DB_InventCompo) vct_InventariCompoC_A.get(j);
                   if (code_istanza_compo.equals(DIFdata_inventarioCompo.getCODE_ISTANZA_COMPO())){
                     data_inventarioCompo.Modifica();
                   }
              
                 }
                 
              
             }
           }
           
          //===================================================================
        
        }




        // Verifico quali sono le modifiche sulle prestazioni aggiuntive
        /***********************************************
         * 
         *    PRESTAZIONI AGGIUNTIVE INIZIO
         * 
         * *********************************************/
        if (vct_InventariPrest != null)  for ( int i = 0;i < vct_InventariPrest.size();i++) {
          DB_InventPrest data_inventarioPrest = (DB_InventPrest) vct_InventariPrest.get(i);

          // Se è stato modificato
          if ((  1 == data_inventarioPrest.eMODIFICATO() )||bllInserisciTutto) {

              if ( blProdottoInserito == false )  {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    intElemElaborati = intElemElaborati + 2;
                    blProdottoInserito = true;
              }

              // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
              if (( !data_inventarioPrest.getCODE_COMPONENTE().equals("") )&& ( !bllInserisciTutto )) {
                   if ( vct_InventariCompo == null )   vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioPrest.getCODE_ISTANZA_PROD());
                  intCodeComponente = trovaComponente  ( data_inventarioPrest.getCODE_ISTANZA_COMPO(), vct_InventariCompo ) ;
                  intReturnCompo = inserisciComponente (lEnt_Inventari,
                  vct_InventariProd,vct_InventariCompo,vct_InventariAnag,
                  intReturn, intCodeComponente,false,vPropagaElem,strpropagaDesc1);
                  intElemElaborati = intElemElaborati + 2;
              }

             // Inserisco la prestazione aggiuntiva
             if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioPrest.getCODE_ISTANZA_PROD());
             intCodePrest = trovaPrestazione  ( data_inventarioPrest.getCODE_ISTANZA_PREST_AGG(), vct_InventariPrest ) ;
             intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,
             vct_InventariPrest,vct_InventariAnag,intReturn
             , intCodePrest,vPropagaElem,strpropagaDesc1,"");
             intElemElaborati = intElemElaborati + 2;
          
          }
        }
      

        // Verifico quali sono le modifiche sulle componenti
        /***********************************************
         * 
         *    COMPONENTI INIZIO
         * 
         * *********************************************/
        if (vct_InventariCompo != null ) for ( int i = 0;i < vct_InventariCompo.size();i++) {
          DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(i);

          // Se è stato modificato
          if ((  1 == data_inventarioCompo.eMODIFICATO())||bllInserisciTutto )  {
            spalmaDIF= false;
             /*MoS verifico se la componente deve essere propagata*/
             //===================================================================
              if (vct_InventariCompoDIF!=null){
               
                code_istanza_compo = data_inventarioCompo.getCODE_ISTANZA_COMPO();                
                for ( int j = 0;j < vct_InventariCompoDIF.size();j++) {

                  DIFdata_inventarioCompo = (DB_InventCompo) vct_InventariCompoDIF.get(j);
                  if (code_istanza_compo.equals(DIFdata_inventarioCompo.getCODE_ISTANZA_COMPO())){
                    spalmaDIF= true;
                  }
             
                }
              }
             //===================================================================
             intElemElaborati = intElemElaborati + 2;
             intReturnCompo = inserisciComponente (lEnt_Inventari,vct_InventariProd,
             vct_InventariCompo,vct_InventariAnag,intReturn, i,spalmaDIF,vPropagaElem,strpropagaDesc1);

              /*
               *  Verifica se ho inserito la componente a cui è legata una prestazione aggiuntiva
              MoS
              Nel caso di cessazione non devo inserire le prest
              e nemmeno se spalmo la dif
              */
             if ( !data_inventarioCompo.getCODE_STATO_ELEM().equals("2")  ){
                 // Inserisco la prestazione aggiuntiva
                 if ( vct_InventariPrest == null )   
                 vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioCompo.getCODE_ISTANZA_PROD());
                
                 vctCodePrest = trovaPrestazioneByCodeIstanzaCompo( data_inventarioCompo.getCODE_ISTANZA_COMPO(), vct_InventariPrest ) ;
                 //MoS Propago la code_componente alle prestazioni aggiuntive relative
                 appo_propagaCodeCompo ="";
                 if (vctpropagaCompo!=null){
                    for ( int z = 0;z < vctpropagaCompo.size();z++) {
                       if (data_inventarioCompo.getCODE_ISTANZA_COMPO().equals( vctpropagaCompo.get(z))){
                           appo_propagaCodeCompo=data_inventarioCompo.getCODE_COMPONENTE();
                        }                 
                    }
                  }
    
    
                 if ( ( vctCodePrest != null ) && ( !bllInserisciTutto ) ) for ( int b = 0;b < vctCodePrest.size();b++) {
                   intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, ((Integer)vctCodePrest.get(b)).intValue(),vPropagaElem,strpropagaDesc1,appo_propagaCodeCompo  );
                   intElemElaborati = intElemElaborati + 2;
                 }
             }
              /*
               *  Verifica se ho inserito il prodotto per le componenti che ho modificato
               */
              if ( blProdottoInserito == false )  {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    intElemElaborati = intElemElaborati + 2;
                    blProdottoInserito = true;
              }
          }
              
        }

  
        // Verifico quali sono le modifiche sui prodotti
        /***********************************************
         * 
         *    PRODOTTI INIZIO
         * 
         * *********************************************/
        for ( int i = 0;i < vct_InventariProd.size();i++) {
          DB_InventProd data_inventarioProdotto = (DB_InventProd) vct_InventariProd.get(i);

          // Se è stato modificato
          if (  1 == data_inventarioProdotto.eMODIFICATO() ) {

                if ( false == blProdottoInserito ) {
                  intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                  intElemElaborati = intElemElaborati + 2;
                  blProdottoInserito = true;
                }
          }
          
          /*MoS verifico se la componente deve essere propagata
             Anche se ho modicato soltanto DIF  
             02/11/2010*/
          //===================================================================
         /* if (vct_InventariCompoDIF!=null && !bllInserisciTutto){
          vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());
         for ( int z = 0;z < vct_InventariCompo.size();z++) {
                    DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(z);
                    spalmaDIF= false;
                    code_istanza_compo = data_inventarioCompo.getCODE_ISTANZA_COMPO();                
                    for ( int j = 0;j < vct_InventariCompoDIF.size();j++) {
                         DIFdata_inventarioCompo = (DB_InventCompo) vct_InventariCompoDIF.get(j);
                        if (code_istanza_compo.equals(DIFdata_inventarioCompo.getCODE_ISTANZA_COMPO())){
                            spalmaDIF= true;
                           intReturnCompo = inserisciComponente (lEnt_Inventari,vct_InventariProd,
                           vct_InventariCompo,vct_InventariAnag,intReturn, z,spalmaDIF,vPropagaElem,strpropagaDesc1);
                         }
              
                     }
                     
           
               }
          }
          */
          //===================================================================        
          
          
        }

        // Verifico quali sono le modifiche sulle anagrafiche IN CASO DI MODIFICHE SOLO SULL'ANAGRAFICA
        /***********************************************
         * 
         *    ANAGRAFICHE INIZIO
         * 
         * *********************************************/
        if (vct_InventariAnag != null) {
            
            for ( int i = 0;i < vct_InventariAnag.size();i++) {
            objAbsAnag = vct_InventariAnag.get(i);

            if ( objAbsAnag instanceof  DB_Invent_RPVD   ) {
              DB_Invent_RPVD data_inventarioRPVD = (DB_Invent_RPVD) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioRPVD.eMODIFICATO() || !strpropagaDesc1.equals("0")   ) {
             
                  // Se è stato modificato il prodotto recupero l'inventario del prodotto
                  if ( data_inventarioRPVD.getTAB().equals("P") && ( false == blProdottoInserito ) ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }
                  // Se è stata modificata la componente recupero l'inventario componente
                  else  if ( data_inventarioRPVD.getTAB().equals("C")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }



                    // Inserisco la componente
                    if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioRPVD.getPROD());
                    intCodeComponente = trovaComponente  ( data_inventarioRPVD.getCOMPO(), vct_InventariCompo ) ;
                     //MoS 25/02/2011
                    // Testo nel caso di propagazione della centrale
                     /******************************************************/
                     DB_InventCompo data_inventarioCompo = (DB_InventCompo) vct_InventariCompo.get(intCodeComponente);
                     int ret= isComponenteTerminazione (vct_InventariAnag, data_inventarioCompo.getCODE_INVENT(), strpropagaDesc1,data_inventarioRPVD.eMODIFICATO());
                     if (ret == 1) {
                       System.out.println("Componete legata ad una Terminazione non inserita");
                     }else{
                     /******************************************************/
                    
                        intReturnCompo = inserisciComponente (lEnt_Inventari,vct_InventariProd
                        ,vct_InventariCompo,vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                    
                     }
                    intElemElaborati = intElemElaborati + 2;
                    
                  } 
                  // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                  else  if ( data_inventarioRPVD.getTAB().equals("A")){
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                    if ( data_inventarioRPVD.getCOMPO().equals("") ) {
                        if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioRPVD.getPROD());
                        intCodeComponente = trovaComponente  ( data_inventarioRPVD.getCOMPO(), vct_InventariCompo ) ;
                        if (intCodeComponente > -1){
                        	intReturnCompo = inserisciComponente (lEnt_Inventari,vct_InventariProd,vct_InventariCompo,
                          vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                        	intElemElaborati = intElemElaborati + 2;
                      	}
                    }

                    // Inserisco la prestazione aggiuntiva
                    if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioRPVD.getPROD());
                    intCodePrest = trovaPrestazione  ( data_inventarioRPVD.getPREST_AGG(), vct_InventariPrest ) ;
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;
                  } 
              }
            } else if ( objAbsAnag instanceof  DB_Invent_MP   ) {
              DB_Invent_MP data_inventarioMP = (DB_Invent_MP) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioMP.eMODIFICATO() || !strpropagaDesc1.equals("0") ){
                  // Se è stato modificato il prodotto recupero l'inventario del prodotto
                  if ( data_inventarioMP.getTAB().equals("P") && ( false == blProdottoInserito ) ) {

                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;    
                    intElemElaborati = intElemElaborati + 2;
                  }
                  // Se è stata modificata la componente recupero l'inventario componente
                  else  if ( data_inventarioMP.getTAB().equals("C")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Inserisco la componente
                    if ( vct_InventariCompo == null )   vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioMP.getPROD());
                    intCodeComponente = trovaComponente  ( data_inventarioMP.getCOMPO(), vct_InventariCompo ) ;
                    intReturnCompo = inserisciComponente ( lEnt_Inventari,
                    vct_InventariProd,vct_InventariCompo,vct_InventariAnag,
                    intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                    intElemElaborati = intElemElaborati + 2;
                  } 
                  // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                  else  if ( data_inventarioMP.getTAB().equals("A")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                    if ( data_inventarioMP.getCOMPO().equals("") ) {

                        // Inserisco la componente
                        if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioMP.getPROD());
                        intCodeComponente = trovaComponente  ( data_inventarioMP.getCOMPO(), vct_InventariCompo ) ;
                        if (intCodeComponente > -1){
                        	intReturnCompo = inserisciComponente (lEnt_Inventari,vct_InventariProd,
                          vct_InventariCompo,vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                        	intElemElaborati = intElemElaborati + 2;
                      	}
                    }

                    // Inserisco la prestazione aggiuntiva
                    if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioMP.getPROD());
                    intCodePrest = trovaPrestazione  ( data_inventarioMP.getPREST_AGG(), vct_InventariPrest ) ;
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;

                  } 
              }
            } else if ( objAbsAnag instanceof  DB_Invent_PP   ) {
              DB_Invent_PP data_inventarioPP = (DB_Invent_PP) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioPP.eMODIFICATO()  || !strpropagaDesc1.equals("0")  ){
               
                  // Se è stato modificato il prodotto recupero l'inventario del prodotto
                  if ( data_inventarioPP.getTAB().equals("P")&& ( false == blProdottoInserito ) ) {

                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }
                  // Se è stata modificata la componente recupero l'inventario componente
                  else  if ( data_inventarioPP.getTAB().equals("C")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Inserisco la componente
                    if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioPP.getPROD());
                    intCodeComponente = trovaComponente  ( data_inventarioPP.getCOMPO(), vct_InventariCompo ) ;
                    intReturnCompo = inserisciComponente ( lEnt_Inventari, vct_InventariProd,
                    vct_InventariCompo, vct_InventariAnag,
                    intReturn, intCodeComponente,spalmaDIF,vPropagaElem ,strpropagaDesc1);
                    intElemElaborati = intElemElaborati + 2;
                  } 
                  // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                  else  if ( data_inventarioPP.getTAB().equals("A")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                    if ( data_inventarioPP.getCOMPO().equals("") ) {
                     if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioPP.getPROD());
                        intCodeComponente = trovaComponente  ( data_inventarioPP.getCOMPO(), vct_InventariCompo ) ;
                        if (intCodeComponente > -1){
                        	intReturnCompo = inserisciComponente ( lEnt_Inventari,vct_InventariProd,
                          vct_InventariCompo,vct_InventariAnag,
                          intReturn, intCodeComponente,spalmaDIF ,vPropagaElem,strpropagaDesc1);
                        	intElemElaborati = intElemElaborati + 2;
                        }
                    }

                    // Inserisco la prestazione aggiuntiva
                    if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioPP.getPROD());
                    intCodePrest = trovaPrestazione  ( data_inventarioPP.getPREST_AGG(), vct_InventariPrest ) ;
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;
                  } 
              }
            } else if ( objAbsAnag instanceof  DB_Invent_ATM   ) {
              DB_Invent_ATM data_inventarioATM = (DB_Invent_ATM) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioATM.eMODIFICATO()  ||  !strpropagaDesc1.equals("0")  ){
       
                  // Se è stato modificato il prodotto recupero l'inventario del prodotto
                  if ( data_inventarioATM.getTAB().equals("P")&& ( false == blProdottoInserito ) ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }
                  // Se è stata modificata la componente recupero l'inventario componente
                  else  if ( data_inventarioATM.getTAB().equals("C")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Inserisco la componente
                    if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioATM.getPROD());
                    intCodeComponente = trovaComponente  ( data_inventarioATM.getCOMPO(), vct_InventariCompo ) ;
                    intReturnCompo = inserisciComponente (lEnt_Inventari,
                    vct_InventariProd,vct_InventariCompo,
                    vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                    intElemElaborati = intElemElaborati + 2;
                  } 
                  // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                  else  if ( data_inventarioATM.getTAB().equals("A")) {
                    if  ( false == blProdottoInserito ) {
                      intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                      blProdottoInserito = true;
                      intElemElaborati = intElemElaborati + 2;
                    }

                    // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                    if ( data_inventarioATM.getCOMPO().equals("") ) {
                        if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioATM.getPROD());
                        intCodeComponente = trovaComponente  ( data_inventarioATM.getCOMPO(), vct_InventariCompo ) ;
                        if (intCodeComponente > -1){
                        	intReturnCompo = inserisciComponente (lEnt_Inventari,
                          vct_InventariProd,vct_InventariCompo,
                          vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                        	intElemElaborati = intElemElaborati + 2;
                        }
                    }

                    // Inserisco la prestazione aggiuntiva
                    if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioATM.getPROD());
                    intCodePrest = trovaPrestazione  ( data_inventarioATM.getPREST_AGG(), vct_InventariPrest ) ;
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;
                  } 
              } 
            } else if ( objAbsAnag instanceof  DB_Invent_ITC   ) {
              DB_Invent_ITC data_inventarioITC = (DB_Invent_ITC) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioITC.eMODIFICATO()  ||  !strpropagaDesc1.equals("0") ){
            
                // Se è stato modificato il prodotto recupero l'inventario del prodotto
                if ( data_inventarioITC.getTAB().equals("P")&& ( false == blProdottoInserito ) ) {

                  intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                  blProdottoInserito = true;
                  intElemElaborati = intElemElaborati + 2;
                }
                // Se è stata modificata la componente recupero l'inventario componente
                else  if ( data_inventarioITC.getTAB().equals("C")) {
                  if  ( false == blProdottoInserito ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }

                  // Inserisco la componente
                  if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());
                  intCodeComponente = trovaComponente  ( data_inventarioITC.getCOMPO(), vct_InventariCompo ) ;
                  intReturnCompo = inserisciComponente ( lEnt_Inventari, 
                  vct_InventariProd,vct_InventariCompo, vct_InventariAnag, 
                  intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                  intElemElaborati = intElemElaborati + 2;
                } 
                // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                else  if ( data_inventarioITC.getTAB().equals("A")) {
                  if  ( false == blProdottoInserito ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }

                  // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                  if ( data_inventarioITC.getCOMPO().equals("")) {
                   if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());
                      intCodeComponente = trovaComponente  ( data_inventarioITC.getCOMPO(), vct_InventariCompo ) ;
                      if(intCodeComponente != -1){
                        intReturnCompo = inserisciComponente ( lEnt_Inventari,
                        vct_InventariProd,vct_InventariCompo,
                        vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1 );
                        intElemElaborati = intElemElaborati + 2;
                      }
                  }

                  // Inserisco la prestazione aggiuntiva
                  if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioProd.getCODE_ISTANZA_PROD());
                  intCodePrest = trovaPrestazione  ( data_inventarioITC.getPREST_AGG(), vct_InventariPrest ) ;
                  if(intCodePrest != -1){
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;
                  }
                } 
              }
            } else if ( objAbsAnag instanceof  DB_Invent_ITC_REV   ) {
              DB_Invent_ITC_REV data_inventarioITC_REV = (DB_Invent_ITC_REV) objAbsAnag;
              // Se è stato modificato
              if  ( 1 == data_inventarioITC_REV.eMODIFICATO()  || !strpropagaDesc1.equals("0") ){
                // Se è stato modificato il prodotto recupero l'inventario del prodotto
                if ( data_inventarioITC_REV.getTAB().equals("P")&& ( false == blProdottoInserito ) ) {

                  intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                  blProdottoInserito = true;
                  intElemElaborati = intElemElaborati + 2;
                }
                // Se è stata modificata la componente recupero l'inventario componente
                else  if ( data_inventarioITC_REV.getTAB().equals("C")) {
                  if  ( false == blProdottoInserito ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }

                  // Inserisco la componente
                  if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioITC_REV.getPROD());
                  intCodeComponente = trovaComponente  ( data_inventarioITC_REV.getCOMPO(), vct_InventariCompo ) ;
                  intReturnCompo = inserisciComponente ( lEnt_Inventari, 
                  vct_InventariProd,vct_InventariCompo, vct_InventariAnag,
                  intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1);
                  intElemElaborati = intElemElaborati + 2;
                } 
                // Se è stata modificata la prestazione aggiuntiva recupero l'inventario prestazioni aggiuntive
                else  if ( data_inventarioITC_REV.getTAB().equals("A")) {
                  if  ( false == blProdottoInserito ) {
                    intReturnProd = inserisciProdotto (lEnt_Inventari,vct_InventariProd,vct_InventariAnag,vct_InventariCompo_x_insprodotto,intReturn,strpropagaDesc1);
                    blProdottoInserito = true;
                    intElemElaborati = intElemElaborati + 2;
                  }

                  // Se è stata modificata una prestazione aggiuntiva legata alla componente la inserisco
                  if ( data_inventarioITC_REV.getCOMPO().equals("")) {
                   if ( vct_InventariCompo == null ) vct_InventariCompo = lEnt_Inventari.getInventarioComponenti(data_inventarioProd.getCODE_ISTANZA_PROD());
                      intCodeComponente = trovaComponente  ( data_inventarioITC_REV.getCOMPO(), vct_InventariCompo ) ;
                      if(intCodeComponente != -1){
                        intReturnCompo = inserisciComponente ( lEnt_Inventari,
                        vct_InventariProd,vct_InventariCompo,
                        vct_InventariAnag,intReturn, intCodeComponente,spalmaDIF,vPropagaElem,strpropagaDesc1 );
                        intElemElaborati = intElemElaborati + 2;
                      }
                  }

                  // Inserisco la prestazione aggiuntiva
                  if ( vct_InventariPrest == null )   vct_InventariPrest = lEnt_Inventari.getInventarioPrestazioni(data_inventarioProd.getCODE_ISTANZA_PROD());
                  intCodePrest = trovaPrestazione  ( data_inventarioITC_REV.getPREST_AGG(), vct_InventariPrest ) ;
                  if(intCodePrest != -1){
                    intReturnPrest = inserisciPrestazioneAggiuntiva (lEnt_Inventari,vct_InventariProd,vct_InventariPrest,vct_InventariAnag,intReturn, intCodePrest,vPropagaElem,strpropagaDesc1,"");
                    intElemElaborati = intElemElaborati + 2;
                  }
                }
              }
            }
          }
        }

        /*Aggiorno l'esito dell'elaborazione nella elab_batch riportando il numero delle INSERT che sono state 
         * effettuate sul sistema */
        intElaborazioneBatch = lEnt_Inventari.aggiornaElabBatch( Integer.toString(intElaborazioneBatch) ,
                                                                 Integer.toString(intElemElaborati),
                                                                 "0",
                                                                 "0",
                                                                 "0" )  ;
        
        } else lrs_Esecuzione=-1;

        return lrs_Esecuzione;
      }
      catch(RemoteException lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserimentoRettifica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
      }
      catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"inserimentoRettifica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

}
