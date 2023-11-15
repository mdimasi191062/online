<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<sec:ChkUserAuth RedirectEnabled="true" VectorName="bottoni" />

<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3007,"Colocation")%>
<%=StaticMessages.getMessage(3006,"ListaAccountCol.jsp")%>
</logtag:logData>


<%
//********************
String cod_tipo_contr="codiceTipoaccount";
String des_tipo_contr="hidDescTipoaccount";
String cod_tar          = request.getParameter("cod_tar");
String cod_PS           = request.getParameter("cod_PS");
String des_PS           = request.getParameter("des_PS");
String desc_tariffa     = request.getParameter("desc_tariffa");
String importo_tariffa  = request.getParameter("importo_tariffa");
String oggFattSelez     = request.getParameter("oggFattSelez");
String clasOggFattSelez = request.getParameter("clasOggFattSelez");
String causaleSelez     = request.getParameter("causaleSelez");
String caricaOggFatt    = request.getParameter("caricaOggFatt");
String caricaCausale    = request.getParameter("caricaCausale");
String caricaLista      = request.getParameter("caricaLista");
String caricaUniMis     = request.getParameter("caricaUniMis");
String misuraDisp       = request.getParameter("misuraDisp");
String richSave         = request.getParameter("richSave");
String contrSelez       = request.getParameter("contrSelez");
String des_contr        = request.getParameter("des_contr");
if (des_contr==null) des_contr="";
String cof           = request.getParameter("cof");
int indice=0;
Vector unitaMisuraV;
//********

String utrSelez       = request.getParameter("utrSelez");
String caricasiti = request.getParameter("caricasiti");
String sitoSelez  = request.getParameter("sitoSelez");


//Inserimento istruzioni per la paginazione inizio
// Lettura dell'indice Combo Numero Record
int index=0;
String strIndex = request.getParameter("txtnumRec");
if ((strIndex!=null)&&(!(strIndex.equals(""))))
  {
   Integer tmpindext=new Integer(strIndex);
   index=tmpindext.intValue();
  }



// Lettura del Numero di record per pagina (default 5)
int records_per_page=5;
String strNumRec = request.getParameter("numRec");
if ((strNumRec!=null)&&(!(strNumRec.equals(""))))
  {
    Integer tmpnumrec=new Integer(strNumRec);
    records_per_page=tmpnumrec.intValue();
  }

// Lettura tipo caricamento per fare query o utilizzare variabili Session
// typeLoad=1 Fare query (default)
// typeLoad=0 Variabile session
int typeLoad=0;
String strtypeLoad = request.getParameter("typeLoad");
if ((strtypeLoad!=null)&&!(strtypeLoad.equals("")))
  {
    Integer tmptypeLoad=new Integer(strtypeLoad);
    typeLoad=tmptypeLoad.intValue();
  }


//Inserimento istruzione per la paginazione fine

// Vettore contenente risultati query per il caricamento della della combo contratti e della lista
Vector contr=null;
Vector utr=null;

Collection tariffe=null;
Collection account=null;


//MMMMMMMMMMMMMMMMMMMMMM 21/10/02 MMMMMMMMMMMMMMMMMMMMMMM
Vector sito=null;
%>
<EJB:useHome id="homeSito" type="com.ejbSTL.SitoSTLHome" location="SitoSTL" />
<%
if(!((caricasiti==null)||(caricasiti.equals("null"))||(caricasiti.equals("false"))))
{
  if (utrSelez!=null)
  {
    SitoSTL remoteSito= homeSito.create();                        
    sito=remoteSito.getSito(utrSelez);
  }
} 
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

%>

<EJB:useHome id="homeContratto"  type="com.ejbSTL.ContrattoSTLHome"  location="ContrattoSTL" />
<EJB:useHome id="homeUnTerRete"  type="com.ejbSTL.UnTerReteSTLHome"  location="UnTerReteSTL" />
<EJB:useHome id="homeColocation" type="com.ejbBMP.ColocationBMPHome" location="ColocationBMP" />

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1252">
<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
<TITLE> Lista Dati Contrattuali Attivazione Sito </TITLE>

<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/openDialog.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/Common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/calendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/ControlliNumerici.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../js/ListaAccount.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/changeStatus.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="../../common/js/validateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE='Javascript'>

//alert("<%=sitoSelez%>");
var codOggFattSel="";
var carCausaleBoolean=true;
var UnitaMisuraDisp=false;
var appoggio;


