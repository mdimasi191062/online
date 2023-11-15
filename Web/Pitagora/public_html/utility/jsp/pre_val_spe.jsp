<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"pre_val_spe.jsp")%>
</logtag:logData>

<EJB:useHome id="homeBatch" type="com.ejbSTL.BatchSTLHome" location="BatchSTL" />
<EJB:useHome id="homeEnt_Catalogo" type="com.ejbSTL.Ent_CatalogoHome" location="Ent_Catalogo" />
<EJB:useBean id="remoteEnt_Catalogo" type="com.ejbSTL.Ent_Catalogo" scope="session">

    <EJB:createBean instance="<%=homeEnt_Catalogo.create()%>" />
</EJB:useBean>

<EJB:useHome id="homeCtr_Utility" type="com.ejbSTL.Ctr_UtilityHome" location="Ctr_Utility" />
<EJB:useBean id="remoteCtr_Utility" type="com.ejbSTL.Ctr_Utility" scope="session">
    <EJB:createBean instance="<%=homeCtr_Utility.create()%>" />
</EJB:useBean>

<%
  int esito = 0;
  String messaggio = "";
  String act=null;
  String operazione = Misc.nh(request.getParameter("operazione"));
  BatchElem  datiBatch=null;    
  String strCodeServizio = Misc.nh(request.getParameter("comboServizi"));
  String flagTipoContr   = null;
  String accorpatoDel = "";
  String codeFunzBatch   = null;
  String codeFunzBatchNC = null;
  String codeFunzBatchRE = null;
  
  /* determino se effettuare la delete per gli accorpamenti non in esercizio eliminati */
%>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/inputValue.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/comboCange.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../elab_attive/js/ElabAttive.js"></SCRIPT>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<script language="JavaScript" src="../../common/js/calendar1.js"></script>

<SCRIPT LANGUAGE='Javascript'>

var step='';
var datiServ;
var datiGestori;
var datiAccAccorpanti;
var datiAccAccorpati;
var datiAccDisponibili;
var code_servizio='';
var code_gestore='';

var controlloAccorpati = '';
var objForm = null;
function initialize(){
    caricaServizi();
    objForm = document.formPag;
    //impostazione delle propriet? di default per tutti gli oggetti della form
    setDefaultProp(objForm);
    divIns.style.display='none';
    divIns.style.visibility='hidden';
    step='accorpanti';
}

function caricaServizi()
{
  carica = function(dati){onCaricaServizi(dati)};
  errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('codiceServizio=0','listaServizi_special',asyncFunz);
}

function onCaricaServizi(dati)
{
  riempiSelect('comboServizi',dati);
  divIns.style.visibility="visible";
  divIns.style.display="inline";
  if(dati.length==0)
  {
    document.formPag.comboServizi.style.visibility="hidden";
    document.formPag.comboServizi.style.display="none";
  }
  else
  {
    document.formPag.comboServizi.style.visibility="visible";
    document.formPag.comboServizi.style.display="inline";
  }
}


function onChangeServizio()
{
  indice= document.formPag.comboServizi.selectedIndex;
  if(indice>0)
  {
    code_servizio =document.formPag.comboServizi.options[indice].value;
    document.formPag.comboServizi.value=document.formPag.comboServizi.options[indice].text.toUpperCase();
    carica = function(dati){onCaricaGestori(dati)};
    errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
    asyncFunz=  function(){ handler_generico(http,carica,errore);};
    chiamaRichiesta('code_servizio='+code_servizio,'listaGestori_special',asyncFunz);
    document.formPag.comboServizi.value = code_servizio;
  }
}

function ONLANCIOBATCH()
{

      document.formPag.act.value="lancio_batch";

      if(document.formPag.comboServizi.value==''){
        alert('Selezionare il Servizio.');
        document.formPag.comboServizi.focus();
        return;
      }

      if(document.formPag.txtDataFineAcq.value==''){
        alert('Selezionare la Data di fine Acquisizione.');
        document.formPag.txtDataFineAcq.focus();
        return;
      } 

      Disable(formPag.LANCIOBATCH);
      document.formPag.action = "LancioPreValSp.jsp";
      document.formPag.submit();
}

