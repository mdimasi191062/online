package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import java.text.*;
import com.utl.*;

public class ColocationCNTL extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private ColocationBMPHome Colocationhome=null;
  private ColocationBMP     Colocationremote=null;
  private ColocationBMPPK    Colocationpk = new ColocationBMPPK();

  String codUtente="";
  String eleCodePs[] = new String[10];
  String  eleQtaPs[] = new String[10];
  String ParameleCodePs="";
  String ParameleQtaPs="";
  String typeLoad="";

  String accountSelez=null;
  String codeaccount=null;
  String sitoSelez=null;
  String codesito=null;
  String utrSelez=null;

  String      dateFormat =  "dd/MM/yyyy";
  String data_ini_jsp=null;
  DateFormat  data_iniFormat = new SimpleDateFormat(dateFormat);
  Date   data_ini;

  String  dataIniValAccDB=null;//      = new SimpleDateFormat(dateFormat);
  DateFormat  dataIniValAccFormat = new SimpleDateFormat(dateFormat);

     
  String mod_ull=null;
  String mod_itc=null;
  String imp_tar=null;
  String imp_cons=null;
  String act=null; 
  String mes=null; //per gestione messaggi 
  
  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    Context context=null;
    try
		{
    	context = new InitialContext();

    	Object homeObject = context.lookup("ColocationBMP");
      Colocationhome = (ColocationBMPHome)PortableRemoteObject.narrow(homeObject, ColocationBMPHome.class);
		}                                                                                       
    catch(NamingException e)
      {
		  
		   StaticMessages.setCustomString(e.toString());
		   StaticContext.writeLog(StaticMessages.getMessage(5001,"ColocationCntl","","",StaticContext.APP_SERVER_DRIVER));

      }
    finally
      {
        try
          {
          if( context != null )
            {
            context.close();
            }
          }
        catch( Exception ex )
          {
          throw new ServletException("Errore close context", ex);
          }
        }
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
    try
    {
      processing(request,response);
    }
    catch (Exception e)
    {
      try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"ColocationCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

//************
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
   try
    {
      processing(request,response);
    }
    catch (Exception e)
    {
    try
      {
        ServletConfig servletconfig=getServletConfig();
        com.utl.SendError mySendError = new com.utl.SendError();
        mySendError.sendErrorRedirect (request,response,servletconfig,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"ColocationCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
    
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {

    boolean elab_ok = true;
    


    try
      {
       PrintWriter out = response.getWriter();

       StaticContext.writeLog(StaticMessages.getMessage(1001,request,StaticContext.APP_SERVER_DRIVER)); //PASSWORD ERRATA

       com.usr.clsInfoUser strUserName=(com.usr.clsInfoUser) request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER);
       codUtente=strUserName.getUserName();

        //System.out.println(request.getQueryString());
             
        act=request.getParameter("act"); 
        accountSelez=request.getParameter("accountSelez");
        if (act.equals("insert"))
          accountSelez=request.getParameter("accountSelez1");
         //chiamante=request.getParameter("chiamante");
        data_ini_jsp = request.getParameter("data_ini");
        data_ini=data_iniFormat.parse(data_ini_jsp);
        codeaccount=accountSelez;
        sitoSelez=request.getParameter("sitoSelez");
        codesito=sitoSelez;
        utrSelez=request.getParameter("utrSelez");
        typeLoad = request.getParameter("typeLoad");
        mod_ull=request.getParameter("mod_ull");
        mod_itc=request.getParameter("mod_itc");
        imp_tar=request.getParameter("imp_tar");
        imp_cons=request.getParameter("imp_cons");

        ParameleCodePs="";
        ParameleQtaPs="";
        if (request.getParameterValues("codePs") != null ){
          for (int ieleCodePs=0;ieleCodePs<request.getParameterValues("codePs").length;ieleCodePs++)
            {
            eleCodePs[ieleCodePs] = request.getParameterValues("codePs")[ieleCodePs];
            eleQtaPs[ieleCodePs] = request.getParameterValues("qta")[ieleCodePs];
            } 
          for (int ieleCodePs=0;ieleCodePs<eleCodePs.length;ieleCodePs++)
           {
           ParameleCodePs+="&eleCodePs="+eleCodePs[ieleCodePs];
           ParameleQtaPs+="&eleQtaPs="+eleQtaPs[ieleCodePs];
           } 
        } 

if (act.equalsIgnoreCase("insert"))
   {
     doInsert(request,response);
    }

//  Aggiornamento Inizio
	if (act.equalsIgnoreCase("agg"))
	{
     doUpdate(request,response);
  }
// Aggiornamento Fine

// Cancellazione Inizio
	if (act.equalsIgnoreCase("can"))
	{
      doCancella(request,response);
  }   
// Cancellazione Fine
     
			
	    out.close();
  }
      catch (Exception e)
    {

      if (e instanceof CustomEJBException)
      {

        CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore durante processing","processing","ColocationCntl",StaticContext.FindExceptionType(e));
    }
  }


//Metodo per l'inserimento inizio
 private void doInsert(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
        try
          {
             Double imptar=new Double(imp_tar.replace(',','.'));
             Double impcons=null;
             if ((imp_cons!=null)&&(!(imp_cons.equals(""))))
             {    
                  //System.out.println("impcons "+impcons);
                  impcons=new Double(imp_cons.replace(',','.'));
             }   
             //System.out.println(">>>>1 ");
             int modull;
             if (!(mod_ull.equals("")))
             {
                modull=new Integer(mod_ull).intValue();
             }
             else
             {
               modull=new Integer(0).intValue();
             }

             int moditc;
             if (!(mod_itc.equals("")))
             {
                moditc=new Integer(mod_itc).intValue();
             }
             else
             {
                moditc=new Integer(0).intValue();
             }
             //ColocationBMP Colocationeremote= Colocationhome.create("CORNELI","006269","142","04/10/2002",imptar,impcons);

             //System.out.println("codUtente "+codUtente+"sitoSelez."+sitoSelez+".accountSelez"+accountSelez+"data_ini_jsp."+data_ini_jsp+"imptar."+imptar+"impcons."+impcons+"modull."+modull+"moditc."+moditc+"eleCodePs."+eleCodePs+"eleQtaPs."+eleQtaPs);             
             ColocationBMP remote= Colocationhome.create(codUtente,sitoSelez,accountSelez,data_ini_jsp,imptar,impcons,modull,moditc,eleCodePs,eleQtaPs); 
             mes = "OK";
             request.getSession().setAttribute("act",act);
             response.sendRedirect(request.getContextPath()+
             "/colocation/jsp/ListaAccountCol.jsp?act="+act+
             "&mes="+java.net.URLEncoder.encode(mes,com.utl.StaticContext.ENCCharset)+
             "&accountSelez=-1"+
             "&sitoSelez=-1"+
             "&utrSelez=-1"+
             "&data_ini="+data_ini_jsp+
             "&mod_ull="+mod_ull+
             "&mod_itc="+mod_itc+
             "&imp_tar="+imp_tar+
             "&imp_cons="+imp_cons+ParameleCodePs+ParameleQtaPs);
            
          }
          catch (Exception e)
          {
			  
			     if (e instanceof CustomEJBException)
			     {
				     CustomEJBException myexception = (CustomEJBException)e;
				     throw myexception;
			      }
			     else
				   throw new CustomEJBException(e.toString(),"Errore in ColocBMPHome.create", "doInsert","ColocCntl",StaticContext.FindExceptionType(e));
          }
         
  }


//Metodo per l'inserimento fine

// Dario aggiornamento - inizio
 private void doUpdate(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
        try
          {  //sostituzione cifre  
             Double imptar=new Double(imp_tar.replace(',','.'));
             Double impcons=null;
             if ((imp_cons!=null)&&(!(imp_cons.equals(""))))
             {    
                  //System.out.println("impcons "+impcons);
                  impcons=new Double(imp_cons.replace(',','.'));
             }
             else
             {
                  impcons=new Double(0);
             }
             int modull;
             if (!(mod_ull.equals("")))
             {
                modull=new Integer(mod_ull).intValue();
             }
             else
             {
               modull=new Integer(0).intValue();
             }

              //System.out.println(">>>>2");
             int moditc;
             if (!(mod_itc.equals("")))
             {
                moditc=new Integer(mod_itc).intValue();
             }
             else
             {
                moditc=new Integer(0).intValue();
             }
             //int modull=new Integer(mod_ull).intValue();
             //int moditc=new Integer(mod_itc).intValue();
             //ColocationBMP Colocationeremote= Colocationhome.create("CORNELI","006269","142","04/10/2002",imptar,impcons);
             //ColocationBMP remote= 

  //System.out.println("UPDATE codUtente "+codUtente+"sitoSelez."+sitoSelez+".accountSelez"+accountSelez+"data_ini_jsp."+data_ini_jsp+"imptar."+imptar+"impcons."+impcons+"modull."+modull+"moditc."+moditc+"eleCodePs."+eleCodePs+"eleQtaPs."+eleQtaPs);             
             
             Colocationhome.store(codUtente,sitoSelez,accountSelez,data_ini_jsp,imptar,impcons,modull,moditc,eleCodePs,eleQtaPs); 
             mes = "OK";
             request.getSession().setAttribute("act",act);
             response.sendRedirect(request.getContextPath()+
             "/colocation/jsp/ListaAccountCol.jsp?act="+act+
             "&mes="+java.net.URLEncoder.encode(mes,com.utl.StaticContext.ENCCharset)+
             "&accountSelez="+accountSelez+
             "&sitoSelez="+sitoSelez+
             "&utrSelez="+utrSelez+
             "&data_ini="+data_ini_jsp+
             "&mod_ull="+mod_ull+
             "&mod_itc="+mod_itc+
             "&caricaLista=true"+
             "&caricasiti=true"+
             "&imp_tar="+imp_tar+
              "&imp_cons="+imp_cons+ParameleCodePs+ParameleQtaPs);
          }
                 
          catch (Exception e)
          {
			  
			     if (e instanceof CustomEJBException)
			     {
				     CustomEJBException myexception = (CustomEJBException)e;
				     throw myexception;
			      }
			     else
				   throw new CustomEJBException(e.toString(),"Errore in ColocBMPHome.create", "doInsert","ColocCntl",StaticContext.FindExceptionType(e));
          }
  }
// Dario aggiornamento fine
// Dario cancellazione - inizio
 private void doCancella(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
        
        try
          {

  //System.out.println("DELETE codUtente "+codUtente+"sitoSelez."+sitoSelez+".accountSelez"+accountSelez+"data_ini_jsp."+data_ini_jsp+"eleCodePs."+eleCodePs+"eleQtaPs."+eleQtaPs);             
             Colocationpk.setAccountSelez(codeaccount);
             Colocationpk.setSitoSelez(codesito);
             Colocationhome.remove(Colocationpk);

             mes = "OK";
             request.getSession().setAttribute("act",act);
             response.sendRedirect(request.getContextPath()+
             "/colocation/jsp/ListaAccountCol.jsp?act="+act+
             "&mes="+java.net.URLEncoder.encode(mes,com.utl.StaticContext.ENCCharset)+
             "&accountSelez="+accountSelez+
             "&sitoSelez="+sitoSelez+
             "&utrSelez="+utrSelez+
             "&data_ini="+data_ini_jsp+
             "&mod_ull="+mod_ull+
             "&mod_itc="+mod_itc+
             "&caricaLista=true"+
             "&caricasiti=true"+
             "&imp_tar="+imp_tar+
              "&imp_cons="+imp_cons+ParameleCodePs+ParameleQtaPs);
             
          }
          catch (Exception e)
          {
			  
			     if (e instanceof CustomEJBException)
			     {
				     CustomEJBException myexception = (CustomEJBException)e;
				     throw myexception;
			      }
			     else
				   throw new CustomEJBException(e.toString(),"Errore in ColocBMPHome.create", "doInsert","ColocCntl",StaticContext.FindExceptionType(e));
          }
  }
// Dario cancellazione fine
}