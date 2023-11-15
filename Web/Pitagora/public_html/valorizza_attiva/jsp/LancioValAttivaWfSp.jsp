<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"LancioValAttivaWfSp.jsp")%>
</logtag:logData>

<%
PeriodoRifBMP obj2 = null;
Collection datiCli=null;   
String        act  = request.getParameter("act");
String comboCicloFattSelez = request.getParameter("comboCicloFattSelez");
String cod_tipo_contr =request.getParameter("cod_tipo_contr");
String prov =request.getParameter("prov");
String resize=request.getParameter("resize");
String periodoFatturazione=null;
String dataFineCiclo=null;
String dataInizioCiclo=null;
String caricaDatiCli=null;
String caricaRiepilogo=null;    

// carica Periodo di Fatturazione
if ( act!=null&& act.equalsIgnoreCase("caricaTutto"))
  {%>
  <EJB:useHome id="homePeriodoRif" type="com.ejbBMP.PeriodoRifBMPHome" location="PeriodoRifBMP" />
  <%
  //System.out.println("WF "+comboCicloFattSelez+" "+cod_tipo_contr);
    obj2 = homePeriodoRif.findPerCicloFat(comboCicloFattSelez,cod_tipo_contr);
  }%>

<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
	<TITLE>ELABORAZIONE IN CORSO...</TITLE>
	<script src="../../common/js/calendar.js" type="text/javascript"></script>
  <script src="../../common/js/comboCange.js" type="text/javascript"></script>
  <script src="../../common/js/changeStatus.js" type="text/javascript"></script>
  <script src="../../common/js/validateFunction.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
  
<SCRIPT LANGUAGE='Javascript'>


<% if (resize==null)
{%>
  if ("<%=act%>"=="caricaTutto")
  {
     resize(400,150);
  }
<%}%>
  

function SubmitMe()
{
<%if (act!=null&& act.equalsIgnoreCase("caricaTutto"))
 {
    if (obj2.getDataFineCiclo()!=null)
    {
    %>
        if (opener && !opener.closed)
        {
          <%if (obj2.getDataIniCiclo()!=null) 
            {
             dataInizioCiclo=obj2.getDataIniCiclo();%>
             opener.document.lancioVAForm.dataIniCiclo.value="<%=dataInizioCiclo%>";
          <%}
            else
            {%>
             opener.document.lancioVAForm.dataIniCiclo.value="";
            <%}

          if (obj2.getDataFineCiclo()!=null)
            {
             dataFineCiclo=obj2.getDataFineCiclo();%>
             opener.document.lancioVAForm.dataFineCiclo.value="<%=dataFineCiclo%>";
          <%}
            else
            {%>
             opener.document.lancioVAForm.dataFineCiclo.value="";
            <%}

          if (obj2.getPeriodoFat()!=null)
          {
             periodoFatturazione=obj2.getPeriodoFat();
             caricaDatiCli="true";
             caricaRiepilogo="true";
//            //System.out.println("PERIODO "+periodoFatturazione);
             %>
             opener.document.lancioVAForm.ciclo.value="<%=periodoFatturazione%>";
        <%}
          else
            {%>
             opener.document.lancioVAForm.ciclo.value="";
          <%}%>
        }
        else
        { 
          alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
        }
    <%}
    else
    {
       //caricaDatiCli="false";
    %>
      //opener.dialogWin.returnFunc();
      //self.close();
   <%}
  }%>  

<% if(caricaDatiCli!= null && caricaDatiCli.equals("true"))
{%>
  if (opener && !opener.closed)
  {
    opener.clear_all_combo("comboAccount");
    opener.clear_all_combo("comboRiepilogoAccount");
    <EJB:useHome id="homecmbAcc" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />
    <EJB:useHome id="homeRiepAcc" type="com.ejbBMP.DatiCliBMPHome" location="DatiCliBMP" />
    <%
    datiCli = homecmbAcc.findAllAccXVa2(comboCicloFattSelez, dataInizioCiclo.substring(0,10), cod_tipo_contr,prov);
    //datiCliApp=datiCli;
    if ((datiCli==null)||(datiCli.size()==0))
    {
       //dataIniPerFattSel="";
       //dataFinePerFattSel="";
    }
    else 
    {
      Object[] objs3=datiCli.toArray();
      DatiCliBMP obj3=null;
      //dataFinePerFattSel="";
      for (int i=0;i<datiCli.size();i++)
      {
        obj3=(DatiCliBMP)objs3[i];
        String riepilogo= obj3.getDataIniPerFatt()+" - "+obj3.getDesc();
       %>
          opener.add_combo_elem("comboAccount","<%=obj3.getAccount()%>","<%=riepilogo%>");
       <%
       }//for
    }//chiusura dell'else

    datiCli = homeRiepAcc.findAllAccXVaCiclo2(comboCicloFattSelez, dataInizioCiclo.substring(0,10), cod_tipo_contr,prov);
    if ((datiCli==null)||(datiCli.size()==0))
    {
    }
    else 
    {
      Object[] objs5=datiCli.toArray();
      DatiCliBMP obj5=null;
      for (int i=0;i<datiCli.size();i++)
      {
        obj5=(DatiCliBMP)objs5[i];
        String riepilogo= obj5.getDataIniPerFatt()+" - "+obj5.getDesc();
       %>
          opener.add_combo_elem("comboRiepilogoAccount","<%=obj5.getAccount()%>","<%=riepilogo%>");
       <%
       }//for
    }//chiusura dell'else
    %>
    //opener.document.lancioVAForm.comboAccount[0].selected=true;
    }
    else
    { 
		   alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
    }
  <%}//if su carica lista
  else
  {
    //dataIniPerFattSel="";
    //dataFinePerFattSel="";
   }
  
%>
//opener.document.lancioVAForm.comboCicloF.focus();
opener.dialogWin.returnFunc();
self.close();
}

</SCRIPT>
</HEAD>

<BODY  onload="window.setTimeout(SubmitMe, 2000)">
<center>
<form name="frmDati" method="post">
	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
</center>
</form>
</BODY>
</HTML>