function riempiSelectWithClass(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  controlloAccorpati = document.formPag.controllaAccorpati.value;
  for(a=0;a < dati.length;a++)
  {        
    eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
    eval('document.formPag.'+select+'.options[a].className=dati[a].classe;');
  }
  document.formPag.controllaAccorpati.value = controlloAccorpati;
}

function addOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
  var classe = '';
  
  if(cboSource.name == 'comboDisponibili')
    classe = 'textListRosso';
  else
    classe = 'textList';
  
	if(index != -1)
	{
		myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource));
		myOpt.className = classe;
		DelOptionByIndex(cboSource,index);
	}
}

function removeOptionToComboWithClass(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
  if(cboSource.options[index].className == 'textListRosso')
  {
    var myOpt = null;
    if(index != -1)
    {
      myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
      myOpt.className == 'textList';
      DelOptionByIndex(cboSource,index);
    }
  }else{
    alert('\tAttenzione!!!\n\nIn questa release non è possibile eliminare accorpamento già presente in esercizio.');
  }
}

function selectAllComboElementsWithClasses(Field)
	{
		var len = Field.length;
		var x=0;
		for (x=0;x<len;x++)
		{
      alert('Field.className ['+Field.className+']');
      if (Field.className == 'textListRosso'){
  			Field.options[x].selected = true;
      }
		}
	}

function ONANNULLA(){
  code_servizio='';
  document.formPag.comboServizi.value='';
}

function selectAllComboElementsLocal(Field)
{
  alert('selectAllComboElementsLocal');
  var len = Field.length;
  var x=0;
  for (x=0;x<len;x++)
  {
    alert('Field ['+x+']');
    Field.options[x].selected = true;
    alert('Field.selected ['+Field.options[x].selected+']');
  }
}
	
</SCRIPT>
<EJB:useBean id="remoteBatch" type="com.ejbSTL.BatchSTL" value="<%=homeBatch.create()%>" scope="session"></EJB:useBean>
<%
 //datiBatch=remoteBatch.getCodeFunzFlag(cod_tipo_contr,"PP",null,"S");
 datiBatch=remoteBatch.getCodeFunzFlag("51","PP",null,"S");
 if (datiBatch!=null)
 {
   codeFunzBatch = datiBatch.getCodeFunz();
   flagTipoContr=  (new Integer(datiBatch.getFlagTipoContr())).toString(); 
 }  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<title>

</title>
</head>
<BODY onload=initialize();>

<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>


<div name="maschera" id="maschera">
<form name="formPag" method="post">
<input type="hidden" name="messaggio" id="messaggio" value="<%=messaggio%>">
<input type="hidden" name="controllaAccorpati" id="controllaAccorpati" value="">
<input type="hidden" name=act                     id=act                      value="<%=act%>">
<table align=center width="90%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td><img src="../images/prevalSpe.png" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">PreValorizzazione Special</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" heigth="100%">
            <div name="divIns" id="divIns" style="visibility:hidden;display:none;" >

              <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">

                <%-- SERVIZI E ACCORPANTI - INIZIO --%>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Servizio:</td>
                        <td class="text" align="left" width="50%">
                          <select class="text" title="Servizio" id="comboServizi" name="comboServizi">                                                  
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                </tr>
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>" >
                      <tr>
                        <td class="textB" align="right" width="50%">Data Fine Periodo:</td>
                        <td class="text">
                            <input type='text' name='txtDataFineAcq' obbligatorio="si" value='' class="text" readonly >
                            <a href="javascript:showCalendar('formPag.txtDataFineAcq','');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='imgCalendar1' src="<%=StaticContext.PH_COMMON_IMAGES%>calendario.gif" border="0"></a>
                            <a href="javascript:clearField(objForm.txtDataFineAcq);" onMouseOver="javascript:showMessage('cancella');  return true;" onMouseOut="status='';return true"><img name='imgCancel1'   src="<%=StaticContext.PH_COMMON_IMAGES%>cancella.gif"   border="0"></a>
                        </td>
                      </tr>
                    </table>  
                  </td>
                </tr>
              </TABLE>
            </div>
                
          </td>
        </tr>
      </table>
    </td>
  </tr>  
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>

  <tr>
    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
            <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />        
	      </tr>
	    </table>
    </td>
  </tr>  
  
</table>

</form>
</div>
</body>
<script>
var http=getHTTPObject();

if(document.formPag.messaggio.value != "") 
    alert("<%=messaggio%>");
</script>

</html>
