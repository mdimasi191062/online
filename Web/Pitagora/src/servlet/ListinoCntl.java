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
import com.usr.*;

import java.util.regex.Pattern;

public class ListinoCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private DatiCliBMPHome home1 = null;
  private TariffaBMPHome home4 = null;
  private TariffaBMP elabBatchTrovate = null;
  private DatiCliBMP numFattLisUn = null;
  
  private String codOf;
  private String cod_PS;
  private String cod_tipo_caus;
  private String contrDest;
    private String contrDestCluster;
  private String codContr;
    private String codContrClus;
  private String codeListino;  
  private String codUt;
  private String codeTipoContratto;
  private String descTipoContratto;
  private String flagTipoContr; //040203
  private Collection Tariffe_ins;
  private TariffeInsElem TariffeIns = new TariffeInsElem();
  private String descContratto;
  private String selDest;
  private String codeListDest;
    private String codeListDestCluster;
  private String numTar_ins;
  private String Insert;
  private String numFatt;
  private String numElab;
  private String numTar;
  private Integer typeLoad;

   public void init(ServletConfig config) throws ServletException
  {
    super.init(config);
    //System.out.println("*********************SERVLET**********************");
    Context context=null;
    try
		{
    	context = new InitialContext();
    	Object homeObject4 = context.lookup("TariffaBMP");
      Object homeObject1 = context.lookup("DatiCliBMP");
      home4 = (TariffaBMPHome)PortableRemoteObject.narrow(homeObject4, TariffaBMPHome.class);
      home1 = (DatiCliBMPHome)PortableRemoteObject.narrow(homeObject1, DatiCliBMPHome.class);
		}
    catch(NamingException e)
      {
		   StaticMessages.setCustomString(e.toString());
		   StaticContext.writeLog(StaticMessages.getMessage(5001,"ListinoCntl","","",StaticContext.APP_SERVER_DRIVER));
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
//System.out.println("*********************DOGET**********************");
    try
    {
//System.out.println("*********************try processing**********************");
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"ListinoCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

   /**
   * Process the HTTP doPost request.
   */
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
//System.out.println("*********************DOPOST**********************");
   try
    {
//System.out.println("*********************try processing**********************");
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"ListinoCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }

  protected void processing(HttpServletRequest request, HttpServletResponse response)
  throws ServletException
  {
    //System.out.println("*********************PROCESSING**********************");
    boolean elab_ok = true;
    
    try
      {
       PrintWriter out = response.getWriter();

       StaticContext.writeLog(StaticMessages.getMessage(1001,request,StaticContext.APP_SERVER_DRIVER)); //PASSWORD ERRATA

       String act = request.getParameter("act");
       
       //codContr = request.getParameter("codeListino");
        codContr = request.getParameter("codeListinoListino");
        codContrClus = request.getParameter("codeListino");
        
       contrDest = request.getParameter("codeListDest");
       contrDestCluster = request.getParameter("codeListDestCluster");
       descTipoContratto = request.getParameter("descTipoContratto");
       codeTipoContratto = request.getParameter("codeTipoContratto");
       flagTipoContr = request.getParameter("flagTipoContr"); //040203
       numElab = request.getParameter("numElab");
       numFatt = request.getParameter("numFatt");
       numTar = request.getParameter("numTar");
       codUt = ((clsInfoUser)request.getSession().getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName();
	     Tariffe_ins = (Collection)request.getSession().getAttribute("Tariffe_ins");
/*System.out.println("in CNTL act"+act);
System.out.println("in CNTL codContr"+codContr);
System.out.println("in CNTL codeTipoContratto"+codeTipoContratto);
System.out.println("in CNTL contrDest"+contrDest);
System.out.println("in CNTL codUt"+codUt);
System.out.println("in CNTL Tariffe_ins"+Tariffe_ins.size());*/

        //System.out.println("act ---> "+act);
  	    boolean elab_ok_XXX = doInsert(request,response);
  	    // doInsert(request,response);
			  if (elab_ok) // si torna al pannello chiamante
			  {
             //System.out.println("elab_ok: "+elab_ok);
             act = null;
             descContratto = "";
             selDest = "";
             codeListDest = "";
              codeListDestCluster = "";
             contrDest = "";
              contrDestCluster ="";
             numTar_ins = "0";
             Insert = null;
             codContr = "";
              codContrClus = "";
             Tariffe_ins.clear();
             codeListino = "";
             request.getSession().setAttribute("descContratto",descContratto);
             request.getSession().setAttribute("descTipoContratto",descTipoContratto);
             request.getSession().setAttribute("codeTipoContratto",codeTipoContratto);
             request.getSession().setAttribute("flagTipoContr",flagTipoContr);//040203
             request.getSession().setAttribute("selDest",selDest);
             request.getSession().setAttribute("codeListDest",codeListDest);
              request.getSession().setAttribute("codeListDestCluster",codeListDestCluster);
             request.getSession().setAttribute("numTar_ins",numTar_ins);
             request.getSession().setAttribute("Insert",Insert);
             request.getSession().setAttribute("codContr",codContr);
              request.getSession().setAttribute("codContrClus",codContrClus);
             request.getSession().setAttribute("codeListino",codeListino);
             request.getSession().setAttribute("contrDest",contrDest);
             request.getSession().setAttribute("contrDestCluster",contrDestCluster);
             request.getSession().setAttribute("codUt",codUt);
             request.getSession().setAttribute("Tariffe_ins",Tariffe_ins);
             request.getSession().setAttribute("numElab",numElab);
             request.getSession().setAttribute("numFatt",numFatt);
             request.getSession().setAttribute("numTar",numTar);             
             request.getSession().setAttribute("act",act);
              request.getSession().setAttribute("messaggio_alert",null);

             if (elab_ok_XXX) {
                 request.getSession().setAttribute("messaggio_alert",null);
             }else {
                 request.getSession().setAttribute("messaggio_alert","ERRORE");
             }

            //System.out.println("descContratto"+descContratto);
             //System.out.println("codeTipoContratto"+codeTipoContratto);
             //System.out.println("selDest"+selDest);
             //System.out.println("codeListDest"+codeListDest);
             //System.out.println("numTar_ins"+Insert);
             //System.out.println("Insert"+Insert);
             //System.out.println("codContr"+codContr);
             //System.out.println("contrDest"+contrDest);
             //System.out.println("codUt"+codUt);
             //System.out.println("Tariffe_ins"+Tariffe_ins);
             //System.out.println("numElab"+numElab);
             //System.out.println("numFatt"+numFatt);
             //System.out.println("numTar"+numTar);              
             //System.out.println("act"+act);


              //System.out.println("Si torna al pannello corrente");
              response.sendRedirect(request.getContextPath()+
              "/ribaltamento_listino/jsp/RibListinoSp.jsp?act="+act+
              "&codUt="+codUt+
              "&flagTipoContr="+flagTipoContr+ //040203
              "&codeTipoContratto="+codeTipoContratto+
              "&descTipoContratto="+java.net.URLEncoder.encode(descTipoContratto,com.utl.StaticContext.ENCCharset)+              
              "&descContratto="+java.net.URLEncoder.encode(descContratto,com.utl.StaticContext.ENCCharset)+
              "&codeListino="+codeListino+              
              "&selDest="+selDest+
              "&codeContratto="+codContr+
              "&codeContrattoCluster="+codContrClus+
              "&Insert="+Insert+
              "&codeListDest="+codeListDest+
              "&codeListDestCluster="+codeListDestCluster+
              "&numTar_ins="+numTar_ins+
              "&numTar="+numTar+              
              "&numFatt="+numFatt+
              "&numElab="+numElab);
              out.close();
          }
          else
          {
             //System.out.println("elab_non_ok: "+elab_ok);
             //System.out.println("Si torna al pannello corrente con un alert");
             act = "CONFERMA";
             request.getSession().setAttribute("descContratto",descContratto);
             request.getSession().setAttribute("descTipoContratto",descTipoContratto);
             request.getSession().setAttribute("codeTipoContratto",codeTipoContratto);
             request.getSession().setAttribute("flagTipoContr",flagTipoContr);//040203
             request.getSession().setAttribute("selDest",selDest);
             request.getSession().setAttribute("codeListDest",codeListDest);
              request.getSession().setAttribute("codeListDestCluster",codeListDestCluster);
             request.getSession().setAttribute("numTar_ins",numTar_ins);
             request.getSession().setAttribute("Insert",Insert);
             request.getSession().setAttribute("codContr",codContr);
              request.getSession().setAttribute("codContrClus",codContrClus);
             request.getSession().setAttribute("codeListino",codeListino);
             request.getSession().setAttribute("contrDest",contrDest);
              request.getSession().setAttribute("contrDestCluster",contrDestCluster);
             request.getSession().setAttribute("codUt",codUt);
             request.getSession().setAttribute("Tariffe_ins",Tariffe_ins);
             request.getSession().setAttribute("numElab",numElab);
             request.getSession().setAttribute("numFatt",numFatt);
             request.getSession().setAttribute("numTar",numTar);             
             request.getSession().setAttribute("act",act);
              

              //System.out.println("Si torna al pannello corrente con un alert");
              response.sendRedirect(request.getContextPath()+
              "/ribaltamento_listino/jsp/RibListinoSp.jsp?act="+act+
              "&codUt="+codUt+
              "&flagTipoContr="+flagTipoContr+ //040203
              "&codeTipoContratto="+codeTipoContratto+
              "&descTipoContratto="+java.net.URLEncoder.encode(descTipoContratto,com.utl.StaticContext.ENCCharset)+              
              "&descContratto="+java.net.URLEncoder.encode(descContratto,com.utl.StaticContext.ENCCharset)+
             "&codeListino="+codeListino+                            
              "&selDest="+selDest+
              "&codeContratto="+codContr+
              "&codeContrattoCluster="+codContrClus+
              "&Insert="+Insert+
              "&codeListDest="+codeListDest+
              "&codeListDestCluster="+codeListDestCluster+
              "&numTar_ins="+numTar_ins+
              "&numFatt="+numFatt+
              "&numTar="+numTar+               
              "&numElab="+numElab);
              out.close();
          }
    }
      catch (Exception e)
          {
//System.out.println("ss");
      if (e instanceof CustomEJBException)
      {
//System.out.println("ss1");
        CustomEJBException myexception = (CustomEJBException)e;
        throw myexception;
      }
      else
        throw new CustomEJBException(e.toString(),"Errore durante processing","processing","TariffaCntl",StaticContext.FindExceptionType(e));
          }
  }


 private boolean doInsert(HttpServletRequest request, HttpServletResponse response)
  throws ServletException, CustomEJBException
  {
//System.out.println("*********************DOINSERT**********************");
        try
          {
           //Chiamo ELAB_BATCH_IN_CORSO_FATT
           ////System.out.println("richiamo il bean findNumFattLisUn");
           ////System.out.println("codeTipoContratto:"+codeTipoContratto);
           ////System.out.println("codContr:"+codContr);
            //DatiCliBMP numFattLisUn = home1.findNumFattLisUn(codeTipoContratto, codContr); //040203
            DatiCliBMP numFattLisUn;

             String i_code_contr = "";
             String i_code_tipo_contr = "";
             String i_code_cluster = null;
             String i_tipo_cluster = null;

             String i_code_contr_listino = "";
             String i_code_tipo_contr_listino = "";
             String i_code_cluster_listino = null;
             String i_tipo_cluster_listino = null;
             
            if ( contrDestCluster!=null && contrDestCluster.indexOf("||") >= 0 ) { ////contrDestCluster
                      String[] loc_data = contrDestCluster.split(Pattern.quote( "||" ) ); ////// contrDestCluster
                      i_code_contr = loc_data[0];
                      i_code_tipo_contr = loc_data[3];
                      i_code_cluster = loc_data[1];
                      i_tipo_cluster = loc_data[2];
                      
                      
                if ( (i_code_contr==null || "".equals(i_code_contr)) && (contrDest!=null && !"".equals(contrDest) && !"-1".equals(contrDest) )  ) {
                    i_code_contr=contrDest;
                }
                      
                //codContr = i_code_contr;
            }
            
                 
             if ( codContrClus!=null && codContrClus.indexOf("||") >= 0 ) { 
                       String[] loc_data = codContrClus.split(Pattern.quote( "||" ) ); ////// contrDestCluster
                       i_code_contr_listino = loc_data[0];
                       i_code_tipo_contr_listino = loc_data[3];
                       i_code_cluster_listino = loc_data[1];
                       i_tipo_cluster_listino = loc_data[2];

             }

            
            numFattLisUn = home1.findNumFattLisUn(flagTipoContr, codContr);       //040203
            
            numFatt = numFattLisUn.getNumFattLisUn().toString();
            if (numFattLisUn != null 
            //&&  numFattLisUn.getNumFattLisUn().toString().equals("0"))
               )
            {    
                 //System.out.println("richiamo il bean findElabBatchInCorsoFatt");
                 TariffaBMP elabBatchTrovate = home4.findElabBatchInCorsoFatt();
                 Integer num = elabBatchTrovate.getNumElaborazTrovate();
                 numElab = num.toString();
                 if (numElab != null && numElab.equalsIgnoreCase("0"))
                 { 
                      //System.out.println("richiamo il bean tariffe addTariffe");
                      //System.out.println("codContr: "+codContr);
                      //System.out.println("contrDest: "+contrDest);
                      //System.out.println("codUt: "+codUt);
                      //System.out.println("Tariffe_ins: "+Tariffe_ins.size()); 

                      Object[] objs=Tariffe_ins.toArray();

                      Collection TarIns = new Vector();
                      for(int i=0;i< Tariffe_ins.size();i++)
                        {
                            TariffeInsElem elem=new  TariffeInsElem();
                            elem.setCodOf(((TariffaBMP)objs[i]).getCodOf());
                            elem.setCodPs(((TariffaBMP)objs[i]).getCodPs());
                            elem.setCodTipoCaus(((TariffaBMP)objs[i]).getCodTipoCaus());  
                            elem.setCodTipoOpz(((TariffaBMP)objs[i]).getCodTipoOpz());
                            TarIns.add(elem);
                        }
                      if (codContr.equalsIgnoreCase("0")) {
                         //Standard
                         if( i_code_cluster == null || i_code_cluster.equals("") ) {
                            home4.addTariffaRibDaUnico(contrDest, codUt, TarIns);
                         } else {
                             home4.addTariffaRibDaUnicoCluster(i_code_contr, codUt, i_code_cluster,i_tipo_cluster,i_code_tipo_contr, TarIns);
                         }
                      } else {
                        //Gestore -> Cluster
                        if ( i_code_cluster != null && (i_code_cluster_listino == null || i_code_cluster_listino.equals(""))) {
                            home4.addTariffaRibDaPersClus(codContr, i_code_contr, codUt, i_code_cluster,i_tipo_cluster,i_code_tipo_contr, TarIns);  
                        
                        //Cluster -> Cluster
                        } else if ( i_code_cluster != null && (i_code_cluster_listino != null && !i_code_cluster_listino.equals(""))) {
                            if ( contrDest!=null && !contrDest.equals("-1")) {
                                home4.addTariffaRibDaPersClusClus(i_code_contr_listino, contrDest, codUt, i_code_cluster_listino,i_code_cluster,i_tipo_cluster_listino,i_tipo_cluster,i_code_tipo_contr, TarIns);   
                            } else {
                                home4.addTariffaRibDaPersClusClus(i_code_contr_listino, i_code_contr, codUt, i_code_cluster_listino,i_code_cluster,i_tipo_cluster_listino,i_tipo_cluster,i_code_tipo_contr, TarIns);  
                            }
                        //Cluster -> Contr
                        } else if ( i_code_cluster_listino != null && (i_code_cluster == null || i_code_cluster.equals("") || i_code_cluster.equals("-1"))
                                    && contrDest != null  && ! "".equals(i_code_cluster_listino)) {
                            home4.addTariffaRibDaPersClusContr(i_code_contr_listino, contrDest, codUt, i_code_cluster_listino,i_tipo_cluster_listino,i_code_tipo_contr_listino, TarIns);  
                        //GESTORE -> GESTORE
                        } else {
                          home4.addTariffaRibDaPers(codContr, contrDest, codUt, TarIns);              
                        }
                      }
                  return true;        
                 }
                 else
                 {
                  return false; 
                 }
            }      
            else
            {
             return false;             
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
				throw new CustomEJBException(e.toString(),"Errore in TariffaBMPHome.create", "doInsert","ListinoCntl",StaticContext.FindExceptionType(e));
          }
  }

}