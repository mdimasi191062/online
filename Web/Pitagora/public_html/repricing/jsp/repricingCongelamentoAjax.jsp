<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottonSp" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"repricingCongelamentoAjax.jsp")%>
</logtag:logData>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js_ajax/ajax.js"></SCRIPT>
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
Verifica Valorizzazione Attiva
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

var valoreSelezionato;
var codeParamSelezionata;
var hasCsvSelezionato;

function lancioBatch(messaggio)
{
 var carica = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
 var asyncFunz=  function(){ handler_generico(http,carica,errore);};
 var sendMessage='codiceTipoContratto=1&elencoParam='+
                  messaggio+
                  '&codeFunz=27';
 chiamaRichiesta(sendMessage,'lancioBatchCongelaRepricing',asyncFunz);
}
function ONCONGELA_SEL()
{
  if(hasCsvSelezionato=='N')
    alert('Impossibile lanciare il Repricing.Non sono stati prodotti i CSV!');
  else
    lancioBatch(codeParamSelezionata);
}
function ONCONGELA_TUTTI()
{
    var params='';
    var i;
    if(document.formPag.options.length==null)
      ONCONGELA_SEL();
    else
    {

      for(i=0;i<document.formPag.options.length;i++)
      {
          var option=document.formPag.options[i];
          eval('funzione='+option.onclick);
          funzione();
          if(i!=0)
           params+='$';
          params+=codeParamSelezionata
          if(hasCsvSelezionato=='N')
          {
            alert('Impossibile lanciare il Repricing.Non sono stati prodotti i CSV!');
            return;
          }
      }
    
      //lancioBatch(params);
   }
}
function onChange(valore)
{

 valoreSelezionato=valore;

}

function onChangeAccount(code_param,hasCsv)
{
    codeParamSelezionata=code_param;
    hasCsvSelezionato=hasCsv;
}

function onChangeAccount(code_param,hasCsv,hasReport)
{
    codeParamSelezionata=code_param;
    hasCsvSelezionato=hasReport;
}

function setInitialValue()
{
  selezionaCodeElab.style.visibility='visible';
  selezionaCodeElab.style.display='inline';
  selezionaAccount.style.visibility='hidden';
  selezionaAccount.style.display='none';
  var headers=new Array("Code Elab","Data inizio","Data Fine","Stato");
  var valori = new Array("0");
  var carica = function(dati){riempiTabellaSelezionabile(divTabella,dati,headers,valori,'onChange');};
  var errore = function(dati){gestisciMessaggio(dati.messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('codiceTipoContratto='+<%=request.getParameter("codiceTipoContratto")%>,'listaCongelamentoRepricing',asyncFunz);
  

}
function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';
   setInitialValue();
}

function ONACCOUNT_ELAB()
{
  var colonne=new Array("Account","Stato Repricing","Report");
  var valori=new Array("1","2","3");
  var carica = function(dati){riempiTabellaSelezionabileRepricing(divTabella,dati,colonne,valori,'onChangeAccount');};
  var errore = function(dati){gestisciMessaggio(dati.messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};

  chiamaRichiesta('code_elab='+valoreSelezionato,'listaAccountCongelamentoRep',asyncFunz);
  selezionaCodeElab.style.visibility='hidden';
  selezionaCodeElab.style.display='none';
  selezionaAccount.style.visibility='visible';
  selezionaAccount.style.display='block';
}

function riempiTabellaSelezionabileRepricing(divTabella,dati,nomiColonne,posValore,onselected)
{
  
  var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
  primo='checked';
  tabella+="<tr><td></td>";
  for(i=0;i<nomiColonne.length;i++)
  {
    tabella+='<td class=\"textB\">'+nomiColonne[i]+'</td>';
  }
  tabella+="</tr>";
  if(dati.length==0)
  {
  	var valoreS='';
    for(k=0;k<posValore.length;k++)
    {
    	valoreS+='null'
      if(k!=posValore.length-1)
      	valoreS+=',';
    }
    eval(onselected+'('+valoreS+');');
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>Dati Assenti</td></tr>';
  }
  else
  {
  	for(i=0;i<dati.length;i++)
    {
      var valoreS='';
      
      for(k=0;k<posValore.length;k++)
      {
        eval('var valore=dati[i].colonna'+posValore[k]);
        valoreS+="\""+valore+"\"";
        if(k!=posValore.length-1)
          valoreS+=',';     
      }


      if(i%2==0)
        bgcol="#cfdbe9";
      else
        bgcol="#ebf0f0";
         
      tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' ><input  type="radio" '+primo+' name="options" value="'+i+'" onclick=\''+onselected+'('+valoreS +')\';></td>';
      if(i==0)
      {
        eval(onselected+'('+valoreS +');');
      }

      
        eval('colonna=dati[i].colonna'+0+';');
        tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';

        eval('colonna=dati[i].colonna'+2+';');
        if(colonna == 'S')
          colonna = 'Generato';
        else if(colonna == 'D')
          colonna = 'Errore';
        else if(colonna == 'I')
          colonna = 'Inizializzato';
        else if(colonna == 'E')
          colonna = 'Esecuzione';
        else
          colonna = 'Non richiesto';
        tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
          
        
        eval('colonna=dati[i].colonna'+3+';');
        if(colonna == 'S')
          colonna = 'Generato';
        else if(colonna == 'D')
          colonna = 'Errore';
        else if(colonna == 'I')
          colonna = 'Inizializzato';
        else if(colonna == 'E')
          colonna = 'Esecuzione';
        else
          colonna = 'Non richiesto';
        tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
        
        
      tabella+="</tr>";
      primo='';
    }
  }
  tabella+="</table>";
	
  divTabella.innerHTML=tabella;

}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<div name="orologio" id="orologio">
<%@include file="../../common/htlm_ajax/orologio.html"%>
</div>
<div name="dvMessaggio" id="dvMessaggio"  style="visibility:hidden;display:none">
<form id="frmMessaggio" name="frmMessaggio">
  <%@include file="../../common/htlm_ajax/messaggio.html"%>
</form>
</div>

<div name="maschera" id="maschera">
<form name="formPag">
                   

<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/titoloPagina.GIF" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Verifica Repricing Special</td>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
              </tr>
					  </table>
					</td>
				</tr>
      </table>
    </td>
  </tr>


  </table>
          <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
        </tr>
  <tr>
  	<td>
      <table align=center width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
       <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Risultati della ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
       
        <tr>
          <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                <div name="divTabella" id="divTabella" style="width:100%;"></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../images/pixel.gif" width="1" height='3'></td>
  </tr>
  <tr>
    <td >
       <div name="selezionaCodeElab" id="selezionaCodeElab"> <sec:ShowButtons VectorName="bottonSp" /></div>
       <div name="selezionaAccount" id="selezionaAccount" style="visibility:hidden;display:none"> <sec:ShowButtons PageName="REPRICINGCONGELAMENTOAJAX_1" /></div>
    </td>
  </tr>
</TABLE>  
                  
</form>

</BODY>
<script>
var http=getHTTPObject();
</script>
</HTML>

