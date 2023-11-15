<%@ page contentType="text/html;charset=windows-1252"%>
<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>

<%@ page import = "com.utl.*" %>
<%@ page import = "com.usr.*" %>
<%@ page import = "com.ds.chart.*" %>
<%@ page import = "com.ejbSTL.*" %>
<%@ page import = "java.io.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "java.awt.Color" %>
<%@ page import = "java.io.IOException" %>
<%@ page import = "javax.naming.*" %>
<%@ page import = "javax.naming.Context" %>
<%@ page import = "javax.naming.InitialContext" %>
<%@ page import = "javax.sql.DataSource" %>
<%@ page import = "javax.rmi.PortableRemoteObject" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true"/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pie.jsp")%>
</logtag:logData>

<html>
<head>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>pie diagram</title>
<script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
</head>
<BODY>

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
    
    int maxNumPS=25;
    String lstrDescrTipoContratto = "";
    
    Context ic = new InitialContext();
    Object home = ic.lookup("ChartEJB");
    ChartEJBHome beanHome = (ChartEJBHome)PortableRemoteObject.narrow(home, ChartEJBHome.class );
    ChartEJB chart = beanHome.create();

    String alertMessage="";
    String msgErrore="";

    String imageMap = "";

    // recupero parametri
    String idGestore=request.getParameter("idGestore");
    String anno=request.getParameter("anno");
    String mese=request.getParameter("mese");

    String diagramType=(String)session.getAttribute("PieDiagramType");
    
    Vector idPS=null;

    // impostazioni file generato
    java.util.Date date = new java.util.Date();
    String filePath=application.getRealPath("/")+"statistiche/save"+System.getProperty("file.separator");
    String pieFile="pie"+date.getTime()+".PNG";

    try {

        // recupero del tipo contratto in sessione
        KeyValue tipoContratto = (KeyValue)session.getAttribute("tipoContratto"); 

        lstrDescrTipoContratto = tipoContratto.getValue();

        String flagSysTipoContratto = (String)session.getAttribute("flagSysTipoContratto");
  
        // recupero del gestore in sessione
        BarDiagramDataset barDataset = (BarDiagramDataset)session.getAttribute("barDataset");
        BarDiagramDataGroup group = barDataset.groupAt(Integer.parseInt(idGestore));

        // generazione lista di tutti i PS (one shot)
        if (session.getAttribute("idPS")==null){
            idPS=chart.getListaPS(StaticContext.DSNAME, 
                                           tipoContratto.getKey(), 
                                           group.getID(), 
                                           anno, 
                                           mese, 
                                           flagSysTipoContratto);
                                           
            session.setAttribute("idPS", idPS);
        }else {
            idPS=(Vector)session.getAttribute("idPS");
        }

        // costruzione del dataset
        PieDiagramDataset pieDataset=null;

        StringBuffer listaPS = new StringBuffer();

        boolean blnPrimoElemento = false;
        
        KeyValue kvPS = null;
        for (int contaPS=0; contaPS<idPS.size();contaPS++){
            kvPS=(KeyValue)idPS.elementAt(contaPS);
            if (kvPS.isChecked()) {
                if (blnPrimoElemento) {
                    listaPS.append(",");
                }
                listaPS.append("'"+(kvPS.getKey())+"'");
                blnPrimoElemento = true;
            }
        }
        
        System.out.println("listaPS" + listaPS.toString());
        
        System.out.println("esecuzione di getPieDiagramDataset");

        pieDataset = chart.getPieDiagramDataset(StaticContext.DSNAME, 
                                                                  tipoContratto.getKey(), 
                                                                  group.getID(), 
                                                                  anno, 
                                                                  mese, 
                                                                  listaPS.toString(), 
                                                                  null, 
                                                                  flagSysTipoContratto);

        System.out.println("fine esecuzione di getPieDiagramDataset");

        session.setAttribute("pieDataset", pieDataset);
 
        // impostazioni proprietà del grafico
        Properties pr = chart.getDefaultProperties();
        pr.setProperty("TYPE_IMG", "PNG");
        pr.setProperty("W_IMG", "800");
        pr.setProperty("H_IMG", "600");
    
        pr.setProperty("GENERATE_IMAGEMAP", "0");
        pr.setProperty("TITLE", "Dettaglio fatturazione "+group.getLabel()+" per il contratto "+tipoContratto.getValue()+" mese "+mese+"/"+anno);

        if (pieDataset.size()>maxNumPS) {
            pr.setProperty("GENERATE_LEGEND", "0");
            pr.setProperty("DRAW_CATEGORY_LABEL", "0");
            alertMessage="Attenzione il numero di elementi è eccessivo. Per una migliore visualizzazione selezionare un numero inferiore";
        } else {
            pr.setProperty("GENERATE_LEGEND", "1");
        }
    
        if (!diagramType.equals("Pie")) {
            // generazione Pie Diagram  
            pr.setProperty("GENERATE_IMAGEMAP", "1");
            pr.setProperty("JAVASCRIPT_FUNCTION", "");
            pr.setProperty("BAR_DIAGRAM_TYPE", diagramType);
            chart.setProperties(pr);
            chart.generateBarChart(pieDataset, group.getLabel());

        } else {
            // aggiunta per modifica
            pr.setProperty("GENERATE_PIETOOLTIP", "0");
            // aggiunta per modifica
            pr.setProperty("GENERATE_IMAGEMAP", "1");
            // aggiunta per modifica
            pr.setProperty("JAVASCRIPT_FUNCTION", "null");
            chart.setProperties(pr);
            // generazione Pie Diagram  
            chart.generatePieChart(pieDataset);  
        }

        System.out.println("esecuzione di getImageMap");
        imageMap = chart.getImageMap();
        System.out.println("fine esecuzione di getImageMap");

        // salvataggio del Grafico su file
        chart.saveToFile(filePath+pieFile, chart.getImageChart());

        if (!imageMap.equalsIgnoreCase("")) {
%>
    <form name="frmDati" method="post" action="pie.jsp" >
    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr align="center">
            <td align="center"><%=imageMap%></td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
                    <tr align="center">
                        <td>
                            <img src="<%= StaticContext.PH_STATISTICHE_SAVE+pieFile %>" border=0 usemap="#Chart">
                        </td>
                    </tr>
                    <tr align="center">
                        <td align=center>
                            <table>
                                <tr align="center">
                                    <td class=alert align=left colspan="3"><%=alertMessage%></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <input type=hidden name=idGestore value=<%=idGestore%> >
                <input type=hidden name=anno value=<%=anno%> >
                <input type=hidden name=mese value=<%=mese%> >
                <input type=hidden name=diagramType value=<%=diagramType%> >

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
<%} catch(Exception ex) {
        msgErrore = "Exception pie.jsp: "+ex.toString();
        System.out.println(msgErrore);
%>
    <script language=javascript>
        imgProgress.style.display='none';
        document.all('msg').innerText = '<%=msgErrore%>';
    </script>

<%}%>
    </form>

    <!-- form per la visualizzazione in formato pdf -->
    <form name='pdf' action='pdf.jsp' method='post' target='_blank'>
      <input type='hidden' name='imgName' value='<%=pieFile%>'>
      <input type='hidden' name='DIAGRAM_TYPE' value='PIE'>
    </form>

<script language=Javascript>

    window.resizeTo(screen.width, screen.height);
    window.moveTo(0,0);

    function handleReturnedListaPS() {
        //document.forms[0].diagramType.value = dialogWin.returnedValue;
        document.forms[0].submit();
    }

    // NUOVE FUNZIONI GESTITE DAL TAG DELLA PULSANTIERA

    function ONSELEZIONA() {
    
 		//popup che visualizza tutti i P/S compresi nel grafico
		var strURL="<%=StaticContext.PH_STATISTICHE_JSP%>cbn1_PS_Statistiche.jsp";
		strURL+="?intAction=<%=StaticContext.LIST%>";
		strURL+="&intFunzionalita=<%=StaticContext.FN_STATISTICHE%>";
		strURL+="&DescTipoContratto=<%=lstrDescrTipoContratto%>";
		strURL+="&FIRST_TIME=1";
			
        openDialog(strURL, 569, 400, handleReturnedListaPS);
        
    }
    
    function ONCHIUDI() {
        window.close();
    }

    function ONGENERA_PDF() {
         document.forms.pdf.submit();
    }
</script>
</body>
</html>
