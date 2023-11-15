<!-- import delle librerie necessarie -->
<%@ include file="../../common/jsp/gestione_cache.jsp"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.rmi.RemoteException"%>
<%@ page import="java.io.IOException"%>

<%@ page import="javax.naming.*"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.rmi.PortableRemoteObject"%>
<%@ page import="javax.ejb.*"%>

<%@ page import="com.utl.*" %>
<%@ page import="com.usr.*"%>
<%@ page import = "com.ds.chart.*" %>

<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"elenco_componenti.jsp")%>
</logtag:logData>
<EJB:useHome id="homeEnt_Inventari" type="com.ejbSTL.Ent_InventariHome" location="Ent_Inventari" />
<EJB:useBean id="remoteEnt_Inventari" type="com.ejbSTL.Ent_Inventari" scope="session">
    <EJB:createBean instance="<%=homeEnt_Inventari.create()%>" />
</EJB:useBean>
<%
    int j=0;

    String strCopia = "";
    String strChecked = "";
    String strSelected = "";

    String comboDiagramType = "";
    String diagramTypeSessione = "";
    String diagramTypePagina = "";

    String paramTipo = request.getParameter("paramTipo");
    
    
    
 //   session.removeAttribute("PIE_DIAGRAM_TYPE");

/*   int intAction;
    if(request.getParameter("intAction") == null){
        intAction = StaticContext.LIST;
    }else{
        intAction = Integer.parseInt(request.getParameter("intAction"));
    }
   
    int intFunzionalita;
	if(request.getParameter("intFunzionalita") == null){
		intFunzionalita = StaticContext.FN_TARIFFA;
	}else{
		intFunzionalita = Integer.parseInt(request.getParameter("intFunzionalita"));
	}
  */ 
    int intRecXPag;
    if(request.getParameter("cboNumRecXPag")==null){
        intRecXPag=50;
    }else{
        intRecXPag = Integer.parseInt(request.getParameter("cboNumRecXPag"));
    }

    String strtypeLoad = request.getParameter("hidTypeLoad");
      if ( strtypeLoad==null || strtypeLoad.equals("") ){
      strtypeLoad = (String)session.getAttribute("hidTypeLoad");
    
      }
     
      String parCodeIstProd = request.getParameter("CodeIstProd");
      Vector vct_InventariCompo =  remoteEnt_Inventari.getInventarioComponenti(parCodeIstProd);
    
      


   
    
    StringTokenizer  stElencoCheck = null;
    
    String nomeElemento = "";
    int statoElemento = 0;

    boolean blnValore = false;

    Vector pvct_Componenti=new Vector();
 DB_InventCompo objCompo = null;  

    if ((session.getAttribute("hidComando")!=null)&&(!session.getAttribute("hidComando").equals(""))){
        blnValore = (session.getAttribute("hidComando").equals("SEL_ALL"));
    }else {
        if ((request.getParameter("hidListaCheck") != null) && (request.getParameter("hidListaCheck") != "")) {

            stElencoCheck = new StringTokenizer(request.getParameter("hidListaCheck"),",");
        
            while (stElencoCheck.hasMoreTokens()) {

                strCopia = stElencoCheck.nextToken();
                nomeElemento = strCopia.substring(0,strCopia.indexOf(":"));
                statoElemento = Integer.parseInt(strCopia.substring(strCopia.indexOf(":")+1,strCopia.length()));
               
                objCompo = new DB_InventCompo();
               
            
                if (statoElemento!=0) {
                  objCompo.Modifica(); 
                  objCompo.setCODE_ISTANZA_COMPO(nomeElemento);
                  pvct_Componenti.add(objCompo); 
                }

                
       
        
            }
           if (paramTipo.equals("DIF")) {
             session.setAttribute("DIFListaCOMPO", pvct_Componenti);
           session.setAttribute("hidTypeLoad", "1");
           }
          if (paramTipo.equals("C_A")) {
             session.setAttribute("C_AListaCOMPO", pvct_Componenti);
           session.setAttribute("hidTypeLoad", "1");
           }

      
           
        }
    }

%>
  
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css">
	<TITLE>Selezione P/S per Statistiche</TITLE>
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
<script src="<%=StaticContext.PH_EVENTI_JS%>generatoreEventi.js" type="text/javascript"></script>
	<SCRIPT LANGUAGE='Javascript'>
    
	var objForm;

	function inizialize() {
	objForm = document.frmDati;
	}




function aggiornaListaCheck() {
    		var stat='';
        var elLength = document.frmDati.elements.length;
        objForm.hidListaCheck.value ='';
        for (i=0; i<elLength; i++)
            {    
              var type = objForm.elements[i].type;
              if (type=="checkbox" && objForm.elements[i].name != 'sel_all'){
                 if (objForm.elements[i].checked == true){
                        stat=stat+objForm.elements[i].value+":1"+ ",";
                    }else {
                        stat=stat+objForm.elements[i].value+":0"+ ",";
                    }
              }
            }
           objForm.hidListaCheck.value = stat;

}

	function goPagina(UrlPagina) {
        aggiornaListaCheck();
        goPage(UrlPagina);
    }

  

function confermaSel(){
    aggiornaListaCheck();
    frmDati.hidTypeLoad.value = '2';
    objForm.submit(); 
  
}
  
