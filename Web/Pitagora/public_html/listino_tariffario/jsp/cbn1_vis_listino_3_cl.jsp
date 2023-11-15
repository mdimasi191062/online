<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.rmi.PortableRemoteObject" %>
<%@ page import="java.rmi.RemoteException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.ejb.*" %>
<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<sec:ChkUserAuth/>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn1_vis_listino_3_cl.jsp")%>
</logtag:logData>
<%@ page contentType="application/vnd.ms-excel; charset=windows-1252"%>
<HTML>
<HEAD>
</HEAD>
<BODY>
<table>
<tr>
<!--mm01 17/03/2004 INIZIO-->
  <td>Tipologia di Offerta</td>
<!--mm01 17/03/2004 FINE-->
	<td>P/S</td>
	<td>Ogg. Fatturaz.</td>
	<td>Causale</td>
	<td>Min Classe Sconto</td>
	<td>Max Classe Sconto</td>
	<td>Descrizione</td>
	<td>Importo</td>
	<td>Tipo Importo</td>
	<td>Unità di Misura</td>
	<td>Data Inizio</td>
	<td>Data Fine</td>
	<td>Data Creazione</td>			
</tr>
<%
	int i = 0;
	Vector vctTariffe = (Vector) session.getAttribute("vctTariffe");
	for(i =0; i < vctTariffe.size(); i++)
       {
			DB_Tariffe lobj_Tariffa = (DB_Tariffe)vctTariffe.elementAt(i);
/*mm01 17/03/2004 INIZIO*/
      String descTipoOff = "";

      if ( Misc.nh(lobj_Tariffa.getDESC_TIPO_OFF()).equals("") ) {
          descTipoOff = "N/A";    
      }
      else {
          descTipoOff = Misc.nh(lobj_Tariffa.getDESC_TIPO_OFF());
      }
/*mm01 17/03/2004 FINE*/
      %>
			<tr>
<!--mm01 17/03/2004 INIZIO-->
        <td><%=descTipoOff%></td>
        <!--td><%=Misc.nh(lobj_Tariffa.getDESC_TIPO_OFF())%></td-->
<!--mm01 17/03/2004 INIZIO-->
				<td><%=Misc.nh(lobj_Tariffa.getDESC_ES_PS())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDESC_OGG_FATRZ())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDESC_TIPO_CAUS())%></td>
				<td><%=CustomNumberFormat.setToNumberFormat(Misc.nh(lobj_Tariffa.getIMPT_MIN_SPESA()))%></td>
				<td><%=CustomNumberFormat.setToNumberFormat(Misc.nh(lobj_Tariffa.getIMPT_MAX_SPESA()))%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDESC_TARIFFA())%></td>
				<td><%=CustomNumberFormat.setToNumberFormat(Misc.nh(lobj_Tariffa.getIMPT_TARIFFA()))%></td>
				<td><%=Misc.nh(lobj_Tariffa.getTIPO_FLAG_MODAL_APPL_TARIFFA())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDESC_UNITA_MISURA())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDATA_INIZIO_TARIFFA())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDATA_FINE_TARIFFA())%></td>
				<td><%=Misc.nh(lobj_Tariffa.getDATA_CREAZ_TARIFFA())%></td>
			</tr>
		<%}%>
</table>
</BODY>
</HTML>
