<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page errorPage = "/common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.rmi.*,com.ejbBMP.*,com.utl.*,com.usr.*,java.util.Collection" %>
<sec:ChkUserAuth isModal="true" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"cbn4_dis_clas_sconto_cl.jsp")%>
</logtag:logData>
<%
  response.addHeader("Pragma", "no-cache");
  response.addHeader("Cache-Control", "no-store");
  
    //Dichiarazioni
  I5_2CLAS_SCONTOEJB remote = null;   
  String bgcolor="";
  int i=0;
  int j=0;
    // This is the variable we will store all records in.
  Collection collection=null;
  I5_2CLAS_SCONTOEJB[] aRemote = null;
  I5_2CLAS_SCONTOPK PrimaryKey    = null; 
  String code_clas_sconto = null ;
  String desc_clas_sconto;
  java.math.BigDecimal impt_min_spesa = null;
  java.math.BigDecimal impt_max_spesa = null;

  String strCodRicerca= request.getParameter("txtCodRicerca");
  String filtro =  request.getParameter("chkClsDisatt");
  String strCodClsSconto= request.getParameter("txtCodClsSconto");
  String CODE_CLAS_SCONTO= request.getParameter("CodSel");
  String data_inizio_valid = "";
  String data_fine_valid = "";  
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<EJB:useHome id="home" type="com.ejbBMP.I5_2CLAS_SCONTOEJBHome" location="I5_2CLAS_SCONTOEJB" /> 
<%
    collection = home.findAllByCodeClsSconto(CODE_CLAS_SCONTO);
    if (!(collection==null || collection.size()==0)) 
    {
      aRemote = (I5_2CLAS_SCONTOEJB[]) collection.toArray( new I5_2CLAS_SCONTOEJB[1]);
      remote = (I5_2CLAS_SCONTOEJB) PortableRemoteObject.narrow(aRemote[0],I5_2CLAS_SCONTOEJB.class);   
      java.text.SimpleDateFormat df = new java.text.SimpleDateFormat ("dd/MM/yyyy");  
      data_inizio_valid = df.format(remote.getIn_Valid());
      data_fine_valid ="";
    }  
%>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">

<!--da qui gestione calendarietto-->

// var objForm=window.document.frmDisattCls; 
var message1="Click per selezionare la data selezionata";
var message2="Click per cancellare la data selezionata";
var data_inizio_valid='<%=data_inizio_valid%>';

function cancelCalendar ()
{
   window.document.frmDisattCls.DataFine.value="";
}

function cancelLink ()
{
  return false;
}

function disableLink (link)
{
  if (link.onclick)
    link.oldOnClick = link.onclick;
  link.onclick = cancelLink;
  if (link.style)
    link.style.cursor = 'default';
}

function enableLink (link)
{
  link.onclick = link.oldOnClick ? link.oldOnClick : null;
  if (link.style)
    link.style.cursor = document.all ? 'hand' : 'pointer';
}

function showMessage (field)
{
	if (field=='seleziona')
		self.status=message1;
	else
		self.status=message2;
}

function deleteData(objs)
{
  obj = eval("document." + objs);
  obj.value="";
}



function chkDataRange(inizio,fine){
			var dataInizio = new Date(inizio.substring(6,10),inizio.substring(3,5)-1,inizio.substring(0,2));
			var dataFine = new Date(fine.substring(6,10),fine.substring(3,5)-1,fine.substring(0,2));
			if(dataFine<dataInizio)
      {
        alert("La data di fine validità deve essere maggiore o uguale alla data d'inizio validità!");
				return false;
      }
      return true;
}

function chkDataOdierna(strData){
			var dataDiOggi = new Date();
			var data = new Date(strData.substring(6,10),strData.substring(3,5)-1,strData.substring(0,2));
			if(dataDiOggi>data)
      {
        alert("La data di fine validità deve essere maggiore della data odierna!");
				return false;
      } 
      return true;
}



function ONCONFERMA()
{
  var objForm=window.document.frmDisattCls;
  if( objForm.DataFine.value.length==0){
    alert('La Data Fine Validità é obligatoria');
    return(false);
  }
	if (!chkDataOdierna(objForm.DataFine.value)){
    return(false);
  }  
	if (!chkDataRange(data_inizio_valid,objForm.DataFine.value)){
    return(false);
  }  
  if (confirm('Si conferma la disattivazione della Classe di sconto selezionata ?')==true)
  {
    Enable(objForm.DataFine);
    window.document.frmDisattCls.submit();
  }
  return(false);
}

function ONANNULLA()
{
  var bControllo= (window.document.frmDisattCls.DataFine.value.length != 0 );
  if (bControllo ) {
    if (confirm('Sono state apportate delle modifiche all\'elemento corrente.\nVuoi ignorarle?')==true){
      window.close();
    }
  }else {
    window.close();
  }      
}

