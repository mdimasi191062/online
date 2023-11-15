<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.usr.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="BOTTONI" />
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"EliminaTariffeSp.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

//INIZIO Parametri passati dal chiamante

    String descTipoContratto=request.getParameter("hidDescTipoContratto");
if (descTipoContratto==null) descTipoContratto=request.getParameter("descTipoContratto");
if (descTipoContratto==null) descTipoContratto=(String)session.getAttribute("hidDescTipoContratto");
//System.out.println("inizio descTipoContratto: "+descTipoContratto);

//descrizione listino
String descContratto  = request.getParameter("descContratto");
if (descContratto==null) descContratto=request.getParameter("descContratto");
if (descContratto==null) descContratto=(String)session.getAttribute("descContratto");
//System.out.println("inizio descContratto: "+descContratto);

//codice Tariffa 
String codeTariffa  = request.getParameter("codeTariffa");
if (codeTariffa==null) codeTariffa=request.getParameter("codeTariffa");
if (codeTariffa==null) codeTariffa=(String)session.getAttribute("codeTariffa");
//System.out.println("inizio codeTariffa: "+codeTariffa);

//descrizione Tariffa 
String descTariffa  = request.getParameter("descTariffa");
if (descTariffa==null) descTariffa=request.getParameter("descTariffa");
if (descTariffa==null) descTariffa=(String)session.getAttribute("descTariffa");
//System.out.println("inizio descTariffa: "+descTariffa);

String progTariffa  = request.getParameter("progTariffa");
if (progTariffa==null) progTariffa=request.getParameter("progTariffa");
if (progTariffa==null) progTariffa=(String)session.getAttribute("progTariffa");
//System.out.println("inizio progTariffa: "+progTariffa);

String Tar = request.getParameter("Tar");
if (Tar==null) Tar=request.getParameter("Tar");
if (Tar==null) Tar=(String)session.getAttribute("Tar");
//System.out.println("inizio Tar: "+Tar);

String numTar = request.getParameter("numTar");
if (numTar==null) numTar=request.getParameter("numTar");
if (numTar==null) numTar=(String)session.getAttribute("numTar");
//System.out.println("inizio numTar: "+numTar);

String numTarZ = request.getParameter("numTarZ");
//if (numTarZ==null) numTarZ=request.getParameter("numTarZ");
if (numTarZ==null) numTarZ=(String)session.getAttribute("numTarZ");

String numTarI = request.getParameter("numTarI");
//if (numTarI==null) numTarI=request.getParameter("numTarI");
if (numTarI==null) numTarI=(String)session.getAttribute("numTarI");

String Insert = request.getParameter("Insert");
if (Insert==null) Insert=request.getParameter("Insert");
if (Insert==null) Insert=(String)session.getAttribute("Insert");
//System.out.println("inizio Insert: "+Insert);
Collection Tariffe = (Collection) session.getAttribute("Tariffe");
Collection Tariffe_appo = (Collection) session.getAttribute("Tariffe_appo");
Collection Tariffe_copia = (Collection) session.getAttribute("Tariffe_copia");
Collection Tariffe_ins = (Collection) session.getAttribute("Tariffe_ins");
Collection Tariffe_ins_appo = (Collection) session.getAttribute("Tariffe_ins_appo");   
//System.out.println("Tariffe inizio: "+Tariffe.size());
//System.out.println("Tariffe_ins inizio: "+Tariffe_ins.size());
//System.out.println("Tariffe_appo inizio: "+Tariffe_appo.size());
//System.out.println("Tariffe_ins_appo inizio: "+Tariffe_ins_appo.size());

//memorizzo il numero delle tariffe
String memo = request.getParameter("memo");

String act=request.getParameter("act");
//if (act==null) act=request.getParameter("act");
if (act==null) act=(String)session.getAttribute("act");

// Lettura dell'indice Combo Numero Record
int index = 0;
String strIndex = request.getParameter("txtnumRec");
if (strIndex!=null)
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

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad = 0;
String strtypeLoad = request.getParameter("typeLoad");
if (strtypeLoad!=null)
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Elimina Tariffe
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
  <script src="<%=StaticContext.PH_COMMON_JS%>browserType.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>comboCange.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>inputValue.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>paginatore.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>viewState.js" type="text/javascript"></script>
	<script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>
IExplorer = document.all?true:false;
Navigator = document.layers?true:false;

