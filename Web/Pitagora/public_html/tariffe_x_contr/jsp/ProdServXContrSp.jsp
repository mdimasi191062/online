<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<sec:ChkUserAuth   isModal="true" VectorName="vectorButton" />
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");
String act=null;
Integer numeroTariffeInt=null;
String chiamante=request.getParameter("chiamante");
if (chiamante!=null && chiamante.equalsIgnoreCase("TariffaXContrSp")) 
    act=request.getParameter("act");

String cod_tipo_contr=request.getParameter("cod_tipo_contr");
if (cod_tipo_contr==null) cod_tipo_contr=(String)session.getAttribute("cod_tipo_contr");
String des_tipo_contr=request.getParameter("des_tipo_contr");
if (des_tipo_contr==null) des_tipo_contr=(String)session.getAttribute("des_tipo_contr");
String des_contr=request.getParameter("des_contr");
if (des_contr==null) des_contr=(String)session.getAttribute("des_contr");
String cod_contr=request.getParameter("cod_contr");
if (cod_contr==null) cod_contr=(String)session.getAttribute("cod_contr");

String cod_ps=request.getParameter("cod_PS");
if (cod_ps==null) cod_ps=(String)session.getAttribute("cod_PS");

String strPsRicerca = Misc.nh(request.getParameter("PsRircerca"));

String des_ps=(String)session.getAttribute("des_PS");
if (des_ps==null)  des_ps=request.getParameter("des_PS");

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

Collection prodServ=null;

TariffaXContrBMP remoteNumTar=null;
// verifica se per il PS si possono acquisire altre tariffe
if ((act!=null)&&(act.equalsIgnoreCase("verTarAcqXContr")))
  {%>
  <EJB:useHome id="homeXContr" type="com.ejbBMP.TariffaXContrBMPHome" location="TariffaXContrBMP" />
<%
     //remoteNumTar= homeNumTar.findNumTar(cod_contratto,cod_ps);
     //numeroTariffeInt= remoteNumTar.getNumTariffe();
     remoteNumTar= homeXContr.findNumTarXContr(cod_tipo_contr,cod_contr,cod_ps);
     numeroTariffeInt= remoteNumTar.getNumTariffe();
  }
%>
<EJB:useHome id="homeOggFatt1" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
<EJB:useHome id="homeProdServ" type="com.ejbSTL.ProdServSTLHome" location="ProdServSTL" />
<EJB:useBean id="remoteProdServ" type="com.ejbSTL.ProdServSTL" value="<%=homeProdServ.create()%>" scope="session"></EJB:useBean>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Selezione Prodotti e Servizi
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
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
<SCRIPT LANGUAGE='Javascript'>


var codPs="";
var descPs="";
var abi_conferma=true;


function ChangeSel(codice, descrizione)
{
  codPs=codice;
  descPs=descrizione.replace('Æ','\'');
}

function submitFrmSearch(typeLoad)
{
  var stringa="";
  stringa=document.frmSearch.PsRircerca.value;
  document.frmSearch.PsRircerca.value=stringa.toUpperCase();
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  document.frmSearch.submit();
}

function setInitialValue()
{
//MODIFICA 13/11/02
if (!abi_conferma)
  { 
     Disable(document.frmSearch.SELEZIONA);
  }

 <% if ( (numeroTariffeInt!=null && numeroTariffeInt.intValue()<=0) || (numeroTariffeInt==null))
 {%>
    eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
 <%}
 if (numeroTariffeInt!=null && !numeroTariffeInt.equals("null") && numeroTariffeInt.intValue()==0)
 {
    act=null;
 %>

    alert('non ci sono tariffe da acquisire per il prodotto/servizio selezionato');
 <%}%>

  //Setta il primo elemento della lista
<% 
if (numeroTariffeInt!=null && !numeroTariffeInt.equals("null") && numeroTariffeInt.intValue()>0)
{
}
else
{%>
   ChangeSel(document.frmSearch.cod_PS_primo.value,document.frmSearch.des_PS_primo.value); //11-03-03
<%}%>
 }

function ONSELEZIONA()
{
      if (codPs!="")
      {
        if(document.frmSearch.chiamante.value=="TariffaXContrSp")
        {
          document.frmSearch.cod_PS.value=codPs;
          document.frmSearch.des_PS.value=descPs;
          document.frmSearch.act.value="verTarAcqXContr";
          document.frmSearch.action="ProdServXContrSp.jsp";
          document.frmSearch.submit();
        }
         else if(document.frmSearch.chiamante.value=="InsAssOfPsXContrSp")
        {
          opener.document.InsAssOfPsSp.act.value="Nuovo";
          opener.document.InsAssOfPsSp.des_PS.value=descPs;
          opener.document.InsAssOfPsSp.cod_PS.value=codPs;
          self.close();
          opener.dialogWin.returnFunc();
        }
        else
        {
        opener.document.contratto.des_PS.value=descPs;
        opener.document.contratto.cod_PS.value=codPs;
        self.close();
        opener.dialogWin.returnFunc();
        }
   }
   else if ((codPs=="")||(codPs==null))
   {
      alert("Selezionare un P/S");
   }
}

