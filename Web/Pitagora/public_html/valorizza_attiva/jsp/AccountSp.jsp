<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*,java.util.Vector.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" VectorName="vectorButton" />
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"AccountSp.jsp")%>
</logtag:logData>

<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
int numElabBatch;
int numFattProvv=0;
int numAccNoVa=0;

ElaborBatchBMP     remoteEB=null;
Collection         remoteFattProvv=null;
Collection         remoteAccNoVa=null;

String cod_tipo_contr =request.getParameter("cod_tipo_contr");
String des_tipo_contr =request.getParameter("des_tipo_contr");

String codeFunzBatch       = request.getParameter("codeFunzBatch");
String codeFunzBatchNC     = request.getParameter("codeFunzBatchNC");
String codeFunzBatchRE     = request.getParameter("codeFunzBatchRE");

String comboCicloFattSelez = request.getParameter("comboCicloFattSelez");
String dataIniCiclo        = request.getParameter("dataIniCiclo");

String act                 =request.getParameter("act");
String cod_account         =request.getParameter("cod_account");
String des_account         =request.getParameter("des_account");
String act1= ""; 

//System.out.println(">>>>>>>>>>>>>>>>>>ENTRO act  : "+act);
//System.out.println(">>>>>>>>>>>>>>>>>>ENTRO act1 : "+act1);

// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");

if (strIndex!=null && !(strIndex.equals("")))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }
// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if (strNumRec!=null)
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null && !(strtypeLoad.equals("")))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

// Vettore contenente risultati query
Collection account=null;
String testo1=" ";
String testo2=" ";
String testo3=" ";
%>
<EJB:useHome id="homeEB"       type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" /> 
<EJB:useHome id="homeAccount1" type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" /> 
<EJB:useHome id="homeAccount"  type="com.ejbBMP.DatiCliBMPHome"     location="DatiCliBMP" />   

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<style type="text/css">
    #waitpage { position: absolute; }
  </style>
<TITLE> Lista Account </TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>

<SCRIPT LANGUAGE='Javascript'>

    function HideImage () 	{
        
	    if (document.layers) {
	      document.waitpage.visibility = 'hide';
	    }
        else if (document.all) {
    	        document.all.waitpage.style.visibility = 'hidden';
	          }
	}

    if ("<%=act%>"=="refresh") {
         opener.document.lancioVAForm.act.value="refresh";
         opener.dialogWin.returnFunc();
         self.close();
    }

    var codeFunzBatch=<%=codeFunzBatch%>;
    var codeFunzBatchNC=<%=codeFunzBatchNC%>;
    var codeFunzBatchRE=<%=codeFunzBatchRE%>;
    var abi_conferma=true;

    function submitFrmSearch(typeLoad) {
      document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
      document.frmSearch.typeLoad.value=typeLoad;
      document.frmSearch.submit();
    }

    function ONANNULLA() {
        if (opener && !opener.closed) {
            self.close();
        } else { 
            alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
            self.close();
        }
    }

    function ONCONFERMA() {
        document.frmSearch.codeFunzBatch.value = "<%=codeFunzBatch%>";
        document.frmSearch.codeFunzBatchNC.value = "<%=codeFunzBatchNC%>";
        document.frmSearch.codeFunzBatchRE.value = "<%=codeFunzBatchRE%>";
        document.frmSearch.comboCicloFattSelez.value = "<%=comboCicloFattSelez%>";
        document.frmSearch.dataIniCiclo.value = "<%=dataIniCiclo%>";
        document.frmSearch.cod_tipo_contr.value ="<%=cod_tipo_contr%>";
        document.frmSearch.des_tipo_contr.value ="<%=des_tipo_contr%>";

        if (document.frmSearch.act.value=="accountFattProvv") {

            document.frmSearch.act.value="elimina_fatture";
            if  (codeFunzBatch=="23" || codeFunzBatch=="21") {
                document.frmSearch.action='<%=request.getContextPath()%>/servlet/LancioValAttivaCntl';
                document.frmSearch.submit();
            } else
                alert("Funzionalità Batch non valida");
                
        } else if (document.frmSearch.act.value=="accountNoFatt") { 
                //HideImage();
                //resize(400,150);  
                document.frmSearch.act.value="aggiornaParVal";
                document.frmSearch.action='<%=request.getContextPath()%>/servlet/LancioValAttivaCntl';
                document.frmSearch.submit();
            }
    }

    function Close() {
        self.close();
        opener.dialogWin.returnFunc();
    }

    function controlli() {}

    function setInitialValue() {
        if ("<%=act%>"!="refresh") {
            eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
            if (!abi_conferma) {
                Disable(document.frmSearch.CONFERMA);
            }
        }
    }
