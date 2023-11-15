<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"InsAssOfPsWfSp.jsp")%>
</logtag:logData>
<%
// act
String act = request.getParameter("act");
String msg="";

String strquerystring = request.getQueryString();
String strCaricaModal = request.getParameter("canone");

String flg_ClassFatt="false";
String flg_ModAppl="false";

Vector classFatt_vect=null;
Vector desc_vect=null;
CanoneElem canone_elem=null;
Vector freq_vect=null;
Vector modappl_vect=null;

  String cod_cluster=request.getParameter("cod_cluster");
  String tipo_cluster=request.getParameter("tipo_cluster");
  String tipo_funz=request.getParameter("tipo_funz");

// conferma
if ((act!=null)&&(act.equalsIgnoreCase("conferma")))
  {
  String data_ini=request.getParameter("data_ini");
  String data_fine=request.getParameter("data_fine");

  SimpleDateFormat datafmt = new SimpleDateFormat ("dd'/'MM'/'yyyy");
  Date data_ini_d = datafmt.parse(data_ini);

  if ((data_fine!=null)&&(!data_fine.equals("")))
    {
    Date data_fine_d = datafmt.parse(data_fine);
    if (!data_fine_d.after(data_ini_d))
      msg="La data fine deve essere strettamente maggiore della data inizio validità";
    }

  // Leggo i parametri  
  String cod_tipo_contr=request.getParameter("cod_tipo_contr");

  String cod_ps=request.getParameter("cod_ps");
  String cod_cof=request.getParameter("cod_cof");
  String cod_of=request.getParameter("cod_of");
  String flag_sys=request.getParameter("flag_sys");
  

  // data_ini> date_ini (contratto, p/s e of)
  if ((msg==null)||(msg.equals("")))
    {
    %>

<%//da cancellare!!!!//////////%>
    <EJB:useHome id="homeContrSTL" type="com.ejbSTL.ContrattoSTLHome" location="ContrattoSTL" />
<%/////////////////////////////%>

    <EJB:useHome id="homeProdServSTL" type="com.ejbSTL.ProdServSTLHome" location="ProdServSTL" />
    <EJB:useHome id="homeInsAssOfPsBMP" type="com.ejbBMP.InsAssOfPsBMPHome" location="InsAssOfPsBMP" />
    <%
//    ContrattoSTL remoteContrSTL=homeContrSTL.create();
//    String data_ini_contr=remoteContrSTL.getDataIni(cod_contr,flag_sys);
    
    ProdServSTL remoteProdServSTL=homeProdServSTL.create();
    ProdServElem elem=remoteProdServSTL.getDataIni(cod_ps);
    
    // Estrazione data da rivedere....
    InsAssOfPsBMP remoteInsAssOfPsBMP = homeInsAssOfPsBMP.findAssOfPsMaxDataIniOf(cod_of);
    String data_ini_of = remoteInsAssOfPsBMP.getDataIniOf();
    
    Date data_max=datafmt.parse("01/01/1900");
/*
    if ((data_ini_contr!=null)&&(!data_ini_contr.equals("")))
      data_max=datafmt.parse(data_ini_contr);
*/
    if ((elem.getDataIni()!=null)&&(!elem.getDataIni().equals("")))
      {
      Date data_ini_ps=datafmt.parse(elem.getDataIni());
      if (data_ini_ps.after(data_max)) data_max=data_ini_ps;
      }

    if ((data_ini_of!=null)&&(!data_ini_of.equals("")))
      {
      Date data_ini_of_s=datafmt.parse(data_ini_of);
      if (data_ini_of_s.after(data_max)) data_max=data_ini_of_s;
      }

    if (!data_ini_d.after(data_max))
      msg="La data inizio validita' deve essere maggiore della massima data inizio P/S e Oggetto di Fatturazione";
    }

  // data_fine <=  data fine of
  if ((msg==null)||(msg.equals("")))
    {
    if ((data_fine!=null)&&(!data_fine.equals("")))
      {
      Date data_fine_d = datafmt.parse(data_fine);
      %>
      <EJB:useHome id="homeInsAssOfPsBMP2" type="com.ejbBMP.InsAssOfPsBMPHome" location="InsAssOfPsBMP" />
      <%
      // Estrazione data da rivedere....
      InsAssOfPsBMP remoteInsAssOfPsBMP = homeInsAssOfPsBMP2.findDataFineValOf(cod_of);
      String data_fine_of = remoteInsAssOfPsBMP.getDataFine();

      if ((data_fine_of!=null)&&(!data_fine_of.equals("")))
        {
        Date data_fine_of_d=datafmt.parse(data_fine_of);
        if (data_fine_d.after(data_fine_of_d))
          msg="La data fine validita' deve essere minore o uguale alla data fine dell'oggetto di fatturazione";
        }
      }
    }  

  %>
  <EJB:useHome id="homeOfPsSTL" type="com.ejbSTL.AssOfPsSTLHome" location="AssOfPsSTL" />
  <%
  // controllo esistenza
  if ((msg==null)||(msg.equals("")))
    {
    AssOfPsSTL remoteOfPsSTL=homeOfPsSTL.create();
    int ret=0;
    
    if ( "999".equals(tipo_funz)|| "998".equals(tipo_funz)) {
        ret = remoteOfPsSTL.check_esiste_clus(cod_tipo_contr,cod_of,cod_ps,cod_cluster,tipo_cluster);
    } else {
        ret = remoteOfPsSTL.check_esiste(cod_tipo_contr,cod_of,cod_ps);
    }
    
    if (ret>0) //se esista un’associazione identica (funzione ASSOC_OFPS_VERIF_ESIST)
      {
//     //System.out.println(">>> Trovato !!!");
      // Continuo con i controlli
      int aperte = 0;
      String data_ini_min = null;
      if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
        aperte = remoteOfPsSTL.check_aperte_clus(cod_tipo_contr,cod_of,cod_ps,cod_cluster,tipo_cluster);
        data_ini_min=remoteOfPsSTL.getMinDataIniClus(cod_tipo_contr,cod_of,cod_ps,cod_cluster,tipo_cluster);
      } else {
        aperte = remoteOfPsSTL.check_aperte(cod_tipo_contr,cod_of,cod_ps);
        data_ini_min=remoteOfPsSTL.getMinDataIni(cod_tipo_contr,cod_of,cod_ps);
      }
 
      if (aperte>0)
        {// aperte
//       //System.out.println(">>> aperte");
        if ((data_fine==null)||(data_fine.equals("")))
          msg="Impostare la data fine validità";
        else
          {
          Date data_fine_d=datafmt.parse(data_fine);
          if ((data_ini_min!=null)&&(!data_ini_min.equals("")))
            {
            Date data_ini_min_d=datafmt.parse(data_ini_min);
            if (!data_fine_d.before(data_ini_min_d))
              msg="La data fine deve essere minore della minore data inizio delle associazioni esistenti.";
            }
          }
        }
      else
        {// no aperte
//       //System.out.println(">>> no aperte");
        String data_fine_max=null;
        if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
            data_fine_max=remoteOfPsSTL.getMaxDataFineClus(cod_tipo_contr,cod_of,cod_ps,cod_cluster,tipo_cluster);
        } else {
            data_fine_max=remoteOfPsSTL.getMaxDataFine(cod_tipo_contr,cod_of,cod_ps);
        }
        Date data_ini_d2=datafmt.parse(data_ini);
        if ((data_fine==null)||(data_fine.equals("")))
          { // data fine non impostata
            // controllo che la data_ini sia maggiore della max data fine
          if ((data_fine_max!=null)&&(!data_fine_max.equals("")))
            {
            Date data_fine_max_d=datafmt.parse(data_fine_max);
            if (!data_ini_d2.after(data_fine_max_d))
              msg="La data inizio validità deve essere maggiore della massima data fine validità delle associazioni esistenti";
            } 
          }
        else
          { // data-fine impostata
            // data_ini < max date_fine or data_fine < min date_ini
            Date data_fine_d=datafmt.parse(data_fine);
            Date data_fine_max_d=datafmt.parse(data_fine_max);
            Date data_ini_min_d=datafmt.parse(data_ini_min);
           if (!data_fine_d.before(data_ini_min_d))
               msg="Data fine deve essere minore della minore data inizio delle associazioni esistenti";
          }
        }

      }
    }

  
  }

