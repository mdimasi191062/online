<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.usr.*,com.ejbSTL.*,com.ejbBMP.*" %>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="vn_ogg_fatt" />
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"OggFatt.jsp")%>
</logtag:logData>
<%
response.addHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "no-store");

String cod_contratto=request.getParameter("cod_contratto");
String des_contratto=request.getParameter("des_contratto");
String flag_sys=request.getParameter("flag_sys");
String action=request.getParameter("act");


String title="";
int kont = 1;
int final_kont = 0;
String code_of="";
String code_classe_of="";
String desc_of="";
String data_ini="";
String data_oggi="";
String data_ini_mmdd="";
String data_fine="";
String flg_tipo_assB="";

boolean disattivabile=true;
boolean assOfPs=false;

data_oggi=Utility.getDateDDMMYYYY();
if ((action==null)||(action.equalsIgnoreCase("Nuovo")))
  {
  title="Nuovo Oggetto di Fatturazione";
  data_ini=Utility.getDateDDMMYYYY();
  }
if (action.equalsIgnoreCase("aggiorna"))
  {
  title="Aggiorna Oggetto di Fatturazione";
  }
if (action.equalsIgnoreCase("disattiva"))
  {
  title="Disattiva Oggetto di Fatturazione";
  }
data_ini_mmdd=Utility.getDateMMDDYYYY();

%>
<EJB:useHome id="home1" type="com.ejbBMP.OggFattBMPHome"   location="OggFattBMP" />
<EJB:useHome id="home"  type="com.ejbSTL.ClasseFattSTLHome" location="ClasseFattSTL" />
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE>
<%=title%>
</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/OggettoFatt.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

</SCRIPT>

<%
    Context context = null;

    context = new InitialContext();

    // Leggo i dati per visualizzazione o modifica o disattivazione;
    if ((action.equalsIgnoreCase("aggiorna"))||(action.equalsIgnoreCase("disattiva")))
      {
        code_of=request.getParameter("SelOf");
        // Creazione oggetto
        OggFattBMPPK pk = new OggFattBMPPK();
        pk.setCodeOf(code_of);
        pk.setFlagSys(flag_sys);
      %>
      <EJB:useBean id="remote1" type="com.ejbBMP.OggFattBMP" value="<%=home1.findByPrimaryKey(pk)%>" scope="session"></EJB:useBean>   
      <%
        code_classe_of=remote1.getCodeCOf();
        data_ini=remote1.getDataIni();
        desc_of=remote1.getDescOggFatt();
        data_fine=remote1.getDataFine();
        flg_tipo_assB=remote1.getTipoFlgAssocB();
        
        if (action.equalsIgnoreCase("disattiva"))
            disattivabile=remote1.isDisattivabile();

        if (action.equalsIgnoreCase("aggiorna"))
            assOfPs=remote1.isAssOfPs();
        
      }

  
%>
<SCRIPT LANGUAGE="JavaScript">
var msg1="Click per selezionare la data";
var msg2="Click per selezionare la data";
var msg3="Click per cancellare la data selezionata";


function on_load()
{
  
  <% if (disattivabile) {%>
  appo_desc = document.OggettoFatt.desc.value;
  flg_data_fine=false;

  Disable(document.OggettoFatt.data_ini);
  Disable(document.OggettoFatt.data_fine);
         
<%
  // Viene disattivata data fine validità
  if (action.equalsIgnoreCase("aggiorna"))
     if ((assOfPs)||(data_fine==null)||(data_fine.trim().equals("")))
          {
           out.println("flg_data_fine=true;");
           out.println("DisableLink (document.links[1],document.OggettoFatt.calendar_fine);");
           out.println("DisableLink (document.links[2],document.OggettoFatt.cancel_fine);");
           out.println("msg2=message1;");
           out.println("msg3=message2;");
          } 

  // Viene disabilitata la classe di fatturazione
  // e la data fine validità
  if (assOfPs)
      {
        out.println("Disable(document.OggettoFatt.classefatt);");
        out.println("Disable(document.OggettoFatt.assPs);");
        out.println("if (!flg_data_fine) {Disable(document.OggettoFatt.data_fine);flg_data_fine=true;}");
      }
%>

  if (document.OggettoFatt.act.value!='insert'){
    DisableLink (document.links[0],document.OggettoFatt.calendar_ini);
    msg1=message1;
    if (document.OggettoFatt.act.value=='disattiva'){
      Disable(document.OggettoFatt.classefatt);
      Disable(document.OggettoFatt.desc);
      Disable(document.OggettoFatt.assPs);
    }
    /*
    else{
      if (document.OggettoFatt.data_fine.value != ''){
          if (!flg_data_fine)
            {
            DisableLink (document.links[1],OggettoFatt.calendar_fine);
            DisableLink (document.links[2],document.OggettoFatt.cancel_fine);
            flg_data_fine=true;
            }
          msg2=message1;
          msg3=message2;
      }
     
    }*/
  }
  else{
   // Disable(document.OggettoFatt.CONFERMA);
  }
  <%}%>
}

</SCRIPT>

</HEAD>
<BODY onload="on_load();">
<%
String act="insert";
if (action.equals("aggiorna"))
  act="aggiorna";
if (action.equals("disattiva"))
  act="disattiva";
