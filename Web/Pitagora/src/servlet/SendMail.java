package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import com.utl.StaticContext;
import javax.mail.*;
import javax.mail.internet.*;
import java.lang.*;
import com.usr.clsInfoUser;


public class SendMail extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {

    java.text.DateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    String dateTime = fmt.format(new Date());

    String tipoErrore = request.getParameter("ERRORE");
    String txtMsg="";
    
    if(tipoErrore.equals("SISTEMA")){
      String strdateTime=request.getParameter("message");
      String strstack_trace=request.getParameter("stack_trace");
      String strcodice=request.getParameter("codice");
      String strtipo=request.getParameter("tipo");
      String strnome_funzione=request.getParameter("nome_funzione");
      String strnome_ejb=request.getParameter("nome_ejb");
      String strremoteAddr=request.getParameter("remoteAddr");
      String strservletContext=request.getParameter("servletContext");
      String strstackTrace=request.getParameter("stack_trace");

      txtMsg="Si è verificato un errore nel codice. Consultare il file di LOG\n";
      txtMsg+="data e ora: "+dateTime+"\n";
      txtMsg+="Client: "+strremoteAddr+"\n";
      txtMsg+="Pagina: "+strservletContext+"\n";
      txtMsg+="Codice: "+strcodice+"\n";
      txtMsg+="Tipo: "+strtipo+"\n";
      txtMsg+="Nome Funzione: "+strnome_funzione+"\n";
      txtMsg+="Nome Ejb/Servlet: "+strnome_ejb+"\n\n\n";    
      txtMsg+="Questo è lo stato dello stack:\n "+strstackTrace+"\n";
    }else{
      String utente = request.getParameter("USERNAME");
      String sistema = request.getParameter("SISTEMA");
      txtMsg="Autenticazione dell'utente "+ utente +" non riuscita per il sistema "+ sistema +".\n";
    }
    
    Properties prop = new Properties();
    prop.put("mail.transport.protocol", "smtp");
    prop.put("mail.smtp.host", StaticContext.MAILSERVER);
    //prop.put(StaticContext.MAILSERVER,StaticContext.POPSERVER);
    Session  session  = Session.getInstance(prop,null);

    String messageResult = null;

    try 
    {
      Message msg = new MimeMessage(session);
      //msg.setFrom(new InternetAddress(StaticContext.SENDADRRESS));
      String desc_mail = null;

      HttpSession sessionMail = null;
      HttpServletResponse  resp = (HttpServletResponse)response;
      HttpServletRequest   req = (HttpServletRequest)request;
      sessionMail = req.getSession(false); 
      clsInfoUser cl = (clsInfoUser)sessionMail.getAttribute(StaticContext.ATTRIBUTE_USER);
      if(cl != null){
        desc_mail = cl.getDescMail();
      }else{
        desc_mail = StaticContext.SENDADRRESS;
      }
      msg.setFrom(new InternetAddress(desc_mail));
      InternetAddress   addressTO = new InternetAddress(StaticContext.RECIPIENTADDRESS);
      msg.setRecipient(Message.RecipientType.TO, addressTO);
      msg.setSubject(StaticContext.SUBJECT);
      msg.setText(txtMsg);
      msg.setSentDate(new java.util.Date());
      Transport.send(msg);
      messageResult = "Invio effettuato con successo";
    }
    catch (Exception  e) 
    {
      System.out.println("Mail: errore in sendMail- " + e.getMessage());
      e.printStackTrace();
      messageResult = "Invio non effettuato";
    }

    response.setContentType(CONTENT_TYPE);

    PrintWriter out = response.getWriter();
    out.println("<html>");
    out.println("<script>");
        out.println("history.back();");
        out.println("window.alert('"+messageResult+"');");
    out.println("</script>");
    out.println("</html>");
    out.close();
  }
}