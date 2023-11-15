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

public class Ent_CatalogoBean extends AbstractClassicEJB implements SessionBean 
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

  private String createPreCatalogoXml(Vector lvct_Ret){

      DB_PreCatalogo lcls_Catalogo = null;
      String Ret = "";
      String lstr_CodeServ = "";
      String lstr_CodeOff = "";

      for (int i = 0; i < lvct_Ret.size(); i++ ){

        lcls_Catalogo = (DB_PreCatalogo)lvct_Ret.get(i);
        lstr_CodeOff = lcls_Catalogo.getCODE_OFFERTA();
        
        Ret += "<OFFERTA ID=\"" + lstr_CodeOff + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Catalogo.getDESC_OFFERTA()) + "</DESC>";
        while (lstr_CodeOff.equals(lcls_Catalogo.getCODE_OFFERTA()))
        {
          Ret += "<SERVIZIO>" + lcls_Catalogo.getCODE_SERVIZIO() + "</SERVIZIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Catalogo = (DB_PreCatalogo)lvct_Ret.get(i);
        }
        i--;
        Ret += "</OFFERTA>";
      }
      return Ret;
  }

  public String getCodiceOfferta() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceOfferta";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceOfferta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insOfferta(DB_CAT_Offerta offerta) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "insOfferta";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getCODE_OFFERTA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDESC_OFFERTA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDATA_FINE_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getTIPO_OFF()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(offerta.getVAL_REC())},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(offerta.getCODE_GRUPPI_CLASS_OFF())}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insOfferta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getGruppiOfferte() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getGruppiOfferte";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Anag_Class_Off.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getGruppiOfferte",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insServizio(DB_CAT_Servizio servizio) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "insServizi";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio.getDESC_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio.getDATA_FINE_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio.getAPP_VAL_EUR()}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insServizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceServizio() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceServizio";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceServizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceServizioLogico() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceServizioLogico";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceServizioLogico",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getPreOfferte(String code_offerta)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "getPreOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                               {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING,code_offerta}
                               };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_CAT_Offerta.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferte",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getPreServizioLogico(String code_servizio) throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "getPreServizioLogico";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                               {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_servizio}
                               };

      Vector lcls_return =  this.callSP(larr_CallSP, DB_PreServiziLogici.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(), "",
                    "getPreServizioLogico",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  private String createProdXML(Vector lvct_Ret){

      DB_Offerta lcls_Offerta = null;
      String Ret = "";
      String lstr_CodeOff = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Offerta = (DB_PreOfferte)lvct_Ret.get(i);
        lstr_CodeOff = lcls_Offerta.getCODE_OFFERTA();
        
        Ret += "<OFFERTA ID=\"" + lstr_CodeOff + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Offerta.getDESC_OFFERTA()) + "</DESC>";
        while (lstr_CodeOff.equals(lcls_Offerta.getCODE_OFFERTA()))
        {
          Ret += "<SERVIZIO>" + lcls_Offerta.getCODE_SERVIZIO() + "</SERVIZIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Offerta = (DB_Offerta)lvct_Ret.get(i);
        }
        i--;
        Ret += "</OFFERTA>";
      }
      return Ret;
  }

  public String getPercorsoXml () throws CustomException, RemoteException   {
        try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPercorsoXml";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_STRING}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP);
      String lvct_Return = (String)lcls_return.get(0);
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreCatalogo" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    

  }

  public String getPercorsoXml(String codeId) throws CustomException, RemoteException   {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPercorsoXml";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeId}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP);
      String lvct_Return = (String)lcls_return.get(0);
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreCatalogo" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    

  }
  
  public Vector getPreCatalogo() throws CustomException, RemoteException {

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreCatalogo";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreCatalogo" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getAlberoPreCatalogoOfferta(String strCodeOfferta) throws CustomException, RemoteException  {
     
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAlberoPreCatalogoOfferta";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AlberoCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAlberoPreCatalogoOfferta" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
   
 public Vector getAlberoPreCatalogo() throws CustomException, RemoteException {

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAlberoPreCatalogo";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AlberoCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAlberoPreCatalogo" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getPreCatalogoXml() throws CustomException, RemoteException{
    try{
      Vector lvct_Ret = getPreCatalogo();
      return createPreCatalogoXml(lvct_Ret);
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                    "",
                    "getPreCatalogoXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  
  private String createPreOffXML(Vector lvct_Ret){

      DB_Offerta lcls_Offerta = null;
      String Ret = "";
      String lstr_CodeOff = "";
      
            
      for (int i = 0;i < lvct_Ret.size();i++){

        lcls_Offerta = (DB_PreOfferte)lvct_Ret.get(i);
        lstr_CodeOff = lcls_Offerta.getCODE_OFFERTA();
        
        Ret += "<OFFERTA ID=\"" + lstr_CodeOff + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Offerta.getDESC_OFFERTA()) + "</DESC>";
        while (lstr_CodeOff.equals(lcls_Offerta.getCODE_OFFERTA()))
        {
          Ret += "<SERVIZIO>" + lcls_Offerta.getCODE_SERVIZIO() + "</SERVIZIO>";
          i++;
          if (i>=lvct_Ret.size()) break;
          lcls_Offerta = (DB_Offerta)lvct_Ret.get(i);
        }
        i--;
        Ret += "</OFFERTA>";
      }
      return Ret;
  }

  public String getPreOfferteXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getPreOfferteAll();
      return createPreOffXML(lvct_Ret);
  
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferteXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }


    public Vector getPreOfferteAll()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreOfferteAll";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreOfferte.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferteAll" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getPreOfferte()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};



      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreOfferte.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferte",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

    public Vector getPreOfferte(int Servizio,int Prodotto)throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreOfferte";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Servizio)},
                    {AbstractEJBTypes.PARAMETER_INPUT,AbstractEJBTypes.TYPE_INTEGER,String.valueOf(Prodotto)},
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreOfferte.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferte(" + Servizio + "," + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getPreOfferteXml(int Servizio,int Prodotto)throws CustomException, RemoteException{
    try{
      Vector lvct_Ret = getPreOfferte(Servizio,Prodotto);
      return createPreOffXML(lvct_Ret);
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreOfferteXml(" + Servizio + "," + Prodotto + ")",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public Vector getPreCaratteristiche ( )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getPreCaratteristiche";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_PreCaratteristiche.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreCaratteristiche",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getPreCaratteristicheXml() throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getPreCaratteristiche();
      DB_PreCaratteristiche lcls_PreCaratteristiche = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_PreCaratteristiche = (DB_PreCaratteristiche)lvct_Ret.get(i);
        Ret += "<CARATTERISTICHE ID=\"" + lcls_PreCaratteristiche.getCODE_CARATT() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_PreCaratteristiche.getDESC_CARATT()) + "</DESC></CARATTERISTICHE>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreCaratteristicheXML",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public Vector getPreServizi()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreServizi";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreServizi.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreServizi",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getPreServiziXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getPreServizi();
      DB_Servizio lcls_Servizio = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_Servizio = (DB_Servizio)lvct_Ret.get(i);
        Ret += "<SERVIZIO ID=\"" + lcls_Servizio.getCODE_SERVIZIO() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Servizio.getDESC_SERVIZIO()) + "</DESC></SERVIZIO>";
       
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getServiziXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }


//AP Aggiunta gestione servizio logico 
  public Vector getPreServiziLogici()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreServiziLogici";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_PreServiziLogici.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreServiziLogici",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public String getPreServiziLogiciXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getPreServiziLogici();
      DB_ServizioLogico lcls_ServizioLog = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_ServizioLog = (DB_ServizioLogico)lvct_Ret.get(i);
        Ret += "<SERVIZIO_LOGICO ID=\"" + lcls_ServizioLog.getCODE_SERVIZIO_LOGICO() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_ServizioLog.getDESC_SERVIZIO_LOGICO()) + "</DESC>";
        Ret += "<SERV>" + Utility.encodeXML(lcls_ServizioLog.getCODE_SERVIZIO()) + "</SERV></SERVIZIO_LOGICO>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreServiziLogiciXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public String getCodiceProdotto() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceProdotto";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceProdotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceComponente() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceComponente";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodicePrestazione() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodicePrestAgg";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodicePrestazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAssOffServ() throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreOffxServ";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_off_x_serv.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAssOffServ",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAssOffServ_codiceServizio(String codice_servizio) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreOffxServ_codiceServ";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_off_x_serv.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAssOffServ_codiceServizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAssOffServ_codServOff(String codice_servizio, String codice_offerta) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreOffxServ_codServOff";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_offerta}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_off_x_serv_x_sconto.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreOffxServ_codServOff",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insAssociazione(DB_Offerta OffServ, int val_fre_cicli_cs) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsOffPerServ";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getCODE_OFFERTA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getDATA_FINE_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, String.valueOf(val_fre_cicli_cs)}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){

          Ctr_Catalogo lCtr_Catalogo = null;
          Ctr_CatalogoHome lCtr_CatalogoHome = null;
          Object homeObject = null;
          Context lcls_Contesto = null;

          // Acquisisco il contesto 
          lcls_Contesto = new InitialContext();

          // Istanzio una classe Ent_Catalogo
          homeObject = lcls_Contesto.lookup("Ctr_Catalogo");
          lCtr_CatalogoHome = (Ctr_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ctr_CatalogoHome.class);
          lCtr_Catalogo = lCtr_CatalogoHome.create();
          String risultato = lCtr_Catalogo.createTreeCatalogoXml( OffServ.getCODE_OFFERTA() );
          //System.out.println("risultato ["+risultato+"]");

          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceClassOff() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceClasseOfferta";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceClassOff",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insClassOff(String codeClassOff, String descClassOff) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsAnagClassiOfferte";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeClassOff},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descClassOff}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insClassOff",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getClassOffFiltro(String descClassOff) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreAnagClasOffFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descClassOff}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Anag_Class_Off.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassOffFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getGestoriFiltro(String codeGest, String descGest) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreGestoriFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeGest},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descGest}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Gestori.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getGestoriFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

