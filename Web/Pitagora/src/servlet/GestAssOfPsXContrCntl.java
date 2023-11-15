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

public class GestAssOfPsXContrCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private AssOfPsXContrBMPHome homeGestAss   = null;
  private AssOfPsXContrBMP     remoteGestAss = null;
  private AssOfPsXContrBMPPK pk = new AssOfPsXContrBMPPK();

  private AssOfPsXContrBMPClusHome homeGestAssClus   = null;
  private AssOfPsXContrBMPClus     remoteGestClus = null;
  private AssOfPsXContrBMPClusPK   pkClus = new AssOfPsXContrBMPClusPK();
  
  private InsAssOfPsBMPHome homeInsAss=null;

  private String cod_contratto=null;
  private String des_contratto=null;
  private String disattivi=null;

  String cod_tipo_contr="";
  String des_tipo_contr="";
//  String codeContr="";
  String codOf="";
  String dataIni="";
  String dataIniOf="";
  String dataIniOfPs="";
  String codPs="";
  String codCOf="";
  String codModal="";
  String codeFreq="";
  String flag="";
  String shift="";
  String dataFineOf="";
  String dataFineOfPs="";

  public void init(ServletConfig config) throws ServletException
  {

    super.init(config);

    Context context=null;
    try
		{
    	context = new InitialContext();    
      
      Object homeObjectGestAss = context.lookup("AssOfPsXContrBMP");
      homeGestAss = (AssOfPsXContrBMPHome)PortableRemoteObject.narrow(homeObjectGestAss, AssOfPsXContrBMPHome.class);

        Object homeObjectGestAssClus = context.lookup("AssOfPsXContrBMPClus");
        homeGestAssClus = (AssOfPsXContrBMPClusHome)PortableRemoteObject.narrow(homeObjectGestAssClus, AssOfPsXContrBMPClusHome.class);

      Object homeObjectInsAss = context.lookup("InsAssOfPsBMP");
      homeInsAss = (InsAssOfPsBMPHome)PortableRemoteObject.narrow(homeObjectInsAss, InsAssOfPsBMPHome.class);

    
		}
    catch(NamingException e)
    {
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }


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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsXContrCntl","","",StaticContext.APP_SERVER_DRIVER));
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
      if(action.equalsIgnoreCase("nuovo2"))
        action="nuovo";
      cod_contratto=request.getParameter("cod_contratto");
      des_contratto=request.getParameter("des_contratto");
      disattivi=request.getParameter("disattivi");

//System.out.println("cod_contratto="+cod_contratto);
//System.out.println("des_contratto="+des_contratto);

   cod_tipo_contr=request.getParameter("cod_tipo_contr");
   des_tipo_contr=request.getParameter("des_tipo_contr");

//System.out.println("cod_tipo_contr="+cod_tipo_contr);
//System.out.println("des_tipo_contr="+des_tipo_contr);
 
     // codeContr=request.getParameter("codeContr");
//System.out.println("codeContr="+codeContr);
      codOf=request.getParameter("codOf");
      dataIni=request.getParameter("dataIni");
      dataIniOf=request.getParameter("dataIniOf");
      dataIniOfPs=request.getParameter("dataIniOfPs");
      codPs=request.getParameter("codPs");
      codCOf=request.getParameter("codCOf");
      codModal=request.getParameter("codModal");
      codeFreq=request.getParameter("codFreq");
      flag=request.getParameter("flag");
      shift=request.getParameter("shift");
      dataFineOf=request.getParameter("dataFineOf");
      dataFineOfPs=request.getParameter("dataFineOfPs");
          String codPS2=request.getParameter("cod_PS");
            String desPs=request.getParameter("des_PS");
            String contratto= request.getParameter("cmb_contratto");
//System.out.println(" flag="+flag);

     
      if (action.equalsIgnoreCase("nuovo"))
        doInsert(request,response);

      if (action.equalsIgnoreCase("cancella"))
        doCancella(request,response);
 
      if (action.equalsIgnoreCase("disattiva"))
        doDisattiva(request,response);

        //PASQUALE
          String cod_cluster=request.getParameter("cod_cluster");
          String tipo_cluster=request.getParameter("tipo_cluster");
          String tipo_funz=request.getParameter("tipo_funz");
          



      if (action.equalsIgnoreCase("nuovo"))
      {
      if ((cod_tipo_contr==null)||(cod_tipo_contr.equals("")))
        cod_tipo_contr=request.getParameter("cod_tipo_contr");

      if ((des_contratto==null)||(des_contratto.equals("")))
        des_contratto=request.getParameter("des_tipo_contr");

      String flag_sys=request.getParameter("flag_sys");


      if(action.equalsIgnoreCase("nuovo"))
      {
      request.setAttribute("cod_PS",codPS2);
      request.setAttribute("des_PS",desPs);
      
  response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/InsAssOfPsXContrSp.jsp?"
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&flag_sys="+flag_sys
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_contratto,com.utl.StaticContext.ENCCharset)
                  +"&act=NUOVO2"
                  +"&cod_PS="+codPS2
                  +"&des_PS="+desPs
                  +"&cod_contr="+contratto
                  +"&cod_cluster="+cod_cluster
                  +"&tipo_cluster="+tipo_cluster
                  +"&tipo_funz="+tipo_funz
                  +"&intFunzionalita="+tipo_funz);
               
      }
      //String flag_sys=request.getParameter("flag_sys");
      else
      {
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/InsAssOfPsXContrSp.jsp?"
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&flag_sys="+flag_sys
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_contratto,com.utl.StaticContext.ENCCharset)
                  +"&act=NUOVO"
                  +"&cod_cluster="+cod_cluster
                  +"&tipo_cluster="+tipo_cluster
                  +"&tipo_funz="+tipo_funz
                  +"&intFunzionalita="+tipo_funz
                 );
      }
      
     
      }
      else
      {
        //request.getSession().setAttribute("cod_tipo_contr",codeContr);
        request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
        //request.getSession().setAttribute("des_tipo_contr",des_contratto);
        request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);

      response.sendRedirect(request.getContextPath()+"/associazioni_of_ps_x_contr/jsp/ListaAssOfPsXContrSp.jsp?"
                  +"&flag_sys="+flag
                  +"&disattivi="+disattivi
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&cod_contratto="+cod_contratto
                  +"&code_contr="+cod_contratto
                  +"&contrSelez="+cod_contratto
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codeFreq+"&flag="+flag+"&shift="+shift
                  +"&dataIni="+dataIni+"&dataIniOf="+dataIniOf+"&dataIniOfPs="+dataIniOfPs+"&dataFineOf="+dataFineOf
          +"&cod_cluster="+cod_cluster
          +"&tipo_cluster="+tipo_cluster
          +"&tipo_funz="+tipo_funz
          +"&intFunzionalita="+tipo_funz);

       }
       out.close();
       return; 
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
            throw new CustomEJBException(e.toString(),"Errore durante processing","processing","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }
  }


  private void doInsert(HttpServletRequest request, HttpServletResponse response)
                            throws  CustomEJBException
  {
  try
    {
//   //System.out.println(">>> doInsert");
    String cod_tipo_contr=request.getParameter("cod_tipo_contr");
//   //System.out.println(">>> cod_tipo_contr="+cod_tipo_contr);
    String cod_contr=request.getParameter("cmb_contratto");
//   //System.out.println(">>> cod_contr="+cod_contr);
    String cod_ps=request.getParameter("cod_PS");
//   //System.out.println(">>> cod_ps="+cod_ps);
    String cod_cof=request.getParameter("oggFattCombo");
//   //System.out.println(">>> cod_cof="+cod_cof);
    String cod_of=request.getParameter("descFattCombo");
//   //System.out.println(">>> cod_of="+cod_of);
    
    String cod_freq=request.getParameter("freqCombo");
//   //System.out.println(">>> cod_freq="+cod_freq);
    String cod_mod=request.getParameter("modApplProrCombo");
    if ((cod_mod==null)||(cod_mod.equals(""))||(cod_mod.equals("-1")))
      cod_mod="";
//   //System.out.println(">>> cod_mod="+cod_mod);
    String flag_AP=request.getParameter("modApplCombo");
    if ((flag_AP==null)||(flag_AP.equals(""))||(flag_AP.equals("-1")))
        flag_AP="X";
//   //System.out.println(">>> flag_AP="+flag_AP);
    
    String shift_s = request.getParameter("shift");
    int shift=0;
    if ((shift_s!=null)&&(!shift_s.equals("")))
      {
       Integer shiftInteger=new Integer (shift_s);
       shift=shiftInteger.intValue();
      }
//   //System.out.println(">>> shift="+shift);
    
    String data_ini=request.getParameter("data_ini");
//   //System.out.println(">>> data_ini="+data_ini);
    
    String data_fine=request.getParameter("data_fine");
//   //System.out.println(">>> data_fine="+data_fine);
    
    String cod_utente=request.getParameter("cod_utente");
//   //System.out.println(">>> cod_utente="+cod_utente);

    InsAssOfPsBMP remoteAssOfPsBMP=homeInsAss.findDataInizioOf(cod_of);
    String data_ini_of = remoteAssOfPsBMP.getDataIni();
//   //System.out.println(">>> data_ini_of="+data_ini_of);


 String cod_cluster=request.getParameter("cod_cluster");
 String tipo_cluster=request.getParameter("tipo_cluster");
 String tipo_funz=request.getParameter("tipo_funz");

    if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
        AssOfPsXContrBMPClus remoteGestAssClu= homeGestAssClus.create(cod_contr,data_ini,cod_of,cod_ps,data_ini_of,cod_mod,cod_freq,cod_utente,shift,flag_AP,data_fine,cod_cluster,tipo_cluster, cod_tipo_contr);
    } else {
        AssOfPsXContrBMP remoteGestAss= homeGestAss.create(cod_contr,data_ini,cod_of,cod_ps,data_ini_of,cod_mod,cod_freq,cod_utente,shift,flag_AP,data_fine);
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
              throw new CustomEJBException(e.toString(),"Errore ","doCancella","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }

  }

  private void doCancella(HttpServletRequest request, HttpServletResponse response)
                          //  throws ServletException
                            throws  CustomEJBException
  {

      String cod_cluster=request.getParameter("cod_cluster");
      String tipo_cluster=request.getParameter("tipo_cluster");
      String tipo_funz=request.getParameter("tipo_funz");

    if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
        pkClus.setCodeTipoContr(cod_tipo_contr);
        //pkClus.setCodeContr(codeContr);
        pkClus.setCodeContr(cod_contratto);
        pkClus.setCodeOf(codOf);
        pkClus.setDataIni(dataIni);
        pkClus.setDataIniOf(dataIniOf);
        pkClus.setDataIniOfPs(dataIniOfPs);
        pkClus.setCodePs(codPs);
        pkClus.setCodeCOf(codCOf);
        pkClus.setCodeFreq(codeFreq);
        pkClus.setFlagSys(flag);
        //   pk.setShift(shift);
        pkClus.setDataFineOf(dataFineOf);
        pkClus.setDataFineOfPs(dataFineOfPs);
        
        pkClus.setCodeCluster(cod_cluster);
        pkClus.setTipoCluster(tipo_cluster);
        
    } else {  
        pk.setCodeTipoContr(cod_tipo_contr);
        //pk.setCodeContr(codeContr);
        pk.setCodeContr(cod_contratto);
        pk.setCodeOf(codOf);
        pk.setDataIni(dataIni);
        pk.setDataIniOf(dataIniOf);
        pk.setDataIniOfPs(dataIniOfPs);
        pk.setCodePs(codPs);
        pk.setCodeCOf(codCOf);
        pk.setCodeFreq(codeFreq);
        pk.setFlagSys(flag);
    //   pk.setShift(shift);
        pk.setDataFineOf(dataFineOf);
        pk.setDataFineOfPs(dataFineOfPs);
    }

    try
    {
        if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            remoteGestClus = homeGestAssClus.findByPrimaryKey(pkClus);
            remoteGestClus.remove();
        } else {
            remoteGestAss= homeGestAss.findByPrimaryKey(pk);
            remoteGestAss.remove();
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
              throw new CustomEJBException(e.toString(),"Errore ","doCancella","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }
  }



  private void doDisattiva(HttpServletRequest request, HttpServletResponse response)
                          //  throws ServletException
                            throws  CustomEJBException
  {

  //PASQUALE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      String tipo_cluster=request.getParameter("tipo_cluster");
      String cod_cluster=request.getParameter("cod_cluster");
      String tipo_funz=request.getParameter("tipo_funz");
       String cod_tipo_contr=request.getParameter("cod_tipo_contr");
       
  //PASQUALE
      if ("999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            pkClus.setCodeTipoContr(cod_tipo_contr);
        //    pkClus.setCodeContr(codeContr);
            pkClus.setCodeContr(cod_contratto);
            pkClus.setCodeOf(codOf);
            pkClus.setDataIni(dataIni);
            pkClus.setDataIniOf(dataIniOf);
            pkClus.setDataIniOfPs(dataIniOfPs);
            pkClus.setCodePs(codPs);
            pkClus.setCodeCOf(codCOf);
            pkClus.setCodeFreq(codeFreq);
            pkClus.setFlagSys(flag);
            pkClus.setDataFineOfPs(dataFineOfPs);
        //  pkClus.setShift(shift);
        //  pkClus.setDataFineOf(dataFineOf);
        pkClus.setCodeCluster(cod_cluster);
        pkClus.setTipoCluster(tipo_cluster);
    
    } else {
    
        pk.setCodeTipoContr(cod_tipo_contr);
    //    pk.setCodeContr(codeContr);
        pk.setCodeContr(cod_contratto);
        pk.setCodeOf(codOf);
        pk.setDataIni(dataIni);
        pk.setDataIniOf(dataIniOf);
        pk.setDataIniOfPs(dataIniOfPs);
        pk.setCodePs(codPs);
        pk.setCodeCOf(codCOf);
        pk.setCodeFreq(codeFreq);
        pk.setFlagSys(flag);
        pk.setDataFineOfPs(dataFineOfPs);
    //  pk.setShift(shift);
    //  pk.setDataFineOf(dataFineOf);
    }

    try
    {
        if ("999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            remoteGestClus= homeGestAssClus.findByPrimaryKey(pkClus);
            remoteGestClus.disattiva(dataFineOfPs);        	
        } else {
            remoteGestAss= homeGestAss.findByPrimaryKey(pk);
            remoteGestAss.disattiva(dataFineOfPs);
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
              throw new CustomEJBException(e.toString(),"Errore ","doDisattiva","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }
  }

/*
  private void doInsert(HttpServletRequest request, HttpServletResponse response)
//  throws ServletException
  throws  CustomEJBException
  {
    try
    {

System.out.println("*********doInsert**************");
//  String cod_tipo_contr=request.getParameter("cod_tipo_contr");
  String codeContr=request.getParameter("codeContr");
  String dataIniOfPs=request.getParameter("data_ini");
  String codOf=request.getParameter("code_of");
  String codPs=request.getParameter("cod_PS");
  String dataIniOf=request.getParameter("dataIniOf");
  String codModal=request.getParameter("codModal");
  String codeFreq=request.getParameter("codFreq");
  String codUtente=request.getParameter("codiceUtente");
  String shift=request.getParameter("shift");
  String flag=request.getParameter("flagAP");
  String dataFineOfPs=request.getParameter("data_fine");
int qtaShiftCanoni = 0;
if (shift!=null)
{
    Integer shi= new Integer(shift);      
    qtaShiftCanoni=shi.intValue();
}

//AssOfPsXContrBMP remoteGestAss= homeGestAss.create(codeContr,dataIniOfPs,codOf,codPs,dataIniOf,codModal,codeFreq,codUtente,qtaShiftCanoni,flag,dataFineOfPs);
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
              throw new CustomEJBException(e.toString(),"Errore durante insert Special","doInsert","GestAssOfPsXContrCntl",StaticContext.FindExceptionType(e));
    }
  }

*/

}