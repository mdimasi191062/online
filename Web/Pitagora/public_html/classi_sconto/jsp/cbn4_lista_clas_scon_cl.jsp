<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<sec:ChkUserAuth />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_lista_clas_sconto_cl.jsp")%>
</logtag:logData>
<%

 // In questa Jsp il pulsante FILTRA consente di popolare  l'elenco delle classi di sconto 
 // anche con quelle disattive (cioè con data fine validita minore della data di sistema)
 // se la chekbox -- Mostra classi di sconto disattive -- è valorizzata.
 // Se la chekbox -- Mostra classi di sconto disattive --  non è valorizzata, 
 // popola invece l'elenco delle classi di sconto  leggendo dalla tabella
 // I5_2clas_sconto i record che hanno il campo data_fime_valid non valorizzata oppure maggiore 
 // o uguale alla data di sistema  se la chekbox -- Mostra classi di sconto disattive -- 
 // non è valorizzata.
 
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  boolean bCheck = false;
    //Dichiarazioni
 // I5_2CLAS_SCONTOEJBHome home = null; 
  I5_2CLAS_SCONTOEJB remote = null;   

  String bgcolor="";
  int i=0;
  int j=0;

     //Il campo contiene l'elemento selezionato dall'utente
  String selCODE_CLS_SCONTO=null;
  String sChecked="checked";
    // This is the variable we will store all records in.
  Collection collection=null;
  I5_2CLAS_SCONTOEJB[] aRemote = null;

  selCODE_CLS_SCONTO=(String) session.getAttribute("CODE_CLAS_SCONTO");

   //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

    //eventuale Filtro di ricerca
  String strCodRicerca= request.getParameter("txtCodRicerca");
  String filtro =  request.getParameter("chkClsDisatt");
  String CheckedFiltro="";
  if (filtro !=null) {
    CheckedFiltro="checked";
  }
  String strCodClsSconto= request.getParameter("txtCodClsSconto");
    //Lettura dell'indice Numero record per pagina della combo per ripristino dopo  ricaricamento
  int index=0;
  String strIndex = request.getParameter("txtnumRec");
  if (strIndex!=null)
  {
    Integer tmpindext=new Integer(strIndex);
    index=tmpindext.intValue();
  }

//Lettura del valore Numero record per pagina della combo per visualizzazione risultato (default 5)
  int records_per_page=5;
  String strNumRec = request.getParameter("numRec");
  if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

// Lettura del valore tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session

//****************
  int typeLoad=0;
  String strtypeLoad = request.getParameter("txtTypeLoad");
  if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }
  
%>

<HTML>
<HEAD>
<EJB:useHome id="home" type="com.ejbBMP.I5_2CLAS_SCONTOEJBHome" location="I5_2CLAS_SCONTOEJB" /> 
<%if (typeLoad!=0)
  {
    aRemote = (I5_2CLAS_SCONTOEJB[]) session.getAttribute("aRemote");
  }
  else
  {
    collection = home.findAll(filtro, strCodRicerca);      
    if (!(collection==null || collection.size()==0)) {
      aRemote = (I5_2CLAS_SCONTOEJB[]) collection.toArray( new I5_2CLAS_SCONTOEJB[1]);
      session.setAttribute("aRemote", aRemote);
    }else{  
      session.setAttribute("aRemote", null);    
    }  
  }    
%>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

function Filtra(){
 
   document.frmLista.action = "cbn4_lista_clas_scon_cl.jsp"
   document.frmLista.submit();
 
}  

function ONNUOVO()
{
  GestioneClsSconto(0);
}
function ONAGGIORNA()
{
  GestioneClsSconto(1);
}