var SelCodeTariffa = "";
var SelProgTariffa = "";

function submitFrmSearch(typeLoad)
{
  document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
  document.frmSearch.typeLoad.value=typeLoad;
  submitME();
}

function submitME()
{

  orologio.style.visibility='visible';
  orologio.style.display='inline';

  maschera.style.visibility='hidden';
  maschera.style.display='none';
  
  document.frmSearch.submit();
}

 function setInitialValue()
 {
  //Setta il numero di record  
  eval('document.frmSearch.numRec.options[<%=index%>].selected=true');
  //Setta il primo elemento della lista
  if (document.frmSearch.numTarZ.value == "null")
      Disable(document.frmSearch.CONFERMA);
  if (String(document.frmSearch.SelCodeTariffa)!="undefined")
  {
    if (document.frmSearch.SelCodeTariffa.lenght=="undefined")
    {
      document.frmSearch.SelCodeTariffa.checked=true; 
    }
    else
    {
      if (document.frmSearch.SelCodeTariffa[1])
      {
         document.frmSearch.SelCodeTariffa[0].checked=true;
         SelCodeTariffa = document.frmSearch.SelCodeTariffa[0].value;
         SelProgTariffa = document.frmSearch.SelProgTariffa[0].value;
         document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa[0].value;
         document.frmSearch.progTariffa.value = document.frmSearch.SelProgTariffa[0].value;
      }
      else   
      {
         SelCodeTariffa = document.frmSearch.SelCodeTariffa.value;
         SelProgTariffa = document.frmSearch.SelProgTariffa.value; 
         document.frmSearch.codeTariffa.value = document.frmSearch.SelCodeTariffa.value;         
         document.frmSearch.progTariffa.value = document.frmSearch.SelProgTariffa.value; 
      }
    }
  }
 }

function ChangeSel(SelCodeTariffa, SelProgTariffa)
{
  document.frmSearch.SelCodeTariffa.value = SelCodeTariffa;
  document.frmSearch.SelProgTariffa.value = SelProgTariffa;
  document.frmSearch.codeTariffa.value = SelCodeTariffa;
  document.frmSearch.progTariffa.value = SelProgTariffa;
}

 function ONELIMINA()
 {
   document.frmSearch.txtnumRec.value=document.frmSearch.numRec.selectedIndex;
   document.frmSearch.act.value = "ELIMINA";
   Enable(document.frmSearch.CONFERMA);
   //document.frmSearch.submit();
   submitME();
 } 

 function ONANNULLA()
 {
   self.close();
 }

 function ONCONFERMA()
 {
   if (document.frmSearch.numTarZ.value == "null")
       alert('Nessuna operazione effettuata');
   else
   {
       opener.document.frmSearch.act.value = "CONFERMA_ELIM";
       opener.document.frmSearch.Insert.value = "SEL";
       self.close();
       opener.dialogWin.returnFunc();
   }
 }

</SCRIPT>
</HEAD>
<BODY onload="setInitialValue();">

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio" style="visibility:hidden;display:none">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>

<div name="maschera" id="maschera" style="visibility:display;display:inline">

<!--<EJB:useHome id="home3" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />-->
<%
//  //System.out.println("act on load: "+act);

   if (act == null)
   {
       Tariffe_ins_appo = new Vector();
       Tariffe_appo = new Vector();
   }
    session.setAttribute("Tariffe_ins_appo", Tariffe_ins_appo);
    session.setAttribute("Tariffe_appo", Tariffe_appo);

//System.out.println("Tariffe_appo i: "+Tariffe_appo.size());
//System.out.println("Tariffe_ins_appo i: "+Tariffe_ins_appo.size());

