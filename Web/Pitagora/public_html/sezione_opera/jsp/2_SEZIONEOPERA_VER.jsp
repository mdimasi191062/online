<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.ejb.*"%>
<%@ page import="com.utl.*"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,java.lang.*,java.text.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,com.filter.*" %>
<sec:ChkUserAuth/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%
//dichiarazioni delle variabili
String tipooperazione = request.getParameter("tipooperazione");
String tipoelaborazione = request.getParameter("tipoelaborazione");
String ciclo = request.getParameter("listVerCiclo");
String code_tipo_contr = request.getParameter("listServizi");
String tipoact = request.getParameter("act");
String code_elab=request.getParameter("code_elab");
String code_stato=request.getParameter("code_stato");
String codetipocontr = request.getParameter("listServizi");
String codeFunzBatch = "";
String provenienza = "verifica";
String datainizio = "";
String datafine = "";
String decodestato = "";
String datafinestampa = "";

String codetipoelaborazione = "";

           
if (tipooperazione != null) {
   if (tipoelaborazione.equals("valorizzazione")) {
       codetipoelaborazione = "V";
      } else {
        codetipoelaborazione = "R";
      }

      if (tipooperazione.equals("caricamentotabelle")) {
         if (codetipoelaborazione.equals("V")) {
             codeFunzBatch = "PV_OPERA";
         } else {
             codeFunzBatch = "PR_OPERA";
         }             
      } else if (tipooperazione.equals("creazionefilecsv")) {
         if (codetipoelaborazione.equals("V")) {
             codeFunzBatch = "FV_OPERA";
         } else {
             codeFunzBatch = "FR_OPERA";
         }             
        }
}

if (tipoelaborazione != null) {
    if (tipoelaborazione.equals("valorizzazione")) {
     codetipoelaborazione = "V";
    } else {
         codetipoelaborazione = "R";
    }
}
//paginatore
int intRecXPag = 0;
int intRecTotali = 0;
if(request.getParameter("cboNumRecXPag")==null){
	intRecXPag=50;
}else{
	intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
}
String strtypeLoad = request.getParameter("hidTypeLoad");
String strSelected = "";
//fine paginatore

int i=0;
String bgcolor = "";
String strTitle = "";
String strCodeFunz = "";
String strImageTitle = "";
String strCodeFunzPkg = "";
String strNameFirstPage = "2_SEZIONEOPERA_VER.jsp";
strTitle = "Verifica Sezione Opera";
strCodeFunz = "10040"; //Batch Lancio Package
strCodeFunzPkg = ""; // 3_SEZIONEOPERA_TAB // 4_SEZIONEOPERA_CSV
strImageTitle =StaticContext.PH_CONSUNT_SWN_IMAGES;
%>

<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
<TITLE>
	<%=strTitle%>
</TITLE>
        <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>changeStatus.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>openDialog.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE="JavaScript">
	var objForm = null;
	function Initialize()
	{
		objForm = document.frmDati;
	}
	
	function ONAGGIORNA(){
		reloadPage('0','<%=strNameFirstPage%>');
	}

	function ONRICERCA(){
            document.frmDati.act.value="cerca";
            document.frmDati.action = "2_SEZIONEOPERA_VER.jsp";
            document.frmDati.submit();
	}

	function ONRIPULISCI(){
            document.frmDati.act.value="";
            document.frmDati.tipooperazione.value="";
            document.frmDati.tipoelaborazione.value="";
            document.frmDati.action = "2_SEZIONEOPERA_VER.jsp";
            document.frmDati.submit();
	}

        function ONACCOUNT_ELAB()
        {
            document.frmDati.act.value="account";
            document.frmDati.action="2_SEZIONEOPERA_VER.jsp" ;
            document.frmDati.submit();
        }

        function ChangeSel(codice, codeStato)
        {
        
          document.frmDati.code_elab.value=codice;
          document.frmDati.code_stato.value=codeStato;
          Enable(document.frmDati.ACCOUNT_ELAB);
          
        }

        function Abilita()
        {
            Disable(document.frmDati.ACCOUNT_ELAB);
            Disable(document.frmDati.RICERCA);
        }
        
        function Disabilita()
        {
            Disable(document.frmDati.ACCOUNT_ELAB);
            Enable(document.frmDati.RICERCA);
        }
        
</SCRIPT>
</HEAD>
<BODY onload="Initialize();">