var codtarSel="";





function ONNUOVO()
{
  document.account.action="NuovaCol.jsp";
  //M 17/10/02 document.account.utrSelez.value="-1";
  //M 17/10/02 document.account.sitoSelez.value="-1";
  //M 18/10/02 document.account.caricasiti.value='false';
  
  if (document.account.caricaLista.value=="true")
  {
     document.account.accountSelez.value="-1";
  }
  document.account.submit();
}

function ONAGGIORNA()
{
//  alert("aggiorna");
  doAct('Agg');
}

function ONCANCELLA()
{
//  alert("cancella");
  doAct('Can');
}

function ONVISUALIZZA()
{
  
  doAct('Vis');
}

function doAct(azioneAct )
{
  document.account.act.value=azioneAct;
  //document.account.utrSelez.disable='false';
  //document.account.sitoSelez.disable='false';
  Enable(document.account.utrSelez);
  Enable(document.account.sitoSelez);
  document.account.desUtrSelez.value=document.account.utr[document.account.utr.selectedIndex].text;
  document.account.desSitoSelez.value=document.account.sito[document.account.sito.selectedIndex].text;
  document.account.action="VisAggCanCol.jsp";
  document.account.submit();
}


function ONPOPOLALISTA()
{
      document.account.caricaLista.value="true";
      Enable(document.account.utr);
      Enable(document.account.sito);
      document.account.utrSelez.value=document.account.utr[document.account.utr.selectedIndex].value;
      document.account.sitoSelez.value=document.account.sito[document.account.sito.selectedIndex].value;
      document.account.submit();
}


function blocca()
{
  document.account.btnPS.focus();
  alert("Campo non editabile.");
  //document.account.btnPS.focus();
}

function avviso()
{
  document.account.btnPS.focus();
  alert("Selezionare un Prodotto/Servizi.");
}

function submitFrmSearch(typeLoad)
{
  document.account.txtnumRec.value=document.account.numRec.selectedIndex;
  document.account.typeLoad.value=typeLoad;
  document.account.submit();
}




function setInitialValue()
{


eval('document.account.numRec.options[<%=index%>].selected=true');
/* if (String(document.account.accountSelez)!="undefined")
  {
    if (document.account.accountSelez.lenght=="undefined")
      document.account.accountSelez.checked=true;
    else
      document.account.accountSelez[0].checked=true;
  }
*/

  if (document.account.utrSelez.value=='')
      document.account.caricasiti.value='false';
     
     
     if (document.account.utrSelez.value=='')
      document.account.caricasiti.value='false';
     
     Enable(document.account.POPOLALISTA);
        if ((document.account.utrSelez.value=='-1')||(document.account.utrSelez.value=='null')||(document.account.sitoSelez.value=='-1')||(document.account.sitoSelez.value=='null'))
              Disable(document.account.POPOLALISTA);
        
     
}

</SCRIPT>

</HEAD>
<BODY onload="setInitialValue();">
<%
if ((typeLoad!=0)||(utrSelez!=null))
   {
     utr = (Vector) session.getAttribute("utr");
     
   }
   else
   {  
          UnTerReteSTL remoteUnTerRete= homeUnTerRete.create();
          utr=remoteUnTerRete.getUTR();

          
          if (utr!=null)
          {
           session.setAttribute("utr", utr);
          } 
          
   }

if (typeLoad!=0)
   {
     account = (Collection) session.getAttribute("account");
     //caricaLista="true";
    //System.out.println("caricalista "+caricaLista);
   }
   else
   {
    if ((caricaLista!= null) && (caricaLista.equals("true")))
    {
                account=homeColocation.findAll(sitoSelez);
                if (account!=null)
                {
                   session.setAttribute("account", account);
                }
    }
   }
 %>
 