if (!Insert.equalsIgnoreCase(""))
{
    Object[] objs_ins = new Object[0];
    if (Insert.equalsIgnoreCase("SEL"))
    {
        objs_ins = Tariffe_ins.toArray();
        for (int i=0;i<Tariffe_ins.size();i++)
        {
              /*/TariffaBMP objsTar=(TariffaBMP)objs_ins[i];
              ClassTariffeElem elemSel=new  ClassTariffeElem();
              elemSel.setImpTar(((TariffaBMP)objs[i]).getImpTar());
              elemSel.setDataCreazTar(((TariffaBMP)objs[i]).getDataCreazTar());
              elemSel.setProgTar(((TariffaBMP)objs[i]).getProgTar());  
              elemSel.setImpMinSps(((TariffaBMP)objs[i]).getImpMinSps());
              elemSel.setImpMaxSps(((TariffaBMP)objs[i]).getImpMaxSps());
              elemSel.setCodTar(((TariffaBMP)objs[i]).getCodTar());  
              elemSel.setFlgMat(((TariffaBMP)objs[i]).getFlgMat());
              elemSel.setCodClSc(((TariffaBMP)objs[i]).getCodClSc());
              elemSel.setPrClSc(((TariffaBMP)objs[i]).getPrClSc());  
              elemSel.setCodUM(((TariffaBMP)objs[i]).getCodUM());
              elemSel.setDescUM(((TariffaBMP)objs[i]).getDescUM());
              elemSel.setCodOf(((TariffaBMP)objs[i]).getCodOf());  
              elemSel.setDescOf(((TariffaBMP)objs[i]).getDescOf());
              elemSel.setCodPs(((TariffaBMP)objs[i]).getCodPs());
              elemSel.setDescEsP(((TariffaBMP)objs[i]).getDescEsP());  
              elemSel.setDescTipoCaus(((TariffaBMP)objs[i]).getDescTipoCaus());
              elemSel.setDataIniTar(((TariffaBMP)objs[i]).getDataIniTar());
              elemSel.setDataFineTar(((TariffaBMP)objs[i]).getDataFineTar());  
              elemSel.setDescTar(((TariffaBMP)objs[i]).getDescTar());
              elemSel.setCodTipoCaus(((TariffaBMP)objs[i]).getCodTipoCaus());
              elemSel.setCodContr(((TariffaBMP)objs[i]).getCodContr());  
              elemSel.setDescContr(((TariffaBMP)objs[i]).getDescContr());  */
              Tariffe_ins_appo.add(objs_ins[i]);
        }
    }    
    if (Insert.equalsIgnoreCase("TUTTI"))        
    {
        objs_ins = Tariffe_copia.toArray();
        for (int i=0;i<Tariffe_copia.size();i++)
        {
              /*/TariffaBMP objsTar=(TariffaBMP)objs_ins[i];
              ClassTariffeElem elemTutti=new  ClassTariffeElem();
              elemTutti.setImpTar(((TariffaBMP)objs[i]).getImpTar());
              elemTutti.setDataCreazTar(((TariffaBMP)objs[i]).getDataCreazTar());
              elemTutti.setProgTar(((TariffaBMP)objs[i]).getProgTar());  
              elemTutti.setImpMinSps(((TariffaBMP)objs[i]).getImpMinSps());
              elemTutti.setImpMaxSps(((TariffaBMP)objs[i]).getImpMaxSps());
              elemTutti.setCodTar(((TariffaBMP)objs[i]).getCodTar());  
              elemTutti.setFlgMat(((TariffaBMP)objs[i]).getFlgMat());
              elemTutti.setCodClSc(((TariffaBMP)objs[i]).getCodClSc());
              elemTutti.setPrClSc(((TariffaBMP)objs[i]).getPrClSc());  
              elemTutti.setCodUM(((TariffaBMP)objs[i]).getCodUM());
              elemTutti.setDescUM(((TariffaBMP)objs[i]).getDescUM());
              elemTutti.setCodOf(((TariffaBMP)objs[i]).getCodOf());  
              elemTutti.setDescOf(((TariffaBMP)objs[i]).getDescOf());
              elemTutti.setCodPs(((TariffaBMP)objs[i]).getCodPs());
              elemTutti.setDescEsP(((TariffaBMP)objs[i]).getDescEsP());  
              elemTutti.setDescTipoCaus(((TariffaBMP)objs[i]).getDescTipoCaus());
              elemTutti.setDataIniTar(((TariffaBMP)objs[i]).getDataIniTar());
              elemTutti.setDataFineTar(((TariffaBMP)objs[i]).getDataFineTar());  
              elemTutti.setDescTar(((TariffaBMP)objs[i]).getDescTar());
              elemTutti.setCodTipoCaus(((TariffaBMP)objs[i]).getCodTipoCaus());
              elemTutti.setCodContr(((TariffaBMP)objs[i]).getCodContr());  
              elemTutti.setDescContr(((TariffaBMP)objs[i]).getDescContr());  */
              Tariffe_ins_appo.add(objs_ins[i]);
        }
    }    
}
Insert = "X";
   