<form name="frmDati" method="post" action="">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name=act                     id=act                      value="">
<input class="textB" type="hidden" name="code_elab" value="<%=code_elab%>">
<input class="textB" type="hidden" name="code_stato" value="<%=code_stato%>">

<!-- inizio filtro -->
<table align=center width="95%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=strTitle%></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro Dati Elaborazione</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%">
                          <tr>
                            <td class="textB">Tipo Operazione</td>
                            <td class="textB">Tipo Elaborazione</td>
                            <td class="textB">Ciclo di Valorizzazione</td>
                            <td class="textB">Servizio Reg/Xdsl</td>
                          </tr>
                          <tr>
                            <td class="text">
                            <%if (tipooperazione==null) {tipooperazione="0";}
                             if (tipoelaborazione==null) {tipoelaborazione="0";} %>
                            <%if (!tipooperazione.equals("creazionefilecsv")) {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="caricamentotabelle" checked>
                            <%} else {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="caricamentotabelle">
                            <%}%>
                                <label for="male">Caricamento Tabelle</label><br>
                            <%if (tipooperazione.equals("creazionefilecsv")) {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="creazionefilecsv" checked>
                            <%} else {%>
                                <input type="radio" id="tipooperazione" name="tipooperazione" value="creazionefilecsv">
                            <%}%>
                                <label for="female">Creazione file CSV</label><br>
                            </td>
                            <td class="text">
                            <%if (!tipoelaborazione.equals("repricing")) {%>
                                <input type="radio" id="caricamentotabelle" name="tipoelaborazione" value="valorizzazione" checked>
                            <%} else {%>
                                <input type="radio" id="caricamentotabelle" name="tipoelaborazione" value="valorizzazione">
                            <%}%>
                                <label for="male">Valorizzazione</label><br>
                            <%if (tipoelaborazione.equals("repricing")) {%>
                                <input type="radio" id="creazionefilecsv" name="tipoelaborazione" value="repricing" checked>
                            <%} else {%>
                                <input type="radio" id="creazionefilecsv" name="tipoelaborazione" value="repricing">
                            <%}%>
                                <label for="female">Repricing</label><br>
                            </td>                            <td class="text">                        
                                <select class="text" title="ciclo" id="listVerCiclo" name="listVerCiclo">

<%if (ciclo != null){ 
%>
                                <option value="<%=ciclo%>"><%=ciclo%></option>                                   
<%}%>
<%
                            GestioneServizioOpera gestServiziOpera = new GestioneServizioOpera();
                            Vector<TypeVerCiclo> listVerCiclo = gestServiziOpera.listVerCiclo();
                              for(int indciclo = 0; indciclo < listVerCiclo.size(); indciclo++){
%>
<% if (!listVerCiclo.get(indciclo).getCiclo().equals(ciclo)) {%>
                                <option value=<%=listVerCiclo.get(indciclo).getCiclo()%>><%=listVerCiclo.get(indciclo).getCiclo()%></option>                                   
<%
  }
                              }
%>
                                </select>
                            </td>
                            <td class="text">                        
                                <select class="text" title="servizi" id="listServizi" name="listServizi">

<%if (codetipocontr != null){ 
//recupero descrizione account
                            code_tipo_contr = codetipocontr;
                            GestioneServizioOpera gestServiziOpera4 = new GestioneServizioOpera();
                            Vector<TypeDescrizione> listDescrizione = gestServiziOpera4.listDescrizione(code_tipo_contr);
                              for(int indDescrizione = 0; indDescrizione < listDescrizione.size(); indDescrizione++){
%>

                                <option value=<%=codetipocontr%>><%=listDescrizione.get(indDescrizione).getDesc()%></option>                                   
<%
                              }
%>
<%}%>
<%
                            GestioneServizioOpera gestServiziOpera2 = new GestioneServizioOpera();
                            Vector<TypeServizi> listServizi = gestServiziOpera2.listServizi(provenienza);
                              for(int indservizi = 0; indservizi < listServizi.size(); indservizi++){
%>
<% if (!listServizi.get(indservizi).getCode().equals(codetipocontr)) {%>
                                <option value=<%=listServizi.get(indservizi).getCode()%>><%=listServizi.get(indservizi).getDesc()%></option>                                   
<%
   }                              
                               }
%>
                                </select>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>

			</td>
		</tr>
  </table>