</SCRIPT>


<TITLE>Disattivazione Classe Di Sconto</TITLE>
</HEAD>
<BODY BODY  onLoad='Disable(window.document.frmDisattCls.DataFine)'>
<form name="frmDisattCls" action="conf_dis_clas_scon_cl.jsp" method="POST">
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
                <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Classe di Sconto</td>
                <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/tre.gif" width="28"></td>
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
      <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
                    <tr>
                      <td bgcolor="#0A6B98" class="white" valign="top" width="91%">&nbsp;Disattivazione Classe di Sconto</td>
                      <td bgcolor="#FFFFFF" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='1'></td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CFDBE9">
                    <tr>
                      <td  class="textB" align="right" colspan="2">Codice Classe Di Sconto:&nbsp;</td>
                      <td  class="text" align="left" colspan="2"><%=CODE_CLAS_SCONTO%>
                      <input type="hidden" name="txtCodiceClsSconto" value="<%=CODE_CLAS_SCONTO%>">
                      </td>
                    </tr>   
                    <tr>
                      <td  class="textB" align="right" >Data Inizio Validità:&nbsp;</td>
                      <td  class="text"  align="left" ><%=data_inizio_valid%></td> 
                      <input type="hidden" name="DataInizio" value="<%=data_inizio_valid%>" >        
                      <td  class="textB"  align="right">Data Fine Validità:&nbsp;</td>        
                      <td  class="text" align="left">
                        <table>
                          <tr>
                          <td>
                            <% if (data_fine_valid==null) {%>
                              <input type="text" class="text" name="DataFine" size="15"  maxlength="10" onfocus='javascript:blur();'>
                            <%}else{%>
                            <input type="text" class="text" name="DataFine" value="<%=data_fine_valid%>" maxlength="10" size="10" onfocus='javascript:blur();'>
                            <%}%>        
                          </td>           
                          <td><a href="javascript:showCalendar('frmDisattCls.DataFine','sysdate');" onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img name='calendar' src="../../common/images/body/calendario.gif" border="no"></a></td>
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
    <td bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='1'></td>
  </tr>
  <tr>
    <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
        <tr>
          <td colspan='3' bgcolor="#FFFFFF"><img src="Images/pixel.gif" width="1" height='1'></td>
        </tr>
        <tr>
          <td>
            <table border="0" width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#0A6B98">
              <tr>
                <td>
                  <table width="100%" align='center' border="0" cellspacing="0" cellpadding="0">
  <% 
  if ((aRemote==null)||(aRemote.length==0))    
  {
    %>
                    <tr>
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF" colspan="3" class="textB" align="center">No Record Found</td>
                    </tr>
   <%
  } else {
  %>
                    <tr>                    
                      <td bgcolor='#D5DDF1' class="textB" height='10'>&nbsp;Descrizione</td>
                      <td bgcolor='#D5DDF1' class="textB" >Val. Minimo</td>
                      <td bgcolor='#D5DDF1' class="textB" >Val. Massimo</td>                     
                    </tr>
<%
      //Scrittura dati su lista            
      String strImpt_min_spesa=null;
      String strImpt_max_spesa=null;
      int indVirgola=0;
      int ind=0;          
      for(j=0;j<aRemote.length;j++){
        remote = (I5_2CLAS_SCONTOEJB) PortableRemoteObject.narrow(aRemote[j],I5_2CLAS_SCONTOEJB.class);                                                
        if ((i%2)==0) 
          bgcolor="#EBF0F0";
        else
          bgcolor="#CFDBE9";
        PrimaryKey    = (I5_2CLAS_SCONTOPK) remote.getPrimaryKey();  
        code_clas_sconto = PrimaryKey.getId_Cls_Sconto();
        desc_clas_sconto = remote.getDesc_Cls_Sconto();
        impt_min_spesa = null;
        impt_max_spesa = null;          
        impt_min_spesa = remote.getMin_Spesa();
        impt_max_spesa = remote.getMax_Spesa();
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
        
%>
                    <TR>                  
                      <TD bgcolor='<%=bgcolor%>' class='text' height='25'>&nbsp;<%=desc_clas_sconto%></td>
                      <TD bgcolor='<%=bgcolor%>' class='text'><%=strImpt_min_spesa%></td>
                      <TD bgcolor='<%=bgcolor%>' class='text'><%=strImpt_max_spesa%></td>                      
                    </tr>                   
                <%
        i+=1;
      }
  }
%>
                    <tr> 
                      <td colspan='3' bgcolor="#FFFFFF"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
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
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr>
      <sec:ShowButtons td_class="textB" td_bgcolor="#D5DDF1" td_align="center" />
  </tr>
</table>
</form>
</BODY>
</HTML>