if (memo==null)
{
    Integer numTarS = new Integer(Tariffe_ins_appo.size());
    numTar = numTarS.toString();
    Integer numTar2 = new Integer(Tariffe_ins.size());
    numTarI = numTar2.toString();
    memo = "M";
}   

   if (act != null && act.equalsIgnoreCase("ELIMINA"))
   {
        if (Tariffe_ins_appo != null)
        {
            Object[] objs_ins = Tariffe_ins_appo.toArray();
            Integer numTarZs = new Integer(Tariffe_ins_appo.size());
            numTarZ = numTarZs.toString();
            String codTarIns = "";
            String progTarIns = "";            
            for(int i=0;i < numTarZs.intValue();i++)
            {
              //TariffaBMP objsTar=(TariffaBMP)objs_ins[i];
              ClassTariffeElem elemX=new  ClassTariffeElem();
              elemX.setProgTar(((TariffaBMP)objs_ins[i]).getProgTar());  
              elemX.setCodTar(((TariffaBMP)objs_ins[i]).getCodTar());  
              codTarIns = elemX.getCodTar();
              progTarIns = elemX.getProgTar();             
              if (codeTariffa.equals(codTarIns) &&
                  progTariffa.equals(progTarIns))
              {
                  Tariffe_ins_appo.remove(objs_ins[i]);
                  Tariffe_appo.add(objs_ins[i]);
              }
            }
            //session.setAttribute("Tariffe_ins_appo", Tariffe_ins_appo);
            //session.setAttribute("Tariffe_appo", Tariffe_appo);
        }
   }

//System.out.println("2 Tariffe: "+Tariffe.size());
//System.out.println("2 Tariffe_appo: "+Tariffe_appo.size());
//System.out.println("2 Tariffe_ins: "+Tariffe_ins.size());
//System.out.println("2 Tariffe_ins_appo: "+Tariffe_ins_appo.size());
%>
<form name="frmSearch" onsubmit="submitFrmSearch('0');return false" method="get" action="EliminaTariffeSp.jsp">
<table width="90%" align=center border="0" cellspacing="0" cellpadding="0" >
<input type="hidden" name="descTipoContratto" id=descTipoContratto value= "<%=descTipoContratto%>">
<input type="hidden" name="descContratto" id=descContratto value= "<%=descContratto%>">  
<input type="hidden" name="codeTariffa" id=codeTariffa value= "<%=codeTariffa%>"> 
<input type="hidden" name="progTariffa" id=progTariffa value= "<%=progTariffa%>"> 
<input type="hidden" name="descTariffa" id=descTariffa value= "<%=descTariffa%>"> 
<input type="hidden" name="act"         id=act         value= "<%=act%>"> 
<input type="hidden" name="numTarZ"     id=numTarZ     value= "<%=numTarZ%>">
<input type="hidden" name="numTar"      id=numTar      value= "<%=numTar%>">
<input type="hidden" name="numTarI"     id=numTarI     value= "<%=numTarI%>">
<input type="hidden" name="Tar"         id=Tar         value= "<%=Tar%>">
<input type="hidden" name="Insert"      id=Insert      value= "<%=Insert%>">
 <tr>
   <td><img src="../images/titoloPagina.gif" alt="" border="0">
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
             <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
               <tr>
                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Ribaltamento Listino</td>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
               </tr>
        	   </table>               
           </td>
        </tr>
	   </table>
   </td>
 </tr>
<!--/table-->
<tr>
  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='13'></td>
</tr>
<tr>
    <td>
	    <table width="90%" border="0" cellspacing="0" cellpadding="1" align='center' bgcolor="<%=StaticContext.bgColorHeader%>"> 
        <tr>
					<td>
             <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">Riepilogo</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </td>
</tr>
<tr> 
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
</tr>
<tr>
 	 <td>
	    <table  width="90%" border="0" cellspacing="0" cellpadding="0" align='center' bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                       <td width="20%" class="textB" align="left">&nbsp;Tipo contratto:&nbsp;
                       </td>   
                       <td width="70%" class="text" align="left"> <%=descTipoContratto.replace('~',' ')%>
                       </td>   
                       <td width="10%" class="text" align="left">&nbsp;
                       </td>   
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                  <td colspan='3' > &nbsp; </td>
              </tr> 
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                    <tr>
                       <td width="20%" class="textB" align="left">&nbsp;Listino:&nbsp;
                       </td>   
                       <td width="70%" class="text" align="left"> <%=descContratto.replace('~',' ')%>
                       </td>   
                       <td width="10%" class="text" align="left">&nbsp;
                       </td>   
                    </tr>
                  </table>
                </td>
              </tr>