//  public String insGestore(DB_Gestori gestori, String codeGestSap) throws RemoteException, CustomException
  public String insGestore(DB_Gestori gestori) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsGestori";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;
      String iva = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestori.getCODE_GESTORE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestori.getDESC_GESTORE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestori.getCODE_PARTITA_IVA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestori.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestori.getDATA_FINE_VALID()},
                    //{AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeGestSap}
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insGestore",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String insProdotto(String code_prodotto,String desc_prodotto) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsProdotto";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_prodotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, desc_prodotto}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"InsProdotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insComponente(DB_Componente componente) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "insComponente";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, componente.getCODE_COMPONENTE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, componente.getDESC_COMPONENTE()}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insPrestAgg(DB_PrestazioneAggiuntiva prestAgg) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "insPrestAgg";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;
     try   {
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prestAgg.getCODE_PREST_AGG()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prestAgg.getDESC_PREST_AGG()}
                    };
                    
        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insPrestAgg",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getAlberoPreCatalogoProdotti(String strCodeOfferta, String strCodeServizio) throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAlberoPreCatalogoProdotti";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AlberoCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAlberoPreCatalogoProdotti" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }
  public Vector getAlberoPreCatalogoComponenti(String strCodeProdotto) throws CustomException, RemoteException {
         
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAlberoPreCatalogoComponenti";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AlberoCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAlberoPreCatalogoComponenti" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getVisualizzaInfo(String Elemento, String strCodeOfferta, String strCodeServizio, String strCodeProdotto, String strCodeComponente , String strCodePrestAgg ) throws CustomException, RemoteException{
     String[][] larr_CallSP_Chiama =null;
      try{
        if ( Elemento.equals("P") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getProdVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        }
        else if ( Elemento.equals ("PA-C") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getProdCompoPrestVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodePrestAgg}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        } 
        else if ( Elemento.equals ("PA-P") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getProdPrestVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodePrestAgg}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        }
        else if ( Elemento.equals ("C") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getCompoVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        }  else if ( Elemento.equals ("O") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getOffertaVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        } else if ( Elemento.equals ("S") ) {
              String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getServizioVisualizzaInf";
          
              String[][] larr_CallSP={
                          {lstr_StoredProcedureName},
                          {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}
                          };
              larr_CallSP_Chiama = larr_CallSP;
        } else {
              throw new CustomException("Funzione Richiamata in maniera non corretta",
                  "",
                "getVisualizzaInfo",
                this.getClass().getName(),
                "");
        }
        Vector lvct_SPReturn = this.callSP(larr_CallSP_Chiama, DB_VisualizzaInfo.class);   
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

        return lvct_Return;
      }
      catch(Exception lexc_Exception){
        throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getVisualizzaInfo",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
      }
  }

  public Vector getAlberoPreCatalogoPrestazioni(String strCodeProdotto , String strCodeComponente) throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAlberoPreCatalogoPrest";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AlberoCatalogo.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getAlberoPreCatalogoPrestazioni" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getModalApplTempoNol() throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getModalApplTempoNol";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR}
                    };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_ModalNoleggio.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);

      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getModalApplTempoNol" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