function checkTutti() {

  var elLength = document.frmDati.elements.length;

    for (i=0; i<elLength; i++)
    {
       var type = objForm.elements[i].type;
      if (type=="checkbox" && objForm.elements[i].name != 'sel_all'){
       if (objForm.elements[i].checked == true){
          objForm.elements[i].checked = false;
      }else{
          objForm.elements[i].checked = true;
      }   
     }
    }
   
}
 
 
	</SCRIPT>
</HEAD>
<BODY onload="inizialize();">
<form name="frmDati" method="post"   >
<input type="hidden" name="hidListaCheck" value="">
<input type="hidden" name="paramTipo" value="<%=paramTipo%>">
<input type="hidden" name="hidTypeLoad" value="">
<input type="hidden" name="CodeIstProd" value="<%=parCodeIstProd%>">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      &nbsp;
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
            <td>
            	<table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                        <tr>
                            <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Componenti  </td>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"></td>
                        </tr>
                         <tr>
                            <td colspan='2' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
				  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
	                    <tr>
	                      <td colspan='3' bordercolor="<%=StaticContext.bgColorCellaBianca%>" bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
	                    </tr>
                       <tr>
                            <td align="left" colspan='3'>
                                <table>
                                    <tr>
                                        <td class="textB" align="left">Seleziona/Deseleziona tutti </td>
                                        <td class="text">
                                            <input type="checkbox" name="sel_all"  onclick="javascript:checkTutti();">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan='3'>
                                <table>
                                    <tr>
                                        <td class="textB" align="left">Risultati per pag.:&nbsp;</td>
                                        <td class="text">
                                            <select class="text" name="cboNumRecXPag" onchange="reloadPageCompo('1','elenco_componenti.jsp')"> 
                                                <%
                                                for(int k = 10;k <= 50; k=k+10){
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
                            </td>
                        </tr>
                    <%if ((vct_InventariCompo==null)||(vct_InventariCompo.size()==0)){%>
                        <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="3" class="textB" align="center">Nessun Componente presente</td>
                        </tr>
	                <%}else{
							String bgcolor="";
							String CodeCompo="";
							String descrizioneCompo="";
                            DB_InventCompo lobj_COMPO=null;
                            int intRecTotali=vct_InventariCompo.size();%>
                            
                        <pg:pager maxPageItems="<%=intRecXPag%>" maxIndexPages="10" totalItemCount="<%=intRecTotali%>">
                     <%for(j=((pagerPageNumber.intValue()-1)*intRecXPag);((j < intRecTotali) && (j < pagerPageNumber.intValue()*intRecXPag));j++)	
                            {
                                lobj_COMPO=null;
                                CodeCompo = "";
                                lobj_COMPO=(DB_InventCompo)vct_InventariCompo.get(j);
                                  CodeCompo=lobj_COMPO.getCODE_ISTANZA_COMPO();
                                if ((j%2)==0){
                                    bgcolor=StaticContext.bgColorRigaDispariTabella;
		                        }else{
                                    bgcolor=StaticContext.bgColorRigaPariTabella;
		                        }

                                if (j ==((pagerPageNumber.intValue()-1)*intRecXPag)){
                                  
                                    
                                }%>
                        <tr>
                            <td width='2%' bgcolor="<%=bgcolor%>">
                              
                                <input type='checkbox' name='chkCOMPO<%=""+j%>' value='<%=CodeCompo%>' <%=strChecked%> >
                            </td>
                            <td bgcolor='<%=bgcolor%>' class='text'><%=CodeCompo%></td>
                        </tr>
                        <%}%>
                        <tr>
                            <td colspan='3' class="text" align="center" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
                                <!--paginatore-->
                                <pg:index>
                                     Risultati Pag.
                                     <pg:prev> 
                                        <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                                     </pg:prev>
                                     <pg:pages>
                                        <%if (pageNumber == pagerPageNumber){%>
                                            <b><%= pageNumber %></b>&nbsp;
                                        <%}else{%>
                                            <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                        <%}%>
                                     </pg:pages>
                                     <pg:next>
                                           <A HREF="javaScript:goPagina('<%= pageUrl %>')" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                                     </pg:next>
                                </pg:index>
                            </pg:pager>
                            </td>
                        </tr>
						<%}%>
	                    <tr>
	                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='2'></td>
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
</table>
 <!--PULSANTIERA-->
<table width="80%" border="0" cellspacing="0" cellpadding="0" align='center'>
	<tr>
		<td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="<%=StaticContext.PH_COMMON_IMAGES%>pixel.gif" width="1" height='3'></td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>

    <TR height="20" bgcolor="<%=StaticContext.bgColorCellaBianca%>">
        <TD>
          <TABLE align="center" width="100%" border="0">
            <TR>
              <td class="text" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center">
                <INPUT TYPE="button" class="textB" value="Annulla" onclick="window.close()">
                <INPUT TYPE="button" class="textB" value="Conferma" onclick="confermaSel()">
              </td>
            </TR>
          </TABLE>
        </TD>
      </TR>
</table>
</form>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript"> 

<%
 if ( strtypeLoad!=null ){
    if (strtypeLoad.equals("2")){%>
      // alert('CHIDUI');
       window.setTimeout('self.close()',200);
<%
}
}
%>
</SCRIPT>
</BODY>
</HTML>