// selezione classe oggetto di fatturazione
if ((act!=null)&&(act.equalsIgnoreCase("classe")))
  {
  String cod_tipo_contr=request.getParameter("cod_tipo_contr");
  String cod_cof=request.getParameter("cod_cof");
  
%>
  <EJB:useHome id="homeOggettoFattLst" type="com.ejbSTL.OggettoFattLstOfAssocbSTLHome" location="OggettoFattLstOfAssocbSTL" />
<%
  OggettoFattLstOfAssocbSTL remoteOggettoFattLst= homeOggettoFattLst.create();
  desc_vect=remoteOggettoFattLst.getDesc(cod_tipo_contr,cod_cof);
  }


// selezione descrizione classe oggetto di fatturazione
if ((act!=null)&&
      ((act.equalsIgnoreCase("descr"))||(act.equalsIgnoreCase("classe")))
      )
  {
  String cod_tipo_contr=request.getParameter("cod_tipo_contr");
  String cod_cof=request.getParameter("cod_cof");
  String cod_ps=request.getParameter("cod_ps");

  %>
  <EJB:useHome id="homeAssOfPsContr" type="com.ejbSTL.AssOfPsSTLHome" location="AssOfPsSTL" />
  <%
  AssOfPsSTL remote=homeAssOfPsContr.create();
    System.out.println("cod_tipo_contr: "+cod_tipo_contr);
    System.out.println("cod_cof: "+cod_cof);
    System.out.println("cod_ps: "+cod_ps);

  if ( "999".equals(tipo_funz) || "998".equals(tipo_funz)) {
    canone_elem=remote.check_canone_exist_cluster(cod_tipo_contr,cod_cof,cod_ps,cod_cluster,tipo_cluster);
  } else {
    canone_elem=remote.check_canone_exist(cod_tipo_contr,cod_cof,cod_ps);
  }
  flg_ModAppl=(String)session.getAttribute("flg_ModAppl");

  if (flg_ModAppl.equals("false"))
      {
          %>
          <EJB:useHome id="homeFrequenza" type="com.ejbSTL.FrequenzaSTLHome" location="FrequenzaSTL" />
          <%
          FrequenzaSTL remoteFreq=homeFrequenza.create();
          freq_vect=remoteFreq.getLista();
          %>
          <EJB:useHome id="homeModAppl" type="com.ejbSTL.ModApplSTLHome" location="ModApplSTL" />
          <%
          ModApplSTL remoteModAppl=homeModAppl.create();
          modappl_vect=remoteModAppl.getLista();
          //30102002session.setAttribute("flg_ModAppl","true");
          session.setAttribute("flg_ModAppl","false");
      }
  }
