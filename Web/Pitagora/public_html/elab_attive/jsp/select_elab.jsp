<%@ page contentType="text/html;charset=windows-1252"%>
<%@ include file="../../common/jsp/gestione_cache.jsp"%>
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
<%@ page errorPage="../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="com.usr.*"%>
<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB"%>
<%@ taglib uri="/webapp/logtag" prefix="logtag"%>
<%@ taglib uri="/webapp/sec" prefix="sec"%>
<sec:ChkUserAuth/>
<EJB:useHome id="homeCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttiveHome" location="Ctr_ElabAttive"/>
<EJB:useBean id="remoteCtr_ElabAttive" type="com.ejbSTL.Ctr_ElabAttive" scope="session">
  <EJB:createBean instance="<%=homeCtr_ElabAttive.create()%>"/>
</EJB:useBean>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
  <%=  StaticMessages.getMessage(3006,"select_elab.jsp")%>
</logtag:logData>
<%  
  Vector vctElabAttive = null;
  Vector vctPeriodoRif = null;
  DB_ElabAttive objElabAttiva = null;
  DB_PeriodoRiferimento objPeriodoRif = null;
  vctElabAttive = remoteCtr_ElabAttive.getElabAttive();
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252"/>
    <LINK REL="stylesheet" HREF="<%=StaticContext.PH_CSS%>Style.css" TYPE="text/css"/>
    <script src="<%=StaticContext.PH_ELAB_ATT_JS%>ElabAttive.js" type="text/javascript"></script>
    <script src="<%=StaticContext.PH_COMMON_JS%>validateFunction.js" type="text/javascript"></script>
    <script src="<%=StaticContext.PH_COMMON_JS%>calendar.js" type="text/javascript"></script>
    <script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
    <title></title>
  </head>
  <SCRIPT LANGUAGE="JavaScript" type="text/javascript">

    function isLeapYear(yr) {
      return new Date(yr,2-1,29).getDate()==29;
    }

    
    function controllaDataFineCiclo(){    
       var dataDB =  window.document.frmDati.elabPreinve_dataFineCiclo.value;
       var tokensDB = dataDB.split("-");

       var annoDB = tokensDB[0];
       var meseDB = tokensDB[1];
       var giornoDB = tokensDB[2];
       
       var dataIns =  window.document.frmDati.txtDataELABORAZIONE_PREINVENTARIO.value;
       var tokensIns = dataIns.split("/");
       var annoIns   = tokensIns[2];
       var meseIns   = tokensIns[1];
       var giornoIns = tokensIns[0];      
/*
       alert('annoIns ['+annoIns+']');
       alert('meseIns ['+meseIns+']');
       alert('giornoIns ['+giornoIns+']');
       
       alert('annoDB ['+annoDB+']');
       alert('meseDB ['+meseDB+']');
       alert('giornoDB ['+giornoDB+']');
*/       
       if(eval(annoIns) > eval(annoDB)){
         return false;
       }else if(eval(annoIns) < eval(annoDB)){
         return false;
       }else{
         if(eval(meseIns) > eval(meseDB)){
            return false;
         }else if(eval(meseIns) < eval(meseDB)){
            return false;
         }else{
            if(eval(giornoIns) > eval(giornoDB)){
              return false;
            }else{
              return true;
            }
         }
       }
    }
    
    function cboperiodoRifChange(obj){
      var opt = obj.options[obj.selectedIndex];
      document.frmDati.txtDataFineCiclo.value = opt.strDataFineCiclo;
    }
    
    function ONSELEZIONA(){
        if(validazioneCampi(frmDati)){
          var submit = '<%=request.getParameter("submit")%>';
          if(window.document.frmDati.CodeFunz_HIDDEN.value != undefined && 
             window.document.frmDati.CodeFunz_HIDDEN.value == "ELABORAZIONE_PREINVENTARIO" &&
             submit != "elab_ver.jsp"){
            var controllo = controllaDataFineCiclo();
            if (controllo){
              for(i=0;i<document.all('CodeFunz').length;i++){
                if(document.all('CodeFunz')[i].checked==true)
                  break;
              }
              if(i==document.all('CodeFunz').length){
                alert('Occorre selezionare un\'elaborazione.');
                return;
              }
              frmDati.action = '<%=request.getParameter("submit")%>';
              frmDati.submit();
            }else{
              alert("Attenzione!!! La Data Fine Elaborazione deve essere compresa nel Ciclo di Riferimento");
            }
          }else{
            for(i=0;i<document.all('CodeFunz').length;i++){
              if(document.all('CodeFunz')[i].checked==true)
                break;
            }
            if(i==document.all('CodeFunz').length){
              alert('Occorre selezionare un\'elaborazione.');
              return;
            }
            frmDati.action = '<%=request.getParameter("submit")%>';
            frmDati.submit();
          }
        }
    }

    function setCodeFunzHidden(obj){
       if(obj.value == "ELABORAZIONE_PREINVENTARIO"){
          window.document.frmDati.CodeFunz_HIDDEN.value = obj.value;
       }else{
          window.document.frmDati.CodeFunz_HIDDEN.value = "";
       }
    }

    function controllo(){
       var combo = window.document.frmDati.cboPeriodoRifELABORAZIONE_PREINVENTARIO.value;
       if(combo != '[Ciclo di Riferimento]'){
         return true;
       }else{
         alert("Attenzione!! Selezionare il Ciclo di Riferimento");
         return false;
       }
    }
    
  </SCRIPT>
  <form name="frmDati" method="get" action="">
  <body>
    <input type="hidden" name="txtDataFineCiclo">
    <TABLE width="90%" height="100%" border="0" cellspacing="0" cellpadding="1" align="center">
      <tr height="30">
        <td>
          <table width="100%">
            <tr>
              <td>
               <%if(request.getParameter("submit").equals("elab_run.jsp")){%>
                <img src="../images/LancioElaborazione.GIF" alt="" border="0"/>
               <%} else {%>
               <img src="../images/VerificaElaborazione.GIF" alt="" border="0"/>
               <%}%>
               </td>
            </tr>
          </table>
        </td>
        <td/>
      </tr>
      <TR height="20">
        <TD>
          <TABLE width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white">Seleziona elaborazione</TD>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>tre.gif" width="28"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR height="20">
        <TD>
          <TABLE width="90%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>" align="center">
            <TR align="center">
              <TD bgcolor="<%=StaticContext.bgColorHeader%>" class="white"/>
              <TD bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%">
                <IMG alt="tre" src="<%=StaticContext.PH_COMMON_IMAGES%>quad_blu.gif"/>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR>
      <TR>
        <TD valign="top">
          <TABLE width="90%" border="0" cellspacing="0" cellpadding="2" align="center" >
          <% 
          String classRow = "row2";
          String strObbligatorio = "";
          for(int i=0;i<vctElabAttive.size();i++){
            classRow = classRow.equals("row2") ? "row1" : "row2";
            objElabAttiva = (DB_ElabAttive)vctElabAttive.get(i);
          %>
            <TR  class="<%=classRow%>">
              <TD width="10">
                <input type="radio" name="CodeFunz" value="<%=objElabAttiva.getCODE_FUNZ()%>" onClick="clickOptElab(this);setCodeFunzHidden(this);">
                <%
                if(objElabAttiva.getCODE_FUNZ().equals("ELABORAZIONE_PREINVENTARIO")){
                   %>
                   <input type="hidden" name="CodeFunz_HIDDEN" value="">
                   <%
                }
                %>
              </TD>
              <TD width="">
                <%=objElabAttiva.getDESC_FUNZ()%>
              </TD>
              <% if(request.getParameter("submit").equals("elab_run.jsp")){%>
              <TD align="right">
                <%
                if(objElabAttiva.getPERIODO_RIFERIMENTO_VISIBLE().equals("S")){
                  vctPeriodoRif = remoteCtr_ElabAttive.getPeriodoRiferimento(objElabAttiva.getQUERY_PERIODO_RIFERIMENTO());

                  if(objElabAttiva.getQUERY_GESTORE_NEED_PER_RIF().equals("S") || 
                      objElabAttiva.getQUERY_SERVIZIO_NEED_PER_RIF().equals("S") ||
                      objElabAttiva.getQUERY_ACCOUNT_NEED_PER_RIF().equals("S")){

                      strObbligatorio = "si";
                  }else{
                      strObbligatorio = "no";
                  }
                if(objElabAttiva.getCODE_FUNZ().equals("ELABORAZIONE_PREINVENTARIO")){
                    //for(int x=0;x<vctPeriodoRif.size();x++){
                      objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(0);
                      %>

                      <%--<Font style="visibility:hidden" id="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>" name="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>">
                      Ciclo di Riferimento: <b><%=objPeriodoRif.getDESCRIZIONE_CICLO()%></b>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      </Font>--%>
                      
                      <Select style="visibility:hidden" name="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>" id="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>" class="text" obbligatorio="<%=strObbligatorio%>" label="Ciclo di riferimento" onchange="cboperiodoRifChange(this)">
                      <%
                      String strCmbValue = "";                
                      if  ( objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_CSV_REPR) || 
                            objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR)
                          ) {
                          strCmbValue = "[Data di Elaborazione]";
                      }
                      else {
                          strCmbValue = "[Ciclo di Riferimento]";
                      }%>
                        <option value="<%=strCmbValue%>"><%=strCmbValue%></option>
                        <%
                        for(int z=0;z<vctPeriodoRif.size();z++){
                          objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                          %>
                          <option value="<%=objPeriodoRif.getDESCRIZIONE_CICLO()%>">
                            <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                          </option>
                          <%
                        }
                      %>
                      </Select>
                      <input type="hidden" name="elabPreinve_dataFineCiclo" value="<%=objPeriodoRif.getTXT_DATA_FINE_CICLO().substring(0,10)%>">
                      <%
                    //}
                }else{
                %>
                <Select style="visibility:hidden" name="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>" id="cboPeriodoRif<%=objElabAttiva.getCODE_FUNZ()%>" class="text" obbligatorio="<%=strObbligatorio%>" label="Ciclo di riferimento" onchange="cboperiodoRifChange(this)">
                  <%String strCmbValue = "";                
                  if  ( objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_CSV_REPR)  || 
                        objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SWN_REPR)  ||
                        objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_REPRICING) || 
                        objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
                  ) {
                        strCmbValue = "[Data di Elaborazione]";
                  }
                  else {
                        strCmbValue = "[Ciclo di Riferimento]";
                  }%>
                  <option value="<%=strCmbValue%>"><%=strCmbValue%></option>
                  <%
                    for(int z=0;z<vctPeriodoRif.size();z++){
                      objPeriodoRif = (DB_PeriodoRiferimento)vctPeriodoRif.get(z);
                      if(objPeriodoRif.getCODE_CICLO().equals("") && 
                         (!objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_REPRICING) &&
                          !objElabAttiva.getCODE_FUNZ().equals(StaticContext.RIBES_J2_EXPORT_SAP_REPRICING)
                         )
                        ){
                      %>
                      <option value="<%=objPeriodoRif.getDATA_AA_RIF_SPESA_COMPL()%>-<%=objPeriodoRif.getDATA_MM_RIF_SPESA_COMPL()%>">
                      <%=objPeriodoRif.getTXT_DATA_MM_RIF_SPESA_COMPL()%> - <%=objPeriodoRif.getDATA_AA_RIF_SPESA_COMPL()%>
                      </option>
                      <%
                      }
                      else{
                        if(objPeriodoRif.getCODE_CICLO().equals("")){
                        %>
                        <option value="Attuale" strDataFineCiclo = "<%=objPeriodoRif.getTXT_DATA_FINE_CICLO()%>" >
                        <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                        </option>
                        <%
                        }else{
                        %>
                        <option value="<%=objPeriodoRif.getCODE_CICLO()%>" strDataFineCiclo = "<%=objPeriodoRif.getTXT_DATA_FINE_CICLO()%>" >
                        <%=objPeriodoRif.getDESCRIZIONE_CICLO()%>
                        </option>
                        <%
                        }
                      }
                    }
                  %>
                </Select>
                <%
                }
                }
                %>
              </TD>
              <TD nowrap>
                <%
                  if(objElabAttiva.getCODE_FUNZ().equals("ELABORAZIONE_PREINVENTARIO")){
                    if(objElabAttiva.getDATA_VISIBLE().equals("S")){%>
                    <Font style="visibility:hidden" id="lblData<%=objElabAttiva.getCODE_FUNZ()%>" name="lblData<%=objElabAttiva.getCODE_FUNZ()%>">
                      Data Fine Elaborazione:
                    </Font>
                    <INPUT style="visibility:hidden;WIDTH:80" class="text" id="txtData<%=objElabAttiva.getCODE_FUNZ()%>" name="txtData<%=objElabAttiva.getCODE_FUNZ()%>" readonly obbligatorio="si" tipocontrollo="data" label="Data Fine Elaborazione" value="" onchange="controllaDataFineCiclo(this.value)">
                    <a href="javascript:if(controllo()){showCalendar('frmDati.txtData<%=objElabAttiva.getCODE_FUNZ()%>','')};"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img style="visibility:hidden" id="imgData<%=objElabAttiva.getCODE_FUNZ()%>" name="imgData<%=objElabAttiva.getCODE_FUNZ()%>"  alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <%}
                  }else{
                    if(objElabAttiva.getDATA_VISIBLE().equals("S")){%>
                    <Font style="visibility:hidden" id="lblData<%=objElabAttiva.getCODE_FUNZ()%>" name="lblData<%=objElabAttiva.getCODE_FUNZ()%>">
                      Data Fine Periodo:
                    </Font>
                    <INPUT style="visibility:hidden;WIDTH:80" class="text" id="txtData<%=objElabAttiva.getCODE_FUNZ()%>" name="txtData<%=objElabAttiva.getCODE_FUNZ()%>" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="<%=DataFormat.getDate()%>">
                    <a href="javascript:showCalendar('frmDati.txtData<%=objElabAttiva.getCODE_FUNZ()%>','');"  onMouseOver="javascript:showMessage('seleziona'); return true;" onMouseOut="status='';return true"><img style="visibility:hidden" id="imgData<%=objElabAttiva.getCODE_FUNZ()%>" name="imgData<%=objElabAttiva.getCODE_FUNZ()%>"  alt="Seleziona data" src="<%=StaticContext.PH_COMMON_IMAGES%>ICOCalendar.gif" border="0"></a>
                  <%}
                  }%>
              </TD>
              <%}%>
            </TR>
          <% 
          }
          %>
          </TABLE>
        </TD>
      </TR>
      <tr height="28">
        <td>
          <sec:ShowButtons td_class="textB"/>
        </td>
      </tr>
    </TABLE>
  </form>
  </body>
</html>