</SCRIPT>

</HEAD>

<%
//System.out.println("act PRIMA DEL BODY "+act);
//if (act!=null &&  (act.equals("search_fatt")))

if (act!=null &&  (act.equals("no_batch")) ||  (act.equals("search_fatt")) )
{ 
act="search_fatt_1";
%>

<BODY onload="controlli();">
<center>
<!--DIV ID="waitpage"-->
<table border=0 align="center" width=100%>
<tr>
  <td align="center">
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="<%=StaticContext.PH_COMMON_IMAGES%>orologio.gif" width="60" height="50" alt="" border="0">
  </td>
</tr>
</table>
<!--/DIV-->
<%
    act1= act; 
    //System.out.println("act "+act);
    if (act!=null && act.equals("search_fatt_1"))
    //if (act!=null && act.equals("search_fatt"))
    {
        //determinaCodBatch();
        //System.out.println("codeFunzBatch "+codeFunzBatch);
        if  (codeFunzBatch.equals("23") || codeFunzBatch.equals("21"))
        {
            //System.out.println("codeFunzBatch " +codeFunzBatch);
            //elabBatch(request,response);%>
            <%remoteEB= homeEB.findElabBatchCtrlEV(codeFunzBatch);
            numElabBatch=remoteEB.getElabBatch();
            //System.out.println("numElabBatch "+numElabBatch);
            if (numElabBatch==0)
            {
                //System.out.println("*****numElabBatch "+numElabBatch);
                //fattProv(request,response);
                String testoEccezione="";
                //RICHIEDE IL NUMERO DI FATTURE PROVVISORIE
                remoteFattProvv= homeAccount1.findFattProvv(codeFunzBatch,comboCicloFattSelez,dataIniCiclo,cod_tipo_contr);
                if ((remoteFattProvv!=null))
                {
                    numFattProvv=remoteFattProvv.size();
                    //System.out.println("*****numFattProvv: "+numFattProvv);
                }
                if (numFattProvv!=0)
                {
                    //visualizza finestra fatture provvisorie;
                    act="accountFattProvv";
                } else if (numFattProvv==0)
                    {
                        //accountNoVa(request,response);
                        remoteAccNoVa= homeAccount1.findAllAccNoVa(cod_tipo_contr,comboCicloFattSelez,dataIniCiclo);
                        if ((remoteAccNoVa!=null))
                        {
                            numAccNoVa=remoteAccNoVa.size();
                            //System.out.println("*****numAccNoVa :"+numAccNoVa);
                        }    
                        if (numAccNoVa!=0)
                        {
                            act="accountNoFatt";
                        } else if (numFattProvv==0 && numAccNoVa==0)
                            {
                                //Lancia PARAM_VALO_AGGIORNA
                                //act="refresh";
                                //aggiornaParamValo(request,response);
                                String strResult="LancioValAttivaCntl";
                                strResult+="?act=aggiornaParVal";
                                strResult+="&cod_tipo_contr="+cod_tipo_contr;
                                strResult+="&comboCicloFattSelez="+comboCicloFattSelez;
                                strResult+="&dataIniCiclo="+dataIniCiclo.substring(0,10);
                                String strUrl = request.getContextPath() + "/servlet/"+strResult; 
                                //System.out.println("*****controlli negativi  Aggiorno PARAM VALORIZZ "+strUrl);
                                response.sendRedirect(strUrl);
                                //response.sendRedirect(request.getContextPath()+"/valorizza_attiva/jsp/AccountSp.jsp?act="+act+"&comboCicloFattSelez="+comboCicloFattSelez
                                //                                 +"&cod_contratto="+cod_contratto+"&des_contratto="+des_contratto);
                            }
                    }
                    else
                    {
                          //NON FARE NIENTE numFattProvv!=0 già gestito
                    }
            }
            else
            {
                act="no_batch";
            %>
                <SCRIPT language='JavaScript'>
                opener.document.lancioVAForm.act.value="no_batch"; 
                opener.dialogWin.returnFunc();
                self.close();
                </SCRIPT>
            <%
            }
        } 
        else//(codeFunzBatch.equals("23") || codeFunzBatch.equals("21"))
        {
        }
    }// if (act!=null && act.equals("search_fatt"))
%>

</BODY>
<%}

