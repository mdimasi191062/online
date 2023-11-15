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

public class GestAssOfPsCntl extends HttpServlet 
{
  private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
  private AssOfPsBMPHome homeAss   = null;
  private AssOfPsBMPClusHome homeAssClus   = null;
  private AssOfPsBMP     remoteAss = null;
  private GestAssOfPsBMPHome homeGestAss   = null;
  private GestAssOfPsBMP     remoteGestAss = null;
  private GestAssOfPsBMPPK pk = new GestAssOfPsBMPPK();
  private GestAssOfPsBMPClusHome homeGestClus   = null;
  private GestAssOfPsBMPClus     remoteGestClus = null;
  private GestAssOfPsBMPClusPK pkClus = new GestAssOfPsBMPClusPK(); 
  private InsAssOfPsBMPHome homeInsAss=null;
  private String disattivi=null;
  String codOf="";
  String codCOf="";
  String flag="";
  String codPs="";
  String codModal="";
  String codeFreq="";
  String shift="";
  String dataIni="";
  String dataIniOf="";
  String dataIniOfPs="";
  String dataFineOf="";

  public void init(ServletConfig config) throws ServletException
  {

//System.out.println("sono in GestAssOfPsCntl");
    super.init(config);

    Context context=null;
    try
		{
    	context = new InitialContext();     

      Object homeObjectAss = context.lookup("AssOfPsBMP");
      homeAss = (AssOfPsBMPHome)PortableRemoteObject.narrow(homeObjectAss, AssOfPsBMPHome.class);

      Object homeObjectAssClus = context.lookup("AssOfPsBMPClus");
      homeAssClus = (AssOfPsBMPClusHome)PortableRemoteObject.narrow(homeObjectAssClus, AssOfPsBMPClusHome.class);


      Object homeObjectGestAss = context.lookup("GestAssOfPsBMP");
      homeGestAss = (GestAssOfPsBMPHome)PortableRemoteObject.narrow(homeObjectGestAss, GestAssOfPsBMPHome.class);

      Object homeObjectGestClus = context.lookup("GestAssOfPsBMPClus");
      homeGestClus = (GestAssOfPsBMPClusHome)PortableRemoteObject.narrow(homeObjectGestClus, GestAssOfPsBMPClusHome.class);

      Object homeObjectInsAss = context.lookup("InsAssOfPsBMP");
      homeInsAss = (InsAssOfPsBMPHome)PortableRemoteObject.narrow(homeObjectInsAss, InsAssOfPsBMPHome.class);
		}
    catch(NamingException e)
    {
       StaticMessages.setCustomString(e.toString());
       StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsCntl","","",StaticContext.APP_SERVER_DRIVER));
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
        //AAAAAAAAAAAAAAAAAAAAAAAAAAA     
                 String cod_cluster=request.getParameter("cod_cluster");
                 String tipo_cluster=request.getParameter("tipo_cluster");
                 String tipo_funz=request.getParameter("tipo_funz");
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsCntl","","",StaticContext.APP_SERVER_DRIVER));
        ex.printStackTrace();
      }
    }
  }


  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
  {
   try
    {
        //AAAAAAAAAAAAAAAAAAAAAAAAAAA     
                 String cod_cluster=request.getParameter("cod_cluster");
                 String tipo_cluster=request.getParameter("tipo_cluster");
                 String tipo_funz=request.getParameter("tipo_funz");
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
        StaticContext.writeLog(StaticMessages.getMessage(5001,"GestAssOfPsCntl","","",StaticContext.APP_SERVER_DRIVER));
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
      String cod_tipo_contr=request.getParameter("cod_tipo_contr");
      String des_tipo_contr=request.getParameter("des_tipo_contr");
      String desPs=request.getParameter("des_PS");
      disattivi=request.getParameter("disattivi");
      String flag_sys=request.getParameter("flag_sys");
      codOf=request.getParameter("codOf");
      codCOf=request.getParameter("codCOf");
      codPs=request.getParameter("codPs");
      flag=request.getParameter("flag");
      codModal=request.getParameter("codModal");
      codeFreq=request.getParameter("codFreq");
      shift=request.getParameter("shift");
      dataIni=request.getParameter("dataIni");
      dataIniOf=request.getParameter("dataIniOf");
      dataIniOfPs=request.getParameter("dataIniOfPs");
      dataFineOf=request.getParameter("dataFineOf");
     // dataFineOfPs=request.getParameter("dataFineOfPs");
     String codPS2=request.getParameter("cod_PS");
      if (action.equalsIgnoreCase("cancella"))
        doCancella(request,response);
      else if (action.equalsIgnoreCase("disattiva"))
        doDisattiva(request,response);  
      else if (action.equalsIgnoreCase("nuovo"))
        doInsert(request,response);


        //PASQUALE
          String cod_cluster=request.getParameter("cod_cluster");
          String tipo_cluster=request.getParameter("tipo_cluster");
          String tipo_funz=request.getParameter("tipo_funz");
          
      if (action.equalsIgnoreCase("nuovo")) //insert
      {
      if ((cod_tipo_contr==null)||(cod_tipo_contr.equals("")))
           cod_tipo_contr=request.getParameter("cod_tipo_contr");
      if ((des_tipo_contr==null)||(des_tipo_contr.equals("")))
           des_tipo_contr=request.getParameter("des_tipo_contr");


      if(action.equalsIgnoreCase("nuovo"))
      {
      request.setAttribute("cod_PS",codPS2);
      request.setAttribute("des_PS",desPs);
         
   response.sendRedirect(   response.encodeURL(request.getContextPath()+"/associazioni_of_ps/jsp/InsAssOfPsSp.jsp?"
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&flag_sys="+flag_sys
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)
                  +"&act=NUOVO2"
                  +"&cod_PS="+codPS2
                  +"&des_PS="+desPs
                  +"&cod_cluster="+cod_cluster
                  +"&tipo_cluster="+tipo_cluster
                  +"&tipo_funz="+tipo_funz
                  +"&intFunzionalita="+tipo_funz));
               
      }
      //String flag_sys=request.getParameter("flag_sys");
      else
      {
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/InsAssOfPsSp.jsp?"
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&flag_sys="+flag_sys
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)
                  +"&act=NUOVO"
                  +"&cod_cluster="+cod_cluster
                  +"&tipo_cluster="+tipo_cluster
                  +"&tipo_funz="+tipo_funz
                  +"&intFunzionalita="+tipo_funz
                 );
      }
      }
      else //canc o disattiva
      {
        //response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/ListaAssOfPsSp.jsp");
        request.getSession().setAttribute("cod_tipo_contr",cod_tipo_contr);
        request.getSession().setAttribute("des_tipo_contr",des_tipo_contr);

/*System.out.println(request.getContextPath()+"/associazioni_of_ps/jsp/ListaAssOfPsSp.jsp?"
                  +"&flag_sys="+flag
                  +"&disattivi="+disattivi
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codeFreq+"&flag="+flag+"&shift="+shift
                  +"&dataIni="+dataIni+"&dataIniOf="+dataIniOf+"&dataIniOfPs="+dataIniOfPs+"&dataFineOf="+dataFineOf);*/

        
        response.sendRedirect(request.getContextPath()+"/associazioni_of_ps/jsp/ListaAssOfPsSp.jsp?"
                  +"&flag_sys="+flag
                  +"&disattivi="+disattivi
                  +"&des_tipo_contr="+java.net.URLEncoder.encode(des_tipo_contr,com.utl.StaticContext.ENCCharset)
                  +"&cod_tipo_contr="+cod_tipo_contr
                  +"&codOf="+codOf+"&codCOf="+codCOf
                  +"&codPs="+codPs+"&codModal="+codModal
                  +"&codFreq="+codeFreq+"&flag="+flag+"&shift="+shift
          +"&cod_cluster="+cod_cluster
          +"&tipo_cluster="+tipo_cluster
          +"&tipo_funz="+tipo_funz
          +"&intFunzionalita="+tipo_funz);
                  //+"&dataIni="+dataIni+"&dataIniOf="+dataIniOf+"&dataIniOfPs="+dataIniOfPs+"&dataFineOf="+dataFineOf);
      }
       //System.out.println("ESCO dalla SERVLET");
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
            throw new CustomEJBException(e.toString(),"Errore durante processing","processing","GestAssOfPsCntl",StaticContext.FindExceptionType(e));
    }
  }




  private void doCancella(HttpServletRequest request, HttpServletResponse response)
                          //  throws ServletException
                            throws  CustomEJBException
  {
//System.out.println("*********doCancella**************");
    String codOf=request.getParameter("codOf");
//System.out.println("codOf="+codOf);
    String dataIni=request.getParameter("dataIni");
//System.out.println("dataIni="+dataIni);
    String dataIniOfPs=request.getParameter("dataIniOfPs");
//System.out.println("dataIniOf="+dataIniOf);
    String codPs=request.getParameter("codPs");
//System.out.println("codPs="+codPs);
    String codCOf=request.getParameter("codCOf");
//System.out.println("codCOf="+codCOf);
    String codModal=request.getParameter("codModal");
//System.out.println("codModal="+codModal);
    String codFreq=request.getParameter("codFreq");
//System.out.println("codFreq="+codFreq);
    String flag=request.getParameter("flag");
//System.out.println("flag="+flag);
    String shift=request.getParameter("shift");
//System.out.println("shift="+shift);
    String dataFineOfPs=request.getParameter("dataFineOfPs");
    String dataFineOf=request.getParameter("dataFineOf");
//System.out.println("dataFineOf="+dataFineOf);

 //PASQUALE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
     String tipo_cluster=request.getParameter("tipo_cluster");
     String cod_cluster=request.getParameter("cod_cluster");
     String tipo_funz=request.getParameter("tipo_funz");
      String cod_tipo_contr=request.getParameter("cod_tipo_contr");
      
 //PASQUALE
     if ("999".equals(tipo_funz) || "998".equals(tipo_funz) ) {
     
      pkClus.setCodeOf(codOf);
      pkClus.setDataIni(dataIni);
      pkClus.setDataIniOfPs(dataIniOfPs);
      pkClus.setCodePs(codPs);
      pkClus.setCodeCOf(codCOf);
      pkClus.setCodModalAppl(codModal);
      pkClus.setCodFreq(codFreq);
      pkClus.setFlag(flag);
      pkClus.setShift(shift);
      pkClus.setDataFineOfPs(dataFineOfPs);
      pkClus.setTipoCluster(tipo_cluster);
      pkClus.setCodeCluster(cod_cluster);
      pkClus.setCodeTipoContr(cod_tipo_contr);
      
   } else {
        pk.setCodeOf(codOf);
        pk.setDataIni(dataIni);
        pk.setDataIniOfPs(dataIniOfPs);
        pk.setCodePs(codPs);
        pk.setCodeCOf(codCOf);
        pk.setCodModalAppl(codModal);
        pk.setCodFreq(codFreq);
        pk.setFlag(flag);
        pk.setShift(shift);
        pk.setDataFineOfPs(dataFineOfPs);
    }
    try
    {
        if ("999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            remoteGestClus= homeGestClus.findByPrimaryKey(pkClus);
            remoteGestClus.remove();
        } else {
            remoteGestAss= homeGestAss.findByPrimaryKey(pk);
            remoteGestAss.remove();
        }
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
              throw new CustomEJBException(e.toString(),"Errore ","doCancella","GestAssOfPsCntl",StaticContext.FindExceptionType(e));
    }
  }



  private void doDisattiva(HttpServletRequest request, HttpServletResponse response)
                          //  throws ServletException
                            throws  CustomEJBException
  {
  //System.out.println("*********doDisattiva**************");
    String codOf=request.getParameter("codOf");
 //System.out.println("codOf="+codOf);
    String dataIni=request.getParameter("dataIni");
 //System.out.println("dataIni="+dataIni);
    String dataIniOfPs=request.getParameter("dataIniOfPs");
 //System.out.println("dataIniOf="+dataIniOf);
    String codPs=request.getParameter("codPs");
 //System.out.println("codPs="+codPs);
    String codCOf=request.getParameter("codCOf");
 //System.out.println("codCOf="+codCOf);
    String codModal=request.getParameter("codModal");
 //System.out.println("codModal="+codModal);
    String codFreq=request.getParameter("codFreq");
 //System.out.println("codFreq="+codFreq);
    String flag=request.getParameter("flag");
 //System.out.println("flag="+flag);
    String shift=request.getParameter("shift");
 //System.out.println("shift="+shift);
    String dataFineOfPs=request.getParameter("dataFineOfPs");
    String dataFineOf=request.getParameter("dataFineOf");
 //System.out.println("dataFineOf="+dataFineOf);

  //PASQUALE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
      String tipo_cluster=request.getParameter("tipo_cluster");
      String cod_cluster=request.getParameter("cod_cluster");
      String tipo_funz=request.getParameter("tipo_funz");
       String cod_tipo_contr=request.getParameter("cod_tipo_contr");
       
  //PASQUALE
      if ("999".equals(tipo_funz) || "998".equals(tipo_funz)) {
      
       pkClus.setCodeOf(codOf);
       pkClus.setDataIni(dataIni);
       pkClus.setDataIniOfPs(dataIniOfPs);
       pkClus.setCodePs(codPs);
       pkClus.setCodeCOf(codCOf);
       pkClus.setCodModalAppl(codModal);
       pkClus.setCodFreq(codFreq);
       pkClus.setFlag(flag);
       pkClus.setShift(shift);
       //pkClus.setDataFineOfPs(dataFineOfPs);
       pkClus.setTipoCluster(tipo_cluster);
       pkClus.setCodeCluster(cod_cluster);
       pkClus.setCodeTipoContr(cod_tipo_contr);
       
    } else {
        pk.setCodeOf(codOf);
        pk.setDataIni(dataIni);
        pk.setDataIniOfPs(dataIniOfPs);
        pk.setCodePs(codPs);
        pk.setCodeCOf(codCOf);
        pk.setCodModalAppl(codModal);
        pk.setCodFreq(codFreq);
        pk.setFlag(flag);
        pk.setShift(shift);
//        pk.setDataFineOf(dataFineOf);
    }

    try
    {
        if ("999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            remoteGestClus= homeGestClus.findByPrimaryKey(pkClus);
            remoteGestClus.setDataFineOfPs(dataFineOfPs);;
        } else {

            remoteGestAss= homeGestAss.findByPrimaryKey(pk);
            remoteGestAss.setDataFineOfPs(dataFineOfPs);
        }
            
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
              throw new CustomEJBException(e.toString(),"Errore ","doDisattiva","GestAssOfPsCntl",StaticContext.FindExceptionType(e));
    }
  }


  private void doInsert(HttpServletRequest request, HttpServletResponse response)
                            throws  CustomEJBException
  {
  try
    {
    //System.out.println(">>> doInsert");
    String cod_tipo_contr=request.getParameter("cod_tipo_contr");
    //System.out.println(">>> cod_tipo_contr="+cod_tipo_contr);
//    String cod_contr=request.getParameter("cmb_contratto");
//    //System.out.println(">>> cod_contr="+cod_contr);
    String cod_ps=request.getParameter("cod_PS");
    //System.out.println(">>> cod_ps="+cod_ps);
    String cod_cof=request.getParameter("oggFattCombo");
    //System.out.println(">>> cod_cof="+cod_cof);
    String cod_of=request.getParameter("descFattCombo");
    //System.out.println(">>> cod_of="+cod_of);
    
    String cod_freq=request.getParameter("freqCombo");
    //System.out.println(">>> cod_freq="+cod_freq);
    String cod_mod=request.getParameter("modApplProrCombo");
    if ((cod_mod==null)||(cod_mod.equals(""))||(cod_mod.equals("-1")))
      cod_mod="";
    //System.out.println(">>> cod_mod="+cod_mod);
    String flag_AP=request.getParameter("modApplCombo");
    if ((flag_AP==null)||(flag_AP.equals(""))||(flag_AP.equals("-1")))
        flag_AP="X";
    //System.out.println(">>> flag_AP="+flag_AP);
    
    String shift_s = request.getParameter("shift");
    int shift=0;
    if ((shift_s!=null)&&(!shift_s.equals("")))
      {
       Integer shiftInteger=new Integer (shift_s);
       shift=shiftInteger.intValue();
      }
    //System.out.println(">>> shift="+shift);
    
    String data_ini=request.getParameter("data_ini");
    //System.out.println(">>> data_ini="+data_ini);
    
    String data_fine=request.getParameter("data_fine");
    //System.out.println(">>> data_fine="+data_fine);
    
    String cod_utente=request.getParameter("cod_utente");
    //System.out.println(">>> cod_utente="+cod_utente);

//PASQUALE AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    String tipo_cluster=request.getParameter("tipo_cluster");
    String cod_cluster=request.getParameter("cod_cluster");
    String tipo_funz=request.getParameter("tipo_funz");

    InsAssOfPsBMP remoteAssOfPsBMP=homeInsAss.findDataInizioOf(cod_of);
    String data_ini_of = remoteAssOfPsBMP.getDataIni();
    //System.out.println(">>> data_ini_of="+data_ini_of);

//PASQUALE
    AssOfPsBMP remoteAss;
    AssOfPsBMPClus remoteAssClus;
    if ("999".equals(tipo_funz) || "998".equals(tipo_funz) ) {
        remoteAssClus= homeAssClus.create(data_ini,cod_of,cod_ps,data_ini_of,cod_mod,cod_freq,cod_utente,shift,flag_AP,data_fine,tipo_cluster,cod_cluster,cod_tipo_contr);
    } else {
        remoteAss= homeAss.create(data_ini,cod_of,cod_ps,data_ini_of,cod_mod,cod_freq,cod_utente,shift,flag_AP,data_fine);
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
              throw new CustomEJBException(e.toString(),"Errore ","doInsert","GestAssOfPsCntl",StaticContext.FindExceptionType(e));
    }

  }


}