package com.utl;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Date;

import com.utl.StaticContext;

public class StaticMessages 
{

  private static String theClientIp=null;           // ip address pc che effettua la connessione
  private static String theJSP=null;                // nome pagina jsp
  private static String theClientMachineName=null;  // nome logico pc che effettua la connessione
  private static String theUserName=null;           // nome utente che effettua la connessione 
  private static String theUserNameLog=null;        // nome utente per il master.log

	public static final SimpleDateFormat formatter_row        = new SimpleDateFormat( "dd/MM/yyyy HH:mm:ss", Locale.getDefault() );

  private static String theCustomString=null;

  public static void setCustomString(String aCustomString )
  {
    theCustomString=aCustomString;
  }
  
	private synchronized static String getDateTime() 
	{
		String lastDate = formatter_row.format(new Date())+" ";
		return lastDate;
	}

  public static String getMessage(int iMessageID,String sCustomString)
  {
    setCustomString(sCustomString);
    return ServletMessage(iMessageID);
  }

  public static String getMessage(int iMessageID,String sCustomString,String aUserName)
  {
    theUserName=aUserName;
    setCustomString(sCustomString);
    return ServletMessage(iMessageID);
  }

  public static String getMessage(int iMessageID,String aJSP,String aClientIp,String aClientMachineName, String aUserName)
  {
    theJSP=aJSP;
    theClientIp=aClientIp;
    theClientMachineName=aClientMachineName;
    theUserName=aUserName;
    return ServletMessage(iMessageID);
  }


  public static String getMessage(int iMessageID,HttpServletRequest request)
  {
    theJSP=StaticContext.getJspName(request);
    theClientIp=request.getRemoteAddr();
    theClientMachineName=request.getRemoteHost();
    theUserName=StaticContext.getAllInfoUser(request).getUserName();
    return ServletMessage(iMessageID);
  }

  public static String getMessage(int iMessageID,HttpServletRequest request,String aUserName)
  {
    theJSP=StaticContext.getJspName(request);
    theClientIp=request.getRemoteAddr();
    theClientMachineName=request.getRemoteHost();
    theUserName=aUserName;
    return ServletMessage(iMessageID);
  }


  private static String getFormattedUserName() {
  // 9 --> 8 caratteri CODE_UTENTE (VARCHAR2(8)) + 1 BLANK
    while (theUserName.length()<9)
      theUserName=theUserName.concat(" ");
    return theUserName;  
  }

  private static String getWARNString() {
    return ("WARN "+getDateTime()+getPC_Ip());
  }
  private static String getCRITString() {
    return ("CRIT "+getDateTime()+getPC_Ip());
  }
  private static String getSECRString() {
    return ("SECR "+getDateTime()+getPC_Ip());
  }
  private static String getINFOString() {
    return ("INFO "+getDateTime()+getPC_Ip());
  }

