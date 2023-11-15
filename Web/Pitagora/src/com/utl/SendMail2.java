package com.utl;

import com.ejbSTL.Ent_Contratti;
import com.ejbSTL.Ent_ContrattiHome;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import com.utl.*;

import javax.naming.Context;
import javax.naming.InitialContext;

import javax.rmi.PortableRemoteObject;


public class SendMail2 {


	public SendMail2(String codeTipoContr, String data_inizio_periodo, String data_fine_periodo, String descrizioneCiclo) throws MessagingException 
  {	
    Properties props = new Properties();
	  props.put("mail.transport.protocol", "smtp");
    props.put("username", StaticContext.USER_SEND_MAIL);
    props.put("password", StaticContext.PWD_SEND_MAIL);
    props.put("mail.smtp.host", StaticContext.MAILSERVER);
	  Session session = Session.getInstance(props, null);
    String txtMsg = "";
    
    String descEASYSL = "E@SY IP - SL";
	  String descEASYWS = "E@SY IP - WS";    
    String descTipoContr = "";
    
	   
    
    if(codeTipoContr.equals("1"))
      descTipoContr = descEASYSL;
    
    if(codeTipoContr.equals("13"))
      descTipoContr = descEASYWS;
    
	  txtMsg="<html><head></head><body><img src=\"http://10.50.16.22:7778/jpub2/common/images/mail/logo_telecom.jpg\" border=\"0\" alt=\"Telecom Italia Information Technology Logo\">";
	  txtMsg+="<hr color=\"#000000\"><font color=\"#0066FF\"><b>MESSAGGIO AUTOMATICO GENERATO DAL SISTEMA J.P.U.B.</b></font>";
	  txtMsg+="<br><hr color=\"#000000\"><br></br>";
	  txtMsg+="<font color=\"#000000\">Eseguito invio file Estrazione <b>"+descTipoContr+"</b> per il ciclo di <b>"+descrizioneCiclo+"</b>";
    txtMsg+=" con data inizio periodo <b>"+data_inizio_periodo+"</b>";
	  txtMsg+=" e data di fine periodo <b>"+data_fine_periodo+"</b></font>";
	  txtMsg+="<br><br><br><br><font color=\"#000000\">Cordiali saluti</font><br></body>";
	  txtMsg+="<img src=\"http://10.50.16.22:7778/jpub2/common/images/mail/jpub_logo.jpg\" border=\"0\" width=\"131\" height=\"150\" alt=\"J.P.U.B. Logo\"><br>";
	  txtMsg+="<b><font color=\"#000000\">Il gruppo J.P.U.B.</font></b><br></html>";

    try
    {
      Multipart mu =null;
      Message msg = new MimeMessage(session);
		  msg.setFrom(new InternetAddress(StaticContext.SENDADRRESS));
      


/* EMAIL PER ESERCIZIO */          
      Address mailAddressesTO[] = { new InternetAddress("tuc.ga.dwh@telecomitalia.it"),
                                    new InternetAddress("DIC.W.GA.WH@telecomitalia.it")};
      
      Address mailAddressesCC[] = { new InternetAddress("tool.Sherlock@telecomitalia.it"),
      															new InternetAddress("andrea.castrucci@telecomitalia.it"),
      															new InternetAddress("daniela.manuelli@telecomitalia.it"),
                                    new InternetAddress("tuc.ga.mb@telecomitalia.it"),
      															new InternetAddress("mariacristina.gaeta@telecomitalia.it"),
      															new InternetAddress("claudio.stellino@guest.telecomitalia.it"),
      															new InternetAddress("giovanni.verrengia@guest.telecomitalia.it")};
/**/


/* EMAIL PER COLLAUDO *
      Address mailAddressesTO[] = { new InternetAddress("daniela.manuelli@telecomitalia.it"),
                                    new InternetAddress("renato.stirpe@guest.telecomitalia.it"),
                                    new InternetAddress("antonio.cuccagna@telecomitalia.it"),
                                    new InternetAddress("alberto.bernasconi@telecomitalia.it")};
       
      Address mailAddressesCC[] = { new InternetAddress("riccardo.inghingolo@telecomitalia.it"),
                                    new InternetAddress("rinaldo.musetti@telecomitalia.it")};
      
      Address mailAddressesBCC[] = {new InternetAddress("luca1.iannacito@guest.telecomitalia.it"),
                                    new InternetAddress("massimigliano.parrello@guest.telecomitalia.it")};
**/


 /* EMAIL PER SVILUPPO
      Address mailAddressesTO[] = { new InternetAddress("rinaldo.musetti@telecomitalia.it"),
                                    new InternetAddress("riccardo.inghingolo@telecomitalia.it")};
      
      Address mailAddressesBCC[] = { new InternetAddress("luca1.iannacito@guest.telecomitalia.it")};
 */
 
      msg.setRecipients(Message.RecipientType.TO, mailAddressesTO);
      msg.setRecipients(Message.RecipientType.CC, mailAddressesCC);
//      msg.setRecipients(Message.RecipientType.BCC, mailAddressesBCC);      
      msg.setSubject("JPUB - Estrazione servizio "+descTipoContr);
      msg.setContent(txtMsg,"text/html; charset=ISO-8859-1");
      //msg.setText(txtMsg);
      msg.setSentDate(new java.util.Date());
      Transport.send(msg);
      System.out.println("Mail inviata corretta!!");
    }
    catch(MessagingException me)
    {
      System.out.println("Mail: errore in sendMail - MessagingException  [" + me.getMessage()+"]");
      me.printStackTrace();
    }
    catch (Exception  e)
    {
      System.out.println("Mail: errore in sendMail - Exception  [" + e.getMessage()+"]");
      e.printStackTrace();
    }

		

	}

}