<FORM name="account" method="get" action="ListaAccountCol.jsp">
<input type="hidden" name=cod_tar           id= cod_tar           value= <%=cod_tar%>>
<input type="hidden" name=cod_PS            id=cod_PS             value=<%=cod_PS%>>
<input type="hidden" name=cod_tipo_contr    id=cod_tipo_contr     value=<%=cod_tipo_contr%>>
<input type="hidden" name=caricaCausale     id=caricaCausale      value= <%=caricaCausale%>>
<input type="hidden" name=caricaLista       id=caricaLista        value= <%=caricaLista%>>
<input type="hidden" name=caricaUniMis      id=caricaUniMis       value= <%=caricaUniMis%>> 
<input type="hidden" name=oggFattSelez      id= oggFattSelez      value= <%=oggFattSelez%>> 
<input type="hidden" name=contrSelez        id= contrSelez        value= <%=contrSelez%>>
<input type="hidden" name=des_contr         id= des_contr         value= <%=des_contr%>>
<input type="hidden" name=clasOggFattSelez  id= clasOggFattSelez  value= <%=clasOggFattSelez%>> 
<input type="hidden" name=causaleSelez      id= causaleSelez      value= <%=causaleSelez%>> 
<input type="hidden" name=misuraDisp        id= misuraDisp        value= <%=misuraDisp%>> 
<input type="hidden" name=richSave          id= richSave          value= <%=richSave%>> 
<input type="hidden" name=descr_tipo_contr  id= descr_tipo_contr  value= <%=des_tipo_contr%>> 
<input type="hidden" name=descr_estesa_ps   id= descr_estesa_ps   value=<%=des_PS%>> 



<input type="hidden" name=act               id= act > 
<input type="hidden" name=desUtrSelez       id= desUtrSelez> 
<input type="hidden" name=desAccountSelez   id= desAccountSelez > 
<input type="hidden" name=desSitoSelez      id= desSitoSelez > 
<input type="hidden" name=utrSelez        id= utrSelez         value= <%=utrSelez%>>
<input type="hidden" name=sitoSelez       id= sitoSelez        value= <%=sitoSelez%>>
<input type="hidden" name=caricasiti      id=caricasiti        value= <%=caricasiti%>>
<input type="hidden" name=ch              id=ch                value= "lst">


<table align=center width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="../images/colocation.gif" alt="" border="0"></td>
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
                <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Lista Dati Contrattuali Attivazione Sito</td>
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
	    <table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>

        <tr>
					<td>
            <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="<%=StaticContext.bgColorHeader%>">
                  <tr>
                    <td bgcolor="<%=StaticContext.bgColorHeader%>" class="white" valign="top" width="91%">&nbsp;Filtro di ricerca</td>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>
                  </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=StaticContext.bgColorTabellaForm%>">
                    <tr>
                      <td colspan='3' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
                    </tr>
                    <tr>
                      <td   width="50%" class="textB" align="left">&nbsp;&nbsp;U.T.R.:&nbsp;</td>
                      <td   width="50%" class="textB" align="left">&nbsp;Sito:&nbsp;</td>
                      <td >  &nbsp; </td>
                    </tr>
                     <tr>