  private static String ServletMessage(int iMessageID)
  {

    String sMessage=null;
    if(theUserName.trim().equals("APSERVER")){
      theUserNameLog = "";
    }else{
      theUserNameLog = theUserName + " ";
    }

    switch (iMessageID) 
    {
      // WARNING da 1001 a 3000
      case 1001:
        sMessage = getWARNString() +theUserNameLog+ "ERRORE DURANTE LA SCRITTURA SUL FILE DI LOG :"+theCustomString; break;

      //INFO da 3001 a 5000
      case 3001: 
        sMessage = getINFOString() + "UTENTE CONNESSO AL SISTEMA"; break;
      case 3002: 
        sMessage = getINFOString() + "UTENTE DISCONNESSO (LOGOUT)"; break;
      case 3003: 
        sMessage = getINFOString() + "ACCESSO ALLA PAGINA DI LOGIN"; break;
      case 3004: 
        sMessage = getINFOString() + "ASSEGNATO ID DI SESSIONE : "+theCustomString; break;
      case 3005: 
        sMessage = getINFOString() + "SCADUTO ID DI SESSIONE : "+theCustomString; break;
      case 3006: 
        sMessage = getINFOString() + "ACCESSO ALLA PAGINA : "+theCustomString; break;
      case 3007: 
        sMessage = getINFOString() + "ATTIVATA FUNZIONALITA' : "+theCustomString; break;
      case 3008: 
        sMessage = getINFOString() + "CARICAMENTO PAGINA : "+theCustomString; break;
      case 3009: 
        sMessage = getINFOString() + "FINE CARICAMENTO PAGINA : "+theCustomString; break;
      case 3010: 
        sMessage = getINFOString() + "UTENTE : " +getFormattedUserName()+ theCustomString; break;
      case 3011: 
        sMessage = getINFOString() + theUserNameLog+ "LANCIATO BATCH : " +theCustomString; break;      
      case 3020: 
          sMessage = "ACCESSO ALLA PAGINA : " +theCustomString; break;

		// Codici CPI
      case 3501: 
        sMessage = getINFOString() + "LANCIO BATCH : "+theCustomString; break;
      case 3502: 
        sMessage = getINFOString() + "CONGELAMENTO : "+theCustomString; break;
      case 3503: 
        sMessage = getINFOString() + "INSERISCI : "+theCustomString; break;
      case 3504: 
        sMessage = getINFOString() + "MODIFICA : "+theCustomString; break;
      case 3505: 
        sMessage = getINFOString() + "ELIMINA : "+theCustomString; break;
      case 3506: 
        sMessage = getINFOString() + "DISATTIVA : "+theCustomString; break;
        
      /////////////////////////////////////////////////////////////////////////////////////////////////

      //CRITICAL da 5001 a 7000
      case 5001:
        sMessage = getCRITString() + "ERRORE DURANTE L'ESECUZIONE DEL SERVLET: "+theJSP+" INFO: "+theCustomString; break;
      case 5002:
        sMessage = getCRITString() + "ERRORE GENERATO SUL SERVER: "+theCustomString; break;

      case 5003:
          sMessage = getCRITString() + "ERRORE GENERATO SUL SERVER: "+theCustomString; break;

      /////////////////////////////////////////////////////////////////////////////////////////////////
      
      //SECURITY da 7001 a 9000  
      case 7001: 
        sMessage = getSECRString() + "ACCESSO ALLA PAGINA "+theJSP+" DA UTENTE NON AUTORIZZATO"; break;
      case 7002: 
        sMessage = getSECRString() + "LOGIN ERRATA"; break;
      case 7003: 
        sMessage = getSECRString() + "INSERITA PASSWORD ERRATA"; break;
      case 7004: 
        sMessage = getSECRString() + "RIDIREZIONE UTENTE NON AUTORIZZATO"; break;
      case 7005: 
        sMessage = getSECRString() + "RIDIREZIONE UTENTE X ALLINEAMENTO DB"; break;
      case 7006: 
        sMessage = getSECRString() + "RIDIREZIONE UTENTE X ATTIVITA DATABASE"; break;
      case 7007:
        sMessage = getSECRString() + "LOGIN O PASSWORD ERRATA PER L'UTENTE : " +getFormattedUserName(); break;
      case 7008: 
        sMessage = getSECRString() + "NUMERO MASSIMO DI ACCESSI ERRATI. UTENTE "+getFormattedUserName()+ " DISABILITATO"; break;
      case 7009: 
        sMessage = getSECRString() + "UTENTE "+getFormattedUserName()+ " DISABILITATO"; break;
        
      /////////////////////////////////////////////////////////////////////////////////////////////////        

      default:
        sMessage = getCRITString() + "VALORE " +iMessageID + " NON GESTITO DALLA SWITCH";
    }
    return (sMessage+"\n");
  }
  public static String getPC_Ip() {
    //return (" : PC="+theClientMachineName+" IP="+theClientIp+" ").toUpperCase();
    return (theClientIp+" ").toUpperCase();
  }

}