//else  
if (act!=null &&  (act.equals("accountFattProvv") || act.equals("accountNoFatt")) )
{
//System.out.println("*****act: "+act);
%>
   <script language="javascript"> resize(650,380); </script>

  <%if (act1!=null && act1.equals("search_fatt_1"))
  {
    act1=null;
    response.sendRedirect(request.getContextPath()+"/valorizza_attiva/jsp/AccountSp.jsp?act="+act+"&comboCicloFattSelez="+comboCicloFattSelez
                                                 +"&cod_tipo_contr="+cod_tipo_contr+"&des_tipo_contr="+des_tipo_contr+"&dataIniCiclo="+dataIniCiclo+
                                                 "&codeFunzBatch="+codeFunzBatch);
//System.out.println("*****redi dopo : "+act);                                                 
  } 

//System.out.println("*****redirect dopo : "+act);

if (act1!=null)
{
//System.out.println(">>>>>>>>>>>>>>>>>>act1 : "+act1);
if (act.equals("accountFattProvv"))
{
    testo1 = "Per i seguenti Account esistono fatture provvisorie";
    testo2 = "E' necessario cancellarle per cambiare ciclo di fatturazione";
    testo3 = "Lista Account";
}    
else if (act.equals("accountNoFatt"))
{
    testo1 = "Per i seguenti Account non è stata prodotta la fattura del";
    testo2 = "ciclo di fatturazione corrente. Procedere con il cambio ciclo?";
    testo3 = "Lista Account";
}
%>
<BODY onload="setInitialValue();">
<!--DIV ID="waitpage"-->
<%
   if (typeLoad!=0)
   {
     account = (Collection) session.getAttribute("account");
   }
   else
   {
      if (act.equals("accountFattProvv"))
      {
         //System.out.println("codeFunzBatch,comboCicloFattSelez,dataIniCiclo "+ codeFunzBatch+" "+comboCicloFattSelez+" "+dataIniCiclo);
         account = homeAccount.findFattProvv(codeFunzBatch,comboCicloFattSelez,dataIniCiclo,cod_tipo_contr);

      }   
      else if (act.equals("accountNoFatt"))
         account = homeAccount.findAllAccNoVa(cod_tipo_contr,comboCicloFattSelez,dataIniCiclo);
      if (account!=null)
          session.setAttribute("account", account);
   }
%>

<form name="frmSearch" method="post" action="AccountSp.jsp">
<input type="hidden" name=comboCicloFattSelez  id= comboCicloFattSelez  value="<%=comboCicloFattSelez%>">  
<input type="hidden" name=dataIniCiclo     id= dataIniCiclo   value="<%=dataIniCiclo%>">  
<input type="hidden" name=cod_tipo_contr   id=cod_tipo_contr  value="<%=cod_tipo_contr%>">
<input type="hidden" name=des_tipo_contr   id=des_tipo_contr  value="<%=des_tipo_contr%>">
<input type="hidden" name=act              id=act             value="<%=act%>">

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
     <img src="../images/titoloPagina.gif" alt="" border="0">
    </td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=testo1%>
                                                                         <BR>&nbsp;<%=testo2%>
                </td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di Ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="images/pixel.gif" width="1" height='2'></td>
                    </tr>
                        <!--input class="textB" type="hidden" name="cod_contratto" value="<%//=cod_contratto%>"-->
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <!--input class="textB" type="hidden" name="des_contratto" value="<%//=des_contratto%>"-->
                        <input class="textB" type="hidden" name="codeFunzBatch"       value="<%=codeFunzBatch%>">
                        <input class="textB" type="hidden" name="codeFunzBatchNC"     value="<%=codeFunzBatchNC%>">
                        <input class="textB" type="hidden" name="codeFunzBatchRE"     value="<%=codeFunzBatchRE%>">
                        <input class="textB" type="hidden" name="comboCicloFattSelez" value="<%=comboCicloFattSelez%>">
                        <input class="textB" type="hidden" name="dataIniCiclo"        value="<%=dataIniCiclo%>">
                        <input class="textB" type="hidden" name="typeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">
                        <input class="textB" type="hidden" name=cod_account id=cod_account value=<%=cod_account%>>
                        <input class="textB" type="hidden" name=des_account id=des_account value=<%=des_account%>>
                    <tr>
                      <td width="10%">&nbsp;</td>
                      <td class="textB" width="40%" align="right">Risultati per pag.:</td>
                      <td class="text" width="25%" align="left">
                        <select class="text" name="numRec"  onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                        </select>
                      </td>
                      <td width="25%">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
					</td>
        </tr>
        <tr>
          <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
  <tr>
  	<td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=testo3%></td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
              </tr>
<%
    if ((account==null)||(account.size()==0))
    {
%>

              <Script language='JavaScript'>abi_conferma=false;</Script>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
<%
    }
    else
    {
%>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor="<%=StaticContext.bgColorFooter%>" class='textB'>&nbsp;</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Descrizione Account</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>            
<%
    }
%>
            </table>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=account.size()%>">
                <pg:param name="typeLoad"            value="1"></pg:param>
                <pg:param name="cod_tipo_contr"       value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="codeFunzBatch"       value="<%=codeFunzBatch%>"></pg:param>
                <pg:param name="codeFunzBatchNC"     value="<%=codeFunzBatchNC%>"></pg:param>
                <pg:param name="codeFunzBatchRE"     value="<%=codeFunzBatchRE%>"></pg:param>                
                <pg:param name="comboCicloFattSelez" value="<%=comboCicloFattSelez%>"></pg:param>
                <pg:param name="dataIniCiclo"        value="<%=dataIniCiclo%>"></pg:param>
                <pg:param name="cod_account"         value="<%=cod_account%>"></pg:param>
                <pg:param name="des_account"         value="<%=des_account%>"></pg:param>
                <pg:param name="txtnumRec"           value="<%=index%>"></pg:param>
                <pg:param name="numRec"              value="<%=strNumRec%>"></pg:param>
                <pg:param name="act"                 value="<%=act%>"></pg:param>
                <%
                String bgcolor="";
                String checked;  
                Object[] objs=account.toArray();
                
                
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<account.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                {
                    DatiCliBMP obj=(DatiCliBMP)objs[i];
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                %>
                       <tr>                                                                                                      
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' name='des_account' class='text'>&nbsp;<%=obj.getDesc()%></td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                        <td bgcolor='<%=bgcolor%>' class='text'>&nbsp;</td>
                      </tr>
                <%    
                    }//for
                %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="3" height='2'></td>
                    </tr>

                <pg:index>
                          <tr>
                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
                                Risultati Pag.
                          <pg:prev>
                          
                                <%
                                pageUrl= pageUrl;
                                %>
                                <A HREF="<%=pageUrl%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  pageUrl= pageUrl;
                                %>
                                  <A HREF="<%=pageUrl%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                          </pg:pages>

                          <pg:next>
                                 <% pageUrl= pageUrl;%>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>

                            </td>
                          </tr>

                </pg:index>

                </pg:pager>

                <tr>
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="Images/pixel.gif" width="1" height='2'></td>
                </tr>
        
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  </table>
  <tr>
    <td colspan=5>  
       <sec:ShowButtons VectorName="vectorButton" />  
    </td>
  </tr> 
    </td>
  </tr>
</TABLE>   
</form>
<!--/DIV-->
</BODY>
<%
 }
////System.out.println("PASSO ALLA FINE");
}%>

</HTML>

