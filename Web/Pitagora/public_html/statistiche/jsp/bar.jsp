<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import = "com.ds.chart.*" %>
<%@ page import = "com.ejbSTL.*" %>
<%@ page import = "com.utl.*" %>
<%@ page import = "com.usr.*" %>
<%@ page import = "org.jfree.data.*" %>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.awt.Color" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.rmi.PortableRemoteObject" %>
<%@ page import = "javax.naming.*" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>

<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"bar.jsp")%>
</logtag:logData>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<title>bar diagram</title>
</head>
<body>

	<script language=javascript>
		window.resizeTo(screen.width/2,screen.height/3.3);
		window.moveTo((screen.width - screen.width/2)/2,(screen.height - screen.height/3.3)/2);
	</script>

    <TABLE width="100%" height="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" id="tblElaborazione" name="tblElaborazione">
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
                &nbsp;
              </TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="middle" width="9%">
                <IMG alt=tre src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width=28>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD align="center" valign="middle">
          <IMG name="imgProgress" id="imgProgress" alt="Elaborazione in corso" src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif">
          <BR>
          <FONT class="text" id="msg" name="msg">
          Elaborazione in corso...
          </FONT>
        </TD>
      </TR>
    </TABLE>
    
<% 
    out.flush();

    String alertMessage="";
    String msgErrore="";
    String tipoGrafico="";

    // impostazioni file generato
    java.util.Date date = new java.util.Date();
    String filePath=application.getRealPath("/")+"statistiche/save"+System.getProperty("file.separator");
    String barFile="chart"+date.getTime()+".PNG";

    try {

        int maxNumACCOUNT=100;
    
        Context ic = new InitialContext();
        Object home = ic.lookup("ChartEJB");
        ChartEJBHome beanHome = (ChartEJBHome)PortableRemoteObject.narrow(home, ChartEJBHome.class );
        ChartEJB chart = beanHome.create();

        // recupero parametri
        tipoGrafico=request.getParameter("tipoGrafico"); 
        
        String ids= request.getParameter("ids");
        String meseInizio= request.getParameter("meseInizio");
        String annoInizio= request.getParameter("annoInizio");      
        String meseFine= request.getParameter("meseFine");
        String annoFine= request.getParameter("annoFine");
        String flagSysTipoContratto= request.getParameter("flagSysTipoContratto");
        String descrTipoContratto = request.getParameter("descrTipoContratto");
        String codeTipoContratto = request.getParameter("codiceTipoContratto");

        KeyValue tipoContratto = null;
        // recupero del tipo contratto (one shot)
        if ((codeTipoContratto==null)|| codeTipoContratto.equals("")){
            tipoContratto=(KeyValue)session.getAttribute("tipoContratto");
        }else {
            session.setAttribute("flagSysTipoContratto", flagSysTipoContratto);
            tipoContratto=new KeyValue(codeTipoContratto, descrTipoContratto);
            session.setAttribute("tipoContratto", tipoContratto);
        }

        // impostazioni proprietà del grafico
        Properties pr = chart.getDefaultProperties();
        pr.setProperty("TYPE_IMG", "PNG");
        pr.setProperty("BAR_DIAGRAM_TYPE", tipoGrafico);
        pr.setProperty("W_IMG", "800");
        pr.setProperty("H_IMG", "600");
        pr.setProperty("GENERATE_IMAGEMAP", "1");
        pr.setProperty("BAR_DIAGRAM_VALUE_LABEL", "Fatturazione");
        pr.setProperty("BAR_DIAGRAM_SERIE_LABEL", "Periodo");
        pr.setProperty("TITLE", "Fatturazioni totali per il contratto "+tipoContratto.getValue());

        // costruzione del dataset bar diagram
        BarDiagramDataset barDataset=null;

        barDataset = chart.getBarDiagramDataset(StaticContext.DSNAME, 
                                                                   tipoContratto.getKey(), 
                                                                   ids, 
                                                                   meseInizio, 
                                                                   annoInizio, 
                                                                   meseFine, 
                                                                   annoFine, 
                                                                   flagSysTipoContratto);

        if (barDataset.size()>maxNumACCOUNT){
            pr.setProperty("GENERATE_LEGEND", "0");
            alertMessage="Attenzione il numero di elementi è eccessivo. Per una migliore visualizzazione selezionare un numero inferiore";
        }else {
            pr.setProperty("GENERATE_LEGEND", "1");
        }

        chart.setProperties(pr);

        // generazione Bar Diagram
        chart.generateBarChart(barDataset);

        // recupero image Map
        String imageMap = "";
        if (!(chart.getImageMap()).equalsIgnoreCase("")){
            imageMap = chart.getImageMap();
        }
  
        // salvataggio del Grafico su file
        chart.saveToFile(filePath+barFile, chart.getImageChart());
    
        // salvataggio del dataset in sessione
        if (barDataset!=null){
            session.setAttribute("barDataset", barDataset);  
        }

        // imposta la tipologia di grafico per entrambe le pagine 
        // per default il tipo grafico del dettaglio è : Pie
        session.setAttribute("BarDiagramType", tipoGrafico);
        session.setAttribute("PieDiagramType", "Pie");

        if (!imageMap.equalsIgnoreCase("")) {
%>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr align="center">
            <%= imageMap %>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
                <tr align="center">
                    <td align="center"><img src="<%= StaticContext.PH_STATISTICHE_SAVE+barFile %>" border=0 usemap="#Chart"></td>
                </tr>
                <tr align="center">
                    <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                </tr>
                <tr align="center">
                    <td align="center" class="alert"><%=alertMessage%></td>
                </tr>
            </table>
             <!--PULSANTIERA-->
            <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
                <tr align="center">
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
                </tr>
            </table>
            <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
              <tr align="center">
                <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                    <sec:ShowButtons td_class="textB"/>
                </td>
              </tr>
            </table>
        </tr>
    </table>
    <script language=javascript>
        tblElaborazione.style.display='none';
    </script>
<%}%>
<%
    } catch(Exception ex) {
        msgErrore = ex.toString();
        StaticContext.writeLog(StaticMessages.getMessage(5002,msgErrore));

%>
    <script language=javascript>
        imgProgress.style.display='none';
        document.all('msg').innerText = '<%=msgErrore%>';
    </script>
<%}%>
    <!-- form per la visualizzazione in formato pdf -->
    <form name='pdf' action='pdf.jsp' method='post' target='_blank'>
      <input type='hidden' name='imgName' value='<%=barFile%>'>
      <input type='hidden' name='DIAGRAM_TYPE' value='BAR'>
    </form>

<script language=javascript>

    window.resizeTo(screen.width, screen.height);
    window.moveTo(0,0);

    function explode(idGestore, serie){
        anno = serie.substring(serie.indexOf(" ")+1), serie.length;  
        mese = serie.substring(0, serie.indexOf(" "));
        urlToOpen='pie.jsp?anno='+anno+'&mese='+mese+"&idGestore="+idGestore;
        //window.open(urlToOpen,"_blank", "toolbar=no,width=400,height=300,screenX=0, screenY=0, top=10, left=10, scrollbars=yes,status=no,location=no,directories=no,menubar=no,personalbar=no,resizable=yes");
        window.open(urlToOpen,"_blank", "toolbar=no, top=10, left=10, scrollbars=no,status=no,location=no,directories=no,menubar=no,personalbar=no,resizable=yes");
    }

    // NUOVE FUNZIONI GESTITE DAL TAG DELLA PULSANTIERA

    function ONCHIUDI() {
        window.close();
    }
    
    function ONGENERA_PDF() {
         document.forms.pdf.submit();
    }

</script>
</body>
</html>