//nicola


// selezione combo contratto
if ((act!=null)&&(act.equalsIgnoreCase("caricaCombo")))
  {
  String cod_tipo_contr=request.getParameter("cod_tipo_contr");
  String flag_sys=request.getParameter("flag_sys");

  flg_ClassFatt=(String)session.getAttribute("flg_ClassFatt");
  if (flg_ClassFatt.equals("false"))
    {
    // caricamento classi di fatturazione
    //
    %>
    <EJB:useHome id="homeClasseFatt" type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
    <%
    ClasseFattSTL remoteClasseFatt= homeClasseFatt.create();
    classFatt_vect=remoteClasseFatt.getCfs();

    session.setAttribute("flg_ClassFatt","true");
    }



  }
%>

<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
	<TITLE>ELABORAZIONE IN CORSO...</TITLE>
	<script src="../../common/js/calendar.js" type="text/javascript"></script>
  <script src="../../common/js/comboCange.js" type="text/javascript"></script>
  <script src="../../common/js/changeStatus.js" type="text/javascript"></script>
  <script src="../../common/js/openDialog.js" type="text/javascript"></script>
  <script src="../../common/js/validateFunction.js" type="text/javascript"></script>
  <script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>
function SubmitMe()
{

<%
// conferma
if ((act!=null)&&(act.equalsIgnoreCase("conferma")))
  {
%>
  if (opener && !opener.closed)
    {
     <% if (!msg.equals("")) 
          {%>
          opener.set_message("<%=msg%>");  
     <%    }%>      
    
    opener.dialogWin.returnFunc();
    }
 	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%
  }
%>




<%
// selezione descr classe di fatturazione
if ((act!=null)&&(act.equalsIgnoreCase("classe")))
  {
%>
  if (opener && !opener.closed)
    {
    // caricamento combo frequenza
    <%  
    if (flg_ClassFatt.equals("false"))
      {
        if ((freq_vect!=null)&&(freq_vect.size()!=0))
          {
          %>
          opener.clear_all_combo("freqCombo");
          opener.add_combo_elem("freqCombo","-1","[Seleziona Opzione]");
          <%
          for(Enumeration e = freq_vect.elements();e.hasMoreElements();)
                  {
                    ClassFreqElem elem=(ClassFreqElem)e.nextElement();
                    %>
                    opener.add_combo_elem("freqCombo","<%=elem.getCodeFreq()%>","<%=elem.getDescFreq()%>");
                    <%
                  }
          }

       if ((modappl_vect!=null)&&(modappl_vect.size()!=0) && ( strCaricaModal !=null) && (strCaricaModal.equals("S")) )
          {
          %>
          opener.clear_all_combo("modApplProrCombo");
          <%
          for(Enumeration e = modappl_vect.elements();e.hasMoreElements();)
                  {
                    ClassModApplRateiElem elem=(ClassModApplRateiElem)e.nextElement();
                    %>
                    opener.add_combo_elem("modApplProrCombo","<%=elem.getCodeModAppl()%>","<%=elem.getDescModAppl()%>");
                    <%
                  }%>
                  
          opener.add_combo_elem("modApplProrCombo","-1","[Seleziona Opzione]");
          <%}%>
       
        opener.clear_all_combo("modApplCombo");
        opener.add_combo_elem("modApplCombo","A","ANTICIPATO");
        opener.add_combo_elem("modApplCombo","P","POSTICIPATO");
        opener.add_combo_elem("modApplCombo","-1","[Seleziona Opzione]");
        opener.Disable(opener.objForm.shift);
       <%
       }


    if ((request.getParameter("canone")!=null)&&(request.getParameter("canone").equals("N")))
      {
      %>
      opener.imposta_altro();
      <%
      }
    else
        // Controllo se l'associazione è già presente
        if (canone_elem!=null)
          {
          // associazione presente
          %>
          opener.imposta_modalita_appl("true","<%=canone_elem.getCodeFreq()%>","<%=canone_elem.getCodeModal()%>","<%=canone_elem.getTipoFlgAP()%>","<%=canone_elem.getQntaShiftCanoni()%>");
          <%
          }
        else
          {
          // associazione non presente
          %>
          opener.imposta_modalita_appl("false","","","","");
          <%
          }
          %> 
    opener.dialogWin.returnFunc();
    }
  else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
    }     
<%
  }