//  public int inserisciProdottoAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strSpesaCompl , String strCodeModalAppl , String strCaratteristica) throws CustomException, RemoteException {
  public int inserisciProdottoAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strSpesaCompl , String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "InsProdottoAssoc";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPrimoNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strRinnNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPreaNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strApplicEurib},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSpesaCompl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeModalAppl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataFineNol}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "inserisciProdottoAssociato" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

//  public int inserisciComponenteAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strSpesaCompl , String strFlusso , String strCodeModalAppl , String strColocato , String strRepCaratt , String strCaratteristica) throws CustomException, RemoteException {
  public int inserisciComponenteAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strSpesaCompl ,String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "InsCompoAssoc";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPrimoNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strRinnNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPreaNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strApplicEurib},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeModalAppl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSpesaCompl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataFineNol}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "inserisciComponenteAssociato" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

//  public int inserisciPrestazioneAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strCodePrestazione, String strSpesaCompl , String strFlusso , String strCodeModalAppl , String strColocato , String strCaratteristica) throws CustomException, RemoteException {
  public int inserisciPrestazioneAssociato(String strPrimoNol , String strRinnNol , String strPreaNol , String strApplicEurib , String strCodeOfferta , String strCodeServizio , String strCodeProdotto , String strCodeComponente , String strCodePrestazione, String strSpesaCompl , String strCodeModalAppl, String strDataFineNol) throws CustomException, RemoteException {
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "InsPrestAssoc";

      String[][] larr_CallSP ={{lstr_StoredProcedure},
                    {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPrimoNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strRinnNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPreaNol},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strApplicEurib},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeModalAppl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSpesaCompl},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodePrestazione},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, ""},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataFineNol}
                    };

        Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "inserisciPrestazioneAssociato" ,
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getOfferteFiltro(String codeOff, String descOff) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreOfferteFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeOff},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descOff}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Offerta.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getOfferteFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getServiziFiltro(String codeServ, String descServ) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreServiziFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeServ},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descServ}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Servizio.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getServiziFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getServiziLogiciFiltro(String codeServLog, String descServLog, String descBreve, String codeServ) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreServiziLogiciFiltro";

    try{
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeServLog},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descServLog},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descBreve},                  
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeServ}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_PreServiziLogici.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getServiziLogiciFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public Vector getProdottiFiltro(String codeProd, String descProd) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreProdottiFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeProd},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descProd}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Prodotto.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getProdottiFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