%>
<form name="OggettoFatt" id="OggettoFatt" method="get"  action='<%=request.getContextPath()%>/servlet/OggFattCntl'>
<input type="hidden" name=cod_contratto id=cod_contratto value="<%=cod_contratto%>">
<input type="hidden" name=des_contratto id=des_contratto value="<%=des_contratto%>">
<input type="hidden" name=flag_sys id=flag_sys value=<%=flag_sys%>>
<input type="hidden" name=code_of id=code_of value=<%=code_of%>>
<input type="hidden" name=data_oggi id=data_oggi value=<%=data_oggi%>>
<input type="hidden" name=act id=act value="<%=act%>">
<table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">

  <tr>
	<td><img src="../images/oggettiFatturazioneTitolo.gif" alt="" border="0"></td>
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
						  <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;<%=title%></td>
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

      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
				<tr>
					<td>
					  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr bgcolor="<%=StaticContext.bgColorHeader%>">
                 <td colspan=4 class="white" valign="top" width="91%"><%=des_contratto%></td>
                 <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
              </tr>
					  </table>
					</td>
				</tr>

      </table>
  </tr></td>   

  <%
  if (!disattivabile)
    {
  %>  
    <tr><td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
      <tr>
      <td class="textB" bgcolor="<%=StaticContext.bgColorTestataTabella%>" align="center" width="50%">
      &nbsp;Non e' possibile disattivare l'oggetto di fatturazione.
      </td>     
      </tr>
      </table>
    </td></tr>
   </table> 
  <%  
    }
  else
    {
  %>  
    <tr><td>
      <table align='center' width="90%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
      <tr>
        <td class="text" align="right">Classe:&nbsp;</td>
        <td class="text">

        
        <EJB:useBean id="remote" type="com.ejbSTL.ClasseFattSTL" value="<%=home.create()%>" scope="page"></EJB:useBean>

        <%
//          Vector classFatts=remote.getCfs();
          Vector classFatts=null;
          if (flag_sys.equals("S"))
            classFatts=remote.getCfs();
          else
            classFatts=remote.getCfsCla();
          if ((classFatts!=null)&&(classFatts.size()!=0))
            {
            // Visualizzo elementi
            %>
             <select class="text" title="Classe Oggetto di Fatturazione" name="classefatt" onchange="change_combo();">
             <option value="-1">[Seleziona Opzione] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
             <%
             for(Enumeration e = classFatts.elements();e.hasMoreElements();)
                {
                kont++;
                ClasseFattElem elem=new ClasseFattElem();
                elem=(ClasseFattElem)e.nextElement();
                String sel="";
                if (code_classe_of.equals(elem.getCodeClasseOf())) 
                  {
                  sel="selected";
                  final_kont=kont;
                  }
                   %>
                   <option value="<%=elem.getCodeClasseOf()%>" <%=sel%>><%=elem.getDescClasseOf()%></option>
                   <%
                }
             %> 
             </select> 
            <%   
            }
          else
            {
            // Visualizzo solo [Seleziona Opzione]
            %>
             <select class="text" title="Classe Oggetto di Fatturazione" name="classefatt" onchange="change_combo();" >
             <option value="-1">[Seleziona Opzione] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
             </select>         
            <%
            }
        %>
        </td>
      </tr>

      <tr>
        <td class="text" align="right">Descrizione:&nbsp;</td>
        <td>
        <input class="text" title="Descrizione" type="text" size="50" maxlength="50" name="desc" value="<%=desc_of%>" > 
        </td>
      </tr>  

      <tr>
        <td class="text" align="right">Data inizio validità:&nbsp;</td>
        <td>
        <input class="text" title="Data inizio" type="text" size="10" maxlength="10" name="data_ini" value="<%=data_ini%>" > 
        <a href="javascript:showCalendar('OggettoFatt.data_ini','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona1'); return true;" onMouseOut="status='';return true"><img name='calendar_ini' src="../../common/images/body/calendario.gif" border="no"></a>
        </td>
      </tr>  
      
      <tr>
        <td class="text" align="right">Data fine validità:&nbsp;</td>
        <td>
        <input class="text" title="Data fine" type="text" size="10" maxlength="10" name="data_fine" value="<%=data_fine%>"> 
        <a href="javascript:showCalendar('OggettoFatt.data_fine','<%=data_ini_mmdd%>');" onMouseOver="javascript:showMessage('seleziona2'); return true;" onMouseOut="status='';return true"><img name='calendar_fine' src="../../common/images/body/calendario.gif" border="no"></a>
        <a href="javascript:cancelCalendar();" onMouseOver="javascript:showMessage('cancella'); return true;" onMouseOut="status='';return true"><img name='cancel_fine' src="../../common/images/body/cancella.gif" border="0"></a>
        </td>
      </tr>  

      <tr>
        <td>&nbsp;</td>
        <td class="textB">
        <input type=checkbox name=assPs value="yes" <%if (flg_tipo_assB.equalsIgnoreCase("S")) out.print("checked");%>>Oggetto di Fatturazione associabile a P/S a catalogo
        </td>
      </tr>

     <tr><td colspan=2>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
	      <tr>
          <td class="textB" bgcolor="<%=StaticContext.bgColorFooter%>" align="center" colspan="5">
            <input type="hidden" name=sel_classe_hidden id=sel_classe_hidden value=<%=final_kont%>>
            <input type="hidden" name=desc_hidden id=desc_hidden value=<%=desc_of%>>
            <input type="hidden" name=data_ini_hidden id=data_ini_hidden value=<%=data_ini%>>
            <input type="hidden" name=data_fine_hidden id=data_fine_hidden value=<%=data_fine%>>
            <input type="hidden" name=assPs_hidden id=assPs_hidden value=<%=flg_tipo_assB%>>
          </td>
	      </tr>
	    </table>
      </td>
    </tr>
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/pixel.gif" width="1" height='3'></td>
  </tr>
  </table>
  </td></tr></table>

  <table align='center' width="80%" border="0" cellspacing="0" cellpadding="0">
  <tr><td>
    <sec:ShowButtons VectorName="vn_ogg_fatt" />
    </table>
  </td></tr>
  </table>
  
</form>
<%
}
%>
</BODY>
</HTML>
