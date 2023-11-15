package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;

import java.io.*;
import java.util.*;

import com.ejbBMP.*;
import com.utl.*;


public class OggFattCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private OggFattBMPHome home=null;
  private OggFattBMP remote=null;
  private OggFattBMPPK pk = new OggFattBMPPK();
  private String cod_contratto=null;
  private String des_contratto=null;
  private String flag_sys=null;
  

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    Context context=null;
    try
		{
    	context = new InitialContext();     
    	Object homeObject = context.lookup("OggFattBMP");
      home = (OggFattBMPHome)PortableRemoteObject.narrow(homeObject, OggFattBMPHome.class);
      
		} 
    catch(NamingException e)
    {
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"OggFattCntl","","",StaticContext.APP_SERVER_DRIVER));
       e.printStackTrace();
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

  /**
   * Process the HTTP doGet request.
   */
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

//        sendErrorRedirect (request,response,"/common/jsp/TrackingErrorPage.jsp",e);
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"OggFattCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  /**
   * Process the HTTP doPost request.
   */
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"OggFattCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
    response.setContentType(CONTENT_TYPE);
    try
      {
      PrintWriter out = response.getWriter();
      String action=request.getParameter("act");

      cod_contratto=request.getParameter("cod_contratto");
      des_contratto=request.getParameter("des_contratto");
      flag_sys=request.getParameter("flag_sys");
      if (action.equalsIgnoreCase("insert"))
        doInsert(request,response);

      if (action.equalsIgnoreCase("aggiorna"))
        doUpdate(request,response);
 
      if (action.equalsIgnoreCase("disattiva"))
        doDisattiva(request,response);
 
      request.getSession().setAttribute("cod_contratto",cod_contratto);
      request.getSession().setAttribute("des_contratto",des_contratto);
      request.getSession().setAttribute("flag_sys",flag_sys);

      response.sendRedirect(request.getContextPath()+"/oggetti_fatturazione/jsp/ListaOf.jsp");

      out.close();
      }
      catch (Exception e)
          {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
          if (e instanceof CustomEJBException)
           {
              CustomEJBException myexception = (CustomEJBException)e;
               throw myexception;
           }
          else
            throw new CustomEJBException(e.toString(),"Errore durante processing","processing","OggFattCntl",StaticContext.FindExceptionType(e));
          }
  }

  private void doInsert(HttpServletRequest request, HttpServletResponse response)
//  throws ServletException
  throws  CustomEJBException
  {
        String dataIni=request.getParameter("data_ini");
        String codeCf=request.getParameter("classefatt");
        String desc=request.getParameter("desc");
        String tipoFlgAssocB="N";
//        if (request.getParameter("assPs").equalsIgnoreCase("yes"))
        if (request.getParameter("assPs")==null)
          {
          tipoFlgAssocB="N";
          }
        else
          {
          tipoFlgAssocB="S";
          }
        String dataFine=request.getParameter("data_fine");

      if (flag_sys.equals("S")){
        try
          {
          remote= home.create(dataIni,codeCf,desc,tipoFlgAssocB,dataFine,cod_contratto);
          }
        catch (Exception e)
          {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
            if (e instanceof CustomEJBException)
            {
              CustomEJBException myexception = (CustomEJBException)e;
              throw myexception;
            }
            else
              throw new CustomEJBException(e.toString(),"Errore durante insert Special","doInsert","OggFattCntl",StaticContext.FindExceptionType(e));
            }
         }
      else{
        try
          {
          remote= home.create(dataIni,codeCf,desc,tipoFlgAssocB,dataFine);
          }
        catch (Exception e)
          {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
            if (e instanceof CustomEJBException)
            {
              CustomEJBException myexception = (CustomEJBException)e;
              throw myexception;
            }
            else
              throw new CustomEJBException(e.toString(),"Errore durante insert Classic","doInsert","OggFattCntl",StaticContext.FindExceptionType(e));
            }
         }
  }
  
  private void doUpdate(HttpServletRequest request, HttpServletResponse response)
//  throws ServletException
  throws  CustomEJBException
  {
          
        String codeOf=request.getParameter("code_of");
        String codeCf=request.getParameter("classefatt");
        String desc=request.getParameter("desc");
        String tipoFlgAssocB;
        if (request.getParameter("assPs")==null)
          tipoFlgAssocB="N";
        else
          tipoFlgAssocB="S";
        String dataFine=request.getParameter("data_fine");

        pk.setCodeOf(codeOf);
        pk.setFlagSys(flag_sys);
        try
          {
            //System.out.println(">>>Update<<<");
            OggFattBMP remote=home.findByPrimaryKey(pk);
            //System.out.println(">>>dataFine="+dataFine);
            remote.setDataFine(dataFine);
            //System.out.println(">>>codeCf="+codeCf);
            remote.setCodeCOf(codeCf);
            //System.out.println(">>>tipoFlgAssocB="+tipoFlgAssocB);
            remote.setTipoFlgAssocB(tipoFlgAssocB);
            //System.out.println(">>>desc="+desc);            
            remote.setDescOggFatt(desc);
          }

       catch (Exception e)
          {
//          throw new ServletException("Errore OggFattBMPHome.create",e);
            if (e instanceof CustomEJBException)
            {
              CustomEJBException myexception = (CustomEJBException)e;
              throw myexception;
            }
            else
              throw new CustomEJBException(e.toString(),"Errore durante update","doUpdate","OggFattCntl",StaticContext.FindExceptionType(e));
          }
  }
  
  private void doDisattiva(HttpServletRequest request, HttpServletResponse response)
  throws CustomEJBException
  {
        String codeOf=request.getParameter("code_of");
        String dataFine=request.getParameter("data_fine");
        String flag_sys=request.getParameter("flag_sys");

       //System.out.println(">>> OggFatt.flag_sys="+flag_sys);
        
        pk.setCodeOf(codeOf);
        pk.setFlagSys(flag_sys);  

        try
          {
            OggFattBMP remote=home.findByPrimaryKey(pk);
            remote.setDataFine(dataFine);
          }
       catch (Exception e)
          {
            if (e instanceof CustomEJBException)
            {
              CustomEJBException myexception = (CustomEJBException)e;
              throw myexception;
            }
            else
              throw new CustomEJBException(e.toString(),"Errore durante disattivazione","doDisattiva","OggFattCntl",StaticContext.FindExceptionType(e));
         }
  }

}