function GestioneClsSconto(iGestione)
{
  var sParametri='';
  sParametri= '?txtnumRec=<%=index%>';
  sParametri= sParametri + '&numRec=<%=records_per_page%>';
<%  
  if (strCodRicerca!=null){
%>
  sParametri= sParametri + '&txtCodRicerca=<%=strCodRicerca%>'; 
<%  
  }
%>      
  if (parseInt(iGestione)==0){
    sParametri= sParametri + '&strProvenienza=0i';
  }else{  
    sParametri= sParametri + '&strProvenienza=0m';
    sParametri= sParametri + '&chkClsDisatt=<%=CheckedFiltro%>';    
    sParametri= sParametri + '&CodiceClsSconto=' + window.document.frmLista.CodSel.value;         
  }
  openDialog("cbn4_agg_clas_sconto_cl.jsp" + sParametri , 600, 380);    
}

function ONSTAMPA()
{
  openDialog("stampa_clas_scon_cl.jsp" , 800, 500, "","print");    
}


function ControlloDisattivazione()
{
  var objForm=window.document.frmLista;
  var id;
	if (objForm.code_clas_sconto.length>1){
    for (i=0;i<objForm.code_clas_sconto.length;i++)
    {
      if (objForm.code_clas_sconto[i].checked==true)
      {
        id = objForm.code_clas_sconto[i].value;
        break;
      }
    }
  }else{
    id = objForm.code_clas_sconto.value;
  }
	var obj = eval("objForm.classesconto_" + id);
	var caso;
	if (obj.length>1)
	{
		caso = obj[0].value * 1;
	}
	else
	{
		caso = obj.value * 1;
	}
	if (caso==1)
	{
		return false;
	}
	else
	{
		return true;
	}
	
}

function ONDISATTIVA()
{
  if(!ControlloDisattivazione())
  {
    alert("Non è possibile disattivare una classe già disattivata!")
    return;
  }
  sParametri= '?CodSel=' + window.document.frmLista.CodSel.value;         
  openDialog("cbn4_dis_clas_sconto_cl.jsp" + sParametri , 700, 400);    
}
  //------------------------------------------------------------------------------
  //Gestione Standard Ricerca
  //------------------------------------------------------------------------------  
function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.CodSel.value=document.frmLista.CodSel.value;
  document.frmSearch.txtTypeLoad.value=typeLoad;
  document.frmSearch.submit();
}  
function setnumRec()
{
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
}

function ChangeSel(codice,indice)
{
  document.frmLista.CodSel.value=codice;
//  document.frmLista.RagSel.value=eval('document.frmOlo.SelClienti[indice].value');
}
  //--------------------------------------------------------------------
  //Fine Gestione Standard Ricerca
  //------------------------------------------------------------------------------  

</SCRIPT>


<TITLE>Selezione Classe di Sconto</TITLE>
</HEAD>
<BODY onLoad="setnumRec();">

  <!-- Gestione navigazione-->

<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="post" action="cbn4_lista_clas_scon_cl.jsp">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/classidisconto.gif" alt="" border="0"></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height="3"></td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Lista Classi di Sconto</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>                                                                 
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td width="40%" class="textB" align="right">Codice Classe di Sconto:&nbsp;</td>
                      <td  width="40%" class="text">
                        <%
                        if (strCodRicerca==null)
                        {
                        %>
                          <input class="text" type='text' name='txtCodRicerca'  size='20'>                        
                        <%                        
                        }
                        else
                        {
                        %>
                          <input class="text" type='text' name='txtCodRicerca' value='<%=strCodRicerca%>' size='20'>                        
                        <%                        
                        }
                        %>
                      </td>
                      <td width="20%" rowspan='3' class="textB" valign="center" align="center">
                        <input class="textB" type="button" name="Esegui" value="Popola" onclick="submitFrmSearch('0');">
                        <% 
                        if (selCODE_CLS_SCONTO!=null){
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="<%=selCODE_CLS_SCONTO%>">
                         <%
                        }else{
                        %>
                        <input class="textB" type="hidden" name="CodSel" value="">
                        <%
                        }  
                        %>
                        <input class="textB" type="hidden" name="txtTypeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                      </td>
                    </tr>
                    <tr>  
                      <td class="textB" align="right">Mostra Classi di Sconto Disattivate:&nbsp;</td>
                      <td class="text">
                        <input type="checkbox" name="chkClsDisatt" <%=CheckedFiltro%>>
                      </td>
                    </tr>                        
                    <tr>
                      <td class="textB" align="right">Risultati per pag.:&nbsp;</td>
                      <td  class="text">
                        <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                    </tr>                    
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
</form>
  <!-- Gestione navigazione-->
