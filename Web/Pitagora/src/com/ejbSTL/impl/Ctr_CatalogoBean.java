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
import org.jdom.*;
import java.io.*;
import org.jdom.output.*;

public class Ctr_CatalogoBean implements SessionBean 
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

  private String strNomePaginaVuota = "../jsp/PaginaVuota.jsp";
  private String strPage = "../images/page.gif";
  private String strPageSel = "../images/page.gif";
  private String strBookGif = "../images/book.gif";
  private String strBookOpenGif = "../images/bookOpen.gif";
  private String strNomePaginaOfferteDettaglio = "../jsp/OfferteDettaglio.jsp";
  private String strNomePaginaServiziDettaglio = "../jsp/ServiziDettaglio.jsp";
  private String strNomePaginaProdottiDettaglio = "../jsp/ProdottiDettaglio.jsp";
  private String strNomePaginaComponentiDettaglio = "../jsp/ComponentiDettaglio.jsp";
  private String strNomePaginaPrestazioniDettaglio = "../jsp/PrestazioniDettaglio.jsp";


  public String createTreeCatalogoXml() throws CustomException, RemoteException{

      String strReturn = "0";
      String lvcs_Return = null;
      Vector vctPreCatalogo = null;
      DB_Offerta lcls_Offerta = null;
      String lstr_CodeOff = null;
    try   {
// Generazione Catalogo completo commentata   lvcs_Return = createTreeCatalogoXml("-1");
          Ent_Catalogo lEnt_Catalogo = null;
          Ent_CatalogoHome lEnt_CatalogoHome = null;
          Object homeObject = null;
          Context lcls_Contesto = null;

          // Acquisisco il contesto 
          lcls_Contesto = new InitialContext();

          // Istanzio una classe Ent_Catalogo
          homeObject = lcls_Contesto.lookup("Ent_Catalogo");
          lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
          lEnt_Catalogo = lEnt_CatalogoHome.create();
          vctPreCatalogo = lEnt_Catalogo.getPreOfferteAll();

          for ( int i = 0; i<vctPreCatalogo.size(); i++ ) {

            lcls_Offerta = (DB_PreOfferte)vctPreCatalogo.get(i);
            System.out.println( "code offerta[" + lcls_Offerta.getCODE_OFFERTA() +"]" );
            lvcs_Return = createTreeCatalogoXml( lcls_Offerta.getCODE_OFFERTA() );
          }
          return strReturn;
    }
    catch(Exception lexc_Exception){
    
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public String createTreeCatalogoXml(String CodeOfferta) throws CustomException, RemoteException{

      String  xmlValue  = "";
      Vector  vctPreCatalogo = null;
      String strDirectoryXml = null;
      String strPaginaRichiamata =null;

      int intScorriCatalogo = 0;
      int intLivelloOfferte = 0;
      int intLivelloServizi = 0;
      int intLivelloProdotti = 0;
      int intLivelloComponenti = 0;
      int intLivelloPrestazioniProd = 0;
      int intLivelloPrestazioniCompo = 0;

      int     intContaServizi = 0;
      int     intContaProdotti = 0;
      int     intContaComponenti = 0;
      int     intContaPrestazioni = 0;

      String strStatoElemento_off   = "S";
      String strStatoElemento_serv  = "S";
      String strStatoElemento_prod  = "S";
      String strStatoElemento_compo = "S";
      String strStatoElemento_prest = "S";
      String strStatoElemento_nero  = "S";
      
      String strCodeOffertaRif =null;
      String strCodeServizioRif =null;
      String strCodeProdottoRif =null;
      String strCodeComponenteRif =null;
      String strFileName = "";

      Entity  recCatalogo = new Entity("CATALOGO", "Catalogo", strNomePaginaVuota, strBookGif, strBookOpenGif,"S");
      Entity  recDescrOfferte = new Entity("OFFERTE", "Offerte", strNomePaginaVuota, strPage, strPageSel,"S");
      Entity  recDescrServizi =null;
      Entity  recDescrProdotti =null;
      Entity  recDescrComponenti =null;
      Entity  recDescrPrestazioni =null;
      Entity  recOfferte = null;
      Entity  recServizi= null;
      Entity  recProdotti= null;
      Entity  recComponenti= null;
      Entity  recPrestazioni= null;
      Entity  recDescrizione = null;

      Element root = new Element("tree");
      Document doc = new Document(root);
      root.addContent(recCatalogo);
      try   {
        Ent_Catalogo lEnt_Catalogo = null;
        Ent_CatalogoHome lEnt_CatalogoHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();
    
        // Istanzio una classe Ent_Catalogo
        homeObject = lcls_Contesto.lookup("Ent_Catalogo");
        lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
        lEnt_Catalogo = lEnt_CatalogoHome.create();

        if (CodeOfferta.equals("-1") ) {
            vctPreCatalogo = lEnt_Catalogo.getAlberoPreCatalogo();
        }
        else {
            vctPreCatalogo = lEnt_Catalogo.getAlberoPreCatalogoOfferta(CodeOfferta);
        }
        while ( intScorriCatalogo < vctPreCatalogo.size()) {
          DB_AlberoCatalogo recPreCatalogo = (DB_AlberoCatalogo) vctPreCatalogo.get(intScorriCatalogo);

          /*Ciclo Offerte*/
          if (  recPreCatalogo.getLIVELLO().equals("0") && intScorriCatalogo < vctPreCatalogo.size()) {
            intLivelloOfferte = 0;
            if ( intLivelloOfferte == 0 ) {
              recCatalogo.addContents(recDescrOfferte);
              intLivelloOfferte = 1;
              recDescrOfferte.setImage(strBookGif);
              recDescrOfferte.setImageSel(strBookOpenGif);
            }
            strCodeOffertaRif =  recPreCatalogo.getCODE_ELEMENTO();
            strPaginaRichiamata = strNomePaginaOfferteDettaglio + "?Offerta=" + strCodeOffertaRif;
             
            if(recPreCatalogo.getSTATO().equals("")){
              strStatoElemento_off   = "";
            }              
            
            recOfferte = new Entity("OFF=" + recPreCatalogo.getCODE_ELEMENTO(),
                                    recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                    //strPaginaRichiamata, 
                                    strNomePaginaVuota,
                                    strPage, 
                                    strPageSel, 
                                    //recPreCatalogo.getSTATO());
                                    strStatoElemento_off);
            
            recDescrOfferte.addContents(recOfferte);
          }

          /*Ciclo Servizi*/
          if (  recPreCatalogo.getLIVELLO().equals("1") && intScorriCatalogo < vctPreCatalogo.size()) {
              intLivelloProdotti = 0;

              if(strStatoElemento_off.equals("")){
                strStatoElemento_serv = "";
              }else{
                strStatoElemento_serv = recPreCatalogo.getSTATO();
              }
              
              if ( intLivelloServizi == 0 ) {

                /* se l'offerta è nuova allora tutti i servizi associati saranno nuovi */
                
                
                recDescrServizi= new Entity("SERVIZI=" + Integer.toString(intContaServizi++), 
                                            "Servizi", 
                                            strNomePaginaVuota, 
                                            strBookGif, 
                                            strBookOpenGif, 
                                            //recPreCatalogo.getSTATO());
                                            strStatoElemento_nero);
                                            
                recOfferte.addContents(recDescrServizi);
                intLivelloServizi = 1;
                recOfferte.setImage(strBookGif);
                recOfferte.setImageSel(strBookOpenGif);
              }
              strCodeServizioRif =  recPreCatalogo.getCODE_ELEMENTO();
              strPaginaRichiamata = strNomePaginaServiziDettaglio + "?Servizio=" + strCodeServizioRif;

              recServizi = new Entity("SERV=" + recPreCatalogo.getCODE_ELEMENTO() + "|OFF=" + strCodeOffertaRif ,
                                      recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                      //strPaginaRichiamata, 
                                      strNomePaginaVuota,
                                      strPage, 
                                      strPageSel, 
                                      //recPreCatalogo.getSTATO());
                                      strStatoElemento_serv);
                                      
              recDescrServizi.addContents(recServizi);
          }

          /*Ciclo Prodotti*/
          if (  recPreCatalogo.getLIVELLO().equals("2") && intScorriCatalogo < vctPreCatalogo.size()) {
              intLivelloComponenti = 0;
              intLivelloPrestazioniProd = 0;

              if(strStatoElemento_off.equals("") || strStatoElemento_serv.equals("")){
                strStatoElemento_prod = "";
              }else{
                strStatoElemento_prod = recPreCatalogo.getSTATO();
              }
              
              if ( intLivelloProdotti == 0 ) {

                recDescrProdotti = new Entity("PRODOTTI=" + Integer.toString(intContaProdotti++) + "|OFF=" + strCodeOffertaRif + "|SERV=" + strCodeServizioRif , 
                                              "Prodotti", 
                                              strNomePaginaVuota, 
                                              strBookGif, 
                                              strBookOpenGif, 
                                              //recPreCatalogo.getSTATO());
                                              strStatoElemento_nero);
                                              
                recServizi.addContents(recDescrProdotti);
                intLivelloProdotti = 1;
                recServizi.setImage(strBookGif);
                recServizi.setImageSel(strBookOpenGif);
              }
              strCodeProdottoRif =  recPreCatalogo.getCODE_ELEMENTO();
              strPaginaRichiamata = strNomePaginaProdottiDettaglio + "?Offerta=" + strCodeOffertaRif + "&Servizio=" + strCodeServizioRif + "&Prodotto=" + strCodeProdottoRif;
              
              recProdotti = new Entity("PROD=" + recPreCatalogo.getCODE_ELEMENTO() + "|" + recPreCatalogo.getELEMENTO_RIF() ,
                                       recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                       strPaginaRichiamata, 
                                       strPage, 
                                       strPageSel, 
                                       //recPreCatalogo.getSTATO());
                                       strStatoElemento_prod);
                                       
              recDescrProdotti.addContents(recProdotti);
          }

          /*Ciclo Componenti e Prestazioni legate al prodotto*/
          if(  recPreCatalogo.getLIVELLO().equals("3") && intScorriCatalogo < vctPreCatalogo.size()) {
                /* Se è una componente */
                if ( recPreCatalogo.getID_ELEMENTO().equals("COMPO")) {

                  if(strStatoElemento_off.equals("") || strStatoElemento_serv.equals("") || strStatoElemento_prod.equals("")){
                    strStatoElemento_compo = "";
                  }else{
                    strStatoElemento_compo = recPreCatalogo.getSTATO();
                  }
              
                  intLivelloPrestazioniCompo = 0;
                  if ( intLivelloComponenti == 0 ) {

                    recDescrComponenti = new Entity("COMPONENTI=" + Integer.toString(intContaComponenti++) + "|OFF=" + strCodeOffertaRif + "|SERV=" + strCodeServizioRif + "|PROD=" + strCodeProdottoRif , 
                                                    "Componenti", 
                                                    strNomePaginaVuota, 
                                                    strBookGif, 
                                                    strBookOpenGif, 
                                                    //recPreCatalogo.getSTATO());
                                                    strStatoElemento_nero);
                                                    
                    recProdotti.addContents(recDescrComponenti);
                    intLivelloComponenti = 1;
                    recProdotti.setImage(strBookGif);
                    recProdotti.setImageSel(strBookOpenGif);
                  }
                  strCodeComponenteRif = recPreCatalogo.getCODE_ELEMENTO();
                  strPaginaRichiamata = strNomePaginaComponentiDettaglio + "?Offerta=" + strCodeOffertaRif + "&Servizio=" + strCodeServizioRif + "&Prodotto=" + strCodeProdottoRif + "&Componente=" + strCodeComponenteRif;
                                    
                  recComponenti = new Entity("COMPO=" + recPreCatalogo.getCODE_ELEMENTO() + "|OFF=" +strCodeOffertaRif + "|SERV=" + strCodeServizioRif + "|" + recPreCatalogo.getELEMENTO_RIF(),
                                             recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                             strPaginaRichiamata, 
                                             strPage, 
                                             strPageSel, 
                                             //recPreCatalogo.getSTATO());
                                             strStatoElemento_compo);
                                             
                  recDescrComponenti.addContents(recComponenti);
                }/*Se è una prestazione aggiuntiva*/
                else {


                //QS,MS 06/03/2008: Spostata la get dello Stato all'esterno di:   if ( intLivelloPrestazioniProd == 0 )
                 if(strStatoElemento_off.equals("") || strStatoElemento_serv.equals("") || strStatoElemento_prod.equals("")){
                      strStatoElemento_prest = "";
                    }else{
                      strStatoElemento_prest = recPreCatalogo.getSTATO();
                    };
                    
                  if ( intLivelloPrestazioniProd == 0 ) {
                    recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) + "|OFF=" + strCodeOffertaRif + "|SERV=" + strCodeServizioRif + "|PROD=" + strCodeProdottoRif , 
                                                     "Prestazioni Aggiuntive", 
                                                     strNomePaginaVuota, 
                                                     strBookGif, 
                                                     strBookOpenGif,
                                                     //recPreCatalogo.getSTATO());
                                                     strStatoElemento_nero);
                                                     
                    recProdotti.addContents(recDescrPrestazioni);
                    intLivelloPrestazioniProd = 1;
                    recProdotti.setImage(strBookGif);
                    recProdotti.setImageSel(strBookOpenGif);
                  }
                  /*else{
                    strStatoElemento_prest = recPreCatalogo.getSTATO();
                  }*/
                  strPaginaRichiamata = strNomePaginaPrestazioniDettaglio + "?Offerta=" + strCodeOffertaRif + "&Servizio=" + strCodeServizioRif + "&Prodotto=" + strCodeProdottoRif + "&Prestazione=" + recPreCatalogo.getCODE_ELEMENTO();

                  recPrestazioni = new Entity("PREST=" +  recPreCatalogo.getCODE_ELEMENTO() + "|OFF=" +strCodeOffertaRif + "|SERV=" + strCodeServizioRif + "|" + recPreCatalogo.getELEMENTO_RIF(),
                                              recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                              strPaginaRichiamata, 
                                              strPage, 
                                              strPageSel, 
                                              //recPreCatalogo.getSTATO());
                                              strStatoElemento_prest);
                  recDescrPrestazioni.addContents(recPrestazioni);
                }
          }

          /*Ciclo Prestazioni legate a componenti*/
          if( recPreCatalogo.getLIVELLO().equals("4") && intScorriCatalogo < vctPreCatalogo.size()) {

              if(strStatoElemento_off.equals("") || strStatoElemento_serv.equals("") || strStatoElemento_prod.equals("") || strStatoElemento_compo.equals("")){
                strStatoElemento_prest = "";
              }else{
                strStatoElemento_prest = recPreCatalogo.getSTATO();
              }
          
              if ( intLivelloPrestazioniCompo == 0 ) {

                recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) + "|OFF=" +strCodeOffertaRif + "|SERV=" + strCodeServizioRif  + "|PROD=" + strCodeProdottoRif + "|COMPO=" + strCodeComponenteRif , 
                                                 "Prestazioni Aggiuntive", 
                                                 strNomePaginaVuota, 
                                                 strBookGif, 
                                                 strBookOpenGif, 
                                                 //recPreCatalogo.getSTATO());
                                                 strStatoElemento_nero);
                                                 
                recComponenti.addContents(recDescrPrestazioni);
                intLivelloPrestazioniCompo = 1;
                recComponenti.setImage(strBookGif);
                recComponenti.setImageSel(strBookOpenGif);
              }
              strPaginaRichiamata = strNomePaginaPrestazioniDettaglio + "?Offerta=" + strCodeOffertaRif + "&Servizio=" + strCodeServizioRif + "&Prodotto=" + strCodeProdottoRif + "&Componente=" + strCodeComponenteRif + "&Prestazione=" + recPreCatalogo.getCODE_ELEMENTO();
              
              recPrestazioni = new Entity("PREST=" + recPreCatalogo.getCODE_ELEMENTO() + "|OFF=" +strCodeOffertaRif + "|SERV=" + strCodeServizioRif + "|PROD=" + strCodeProdottoRif + "|"  + recPreCatalogo.getELEMENTO_RIF(),
                                          recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                          strPaginaRichiamata, 
                                          strPage, 
                                          strPageSel, 
                                          //recPreCatalogo.getSTATO());
                                          strStatoElemento_prest);
              recDescrPrestazioni.addContents(recPrestazioni);
          }

          intScorriCatalogo ++;
        }
        
        try {
            // serializzazione su standard output
            XMLOutputter outputter = new XMLOutputter();
            FileOutputStream idFileXml;

            strDirectoryXml = lEnt_Catalogo.getPercorsoXml();
            if (!CodeOfferta.equals("-1")) 
                strFileName +=CodeOfferta ;
            strFileName += "tree.xml";
            try
            {
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );
            }
            catch(IOException e)
            {
              strDirectoryXml = lEnt_Catalogo.getPercorsoXml("XML1");
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );
            }        
            outputter.output(doc,idFileXml);
            idFileXml.close();
          } 
          catch(IOException e) {
              throw new CustomException(e.toString(),
                    "errore durante la serializzazione del Documento",
                    "createTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(e));
          }

        return xmlValue;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "createTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public  Element buildItem( String idItem,
                                          String description, 
                                          String url, 
                                          String image, 
                                          String imageOpen,
                                          String contents) throws CustomException, RemoteException {

                                          try {
    Element entity = new Element("entity"),
    DescriptionEl = new Element("Description"),
    urlEl = new Element("url"),
    imageEl = new Element("image"),
    imageOpenEl = new Element("imageOpen"),
    contentsEl = new Element("contents");
	
    DescriptionEl.setText(description);
    urlEl.setText(url);
    imageEl.setText(image);
    imageOpenEl.setText(imageOpen);
    contentsEl.setText(contents);

    entity.setAttribute("Id",idItem);
    entity.addContent(DescriptionEl);
    entity.addContent(urlEl);
    entity.addContent(imageEl);
    entity.addContent(imageOpenEl);
    entity.addContent(contentsEl);

    return entity;

    } catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String createTreeCatalogoXmlProdotti(String CodeOfferta, String CodeServizio) throws CustomException, RemoteException{

      String  xmlValue  = "";
      Vector  vctPreCatalogo = null;
      String strDirectoryXml = null;
      String strPaginaRichiamata =null;

      int intScorriCatalogo = 0;
      int intLivelloOfferte = 0;
      int intLivelloServizi = 0;
      int intLivelloProdotti = 0;
      int intLivelloComponenti = 0;
      int intLivelloPrestazioniProd = 0;
      int intLivelloPrestazioniCompo = 0;

      int     intContaProdotti = 0;
      int     intContaComponenti = 0;
      int     intContaPrestazioni = 0;
  
      String strCodeProdottoRif =null;
      String strCodeComponenteRif =null;
      String strFileName = "";

      Entity  recCatalogo = new Entity("CATALOGO", "Catalogo", "", strBookGif, strBookOpenGif,"S");

      Entity  recDescrProdotti =new Entity("PRODOTTI", "Prodotti", "", strPage, strPageSel,"S");
      Entity  recDescrComponenti =null;
      Entity  recDescrPrestazioni =null;
      Entity  recProdotti= null;
      Entity  recComponenti= null;
      Entity  recPrestazioni= null;
      Entity  recDescrizione = null;

      Element root = new Element("tree");
      Document doc = new Document(root);
      root.addContent(recCatalogo);
      try   {
        Ent_Catalogo lEnt_Catalogo = null;
        Ent_CatalogoHome lEnt_CatalogoHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();
    
        // Istanzio una classe Ent_Catalogo
        homeObject = lcls_Contesto.lookup("Ent_Catalogo");
        lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
        lEnt_Catalogo = lEnt_CatalogoHome.create();

        vctPreCatalogo = lEnt_Catalogo.getAlberoPreCatalogoProdotti(CodeOfferta,CodeServizio);

        while ( intScorriCatalogo < vctPreCatalogo.size()) {
          DB_AlberoCatalogo recPreCatalogo = (DB_AlberoCatalogo) vctPreCatalogo.get(intScorriCatalogo);

          /*Ciclo Prodotti*/
          if (  recPreCatalogo.getLIVELLO().equals("0") && intScorriCatalogo < vctPreCatalogo.size()) {
              intLivelloComponenti = 0;
              intLivelloPrestazioniProd = 0;
              if ( intLivelloProdotti == 0 ) {
                recDescrProdotti = new Entity("PRODOTTI=" + Integer.toString(intContaProdotti++) , 
                                              "Prodotti", 
                                              strNomePaginaVuota, 
                                              strBookGif, 
                                              strBookOpenGif,
                                              "S");
                recCatalogo.addContents(recDescrProdotti);
                intLivelloProdotti = 1;
                recCatalogo.setImage(strBookGif);
                recCatalogo.setImageSel(strBookOpenGif);
              }
              strCodeProdottoRif =  recPreCatalogo.getCODE_ELEMENTO();
              strPaginaRichiamata = "";
              recProdotti = new Entity("PROD=" + recPreCatalogo.getCODE_ELEMENTO() + recPreCatalogo.getELEMENTO_RIF() ,
                                       recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                       strPaginaRichiamata, 
                                       strPage, 
                                       strPageSel,
                                       "PROD"
                                       ,recPreCatalogo.getSTATO());
              recDescrProdotti.addContents(recProdotti);
          }

          /*Ciclo Componenti e Prestazioni legate al prodotto*/
          if(  recPreCatalogo.getLIVELLO().equals("1") && intScorriCatalogo < vctPreCatalogo.size()) {
                /* Se è una componente */
                if ( recPreCatalogo.getID_ELEMENTO().equals("COMPO")) {
                  intLivelloPrestazioniCompo = 0;
                  if ( intLivelloComponenti == 0 ) {
                    recDescrComponenti = new Entity("COMPONENTI=" + Integer.toString(intContaComponenti++) +  "PROD=" + strCodeProdottoRif , 
                                                    "Componenti", 
                                                    strNomePaginaVuota, 
                                                    strBookGif, 
                                                    strBookOpenGif,
                                                    "S");
                    recProdotti.addContents(recDescrComponenti);
                    intLivelloComponenti = 1;
                    recProdotti.setImage(strBookGif);
                    recProdotti.setImageSel(strBookOpenGif);
                  }
                  strCodeComponenteRif = recPreCatalogo.getCODE_ELEMENTO();
                  strPaginaRichiamata = "";
                  recComponenti = new Entity("COMPO=" + recPreCatalogo.getCODE_ELEMENTO() + recPreCatalogo.getELEMENTO_RIF() ,
                                             recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                             strPaginaRichiamata, 
                                             strPage, 
                                             strPageSel, 
                                             "",
                                             recPreCatalogo.getSTATO());
                  recDescrComponenti.addContents(recComponenti);
                }/*Se è una prestazione aggiuntiva*/
                else {
                  if ( intLivelloPrestazioniProd == 0 ) {
                    recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) , 
                                                     "Prestazioni Aggiuntive", 
                                                     strNomePaginaVuota, 
                                                     strBookGif, 
                                                     strBookOpenGif,
                                                     "S");
                    recProdotti.addContents(recDescrPrestazioni);
                    intLivelloPrestazioniProd = 1;
                    recProdotti.setImage(strBookGif);
                    recProdotti.setImageSel(strBookOpenGif);
                  }
                  strPaginaRichiamata = "";
                  recPrestazioni = new Entity("PREST=" +  recPreCatalogo.getCODE_ELEMENTO() +  recPreCatalogo.getELEMENTO_RIF(),
                                              recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                              strPaginaRichiamata, 
                                              strPage, 
                                              strPageSel,
                                              "",
                                              recPreCatalogo.getSTATO());
                  recDescrPrestazioni.addContents(recPrestazioni);
                }
          }

          /*Ciclo Prestazioni legate a componenti*/
          if( recPreCatalogo.getLIVELLO().equals("2") && intScorriCatalogo < vctPreCatalogo.size()) {
              if ( intLivelloPrestazioniCompo == 0 ) {
                recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) , 
                                                 "Prestazioni Aggiuntive", 
                                                 strNomePaginaVuota, 
                                                 strBookGif, 
                                                 strBookOpenGif,
                                                 "S");
                recComponenti.addContents(recDescrPrestazioni);
                intLivelloPrestazioniCompo = 1;
                recComponenti.setImage(strBookGif);
                recComponenti.setImageSel(strBookOpenGif);
              }
              strPaginaRichiamata = "";
              recPrestazioni = new Entity("PREST=" + recPreCatalogo.getCODE_ELEMENTO() + "COMPO=" + strCodeComponenteRif + recPreCatalogo.getELEMENTO_RIF(),
                                          recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                          strPaginaRichiamata, 
                                          strPage, 
                                          strPageSel,
                                          "",
                                          recPreCatalogo.getSTATO());
              recDescrPrestazioni.addContents(recPrestazioni);
          }

          intScorriCatalogo ++;
        }
        
        try {
            // serializzazione su standard output
            XMLOutputter outputter = new XMLOutputter();
            FileOutputStream idFileXml;
            
            strDirectoryXml = lEnt_Catalogo.getPercorsoXml();
            strFileName += "Off" +CodeOfferta + "-Serv" +CodeServizio ;
            strFileName += "tree.xml";
            try
            {
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );  
            }
            catch(IOException e)
            {
              strDirectoryXml = lEnt_Catalogo.getPercorsoXml("XML1");
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );  
            }
            outputter.output(doc,idFileXml);
            idFileXml.close();
          } catch(IOException e) {
              throw new CustomException(e.toString(),
                    "Errore durante la serializzazione del Documento",
                    "createTreeCatalogoXmlProdotti()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(e));
          }

        return xmlValue;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "createTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public String createTreeCatalogoXmlComponenti(String CodeProdotto) throws CustomException, RemoteException{

      String  xmlValue  = "";
      Vector  vctPreCatalogo = null;
      String strDirectoryXml = null;
      String strPaginaRichiamata =null;

      int intScorriCatalogo = 0;
      int intLivelloOfferte = 0;
      int intLivelloServizi = 0;
      int intLivelloComponenti = 0;
      int intLivelloPrestazioniProd = 0;
      int intLivelloPrestazioniCompo = 0;

      int     intContaServizi = 0;
      int     intContaComponenti = 0;
      int     intContaPrestazioni = 0;
  
      String strCodeComponenteRif =null;
      String strFileName = "";

      Entity  recCatalogo = new Entity("CATALOGO", "Catalogo", strNomePaginaVuota, strBookGif, strBookOpenGif,"S");
      Entity  recDescrComponenti =new Entity("COMPONENTI", "Componenti", strNomePaginaVuota, strPage, strPageSel,"S");
      Entity  recDescrPrestazioni =null;
      Entity  recComponenti= null;
      Entity  recPrestazioni= null;
      Entity  recDescrizione = null;

      Element root = new Element("tree");
      Document doc = new Document(root);
      root.addContent(recCatalogo);
      try   {
        Ent_Catalogo lEnt_Catalogo = null;
        Ent_CatalogoHome lEnt_CatalogoHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();
    
        // Istanzio una classe Ent_Catalogo
        homeObject = lcls_Contesto.lookup("Ent_Catalogo");
        lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
        lEnt_Catalogo = lEnt_CatalogoHome.create();

        vctPreCatalogo = lEnt_Catalogo.getAlberoPreCatalogoComponenti(CodeProdotto);

        while ( intScorriCatalogo < vctPreCatalogo.size()) {
          DB_AlberoCatalogo recPreCatalogo = (DB_AlberoCatalogo) vctPreCatalogo.get(intScorriCatalogo);

          /*Ciclo Componenti e Prestazioni legate al prodotto*/
          if(  recPreCatalogo.getLIVELLO().equals("0") && intScorriCatalogo < vctPreCatalogo.size()) {
                /* Se è una componente */
                if ( recPreCatalogo.getID_ELEMENTO().equals("COMPO")) {
                  intLivelloPrestazioniCompo = 0;
                  if ( intLivelloComponenti == 0 ) {
                    recDescrComponenti = new Entity("COMPONENTI=" + Integer.toString(intContaComponenti++) , 
                                                    "Componenti", 
                                                    strNomePaginaVuota, 
                                                    strBookGif, 
                                                    strBookOpenGif,
                                                    "S");
                    recCatalogo.addContents(recDescrComponenti);
                    intLivelloComponenti = 1;
                    recCatalogo.setImage(strBookGif);
                    recCatalogo.setImageSel(strBookOpenGif);
                  }
                  strCodeComponenteRif = recPreCatalogo.getCODE_ELEMENTO();
                  strPaginaRichiamata = "";
                  recComponenti = new Entity("COMPO=" + recPreCatalogo.getCODE_ELEMENTO() +  recPreCatalogo.getELEMENTO_RIF() ,
                                             recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                             strPaginaRichiamata, 
                                             strPage, 
                                             strPageSel,
                                             "COMPO",
                                             recPreCatalogo.getSTATO());
                  recDescrComponenti.addContents(recComponenti);
                }/*Se è una prestazione aggiuntiva*/
                else {
                  if ( intLivelloPrestazioniProd == 0 ) {
                    recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) , 
                                                     "Prestazioni Aggiuntive", 
                                                     strNomePaginaVuota, 
                                                     strBookGif, 
                                                     strBookOpenGif,
                                                     "S");
                    recCatalogo.addContents(recDescrPrestazioni);
                    intLivelloPrestazioniProd = 1;
                    recCatalogo.setImage(strBookGif);
                    recCatalogo.setImageSel(strBookOpenGif);
                  }
                  strPaginaRichiamata = "";
                  recPrestazioni = new Entity("PREST=" +  recPreCatalogo.getCODE_ELEMENTO()  + recPreCatalogo.getELEMENTO_RIF(),
                                              recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                              strPaginaRichiamata, 
                                              strPage, 
                                              strPageSel,
                                              "PREST",
                                              recPreCatalogo.getSTATO());
                  recDescrPrestazioni.addContents(recPrestazioni);
                }
          }

          /*Ciclo Prestazioni legate a componenti*/
          if( recPreCatalogo.getLIVELLO().equals("1") && intScorriCatalogo < vctPreCatalogo.size()) {
              if ( intLivelloPrestazioniCompo == 0 ) {
                recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) , 
                                                 "Prestazioni Aggiuntive", 
                                                 strNomePaginaVuota, 
                                                 strBookGif, 
                                                 strBookOpenGif,
                                                 "S");
                recComponenti.addContents(recDescrPrestazioni);
                intLivelloPrestazioniCompo = 1;
                recComponenti.setImage(strBookGif);
                recComponenti.setImageSel(strBookOpenGif);
              }
              strPaginaRichiamata = "";
              recPrestazioni = new Entity("PREST=" + recPreCatalogo.getCODE_ELEMENTO() + "COMPO=" + strCodeComponenteRif + recPreCatalogo.getELEMENTO_RIF(),
                                          recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                          strPaginaRichiamata, 
                                          strPage, 
                                          strPageSel,
                                          "",
                                          recPreCatalogo.getSTATO());
              recDescrPrestazioni.addContents(recPrestazioni);
          }

          intScorriCatalogo ++;
        }
        
        try {
            // serializzazione su standard output
            XMLOutputter outputter = new XMLOutputter();
            FileOutputStream idFileXml;

            strDirectoryXml = lEnt_Catalogo.getPercorsoXml();
            strFileName = "Prodotto";
            strFileName += CodeProdotto ;
            strFileName += "tree.xml";
            try
            {
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );  
            }
            catch(IOException e)
            {
              strDirectoryXml = lEnt_Catalogo.getPercorsoXml("XML1");
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );
            }
            outputter.output(doc,idFileXml);
            idFileXml.close();
          } catch(IOException e) {
              throw new CustomException(e.toString(),
                    "Errore durante la serializzazione del Documento",
                    "createTreeCatalogoXmlComponenti()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(e));
          }

        return xmlValue;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "createTreeCatalogoXml()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public String createTreeCatalogoXmlPrestazioni(String CodeProdotto, String CodeComponente) throws CustomException, RemoteException{

      String  xmlValue  = "";
      Vector  vctPreCatalogo = null;
      String strDirectoryXml = null;
      String strPaginaRichiamata =null;

      int intScorriCatalogo = 0;

      int     intContaPrestazioni = 0;
      int     intLivelloPrestazioni = 0;
  
      String strFileName = "";

      Entity  recCatalogo = new Entity("CATALOGO", "Catalogo", strNomePaginaVuota, strBookGif, strBookOpenGif,"S");
      Entity  recDescrPrestazioni =null;
      Entity  recPrestazioni= null;

      Element root = new Element("tree");
      Document doc = new Document(root);
      root.addContent(recCatalogo);
      try   {
        Ent_Catalogo lEnt_Catalogo = null;
        Ent_CatalogoHome lEnt_CatalogoHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();
    
        // Istanzio una classe Ent_Catalogo
        homeObject = lcls_Contesto.lookup("Ent_Catalogo");
        lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
        lEnt_Catalogo = lEnt_CatalogoHome.create();

        vctPreCatalogo = lEnt_Catalogo.getAlberoPreCatalogoPrestazioni(CodeProdotto,CodeComponente);

        while ( intScorriCatalogo < vctPreCatalogo.size()) {
          DB_AlberoCatalogo recPreCatalogo = (DB_AlberoCatalogo) vctPreCatalogo.get(intScorriCatalogo);

          /*Ciclo Prestazioni Aggiuntive */
          if( recPreCatalogo.getLIVELLO().equals("0") && intScorriCatalogo < vctPreCatalogo.size()) {
              if ( intLivelloPrestazioni == 0 ) {
                recDescrPrestazioni = new Entity("PRESTAZIONI=" + Integer.toString(intContaPrestazioni++) , 
                                                 "Prestazioni Aggiuntive", 
                                                 strNomePaginaVuota, 
                                                 strBookGif, 
                                                 strBookOpenGif,
                                                 "S");
                recCatalogo.addContents(recDescrPrestazioni);
                intLivelloPrestazioni = 1;
                recCatalogo.setImage(strBookGif);
                recCatalogo.setImageSel(strBookOpenGif);
              }
              strPaginaRichiamata = "";
              recPrestazioni = new Entity("PREST=" + recPreCatalogo.getCODE_ELEMENTO() + recPreCatalogo.getELEMENTO_RIF(),
                                          recPreCatalogo.getCODE_ELEMENTO() + " - " +  recPreCatalogo.getDESC_ELEMENTO(), 
                                          strPaginaRichiamata, 
                                          strPage, 
                                          strPageSel,
                                          "PREST",
                                          recPreCatalogo.getSTATO());
              recDescrPrestazioni.addContents(recPrestazioni);
          }

          intScorriCatalogo ++;
        }
        
        try {
            // serializzazione su standard output
            XMLOutputter outputter = new XMLOutputter();
            FileOutputStream idFileXml;
          
            strDirectoryXml = lEnt_Catalogo.getPercorsoXml();
            strFileName = "Prestazioni";
            strFileName += "P" + CodeProdotto ;
            strFileName += "C" + CodeComponente ;
            strFileName += "tree.xml";
            try
            {
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );  
            }
            catch(IOException e)
            {
              strDirectoryXml = lEnt_Catalogo.getPercorsoXml("XML1");
              idFileXml =  new FileOutputStream( strDirectoryXml + strFileName );  
            }
            outputter.output(doc,idFileXml);
            idFileXml.close();
          } catch(IOException e) {
              throw new CustomException(e.toString(),
                    "Errore durante la serializzazione del Documento",
                    "createTreeCatalogoXmlPrestazioni()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(e));
          }

        return xmlValue;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "createTreeCatalogoXmlPrestazioni()",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  private String createModalXML(Vector lvct_Ret){

      DB_ModalNoleggio lcls_Noleggio = null;
      String Ret = "";
      String lstr_CodeNol = "";

      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_Noleggio = (DB_ModalNoleggio)lvct_Ret.get(i);
        Ret += "<NOLEGGIO ID=\"" + lcls_Noleggio.getCODE_MODAL_APPLICAB_NOLEG() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Noleggio.getDESC_MODAL_APPLICAB_NOLEG()) + "</DESC></NOLEGGIO>";
      }
      return Ret;
  }

 public String getModalitaApplicazioneNoleggioXml()throws CustomException, RemoteException {
    try{
        Ent_Catalogo lEnt_Catalogo = null;
        Ent_CatalogoHome lEnt_CatalogoHome = null;
        Object homeObject = null;
        Context lcls_Contesto = null;

        // Acquisisco il contesto 
        lcls_Contesto = new InitialContext();
    
        // Istanzio una classe Ent_Catalogo
        homeObject = lcls_Contesto.lookup("Ent_Catalogo");
        lEnt_CatalogoHome = (Ent_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ent_CatalogoHome.class);
        lEnt_Catalogo = lEnt_CatalogoHome.create();
        Vector lvct_Ret  = lEnt_Catalogo.getModalApplTempoNol();
       
        return createModalXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getModalitaApplicazioneNoleggioXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

}