<!-- fine filtro -->
<!-- inizio risultato -->
<%if (tipoact != null) { %>
<%if (tipoact.equals("cerca")) { %>
<!-- inizio elenco lista elab -->
<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width='100%'>
			<table width="100%" cellspacing="1" align="center">
				<%
                            GestioneServizioOpera gestServiziOpera3 = new GestioneServizioOpera();
                            Vector<TypeBatch> listBatch = gestServiziOpera3.listBatch(codeFunzBatch, ciclo, code_tipo_contr);

					      session.setAttribute("listBatch", listBatch);
					intRecTotali = listBatch.size();
				if(listBatch.size()!=0){%>
					<tr>
						<td colspan="6">
<!--
                                                    <table >
								<tr>
				                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
				                      <td  class="text">
				                        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>');">
										<%for(int k = 50;k <= 300; k=k+50){
											if(k==intRecXPag){
												strSelected = "selected";
											}else{
												strSelected = "";
											}
										%>
				                          <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
										<%}%>
				                        </select>
				                      </td>
								  </tr>
							 </table>
-->
                                        </td>
	                </tr>
					<tr bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
						<td height="25" class="textB"></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Data/Ora Inizio Elaboraz.</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Data/Ora Fine Elaboraz.</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Stato</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Nr Account</font></td>
					</tr>
				<%}else{
                                    tipoact = null;
                                %>
					<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
						<td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
					</tr>
				<%}%>
					<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
				      <%
					   // se il vettore è stato caricato si prosegue con il caricamento della lista	
                            String classRow = "row2"; 

                            for(int indBatch = 0; indBatch < listBatch.size(); indBatch++){
                               classRow = classRow.equals("row2") ? "row1" : "row2";

                                  if(listBatch.get(indBatch).getStato().equals("INIT")){
                                    decodestato = "Inizializzato";
                                  } else if(listBatch.get(indBatch).getStato().equals("RUNN")){
                                      decodestato = "In esecuzione";
                                    }  else if(listBatch.get(indBatch).getStato().equals("DUMP")){
                                        decodestato = "Interrotto";
                                      } else if ( (listBatch.get(indBatch).getStato().equals("SUCC")) || (listBatch.get(indBatch).getStato().equals("SUCV")) ){
                                          decodestato = "Terminato";
                                        } else if(listBatch.get(indBatch).getStato().equals("CLOS")){
                                            decodestato = "In chiusura";
                                          }
%>
							<tr>
                                                            <td class="<%=classRow%>" width='2%'>
                                                              <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio' unchecked name='SelOf' value='<%=listBatch.get(indBatch).getCodice()%>' onclick=ChangeSel('<%=listBatch.get(indBatch).getCodice()%>','<%=listBatch.get(indBatch).getStato()%>')>
                                                            </td>   
								<td height="25" class="<%=classRow%>">&nbsp;<%=listBatch.get(indBatch).getInizio()%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=listBatch.get(indBatch).getFine()%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=decodestato%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=listBatch.get(indBatch).getValore()%></td>
							</tr>

<%
                              }
%>


							<tr>
								<td colspan="5" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
									<!--paginatore-->
										<pg:index>
											 Risultati Pag.
											 <pg:prev> 
					                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
					                         </pg:prev>
											 <pg:pages>
											 		<%if (pageNumber == pagerPageNumber){%>
													       <b><%= pageNumber %></b>&nbsp;
													<%}else{%>
									                       <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
													<%}%>
											 </pg:pages>
											 <pg:next>
					                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
					                         </pg:next>
										</pg:index>
									</pg:pager>
								</td>
							</tr>
			</table>
		</td>
	</tr>
</table>
<!-- fine elenco lista elab -->
<% } else if (tipoact.equals("account")) { %>
<!-- inizio elenco lista account -->

<table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	<tr>
		<td width='100%'>
			<table width="100%" cellspacing="1" align="center">
				<%
                            GestioneServizioOpera gestServiziOpera4 = new GestioneServizioOpera();
                            Vector<TypeElaborati> listElaborati = gestServiziOpera4.listElaborati(code_elab);

			      session.setAttribute("listElaborati", listElaborati);
					intRecTotali = listElaborati.size();
				if(listElaborati.size()!=0){%>
					<tr>
						<td colspan="6">
<!--
                                                    <table >
								<tr>
				                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
				                      <td  class="text">
				                        <select class="text" name="cboNumRecXPag" onchange="reloadPage('1','<%=strNameFirstPage%>');">
										<%for(int k = 50;k <= 300; k=k+50){
											if(k==intRecXPag){
												strSelected = "selected";
											}else{
												strSelected = "";
											}
										%>
				                          <option <%=strSelected%> class="text" value="<%=k%>"><%=k%></option>
										<%}%>
				                        </select>
				                      </td>
								  </tr>
							 </table>
-->
                                        </td>
	                </tr>
					<tr bgcolor="<%=StaticContext.bgColorHeader%>" class="white">
						<td height="25" class="textB" ><font color="#FFFFFF">Codice</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Account</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Data/Ora Inizio Elaboraz.</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Data/Ora Fine Elaboraz.</font></td>
						<td height="25" class="textB" ><font color="#FFFFFF">Stato</font></td>
					</tr>
				<%}else{%>
					<tr bgcolor="<%=StaticContext.bgColorTabellaForm%>">
						<td width="8%" height="20" class="textB" align="center">Nessun dato da visualizzare!</td>
					</tr>
				<%}%>
					<pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
					
				      <%
					   // se il vettore è stato caricato si prosegue con il caricamento della lista	
                            String classRow = "row2"; 


                              for(int indElaborati = 0; indElaborati < listElaborati.size(); indElaborati++){
                                 classRow = classRow.equals("row2") ? "row1" : "row2";
                              
                                 if (listElaborati.get(indElaborati).getFine() == null) {
                                    datafinestampa = " ";
                                 } else { datafinestampa = listElaborati.get(indElaborati).getFine();
                                 }
                                  if(listElaborati.get(indElaborati).getStato().equals("INIT")){
                                    decodestato = "Inizializzato";
                                  }
                                  else if(listElaborati.get(indElaborati).getStato().equals("RUNN")){
                                    decodestato = "In esecuzione";
                                  }
                                  else if(listElaborati.get(indElaborati).getStato().equals("DUMP")){
                                    decodestato = "Interrotto";
                                  }
                                  else if ( (listElaborati.get(indElaborati).getStato().equals("SUCC")) || (listElaborati.get(indElaborati).getStato().equals("SUCV")) ){
                                    decodestato = "Terminato";
                                  }
                                  else if(listElaborati.get(indElaborati).getStato().equals("CLOS")){
                                    decodestato = "In chiusura";
                                  }

%>
							<tr bgcolor="<%=bgcolor%>">
								<td height="25" class="<%=classRow%>">&nbsp;<%=listElaborati.get(indElaborati).getCodice()%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=listElaborati.get(indElaborati).getAccount()%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=listElaborati.get(indElaborati).getInizio()%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=datafinestampa%></td>
								<td height="25" class="<%=classRow%>">&nbsp;<%=decodestato%></td>
							</tr>

<%
                              }
%>


							<tr>
								<td colspan="5" class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
									<!--paginatore-->
										<pg:index>
											 Risultati Pag.
											 <pg:prev> 
					                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
					                         </pg:prev>
											 <pg:pages>
											 		<%if (pageNumber == pagerPageNumber){%>
													       <b><%= pageNumber %></b>&nbsp;
													<%}else{%>
									                       <A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
													<%}%>
											 </pg:pages>
											 <pg:next>
					                            	<A HREF="javaScript:goPage('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
					                         </pg:next>
										</pg:index>
									</pg:pager>
								</td>
							</tr>
			</table>
		</td>
	</tr>
</table>

<!-- fine elenco lista account -->
<% } else { %>                
        <SCRIPT LANGUAGE="JavaScript">
            Disable(document.frmDati.ACCOUNT_ELAB);
        </SCRIPT>
<%
     }
%>
<% }%>
<!-- fine risultato -->
<!--PULSANTIERA-->
	<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
	    <tr>
    		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
    	</tr>
	</table>
	<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
		<tr>
			<td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
				<sec:ShowButtons td_class="textB"/>
			</td>
		</tr>
	</table> 
</form>
<%
if (tipoact!=null) {
    if (!tipoact.equals("cerca")) {
        out.println("<script>Disabilita();</script>");
    } else {
        out.println("<script>Abilita();</script>");
      }
} else {
        out.println("<script>Disabilita();</script>");
}
%>
</BODY>
</HTML>