<form name="frmLista">
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                  <tr>
                    <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp; Classi di Sconto Selezionate</td>
                    <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td colspan='1' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
  <% 
  if ((aRemote==null)||(aRemote.length==0))  
  
  {
    %>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="1" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>                  
                    <tr>
                      <td>
                        <table align='center' width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#CFDBE9">
                        <tr>
                         <td bgcolor='white' width="0%" >&nbsp;</td>      
                         <td bgcolor='#D5DDF1' class="textB" >Codice</td>
                         <td bgcolor='#D5DDF1' class="textB" >Descrizione</td>
                         <td bgcolor='#D5DDF1' class="textB" >Val. Minimo</td>
                         <td bgcolor='#D5DDF1' class="textB" >Val. Massimo</td>
                         <td bgcolor='#D5DDF1' class="textB" >Data Inizio</td>
                         <td bgcolor='#D5DDF1' class="textB" >Data Fine</td>
                        </tr>
<pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=aRemote.length%>">
<pg:param name="typeLoad" value="1"></pg:param>
<pg:param name="chkClsDisatt" value="<%=filtro%>"></pg:param>
<pg:param name="txtCodRicerca" value="<%=strCodRicerca%>"></pg:param>
<pg:param name="txtnumRec" value="<%=index%>"></pg:param>
<pg:param name="numRec" value="<%=strNumRec%>"></pg:param>                        
<%
     //Scrittura dati su lista
    I5_2CLAS_SCONTOPK PrimaryKey    = null; 
    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");   
    String code_clas_sconto = null ;
    String desc_clas_sconto   = null;
    java.math.BigDecimal  impt_min_spesa=null;
    java.math.BigDecimal  impt_max_spesa=null;
    String strImpt_min_spesa=null;
    String strImpt_max_spesa=null;
    int indVirgola=0;
    int ind=0;    
      for(j=((pagerPageNumber.intValue()-1)*records_per_page);((j<aRemote.length) && (j<pagerPageNumber.intValue()*records_per_page));j++)
   
      {
   /*      remote = null;
         remote = (I5_2CLAS_SCONTOEJB) PortableRemoteObject.narrow(aRemote[j],I5_2CLAS_SCONTOEJB.class);                                                
     */    if ((i%2)==0)
          bgcolor="#EBF0F0";
         else
          bgcolor="#CFDBE9";
          PrimaryKey    = (I5_2CLAS_SCONTOPK) aRemote[j].getPrimaryKey();  
          code_clas_sconto = PrimaryKey.getId_Cls_Sconto();
          desc_clas_sconto = aRemote[j].getDesc_Cls_Sconto();
          impt_min_spesa = null;
          impt_max_spesa = null;
          impt_min_spesa = aRemote[j].getMin_Spesa();
          impt_max_spesa = aRemote[j].getMax_Spesa();
          if (impt_min_spesa!=null) {
            strImpt_min_spesa=impt_min_spesa.toString().replace('.',',');           
            indVirgola=strImpt_min_spesa.indexOf(",");
             if (indVirgola==-1){
              indVirgola=strImpt_min_spesa.length();
            }
            ind =1;
            while ( indVirgola > (ind*3) ){              
              strImpt_min_spesa=strImpt_min_spesa.substring(0,indVirgola - (ind*3)) + "." + strImpt_min_spesa.substring(indVirgola-(ind*3));
              ind=ind+1;              
            }
          }else{
            strImpt_min_spesa="&nbsp;";
          }
          if (impt_max_spesa!=null) {
            strImpt_max_spesa=impt_max_spesa.toString().replace('.',',');           
            indVirgola=strImpt_max_spesa.indexOf(",");
            if (indVirgola==-1){
              indVirgola=strImpt_max_spesa.length();
            }
            ind =1;
            while ( indVirgola > (ind*3) ){              
              strImpt_max_spesa=strImpt_max_spesa.substring(0,indVirgola - (ind*3)) + "." + strImpt_max_spesa.substring(indVirgola-(ind*3));
              ind=ind+1;              
            }
          }else{
            strImpt_max_spesa="&nbsp;";
          }          
          String data_inizio_valid = df.format(aRemote[j].getIn_Valid());
          String data_fine_valid = "&nbsp;";
          if (aRemote[j].getFi_Valid()!=null){          
           data_fine_valid = df.format(aRemote[j].getFi_Valid());          
          }
         sChecked="";           
         if (!bCheck){
           if (selCODE_CLS_SCONTO!=null){
              if(code_clas_sconto.equals(selCODE_CLS_SCONTO)){
                sChecked="checked";
                bCheck=true;
              }
           }  else {   
              if (i==0) {
                sChecked="checked";
                bCheck=true;              
                selCODE_CLS_SCONTO=code_clas_sconto;
              }
           }  
        }
%>
                        <TR>
                           <td bgcolor='white'>
                              <input type="radio" name="code_clas_sconto" value="<%=PrimaryKey.getId_Cls_Sconto()%>" <%=sChecked%> onclick=ChangeSel('<%=PrimaryKey.getId_Cls_Sconto()%>','<%=i%>')>
                           </td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=PrimaryKey.getId_Cls_Sconto()%></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=desc_clas_sconto%></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=strImpt_min_spesa%></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=strImpt_max_spesa%></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=data_inizio_valid%></td>
                           <TD bgcolor='<%=bgcolor%>' class='text'><%=data_fine_valid%>
                             <input type="hidden" name="classesconto_<%=PrimaryKey.getId_Cls_Sconto()%>" value="<%if(data_fine_valid.equals("&nbsp;")){out.println("0");}else{out.println("1");}%>">
                           </td>
                       </tr>
                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
<%
          i+=1;
        }
%>
                        <tr>
                          <td colspan='7' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                        </tr>
<pg:index>
                        <tr>
                          <td bgcolor="#FFFFFF" colspan="7" class="text" align="center">
                          Risultati Pag.
                          <pg:prev> 
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[<< Prev]</A>
                          </pg:prev>
<pg:pages>
<% 
    if (pageNumber == pagerPageNumber) 
    {
%>
                            <b><%= pageNumber %></b>&nbsp;

<% 
    }
    else
    {
%>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
<%
    } 
%>
</pg:pages>
                          <pg:next>
                            <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page <%=pageNumber%>';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>
                          </td>
                        </tr>
</pg:index>
</pg:pager>
<%
    }
%> 
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
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <input type="hidden" name="chkClsDisatt" value="<%= filtro %>" >         
          <input type="hidden" name="CodSel" value="<%= selCODE_CLS_SCONTO %>" > 
          <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
	      </tr>
	    </table>
    </td>
  </tr>
</table>
</form>

<script language="javascript">
<% 
if ((aRemote==null)||(aRemote.length==0)) { 
%>
    Disable(document.frmLista.DISATTIVA);
    Disable(document.frmLista.AGGIORNA);        
    Disable(document.frmLista.STAMPA);
    //alert('Nessun dato selezionabile associato alla scelta !');
<%
}else{
  if (!bCheck){
    if (i==1){
%>
    document.frmLista.code_clas_sconto.checked=true;
    document.frmLista.CodSel.value=document.frmLista.code_clas_sconto.value;
<%    
    }else{    
%>
    document.frmLista.code_clas_sconto[0].checked=true;
    document.frmLista.CodSel.value=document.frmLista.code_clas_sconto[0].value;
<% 
    }
  }
}  
%>
</script>
</BODY>
</HTML>