/*AP*/
  public Vector getPreProdotto(String codeProd) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreProdotto";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeProd}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Prodotto.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreProdotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getComponentiFiltro(String codeCompo, String descCompo) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreComponentiFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCompo},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descCompo}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Componente.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getComponentiFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

/*AP*/
  public Vector getPreComponente(String codeCompo) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreComponente";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCompo}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Componente.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


  
  public Vector getPrestazioniFiltro(String codePrestAgg, String descPrestAgg) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPrePrestazioniFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codePrestAgg},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descPrestAgg}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_PrestazioneAggiuntiva.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPrestazioniFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getTipoCausFiltro(String codeCaus, String descCaus) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreCausaliFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCaus},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descCaus}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TipoCausaleNew.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTipoCausFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceTipoCaus() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceTipoCausale";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceTipoCaus",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insTipoCaus(DB_TipoCausaleNew tipoCaus) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsTipoCausali";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tipoCaus.getCODE_TIPO_CAUSALE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, tipoCaus.getDESC_TIPO_CAUSALE()}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insTipoCaus",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String insCaratteristica(DB_PreCaratteristiche caratteristica) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "insCaratteristiche";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getCODE_CARATT()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getDESC_CARATT()},                    
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getCODE_TIPO_CARATT()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getFLAG_MODIF()}                    
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceCaratteristica() throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceCaratteristica";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceOfferta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getCaratteristicheFiltro(String codeCarat,String codeTipoCarat, String descCarat, String descTipoCarat) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreCaratteristicheFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCarat},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeTipoCarat},                  
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descCarat},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descTipoCarat}                  
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_PreCaratteristiche.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreCaratteristicheFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getCaratteristica(String codeCarat) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreCaratteristica";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeCarat}            
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_PreCaratteristiche.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreCaratteristica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getTipoCaratteristiche ( )
  throws CustomException, RemoteException {

   Vector lvct_SPReturn = null;
   String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getTipoCaratteristiche";

    try{
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP, DB_TipoCaratteristiche.class);
        Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreCaratteristiche",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getTipoCaratteristicheXml() throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getTipoCaratteristiche();
      DB_TipoCaratteristiche lcls_TipoCaratteristiche = null;
      String Ret = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_TipoCaratteristiche = (DB_TipoCaratteristiche)lvct_Ret.get(i);
        Ret += "<TIPO_CARATTERISTICHE ID=\"" + lcls_TipoCaratteristiche.getCODE_TIPO_CARATT() + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_TipoCaratteristiche.getDESC_TIPO_CARATT()) + "</DESC></TIPO_CARATTERISTICHE>";
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreCaratteristicheXML",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public Vector getAccountFiltro(String codeAcc, String descAcc) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreAccountFiltro";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAcc},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, descAcc}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Account.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getAccountFiltro",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getPreAccount(String codeAcc) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getPreAccount";

    try{
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeAcc}                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_CAT_Account.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getPreAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
    public String getPreGestoriXml()throws CustomException, RemoteException{
    try{

      Vector lvct_Ret = getPreGestori();
      DB_Gestori lcls_Gestore = null;
      String Ret = "";
      String code_sap = "";
            
      for (int i = 0;i < lvct_Ret.size();i++){
        lcls_Gestore = (DB_Gestori)lvct_Ret.get(i);
        code_sap = lcls_Gestore.getCODE_GESTORE() + "||" + Utility.encodeXML(lcls_Gestore.getCODE_GESTORE_SAP());
        Ret += "<GESTORE ID=\"" + code_sap + "\">";
        Ret += "<DESC>" + Utility.encodeXML(lcls_Gestore.getDESC_GESTORE()) + "</DESC></GESTORE>";
       
      }

      return Ret;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreGestoriXml",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
      
  }

  public Vector getPreGestori()throws CustomException, RemoteException{

    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreGestoriAllPerAcc";

      String[][] larr_CallSP ={{lstr_StoredProcedure},{AbstractEJBTypes.PARAMETER_RETURN, 
                    AbstractEJBTypes.TYPE_VECTOR}};

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Gestori.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      
            
      return lvct_Return;
      
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreGestori",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getPreGestori_codGest(String codeGest)throws CustomException, RemoteException{
    try{

      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getpregestori_codgest";

      String[][] larr_CallSP ={
          {lstr_StoredProcedure},
          {AbstractEJBTypes.PARAMETER_RETURN,AbstractEJBTypes.TYPE_VECTOR},
          {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeGest}
      };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Gestori.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
                
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
    
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreGestori_codGest",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getCodiceAccount() throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getCodiceAccount";

    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      String lvct_Return = (String)lvct_SPReturn.get(0);
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getCodiceAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


//  public String insAccount(DB_CAT_Account newAccount, String codeGestSap) throws RemoteException, CustomException
  public String insAccount(DB_CAT_Account newAccount) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsAccount";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getCODE_ACCOUNT()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getCODE_SERVIZIO_LOGICO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getCODE_GESTORE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getDESC_ACCOUNT()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getTIPO_FLAG_FATTRB()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getTIPO_FLAG_FITTZ()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getTIPO_FLAG_CLAS_SCONTO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getFLAG_INTERIM()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getDATA_FINE_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getFLAG_INVIO_SAP()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newAccount.getCODE_GESTORE_SAP()}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAccount",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String insServizioLogico(DB_PreServiziLogici newServizio) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsServizioLogico";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getCODE_SERVIZIO_LOGICO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getDESC_SERVIZIO_LOGICO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getDESC_BREVE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getTIPO_SISTEMA_MITTENTE()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, newServizio.getFLAG_MODIF()}
                };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insServizioLogico",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }  

  public Vector getPreAccorpanti(String codice_servizio, String codice_gestore)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreAccountAccorpante";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_gestore}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_AccountNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreAccorpanti",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getPreGestori(String codice_servizio)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getPreGestori";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio}
                              };

      Vector lcls_return =  this.callSP(larr_CallSP,DB_Gestori.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);            
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreGestori",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getPreAccorpati(String codice_accorpante) throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAccountGiaAccorpati";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_accorpante}
                              };
      Vector lcls_return =  this.callSP(larr_CallSP,DB_AccountNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreAccorpati",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
    
  }

  public Vector getPreDisponibili(String codice_servizio,String codice_accorpante)throws CustomException, RemoteException{
    try{
      String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "getAccountDispAccorpa";
      String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio},                              
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_accorpante}
                              };
      Vector lcls_return =  this.callSP(larr_CallSP,DB_AccountNew.class);
      Vector lvct_Return = (Vector)lcls_return.get(0);
      return lvct_Return;
    }
    catch(Exception lexc_Exception){
      throw new CustomException(lexc_Exception.toString(),
                      "",
                    "getPreDisponibili",
                    this.getClass().getName(),
                    StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public int insAccorpamenti(String str_Servizi, String str_AccountAccorpante,String[] str_AccountAccorpati,String data_accorpamento) throws CustomException, RemoteException
  {
    int i = 0;
    int int_Return = 0;
    Vector lvct_SPReturn = null;
    String str_AccountAccorpato = "";
    try     
    {
      if(str_AccountAccorpati!=null && str_AccountAccorpati.length > 0){
        for(i=0;i<str_AccountAccorpati.length;i++){
          str_AccountAccorpato = str_AccountAccorpati[i];
          String lstr_StoredProcedure = StaticContext.PKG_CATALOGO + "InsAccorpamenti";
          String[][] larr_CallSP ={
                              {lstr_StoredProcedure},
                              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpante},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpato},
                              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, data_accorpamento}
                              };
          lvct_SPReturn = this.callSP(larr_CallSP);
          Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
          int_Return = lvct_Return.intValue();
        }
      }

      return int_Return;

    }
    catch(Exception lexc_Exception)
    {
      throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAccorpamenti",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public int deleteAccorpamento(String str_Servizi, String str_AccountAccorpante,String str_AccountAccorpato) throws CustomException, RemoteException
  {
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "DeleteAccorpamento";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpante},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, str_AccountAccorpato}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);


        if(lvct_Return.intValue() == DBMessage.OK_RT){
          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"deleteAccorpamento",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public int determinaAssenzaCaratt(String strProdotto, String strComponente, String strPrestazione) throws RemoteException, CustomException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getVerificaCarattxelem";

    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strProdotto},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strComponente},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strPrestazione}              
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"determinaAssenzaCaratt",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescServizio(String strCodeServizio) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getDescServizio";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio}                   
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescServizio",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescOfferta(String strCodeOfferta) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getDescOfferta";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta}                   
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescOfferta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String getDescProdotto(String strCodeProdotto) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getDescProdotto";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}                   
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescProdotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescComponente(String strCodeComponente) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getDescComponente";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeComponente}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescComponente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String getDescPrestazione(String strCodePrestazione) throws CustomException, RemoteException
  {      
      Vector lvct_SPReturn = null;
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getDescPrestazione";

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodePrestazione}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        String lvct_Return = (String)lvct_SPReturn.get(0);
        return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getDescPrestazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public int insCaratt_x_elem(String elementi,String tipo, String code_caratt,String colocata, String trasmissiva, String ProdottoRif,String ComponenteRif) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "InsCarattxElem";

    String prodotto="";
    String compo="";
    String prestAgg="";
    String col="";
    String trasm="";

    
    System.out.println("elementi ["+elementi+"] code_caratt ["+code_caratt+"] colocata ["+colocata+"] trasmissiva ["+trasmissiva+"] ProdottoRif ["+ProdottoRif+"] ComponenteRif ["+ComponenteRif+"]");

    if (colocata.equals("true"))
      col = "S";
    else if (colocata.equals("false"))
      col = "N";

    if (trasmissiva.equals("true"))
      trasm = "S";
    else if (trasmissiva.equals("false"))
      trasm = "N";
    
    if(tipo.equals("PRODOTTO")){
      prodotto = elementi;
    }else if(tipo.equals("COMPONENTE")){
      prodotto = ProdottoRif;
      compo = elementi;
    }else{
      prodotto = ProdottoRif;
      compo    = ComponenteRif;
      prestAgg = elementi;
    }
      
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prodotto},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, compo},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prestAgg},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_caratt},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, col},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, trasm}               
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insCaratt_x_elem",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public int checkGestoreSap(String codice_gestore,String codice_gestore_sap) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getVerificaGestoreSapDiff";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_gestore},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_gestore_sap}            
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"checkGestoreSap",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public String aggiorna_servizio_logico(DB_PreServiziLogici servizio_logico) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_servizi_logici";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio_logico.getCODE_SERVIZIO_LOGICO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio_logico.getDESC_SERVIZIO_LOGICO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio_logico.getDESC_BREVE()},              
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio_logico.getCODE_SERVIZIO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, servizio_logico.getFLAG_MODIF()}              
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_servizio_logico",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String aggiorna_offerta(DB_CAT_Offerta offerta) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_offerta";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    String val_rec = String.valueOf(offerta.getVAL_REC());
    if ((val_rec.equals("")) || (val_rec == null))
    {
      val_rec = null;
    }

    String code_gruppi_class_off = String.valueOf(offerta.getCODE_GRUPPI_CLASS_OFF());
    if ((code_gruppi_class_off.equals("")) || (code_gruppi_class_off == null))
    {
      code_gruppi_class_off = null;
    }
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getCODE_OFFERTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDESC_OFFERTA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDATA_INIZIO_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getDATA_FINE_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getTIPO_OFF()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, val_rec},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, code_gruppi_class_off},
              //QS 4.9
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, offerta.getFLAG_MODIF()},
              
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_offerta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String aggiorna_Account(DB_CAT_Account account) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_account";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getCODE_ACCOUNT()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getCODE_SERVIZIO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getCODE_SERVIZIO_LOGICO()},              
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getCODE_GESTORE()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getDESC_ACCOUNT()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getTIPO_FLAG_FATTRB()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getTIPO_FLAG_FITTZ()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getTIPO_FLAG_CLAS_SCONTO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getFLAG_INTERIM()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getDATA_INIZIO_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getDATA_FINE_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getFLAG_INVIO_SAP()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getCODE_GESTORE_SAP()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, account.getFLAG_MODIF()}              
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_account",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String aggiorna_gestore(DB_Gestori gestore) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_gestori";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getCODE_GESTORE()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getDESC_GESTORE()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getCODE_PARTITA_IVA()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getDATA_INIZIO_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getDATA_FINE_VALID()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, gestore.getFLAG_MODIF()}              
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_gestore",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String aggiorna_prodotto(DB_Prodotto prodotto) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_prodotti";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prodotto.getCODE_PRODOTTO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prodotto.getDESC_PRODOTTO()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, prodotto.getFLAG_MODIF()}
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_prodotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

   public String aggiorna_componente(DB_Componente componente) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_componenti";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, componente.getCODE_COMPONENTE()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, componente.getDESC_COMPONENTE()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, componente.getFLAG_MODIF()}
              
      };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_componente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 public String cancella_servizio_logico(String code_servizio_logico) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_servizio_logico";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_servizio_logico}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella_servizio_logico",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String cancella_offerta(String code_offerta) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_offerta";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_offerta}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella offerta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String cancella_gestore(String code_gestore) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_gestore";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_gestore}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      //controllo se e' stata cancellata una sola occorrenza
      if(lvct_Return.intValue()==1){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella gestore",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String cancella_prodotto(String code_prodotto) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_prodotto";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_prodotto}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      //controllo se e' stata cancellata una sola occorrenza
      if(lvct_Return.intValue()==1){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella prodotto",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String cancella_componente(String code_componente) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_componente";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_componente}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      //controllo se e' stata cancellata una sola occorrenza
      if(lvct_Return.intValue()==1){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella componente",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String cancella_account(String code_account) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_account";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_account}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella account",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
  public String aggiorna_associazione(DB_Offerta OffServ, int val_fre_cicli_cs) throws RemoteException, CustomException
  {      
      Vector lvct_SPReturn = null;
      Vector lvct_SPReturn_error = null;      
      String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_OffPerServ";
      String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
      String msg_return = null;

     try   {

        String[][] larr_CallSP={
                    {lstr_StoredProcedureName},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getCODE_OFFERTA()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getCODE_SERVIZIO()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getDATA_INIZIO_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, OffServ.getDATA_FINE_VALID()},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, String.valueOf(val_fre_cicli_cs)}
                    };

        lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

        if(lvct_Return.intValue() == DBMessage.OK_RT){

          Ctr_Catalogo lCtr_Catalogo = null;
          Ctr_CatalogoHome lCtr_CatalogoHome = null;
          Object homeObject = null;
          Context lcls_Contesto = null;

          // Acquisisco il contesto 
          lcls_Contesto = new InitialContext();

          // Istanzio una classe Ent_Catalogo
          homeObject = lcls_Contesto.lookup("Ctr_Catalogo");
          lCtr_CatalogoHome = (Ctr_CatalogoHome)PortableRemoteObject.narrow(homeObject, Ctr_CatalogoHome.class);
          lCtr_Catalogo = lCtr_CatalogoHome.create();
          String risultato = lCtr_Catalogo.createTreeCatalogoXml( OffServ.getCODE_OFFERTA() );
          //System.out.println("risultato ["+risultato+"]");

          msg_return = "";
        }else{
          String[][] larr_CallSP_error={
                    {lstr_StoredProcedureName_error},
                    {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                    {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                    };

          lvct_SPReturn_error = this.callSP(larr_CallSP_error);
          msg_return = (String)lvct_SPReturn_error.get(0);
        }
        
        return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"insAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String delAssociazione(String code_offerta,String codice_servizio) throws RemoteException, CustomException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "delAssOffServ";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codice_servizio}              
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"delAssociazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String cancella_classe_offerta(String code_classe_offerta) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "delclassiofferte";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_classe_offerta}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella_classe_offerta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public String aggiorna_classe_offerta(String code_classe_offerta, String desc_classe_offerta, String strFlagModificaDescrizione) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_classiofferte";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_classe_offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, desc_classe_offerta},
              //QS 4.9
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strFlagModificaDescrizione}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna_offerta",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  public Vector getClassOff_codeClasOff(String code_classe_offerta) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getpreanagclasoff_codeclasoff";

    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_classe_offerta}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_Anag_Class_Off.class);   
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);

      return lvct_Return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getClassOff_codeClasOff",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }


   public int eliminaProdottoAssociato (String Offerta , String Servizio , String Prodotto ) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "delProdottoAssociato";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Servizio},    
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prodotto}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"eliminaProdottoAssociato",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }


 public int eliminaComponenteAssociato(String Offerta , String Servizio , String Prodotto, String Componente) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "delComponenteAssociato";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Servizio},    
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prodotto}, 
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Componente}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"eliminaComponenteAssociato",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }



  public int eliminaPrestazioneAssociata (String Offerta , String Servizio , String Prodotto, String Componente, String Prestazione) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "delPrestazioneAssociata";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Servizio},    
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prodotto}, 
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Componente}, 
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prestazione} 
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"eliminaPrestazioneAssociata",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }


 public int aggiornaProdCompPrest (String Offerta , String Servizio , String Prodotto, String Componente, String Prestazione, String strModalApplEur, String strValoPrimoNol, String strValoPreaNol, String strValoRinnNol,String strDataFineNoleggio, String strSpesa, String strEuribor) throws CustomException, RemoteException
  {

    Vector lvct_SPReturn = null;
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiornaProdCompPrest";
 
    try{
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Offerta},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Servizio},    
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prodotto}, 
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Componente}, 
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, Prestazione},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strModalApplEur},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strValoPrimoNol},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strValoPreaNol},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strValoRinnNol},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strDataFineNoleggio},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strSpesa},
               {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strEuribor}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      return lvct_Return.intValue();
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiornaProdCompPrest",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }

  }

  public String aggiorna_prestazione(DB_PrestazioneAggiuntiva PrestAgg) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_prestazione";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PrestAgg.getCODE_PREST_AGG()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PrestAgg.getDESC_PREST_AGG()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, PrestAgg.getFLAG_MODIF()}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna prestazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 public String cancella_prestazione(String code_prestazione) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_prestazione";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_prestazione}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella prestazione",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

 public String cancella_caratteristica(String code_caratteristica) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "cancella_caratteristica";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, code_caratteristica}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"cancella caratteristica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

   public String aggiorna_caratteristica(DB_PreCaratteristiche caratteristica) throws CustomException, RemoteException
  {      
    Vector lvct_SPReturn = null;
    Vector lvct_SPReturn_error = null;      
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO_AGGIORNAMENTO + "aggiorna_caratteristica";
    String lstr_StoredProcedureName_error = StaticContext.PKG_CATALOGO + "getError";
    String msg_return = null;
    
    try   {
      String[][] larr_CallSP={
              {lstr_StoredProcedureName},
              {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getCODE_CARATT()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getDESC_CARATT()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getCODE_TIPO_CARATT()},
              {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, caratteristica.getFLAG_MODIF()}
              };

      lvct_SPReturn = this.callSP(larr_CallSP);
      Integer lvct_Return = (Integer)lvct_SPReturn.get(0);

      if(lvct_Return.intValue() == DBMessage.OK_RT){
        msg_return = "";
      }else{
        String[][] larr_CallSP_error={
                  {lstr_StoredProcedureName_error},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_STRING},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_INTEGER, String.valueOf(lvct_Return.intValue())}
                  };

        lvct_SPReturn_error = this.callSP(larr_CallSP_error);
        msg_return = (String)lvct_SPReturn_error.get(0);
      }
      return msg_return;
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"aggiorna caratteristica",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
  
   public int getApplicabilitaEuribor(String codeprodotto,String codecomponente, String codeprestagg) throws CustomException, RemoteException{
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO  + "getpreapplicabilita_euribor";
    
    try{

      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_INTEGER},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeprodotto},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codecomponente},                  
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, codeprestagg}                
                  };
     Vector lvct_SPReturn = this.callSP(larr_CallSP);
        Integer lvct_Return = (Integer)lvct_SPReturn.get(0);
        return lvct_Return.intValue();
     
    }
    catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getpreapplicabilita_euribor",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }

  
  public Vector getTempoNol(String strCodeOfferta, String strCodeServizio, String strCodeProdotto)  throws CustomException, RemoteException {
    String lstr_StoredProcedureName = StaticContext.PKG_CATALOGO + "getTempoNoleggio";
    try{
      String[][] larr_CallSP={
                  {lstr_StoredProcedureName},
                  {AbstractEJBTypes.PARAMETER_RETURN, AbstractEJBTypes.TYPE_VECTOR},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeOfferta},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeServizio},
                  {AbstractEJBTypes.PARAMETER_INPUT, AbstractEJBTypes.TYPE_STRING, strCodeProdotto}
                  };

      Vector lvct_SPReturn = this.callSP(larr_CallSP, DB_TempoNoleggio.class);

      /*DB_TempoNoleggio dbTempoNoleggio = new DB_TempoNoleggio();
      
      for (int a=0; a<lvct_SPReturn.size(); a++){
        Vector vector = (Vector)lvct_SPReturn.elementAt(a);
        dbTempoNoleggio = (DB_TempoNoleggio)vector.elementAt(a);
      }*/
      Vector lvct_Return = (Vector)lvct_SPReturn.get(0);
      
      return lvct_Return;
      
    }catch(Exception lexc_Exception){
  		throw new CustomException(lexc_Exception.toString(),
	  								"",
									"getTempoNol",
									this.getClass().getName(),
									StaticContext.FindExceptionType(lexc_Exception));
    }
  }
}