function Close()
{
    opener.document.contratto.des_PS.value="<%=des_ps%>";
    opener.document.contratto.cod_PS.value="<%=cod_ps%>";
    self.close();
    opener.dialogWin.returnFunc();
}

/*function SubmitMe(selection)
{
if (selection.value=="Chiudi")
     document.ProdServ.act.value="disattiva";    
 document.ProdServ.action="OggettoFatt.jsp";
 document.ProdServ.submit();  
 return false; 
}*/

function Close()
{
<%
  Collection oggfatt= homeOggFatt1.findOggFattAssPsXContr(cod_tipo_contr,cod_contr,cod_ps);

   Object[] objs1=oggfatt.toArray();%>
   if (opener && !opener.closed)
    {
       opener.document.oggFattForm.des_PS.value="<%=des_ps%>";
       opener.document.oggFattForm.cod_PS.value="<%=cod_ps%>";
       opener.document.oggFattForm.comboOggFatt[0].selected=true;
       opener.numeroTariffe= "<%=numeroTariffeInt%>";
       opener.clear_all_combo("comboOggFatt");
       opener.add_combo_elem("comboOggFatt","-1","[Seleziona Opzione]                                 ");
    <%
    if ((oggfatt!=null)&&(oggfatt.size()!=0))
    {
      for (int i=0; i<oggfatt.size(); i++)
      {
        OggFattBMP obj=(OggFattBMP)objs1[i];
        %>
        opener.add_combo_elem("comboOggFatt","<%=obj.getCodeOggFatt()%>","<%=obj.getDescOggFatt()%>");
        opener.classeOf["<%=i%>"]="<%=obj.getCodeCOf()%>";
    <%}//for
    }//if%>
   opener.dialogWin.returnFunc(); 
  }
  else
  { 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
    self.close();
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%if (numeroTariffeInt!=null && !numeroTariffeInt.equals("null") && numeroTariffeInt.intValue()>0)
  {%>
  <script language="JavaScript"> Close(); </script>
<%
}
else
{
  
   if (typeLoad!=0)
   {
     prodServ = (Collection) session.getAttribute("prodServ");
     
   }
   else
   {
      
      if (chiamante.equalsIgnoreCase("ListaTariffeXContrSp")) 
      {
         
         prodServ = remoteProdServ.getPsXContr(cod_contr,strPsRicerca);
      }
      else
      if (chiamante.equalsIgnoreCase("InsAssOfPsXContrSp")) 
      {
         prodServ = remoteProdServ.getPsAssOfPs(cod_tipo_contr,strPsRicerca);
      }
      else
      {
          prodServ = remoteProdServ.getPsXContrIns(cod_tipo_contr,cod_contr,strPsRicerca);
      }

       if (prodServ!=null)
          session.setAttribute("prodServ", prodServ);
   }

  String checkedfiltra="";
  String checkvalue="";
  if ((request.getParameter("disattivi")!=null)&&
       (request.getParameter("disattivi").equals("yes")))
       {
       checkedfiltra="checked";
       checkvalue="yes";
       } 
%>

<form name="frmSearch" method="get" action="ProdServXContrSp.jsp">
<input type="hidden" name=chiamante id=chiamante value="<%=chiamante%>">
<input type="hidden" name=act id=act value= "<%=act%>">
<input type="hidden" name=cod_PS_primo id=cod_PS_primo value=""> <!--12-03-03 -->
<input type="hidden" name=des_PS_primo id=des_PS_primo value=""> <!--12-03-03 -->

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista di selezione dei Prodotti e Servizi</td>
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
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                      <td colspan='4' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="images/pixel.gif" width="1" height='2'></td>
                    </tr>
                        <input class="textB" type="hidden" name="cod_tipo_contr" value="<%=cod_tipo_contr%>">
                        <input class="textB" type="hidden" name="des_tipo_contr" value="<%=des_tipo_contr%>">
                        <input class="textB" type="hidden" name="cod_contr" value="<%=cod_contr%>">
                        <input class="textB" type="hidden" name="des_contr" value="<%=des_contr%>">

                        <input class="textB" type="hidden" name="typeLoad" value="">
                        <input class="textB" type="hidden" name="txtnumRec" value="<%=index%>">
                        <input class="textB" type="hidden" name="txtnumPag" value="1">

                    
                    <tr>
                      <td class="textB" width="25%">&nbsp;Tipo Contratto:</td>
                      <td class="text" width="75%" align="left">&nbsp;<%=des_tipo_contr%></td>
                      <td colspan=2>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="textB" width="25%">&nbsp;Contratto:&nbsp;</td>
                      <td class="text" width="75%" align="left">&nbsp;<%=des_contr%></td>
                      <td colspan=2>&nbsp;</td>
                    </tr>
 <tr>
                     <td width="40%" class="textB" align="right">Descrizione Ps:&nbsp;</td>
                     <td width="30%" class="text"><input class="text" type='text' id="PsRircerca" name="PsRircerca" value='<%=strPsRicerca%>' size='15'></td>
                     <td width="30%" rowspan='2' class="textB" valign="center" align="center">
                       <input type="button" class="textB" name="Esegui" value="ESEGUI" onclick="submitFrmSearch('0');">
                     </td>
                     <td>&nbsp;</td>
 </tr>

                   </table>
                   <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorRigaDispariTabella%>">
                    <tr>
                    <td width="25%">&nbsp;</td>
                      <td class="textB" width="25%" align="right">Risultati per pag.:</td>
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
   <input type="hidden" name=cod_tipo_contr id=cod_tipo_contr value="<%=cod_tipo_contr%>">
   <input type="hidden" name=des_tipo_contr id=des_tipo_contr value="<%=des_tipo_contr%>">
   <input type="hidden" name=cod_ps id=cod_ps value="<%=cod_ps%>">
   <input type="hidden" name=cod_PS id=cod_PS value="<%=cod_ps%>">
   <input type="hidden" name=des_PS id=des_PS value="<%=des_ps%>">
   <!--input type="hidden" name=act id=act value=""-->
  <tr>
  	<td>
      <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultato di ricerca</td>
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
  
   if ((prodServ==null)||(prodServ.size()==0))
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
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>&nbsp;</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Descrizione P/S</td>
                <td colspan='3' bgcolor="<%=StaticContext.bgColorTestataTabella%>" class="white">&nbsp;</td>
              </tr>            
<%
    }
%>
            </table>
            <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">

                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=prodServ.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="cod_tipo_contr" value="<%=cod_tipo_contr%>"></pg:param>
                <pg:param name="cod_contr" value="<%=cod_contr%>"></pg:param> 
                <pg:param name="cod_ps" value="<%=cod_ps%>"></pg:param>
                <pg:param name="des_ps" value="<%=des_ps%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>

                <pg:param name="chiamante" value="<%=chiamante%>"></pg:param>
                <pg:param name="des_contr" value="<%=des_contr%>"></pg:param>
                <pg:param name="des_tipo_contr" value="<%=des_tipo_contr%>"></pg:param>

                <%
                String bgcolor="";
                String checked;  
                Object[] objs=prodServ.toArray();
                boolean first_rec=true; //11-03-03
                boolean  caricaDesc=true;
                for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<prodServ.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                {
                    ProdServElem obj=(ProdServElem)objs[i];
                    
                    if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                    else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;

                %>
                       <tr>                                                                                                      
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>

                          <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name="SelOf" value="<%=obj.getCodePs()%>" <%if (first_rec) {out.print("checked");first_rec=false;}%> onclick="ChangeSel('<%=obj.getCodePs()%>','<%=obj.getDescPs().replace('\'','Æ')%>')">
                         <%
                         if (caricaDesc)
                         {
                          caricaDesc=false;%>
                          <script language='javascript'>  
                              document.frmSearch.cod_PS_primo.value="<%=obj.getCodePs()%>"; //12-03-03 
                              document.frmSearch.des_PS_primo.value="<%=obj.getDescPs()%>"; //12-03-03 
                          </script>
                         <%}%>
                            
                        </td>
                        <td bgcolor='<%=bgcolor%>' name='des_ps' class='text'><%=obj.getDescPs()%></td>
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
                                <A HREF="<%=pageUrl%>&PsRircerca=<%=strPsRicerca%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                  <A HREF="<%=pageUrl%>&PsRircerca=<%=strPsRicerca%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                          </pg:pages>

                          <pg:next>
                                 <A HREF="<%=pageUrl%>&PsRircerca=<%=strPsRicerca%>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
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
     <td>  
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'> 
            <tr> <td colspan=5>  <sec:ShowButtons VectorName="vectorButton" />  </td> </tr>
        </table> 
     </td>
  </tr>
       
    </td>
  </tr>
</TABLE>   
</form>
<% }%>
</BODY>
</HTML>