%>

<%
// selezione combo classe oggetto di fatturazione
if ((act!=null)&&(act.equalsIgnoreCase("classe")))
  {
%>
  if (opener && !opener.closed)
    {
    opener.clear_all_combo("descFattCombo");
    <%
     if (flg_ClassFatt.equals("false"))
        if ((desc_vect!=null)&&(desc_vect.size()!=0))
          {
          if ( 1 == desc_vect.size()) {
            Enumeration e = desc_vect.elements();
            OggettoFattListaPsElem elem=(OggettoFattListaPsElem)e.nextElement();
            %>
               opener.add_combo_elem("descFattCombo","<%=elem.getCodeCOf()%>","<%=elem.getDescCOf()%>");
              closeWindow();
            <%
           }
          else { %>
                  opener.add_combo_elem("descFattCombo","-1","[Seleziona Opzione]"); <%
                  for(Enumeration e = desc_vect.elements();e.hasMoreElements();) {
                            OggettoFattListaPsElem elem=(OggettoFattListaPsElem)e.nextElement();
                            %>
                            opener.add_combo_elem("descFattCombo","<%=elem.getCodeCOf()%>","<%=elem.getDescCOf()%>");
                            <%
                  }
                }
                  %>
                  opener.Enable(opener.objForm.descFattCombo);
                  <%
          }
          else
          %>
            opener.Disable(opener.objForm.descFattCombo);
          <%
    %> 
    opener.dialogWin.returnFunc();
    }
  else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}

<%  
  }

// selezione combo contratto
if ((act!=null)&&(act.equalsIgnoreCase("caricaCombo")))
  {
%>
  if (opener && !opener.closed) 
	{
		opener.dialogWin.state="0";
    <% if (!msg.equals("")) 
          {%>
          opener.set_message("<%=msg%>");  
    <%    }%>      

    <%
     if (flg_ClassFatt.equals("false"))
        if ((classFatt_vect!=null)&&(classFatt_vect.size()!=0))
          {
          %>
          opener.clear_all_combo("oggFattCombo");
          opener.add_combo_elem("oggFattCombo","-1","[Seleziona Opzione]");
          <%
          for(Enumeration e = classFatt_vect.elements();e.hasMoreElements();)
              {      
              ClasseFattElem elem=(ClasseFattElem)e.nextElement();          
              %>
              opener.add_combo_elem("oggFattCombo","<%=elem.getCodeClasseOf()%>","<%=elem.getDescClasseOf()%>");         
              <%
              }
          }
    %>

    opener.dialogWin.returnFunc();
	}
	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%
  }
%>
// chiusura window
//  self.close();
  closeWindow();
}
</SCRIPT>
</HEAD>
<BODY  onload="window.setTimeout(SubmitMe, 2000);setInterval('recursiveCloseWindow()',1000);">

<center>
<form name="frmDati" method="post">
	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>

</BODY>
</HTML>

 