<%
if ((utr==null)||(utr.size()==0))
                    {
                      
                    %>
                      <td  width="50%" class="text">
							          &nbsp;<select class="text" title="utr" name="utr"  >
					                 <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
					              </select>
                      </td>
                      <Script language="javascript"> Disable(document.account.utr); </Script>
                    <%}
                      else
                      {

                      %>
                      <td  width="50%" class="text">
                          &nbsp;<select class="text" title="utr" name="utr" onchange='carsiti()'>
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                               <%
                               
                                Object[] objs=utr.toArray();
                                for (Enumeration e = utr.elements();e.hasMoreElements();)
                                {
                                  
                                  UnTerReteElem elem2=new UnTerReteElem();
                                  elem2=(UnTerReteElem)e.nextElement();
                                  String selez="";
                                  
                                  if(utrSelez!=null && utrSelez.equals(elem2.getCodeUTR())) 
                                  {
                                      selez="selected";
                                  }
                                                                    
                                    %>
                                     <option value="<%=elem2.getCodeUTR()%>"   <%=selez%>><%=elem2.getCodeUTR()%></option>
                                    <%
                                  }//for
                               %> 
                               </select>
                            </td>   
                      <%}//else%>

                   <%
                   
                    if((caricasiti==null)||(caricasiti.equals("null"))||(caricasiti.equals("false")))
                    {
                      
                    %>
                      <td  width="50%" class="text">
							          &nbsp;<select class="text" title="sito" name="sito" >
                               <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                              </select>
                      </td>
                      <Script language="javascript"> Disable(document.account.sito); </Script>
                    <%}
                      else
                      {
                         
                      %>
                      <!--AAA-->
                      <!--aaa-->
                      
                        <%
                        //SitoSTL remoteSito= homeSito.create();
                        //Vector sito=remoteSito.getSito(utrSelez);
                        if ((sito!=null)&&(sito.size()!=0))
                        
                        {
                        
                        %>
                         <td  width="50%" class="text">
                          &nbsp;<select class="text" title="sito" name="sito" onchange="carlista()">
                                  <option value="-1">[Seleziona Opzione]<%=Utility.getSpazi(32)%></option>
                               <%
                               
                                Object[] objs=sito.toArray();
                                for (Enumeration e = sito.elements();e.hasMoreElements();)
                                {
                                  
                                  SitoElem elem2=new SitoElem();
                                  elem2=(SitoElem)e.nextElement();
                                  String selez="";
                                  
                                  if(sitoSelez!=null && sitoSelez.equals(elem2.getCodeSito())) 
                                  {
                                      selez="selected";
                                  }
                                                                    
                                    %>
                                     <option value="<%=elem2.getCodeSito()%>" name="<%=elem2.getDescSito()%>"  <%=selez%>><%=elem2.getDescSito()%></option>
                                    <%
                                  }//for
                               %> 
                               </select>
                               <%
                               //da qui
                              }//if (sito!=null)&&(sito.size()!=0)
                             
                            //a qui
                            %>
                            </td>   
                      <%}//else%>
                      <td>
						            &nbsp;
						          </td>
                      
                      <tr>
                      <td colspan='3'>
						            &nbsp;
						          </td>
                      </tr>
                     
                     </tr>
                      <!--mmmmmmmm-->
                  <tr>
                    <input class="textB" type="hidden" name="typeLoad" value="">
                    <input class="textB" type="hidden" name="txtnumRec" value="">
                    <input class="textB" type="hidden" name="txtnumPag" value="1">
                        
                    <td class="textB" width="70%"  align="right">Risultati per pag.:&nbsp;</td>  
                    <td  class="text">
                      <select class="text" name="numRec" onchange="submitFrmSearch('1');">
                          <option class="text" value=5>5</option>
                          <option class="text" value=10>10</option>
                          <option class="text" value=20>20</option>
                          <option class="text" value=50>50</option>
                      </select>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                      <!--MMMMMMMMM-->
              </table>
            </td>
          </tr>
        </table>
                <sec:ShowButtons VectorName="bottoni"/>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
          <tr>
           <td  bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
         </tr>
       </table>
			</td>
    </tr>
      <tr>
       <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/images/body/pixel.gif" width="1" height='2'></td>
      </tr>
      <%
        
        if((caricaLista!= null) && (caricaLista.equals("true")))
        {
      %>
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
                <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/body/pixel.gif" width="1" height='2'></td>
              </tr>
            <%
               //if (account!=null) 
                 //session.setAttribute("account", account);
               if ((account==null)||(account.size()==0))
               {
                  caricaLista="false";
%>                  
<SCRIPT LANGUAGE='Javascript'>
document.account.caricaLista.value='false';
</SCRIPT>
         
              <tr>
                <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="textB" align="center">No Record Found</td>
              </tr>
<%              
               }else 
               {
              
%>
                 <tr>
                    <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" class="white">&nbsp;</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Account</td>
                    <td bgcolor='<%=StaticContext.bgColorTestataTabella%>' class='textB'>Data Consegna Sito</td>
                    <td colspan='2' bgcolor='<%=StaticContext.bgColorTestataTabella%>' class="white">&nbsp;</td>
                 </tr>
            <%
            //}
            %>
                <pg:pager maxPageItems="<%=records_per_page%>" maxIndexPages="10" totalItemCount="<%=account.size()%>">
                <pg:param name="typeLoad" value="1"></pg:param>
                <pg:param name="utrSelez" value="<%=utrSelez%>"></pg:param>
                <pg:param name="sitoSelez" value="<%=sitoSelez%>"></pg:param>
                <pg:param name="caricasiti" value="<%=caricasiti%>"></pg:param>
                <pg:param name="caricaLista" value="<%=caricaLista%>"></pg:param>
                <pg:param name="txtnumRec" value="<%=index%>"></pg:param>
                <pg:param name="numRec" value="<%=strNumRec%>"></pg:param>
                <pg:param name="caricaLista" value="true"></pg:param>
                <%
                   String bgcolor="";
                   String checked;  
                   Object[] objs=account.toArray();
                   
                   for (int i=((pagerPageNumber.intValue()-1)*records_per_page);((i<account.size()) && (i<pagerPageNumber.intValue()*records_per_page));i++)
                   //for (int i=0;i<account.size();i++)
                   {
                     ColocationBMP obj=(ColocationBMP)objs[i];
                     if ((i%2)==0)
                        bgcolor=StaticContext.bgColorRigaPariTabella;
                     else
                        bgcolor=StaticContext.bgColorRigaDispariTabella;
                 %>
                    <!--pg:item-->
                       <tr>
                        <input type="hidden" name=cod_account  id=cod_account  value='<%=obj.getCodeAccount()%>'>
                        <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" width='2%'>
                            <input bgcolor='<%=StaticContext.bgColorCellaBianca%>'  type='radio'  name='accountSelez'  <%if (i==((pagerPageNumber.intValue()-1)*records_per_page)) out.print("checked");%>  value='<%=obj.getCodeAccount()%>' onclick="ChangeSel('<%=obj.getCodeAccount()%>','<%=obj.getDescAccount().replace('\'','Æ')%>')">
                            <SCRIPT LANGUAGE='Javascript'>
                            if ( ("<%=i%>"=="0") || ("<%=i%>"=="<%=((pagerPageNumber.intValue()-1)*records_per_page)%>") )
                            {
                              ChangeSel("<%=obj.getCodeAccount()%>","<%=obj.getDescAccount().replace('\'','Æ')%>");
                            }
                            </SCRIPT>
                        </td>
                        <td bgcolor='<%=bgcolor%>' class='text'><%=obj.getDescAccount()%></td>
                        <td bgcolor="<%=bgcolor%>" class="text"><%=obj.getDataConsSito()%></td>
                        
                        <td colspan='2' bgcolor="<%=bgcolor%>" class="white">&nbsp;</td>  
                      </tr>
                    <!--/pg:item-->
                 <%    
                    }//for
                 %>
                    <tr>
                      <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/pixel.gif" width="3" height='2'></td>
                    </tr>
                <pg:index>
                         <tr>
                            <td bgcolor="<%=StaticContext.bgColorCellaBianca%>" colspan="5" class="text" align="center">
                                Risultati Pag.
                          <pg:prev> 
                                <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[<< Prev]</A>
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
                                   <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true"><%= pageNumber %></A>&nbsp;
                                <%
                                  } 
                                %>
                                
                          </pg:pages>
                          <pg:next>
                                 <A HREF="<%= pageUrl %>" onMouseOver="status='Go to Page ...';return true" onMouseOut="status='';return true">[Next >>]</A>
                          </pg:next>

                            </td>
                          </tr>
                </pg:index>
                </pg:pager>
                <tr>
                  <td colspan='5' bgcolor="<%=StaticContext.bgColorCellaBianca%>"><img src="../../common/image/body/pixel.gif" width="1" height='2'></td>
                </tr>
             </table>


<%
    if((caricaLista!= null) && (caricaLista.equals("true")))
    {
     %> 
       <sec:ShowButtons PageName="LSTACCCOL_ELAB" />
     <%
     }
     else
     {
     %>
      <sec:ShowButtons PageName="LSTACCCOL_NEW" />
     <%
      }
     %>
<%
 }//else (se tariffe è pieno)   
%>

</td>
        </tr>

</table>
      </table>
    </td>
  </tr>

 
  <tr>
    <td colspan=5 bgcolor="<%=StaticContext.bgColorCellaBianca%>">
    <img src="../../common/image/body/pixel.gif" width="1" height='3'>
    &nbsp;




    </td>
  </tr>
  <tr>
    <td colspan=6>
     
       
    </td>
   </tr>

<%
 }//if su carica lista
%> 
 

 </table>
 <%
 if(!((caricaLista!= null) && (caricaLista.equals("true"))))
 {
 %>
 <sec:ShowButtons PageName="LSTACCCOL_NEW" />
 <%
 }
 %>
  </td>
  </tr>
<SCRIPT LANGUAGE='Javascript'>
<%String mess=request.getParameter("mes");%>
if ('<%=mess%>'!='null' && 'verFatt'=='null'){
  alert("Impossibile proseguire in quanto l' account è già stato fatturato"); }
</SCRIPT>

  
  </table>
 </FORM>
</BODY>
</HTML>