<%//inizio risultati per pag%>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <!--tr>
                             <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
                          </tr--> 
                              <tr>
                                <input type="hidden" name="txtnumPag" value="1">
                                <input type="hidden" name="typeLoad" value="0">
                                <input type="hidden" name="txtnumRec" value="0">
                              </tr>
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
<%//fine risultati per pag%>
                    <tr> 
                        <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
<%//inizio lista tariffe%>
                    <tr>
                      <td>
                        <table width="100%" border="0" align="center" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                          <tr>
                            <td>
                              <table width="100%" border="0" align="center" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
                                <tr>
                                  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista tariffe</td>
                                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                     <tr>
                       <td> 
                        <table align=center width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaGenerale%>">
                          <tr> 
                            <td> 
                              <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td colspan='8' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                                </tr>
<%
         Integer numG = new Integer(Tariffe_ins_appo.size());
         numTar = numG.toString();

          if ((Tariffe_ins_appo==null)||(Tariffe_ins_appo.size()==0))
          {
%>
                                <SCRIPT LANGUAGE='Javascript'> document.frmSearch.Tar.value = "0";</SCRIPT>
                                <tr> 
                                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="8" class="textB" align="center"></td>
                                </tr>
<%
          }
          else
          {
%>
                                <SCRIPT LANGUAGE='Javascript'> document.frmSearch.Tar.value = "1";</SCRIPT>
                                <tr> 
                                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class='white'>&nbsp;</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Prodotto/Servizio </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Ogg.di Fatt. </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Causale </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Tipo Opzione</td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Importo </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data inizio </td>
                                  <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data fine </td>
                                </tr>
                                   <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=Tariffe_ins_appo.size()%>"> 
                                   <pg:param name="descTipoContratto" value="<%=descTipoContratto%>"></pg:param>             
                                   <pg:param name="Tar" value="<%=Tar%>"></pg:param>                            
                                   <pg:param name="typeLoad" value="1"></pg:param> 
                                   <pg:param name="txtnumRec" value="<%=index%>"></pg:param> 
                                   <pg:param name="numRec" value="<%=strNumRec%>"></pg:param> 

                                   <pg:param name="descContratto" value="<%=descContratto%>"></pg:param> 
                                   <pg:param name="codeTariffa" value="<%=codeTariffa%>"></pg:param> 
                                   <pg:param name="progTariffa" value="<%=progTariffa%>"></pg:param> 
                                   <pg:param name="strNumRec" value="<%=strNumRec%>"></pg:param> 
                                   <pg:param name="index" value="<%=index%>"></pg:param> 
                                   <pg:param name="Insert" value="<%=Insert%>"></pg:param> 
                                   <pg:param name="memo" value="<%=memo%>"></pg:param> 

                                    <%
                                         String bgcolor="";
                                         String checked;  
                                         Object[] objs=Tariffe_ins_appo.toArray();
                                         //Lista Tariffe 
                                         //System.out.println("in lista tariffe Tariffe_ins_appo.size: "+Tariffe_ins_appo.size());
                                         //if ((Tariffe_ins_appo!=null)&&(Tariffe_ins_appo.size()!=0))
                                         //{
                                            // Visualizzo elementi
                                            for(int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<Tariffe_ins_appo.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                                            {
                                             //TariffaBMP objtar=(TariffaBMP)objs[i];
                                              ClassTariffeElem elemTar=new  ClassTariffeElem();
                                              elemTar.setImpTar(((TariffaBMP)objs[i]).getImpTar());
                                              elemTar.setProgTar(((TariffaBMP)objs[i]).getProgTar());  
                                              elemTar.setCodTar(((TariffaBMP)objs[i]).getCodTar());  
                                              elemTar.setCodOf(((TariffaBMP)objs[i]).getCodOf());  
                                              elemTar.setDescOf(((TariffaBMP)objs[i]).getDescOf());
                                              elemTar.setDescEsP(((TariffaBMP)objs[i]).getDescEsP());  
                                              elemTar.setDescTipoCaus(((TariffaBMP)objs[i]).getDescTipoCaus());
                                             // 11-02-03 viti
                                              elemTar.setDescTipoOpz(((TariffaBMP)objs[i]).getDescTipoOpz());
                                              elemTar.setDataIniTar(((TariffaBMP)objs[i]).getDataIniTar());
                                              elemTar.setDataFineTar(((TariffaBMP)objs[i]).getDataFineTar());  
                                              elemTar.setCodTipoCaus(((TariffaBMP)objs[i]).getCodTipoCaus());
                                             
                                               if ((i%2)==0)
                                                   bgcolor=StaticContext.bgColorRigaPariTabella;
                                               else
                                                   bgcolor=StaticContext.bgColorRigaDispariTabella;
                                    %>
                                             <tr> 
                                                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'> 
                                                  <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='SelCodeTariffa' checked = 'true' value='<%=elemTar.getCodTar()%>' onClick="ChangeSel('<%=elemTar.getCodTar()%>','<%=elemTar.getProgTar()%>')">
                                                  <input type='hidden'  name='SelProgTariffa' value='<%=elemTar.getProgTar()%>'>                                                  
                                                </td>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="23%"><%=elemTar.getDescEsP()%></td>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="15%"><%=elemTar.getDescOf()%></td>
                                    <%  
                                               if (elemTar.getDescTipoCaus().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=elemTar.getDescTipoCaus()%></td>
                                    <%    
                                               }
                                       // 11-02-03 viti     
                                               if (elemTar.getDescTipoOpz().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="11%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="11%"><%=elemTar.getDescTipoOpz()%></td>
                                    <%    
                                               }
                                    %>
    
                                                <td bgcolor="<%=bgcolor%>" class='text' width="12%"><%=CustomNumberFormat.setToCurrencyFormat(elemTar.getImpTar().toString(),4)%></td>
                                    <%  
                                               if (elemTar.getDataIniTar().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%"><%=elemTar.getDataIniTar()%></td>
                                    <%    
                                               }
                                               if (elemTar.getDataFineTar().trim().equals(""))
                                               { 
                                    %>
                                                <td bgcolor="<%=bgcolor%>" class='text' width="13%">&nbsp;</td>
                                    <%    
                                               } 
                                               else
                                               {
                                    %>
                                                <td bgcolor='<%=bgcolor%>' class='text' width="13%"><%=elemTar.getDataFineTar()%></td>
                                             </tr>
                                    <%    
                                               }
                                           }
                                        //}   
                                    %>
                                   <pg:index> 
                                      <tr> 
                                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="8" class="text" align="center"> Risultati Pag. 
                                          <pg:prev> 
                                          <%pageUrl=pageUrl+"&act="+act;%>
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< 
                                          Prev]</a> 
                                          </pg:prev> <pg:pages> 
                                    <% 
                                                    if (pageNumber == pagerPageNumber) 
                                                      {
                                    %>
                                          <b><%= pageNumber %></b>&nbsp; 
                                    <% 
                                                      }
                                                   else
                                                      {
                                                   pageUrl=pageUrl+"&act="+act;
                                    %>
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></a>&nbsp; 
                                    <%
                                                      } 
                                    %>
                                          </pg:pages> 
                                          <pg:next> 
                                          <%pageUrl=pageUrl+"&act="+act;%>
                                          <a href="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next 
                                          >>]
                                          </a> 
                                          </pg:next> 
                                          </td>
                                      </tr>
                                    </pg:index> 
                                  </pg:pager> 
                                    <%
                                    //}//chiusura dell if
                      }
          %>
                                    <tr> 
                                      <td colspan='8' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="2" height='3'></td>
                                    </tr>
                                    <tr> 
                                      <td colspan='8' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="2" height='3'></td>
                                    </tr>
                                  </td>
                                </tr>
                              </table>
                            </td> 
                          </tr>
                        </table> 
                      </td>
                    </tr> 
<%//fine lista tariffe%>
            </table>
          </td>
        </tr>
        <tr>
          <td colspan='2' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="3" height='2'></td>
        </tr>
    </table>
  </td>
</tr>
</table>

<tr> 
  <td>
    <table width="90%" align=center border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorHeader%>">
       <tr> 
         <td>
           <sec:ShowButtons VectorName="BOTTONI" /> 
         </td>  
       </tr>
    </table>       
 </td>  
</tr>
</form>
</div>
</BODY>
</HTML>
