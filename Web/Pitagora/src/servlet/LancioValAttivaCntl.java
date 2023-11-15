package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import java.text.*;
import com.utl.*;



public class LancioValAttivaCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private DatiCliBMPHome     homeAccount=null;
  private Collection         remoteAccNoVa=null;
  private Collection         remoteFattProvv=null;
  private Collection         remoteAggParam=null;
  int numFattProvv;
  int numAccNoVa;
  int numAccNoteCred;
  String codeFunzBatch;
  String codeFunzBatchNC;
  String flagTipoContr; //???
  String comboCicloFattSelez;
  String act;
  String dataIniCiclo;
  String cod_tipo_contr=null;
  String prov;
  String des_tipo_contr=null;
  
  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    Context context=null;
     try
		{
    	context = new InitialContext();     
      Object homeObject = context.lookup("DatiCliBMP");
      homeAccount = (DatiCliBMPHome)PortableRemoteObject.narrow(homeObject, DatiCliBMPHome.class);
		}
    catch(NamingException e)
      {
			throw new ServletException("Errore lookup DatiCliBMP", e);
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
      }
      catch(Exception ex)
      {
        StaticMessages.setCustomString(ex.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5001,"LancioValAttivaCntl","","",StaticContext.APP_SERVER_DRIVER));
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"LancioValAttivaCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response) throws ServletException
  {
    //response.setContentType(CONTENT_TYPE);
    try
      {
       PrintWriter out     = response.getWriter();
       comboCicloFattSelez = request.getParameter("comboCicloFattSelez");
       dataIniCiclo        = request.getParameter("dataIniCiclo");
       codeFunzBatch       = request.getParameter("codeFunzBatch");
       codeFunzBatchNC     = request.getParameter("codeFunzBatchNC");
       act                 = request.getParameter("act");
       cod_tipo_contr =request.getParameter("cod_tipo_contr");
       des_tipo_contr =request.getParameter("des_tipo_contr");
            
           if (act!=null && act.equals("elimina_fatture"))
           {
                eliminaFatture(request,response);
                accountNoVa(request,response);
                if (numAccNoVa!=0)
                {
                   act="accountNoFatt";
                   response.sendRedirect(request.getContextPath()+"/valorizza_attiva/jsp/AccountSp.jsp?act="+act+"&comboCicloFattSelez="+comboCicloFattSelez
                                                                 +"&cod_tipo_contr="+cod_tipo_contr+"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)+"&dataIniCiclo="+dataIniCiclo);
                }
                else
                {
                  act="refresh";
                  aggiornaParamValo(request,response);
                  response.sendRedirect(request.getContextPath()+"/valorizza_attiva/jsp/AccountSp.jsp?act="+act+"&comboCicloFattSelez="+comboCicloFattSelez
                                                                 +"&cod_tipo_contr="+cod_tipo_contr+"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset));
                }
            }

             else if (act!=null && act.equals("aggiornaParVal"))
                  {
                     //Lancia PARAM_VALO_AGGIORNA
                     act="caricaTutto";
                     prov="1";
                     aggiornaParamValo(request,response);
                     response.sendRedirect(request.getContextPath()+"/valorizza_attiva/jsp/LancioValAttivaWfSp.jsp?act="+act+
                     "&comboCicloFattSelez="+comboCicloFattSelez+"&cod_tipo_contr="+cod_tipo_contr+"&prov="+prov);
                 }
                  else
                  {
                  }
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
        throw new CustomEJBException(e.toString(),"Errore durante processing","processing","LancioValAttivaCntl",StaticContext.FindExceptionType(e));
          }

  }

  private void accountNoVa(HttpServletRequest request, HttpServletResponse response)  throws ServletException, CustomEJBException
  {
    try
    {
     //RICHIEDE LA LISTA DELLE FATTURE MAI VALORIZZATE
     remoteAccNoVa= homeAccount.findAllAccNoVa(cod_tipo_contr,comboCicloFattSelez,dataIniCiclo);
     if ((remoteAccNoVa!=null))
         numAccNoVa=remoteAccNoVa.size();
     }
    catch (Exception e)
    {
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored ACCOUNT_NO_VA","accountNoVa","LancioValAttivaCntl",StaticContext.FindExceptionType(e));
    }
  }


    private void eliminaFatture(HttpServletRequest request, HttpServletResponse response)  throws ServletException, CustomEJBException
    {
    String testoEccezione="";

    String codiceTipoContratto=""; // lp 25/08/2004 anomalia Cambio Ciclo

    if (codeFunzBatch.equals("23"))
        testoEccezione="ACCOUNT_CON_FATT_PROVV";
    else if (codeFunzBatch.equals("21"))
          testoEccezione="ACCOUNT_CON_FATT_PROVV_XDSL";
    try
    {
      //ELIMINA LE FATTURE PROVVISORIE
      remoteFattProvv= homeAccount.findFattProvv(codeFunzBatch,comboCicloFattSelez,dataIniCiclo,codiceTipoContratto);
      if ((remoteFattProvv!=null) && (remoteFattProvv.size()!=0))
      {
            Object[] objs=remoteFattProvv.toArray();
            Collection FattProvv = new Vector();
            for(int i=0;i< remoteFattProvv.size();i++)
               {
                 DatiCliElem elem=new  DatiCliElem();
                 elem.setAccount(((DatiCliBMP)objs[i]).getAccount());
                 elem.setDesc(((DatiCliBMP)objs[i]).getDesc());
                 elem.setCodeDocFatt(((DatiCliBMP)objs[i]).getCodeDocFatt());  
                 FattProvv.add(elem);
               }
            homeAccount.removeFattProvv(codeFunzBatch,FattProvv);
      }      
     }
     catch (Exception e)
    {
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored "+testoEccezione,"eliminaFatture","LancioValAttivaCntl",StaticContext.FindExceptionType(e));
    }

  }

    private void aggiornaParamValo(HttpServletRequest request, HttpServletResponse response)  throws ServletException, CustomEJBException
    {
    try
    {
      //AGGIORNA PARAMETRI DI VALORIZZAZIONE
      int flag_commit=0;
      remoteAggParam = homeAccount.findAllAccNoVa(cod_tipo_contr,comboCicloFattSelez,dataIniCiclo.substring(0,10));
      if ((remoteAggParam!=null) && (remoteAggParam.size()!=0))
      {
            Object[] objs=remoteAggParam.toArray();
            Collection AggParam = new Vector();
            for(int i=0;i< remoteAggParam.size();i++)
               {
                 DatiCliElem elem=new  DatiCliElem();
                 elem.setAccount(((DatiCliBMP)objs[i]).getAccount());
                 elem.setDesc(((DatiCliBMP)objs[i]).getDesc());
                 elem.setCodeParam(((DatiCliBMP)objs[i]).getCodeParam());  
                 AggParam.add(elem);
               }
            homeAccount.aggInsCodParam(AggParam);
       }   
     }
         catch (Exception e)
    {
      if (e instanceof CustomEJBException)
      {
       	CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore nella stored PARAM_VALO_AGGIORNA","aggiornaParamValo","LancioValAttivaCntl",StaticContext.FindExceptionType(e));
    }
  }
}