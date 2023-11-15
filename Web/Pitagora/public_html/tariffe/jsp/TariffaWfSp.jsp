<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"TariffaWfSp.jsp")%>
</logtag:logData>



<%

boolean caricaOggFatt=false;
String msg="";
String flg_ClassFatt="false";
Vector classFatt_vect=null;
Vector desc_vect=null;
//viti 28-02-03
Vector classOpzioniTariffa = null;
Vector classFatts2=null;
Vector unitaMisuraV=null;
Integer numeroTariffe=new Integer("0");
TariffaBMP remoteNumTar=null;
TariffaBMP remoteCalcCode=null;
TariffaBMP remoteMaxDataIniOf=null;
TariffaBMP remoteMaxDataIniOfPs=null;
TariffaBMP remoteElabBatch=null;
TariffaBMP remoteInsert=null;
String      dateFormat =  "dd/MM/yyyy";
DateFormat  dataIniTarFormat        = new SimpleDateFormat(dateFormat);
DateFormat  dataIniValOfFormat      = new SimpleDateFormat(dateFormat);
DateFormat  dataIniValAssOfPsFormat = new SimpleDateFormat(dateFormat);
DateFormat  maxDate                 = new SimpleDateFormat(dateFormat);
Date        data_ini_1;
Date        dataIniValOf1;
Date        dataIniValAssOfPs1;
Date        maxDate1;
String      dataIniValOf="";
String      dataIniValAssOfPs="";
int numElabBatch;
String codTar=null;
String act              = request.getParameter("act");
String cod_PS           = request.getParameter("cod_PS");
String cod_tipo_contr   = request.getParameter("cod_tipo_contr");
String oggFattSelez     = request.getParameter("oggFattSelez");
String clasOggFattSelez = request.getParameter("clasOggFattSelez");
String codUt            = request.getParameter("codUt");
String descTar          = request.getParameter("descTar");
String flgMat           = request.getParameter("flgMat");
String data_ini         = request.getParameter("data_ini");
String progTar = "1";
String codClSc = null;
String prClSc  = null;
String dataFineTar = null;
String codUM            = request.getParameter("codUM");
if (codUM!=null && codUM.equals("null")) codUM=null;
String impTar = request.getParameter("impTar");
if (impTar!=null && !(impTar.equals("null"))) 
   impTar =impTar.replace(',','.');
else 
   impTar  =null;
String causFatt         = request.getParameter("causFatt");
if (causFatt!=null && causFatt.equalsIgnoreCase("-1")) causFatt=null;

String flagExc="error"; // per congelare il chiamante in caso di Exception
//viti 28-02-03
String opzioneSelez         = request.getParameter("opzioneSelez");
if (opzioneSelez!=null && opzioneSelez.equalsIgnoreCase("-1")) opzioneSelez=null;
if ((act!=null)&&(act.equalsIgnoreCase("insert")))
{%>
<EJB:useHome id="home" type="com.ejbBMP.TariffaBMPHome" location="TariffaBMP" />
    <%
     String dataIniTar=request.getParameter("data_ini");
     data_ini_1 = dataIniTarFormat.parse(dataIniTar); //formato Date
		 
     remoteMaxDataIniOfPs= home.findOfMaxDataIniOfPs(oggFattSelez,cod_PS);
     dataIniValAssOfPs= remoteMaxDataIniOfPs.getDataIniValAssOfPs();
     dataIniValAssOfPs1= dataIniValAssOfPsFormat.parse(dataIniValAssOfPs);
	 	 
     remoteMaxDataIniOf= home.findOfMaxDataIniOf(oggFattSelez);
     dataIniValOf= remoteMaxDataIniOf.getDataIniValOf();
     dataIniValOf1=dataIniValOfFormat.parse(dataIniValOf);
		 if (dataIniValAssOfPs1!=null && dataIniValOf1!=null && data_ini_1!=null)
			{
				maxDate1= dataIniValAssOfPs1.after(dataIniValOf1)? dataIniValAssOfPs1:dataIniValOf1;
			if (maxDate1.after(data_ini_1))
			{
           if ( (dataIniValOf1.after(dataIniValAssOfPs1)) || (dataIniValOf1.equals(dataIniValAssOfPs1)))
           {
             if (data_ini_1.before(dataIniValOf1)) 
                act="no_data_0";
           }
           else if (data_ini_1.before(dataIniValAssOfPs1)) 
                    act="no_data_1";   
				}
				else
				{
				
          remoteElabBatch= home.findElabBatchInCorsoFatt();
          numElabBatch=remoteElabBatch.getNumElaborazTrovate().intValue();
					if (numElabBatch==0)
					{
				
            remoteCalcCode= home.findCalcolaCodice();
            codTar= remoteCalcCode.getCodTar();
						
           act="go_insert";
					}
					else
					{
					  act="no_batch";
					}
				}//else
			 }//if

   	else
   	{
        act="no_data_2";
   	}
}

// selezione combo causale
if ((act!=null)&& (act.equalsIgnoreCase("causale")  || act.equalsIgnoreCase("refresh") ) )
  {
  %>
  <EJB:useHome id="homeCausale" type="com.ejbSTL.CausaleSTLHome" location="CausaleSTL" />

  <%
  CausaleSTL remote= homeCausale.create();
  classFatts2=remote.getCaus(cod_tipo_contr,clasOggFattSelez,cod_PS,oggFattSelez);
 
  }
  
  if ((act!=null)&& (act.equalsIgnoreCase("opz")))
  {
  %>
 
   <EJB:useHome id="homeOpzioniTariffa1" type="com.ejbSTL.OpzioniTariffaSTLHome" location="OpzioniTariffaSTL" />
  <%
   //viti 28-02-03
  
  OpzioniTariffaSTL remoteOpzioniTariffa= homeOpzioniTariffa1.create();
  OpzioniElem opzioni = remoteOpzioniTariffa.getOpzioniFlag(oggFattSelez,cod_PS);

      
      if(opzioni.getOpzioniFlag()>0)
      {
         classOpzioniTariffa = remoteOpzioniTariffa.getDispOpz(oggFattSelez,cod_PS);
         flagExc="opzione";
      }
      else
      {
         flagExc="no_opzione";
       }  
          
  }
  
// selezione classe oggetto di fatturazione
if ((act!=null)&&(act.equalsIgnoreCase("unitaMisura")))
{%>
  <EJB:useHome id="homeUMisura" type="com.ejbSTL.UnitaMisuraSTLHome" location="UnitaMisuraSTL" />
<%
     UnitaMisuraSTL remote= homeUMisura.create();
     unitaMisuraV=remote.getUm();
}
%>

<HTML>
<HEAD>
	<LINK REL="stylesheet" HREF="../../css/Style.css" TYPE="text/css">
	<TITLE>ELABORAZIONE IN CORSO...</TITLE>
	<script src="../../common/js/calendar.js" type="text/javascript"></script>
  <script src="../../common/js/comboCange.js" type="text/javascript"></script>
  <script src="../../common/js/changeStatus.js" type="text/javascript"></script>
  <script src="../../common/js/openDialog.js" type="text/javascript"></script>
  <script src="../../common/js/validateFunction.js" type="text/javascript"></script>
  <script src="<%=StaticContext.PH_COMMON_JS%>misc.js" type="text/javascript"></script>
<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;
function SubmitMe()
{
<%

//Data inserita non idonea
if ((act!=null)&&((act.equalsIgnoreCase("no_data_0")) || (act.equalsIgnoreCase("no_data_1")) ||
                  (act.equalsIgnoreCase("no_data_2")) || (act.equalsIgnoreCase("no_batch"))))
{%>
opener.act="<%=act%>";
opener.dialogWin.returnFunc();
<%}
if ((act!=null)&&(act.equalsIgnoreCase("go_insert"))) 
{
   String strResult="TariffaCntl";
      strResult+="?act=insert";
      strResult+="&cod_tipo_contr="+cod_tipo_contr;
      strResult+="&clasOggFattSelez="+clasOggFattSelez;
      strResult+="&codTar="+codTar;
      strResult+="&progTar=1";
      strResult+="&codUM="+codUM;
      strResult+="&codUt="+codUt;
      strResult+="&dataIniValAssOfPs="+dataIniValAssOfPs;
      strResult+="&codOf="+oggFattSelez;
      strResult+="&dataIniValOf="+dataIniValOf;
      strResult+="&cod_PS="+cod_PS;
      strResult+="&dataIniTar="+data_ini;

      strResult+="&descTar="+java.net.URLEncoder.encode(descTar,com.utl.StaticContext.ENCCharset);
      strResult+="&impTar="+impTar;
      strResult+="&flgMat="+flgMat;
      strResult+="&causFatt="+causFatt;
      //viti
      strResult+="&opzioneSelez="+opzioneSelez;
      String strUrl = request.getContextPath() + "/servlet/"+strResult; 
 		  response.sendRedirect(strUrl);
}  

if ((act!=null)&&(act.equalsIgnoreCase("causale")) || (act.equalsIgnoreCase("refresh")))
  {
  %>
  if (opener && !opener.closed)
    {
          opener.clear_all_combo("comboCausale");
          opener.add_combo_elem("comboCausale","-1","[Seleziona Opzione]                                 ");

    <%
     if ((classFatts2!=null)&&(classFatts2.size()!=0))
     {
          for(Enumeration e = classFatts2.elements();e.hasMoreElements();)
          {
             CausaleElem elem2=new CausaleElem();
             elem2=(CausaleElem)e.nextElement();
             %>
                 opener.add_combo_elem("comboCausale","<%=elem2.getCodeTipoCausFat()%>","<%=elem2.getDescTipoCausFat()%>");
             <%
          }
    } 
   
    %>
    opener.document.oggFattForm.comboCausale[0].selected=true;
   
    <%
 
        if((act!=null) && (act.equalsIgnoreCase("causale")))
        {%> 
         opener.dialogWin.returnFunc();
        <%}
        if((act!=null) && (act.equalsIgnoreCase("refresh") && ((classFatts2!=null) &&(classFatts2.size()!=0))))
        {%> 
         opener.act="<%=act%>";
         opener.dialogWin.returnFunc();
        <%}
        if((act!=null) && (act.equalsIgnoreCase("refresh") && ( (classFatts2==null)|| (classFatts2!=null) &&(classFatts2.size()==0))))
        {
           caricaOggFatt=true;
        %> 
         opener.act="<%=act%>";
         if (IExplorer) 
         {
           opener.document.all["causale"].style.visibility="hidden"; 
           opener.document.all["comboCausale"].style.visibility="hidden";
         }  
         opener.Disable(opener.document.oggFattForm.comboCausale);
       
        <%}

        %> 
    }
  else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%  
}
//viti
if ((act!=null)&&(act.equalsIgnoreCase("opz")))
  {%>
  if (opener && !opener.closed)
    {
         
          opener.clear_all_combo("comboOpzioniTariffa");
          opener.add_combo_elem("comboOpzioniTariffa","-1","[Seleziona Opzione]  ");
    <%
      if ((classOpzioniTariffa!=null)&&(classOpzioniTariffa.size()!=0))
     {
          for(Enumeration e = classOpzioniTariffa.elements();e.hasMoreElements();)
          {
             OpzioniElem elem3=new OpzioniElem();
             elem3=(OpzioniElem)e.nextElement();
             %>
                 opener.add_combo_elem("comboOpzioniTariffa","<%=elem3.getCodeOpzione()%>","<%=elem3.getDescOpzione()%>");
                 
             <%
          }
          %>
          opener.Enable(opener.document.oggFattForm.comboOpzioniTariffa);
          opener.document.oggFattForm.tipoOpzSelez.value=null;
          opener.document.oggFattForm.caricaOpz.value="true";
          <%
    } 

    %>

    opener.flagExc="<%=flagExc%>";    
    opener.document.oggFattForm.comboOpzioniTariffa[0].selected=true;
    opener.dialogWin.returnFunc();
    }
  else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%  
}

if ((act!=null)&& (act.equalsIgnoreCase("refresh")) && (caricaOggFatt))
{%>
<EJB:useHome id="homeOggFatt1" type="com.ejbBMP.OggFattBMPHome" location="OggFattBMP" />
<%
  Collection oggfatt= homeOggFatt1.findOggFattAssPs(cod_PS,cod_tipo_contr);
  Object[] objs=oggfatt.toArray();%>
  if (opener && !opener.closed)
    {
       opener.clear_all_combo("comboOggFatt");
       opener.add_combo_elem("comboOggFatt","-1","[Seleziona Opzione]                                 ");
    <%
    if ((oggfatt!=null)&&(oggfatt.size()!=0))
    {
      for (int i=0; i<oggfatt.size(); i++)
      {
        OggFattBMP obj=(OggFattBMP)objs[i];
        %>
        opener.add_combo_elem("comboOggFatt","<%=obj.getCodeOggFatt()%>","<%=obj.getDescOggFatt()%>");
        opener.classeOf["<%=i%>"]="<%=obj.getCodeCOf()%>";
    <%}
    }%>
    opener.document.oggFattForm.comboOggFatt[0].selected=true;
  }
  else
  { 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
opener.act="<%=act%>";
<%
if( (oggfatt==null) || (oggfatt!=null) &&(oggfatt.size()==0))
    {%> 
        Disable(opener.document.oggFattForm.comboOggFatt);
        opener.act="reset";
   <%}
%>

opener.dialogWin.returnFunc();
<%}

if ((act!=null)&&(act.equalsIgnoreCase("unitaMisura")))
  {%>
  if (opener && !opener.closed)
    {
          opener.clear_all_combo("comboUnitaMisura");
          opener.add_combo_elem("comboUnitaMisura","-1","[Seleziona Opzione]                             ");
    <%
     if ((unitaMisuraV!=null)&&(unitaMisuraV.size()!=0))
     {
          for(Enumeration e = unitaMisuraV.elements();e.hasMoreElements();)
          {
               UnitaMisuraElem elem3=new UnitaMisuraElem();
               elem3=(UnitaMisuraElem)e.nextElement();

             %>
                 opener.add_combo_elem("comboUnitaMisura","<%=elem3.getCodeUnitaMisura()%>","<%=elem3.getDescUnitaMisura()%>");
             <%
          }
    } 
    %> 
    opener.document.oggFattForm.comboUnitaMisura[0].selected=true;
    opener.dialogWin.returnFunc();
    }
  else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%
}

if ((act==null)  ||  ((act!=null)&& !(act.equalsIgnoreCase("go_insert"))))
{
%>
// chiusura window

  	closeWindow();
<%}%>  


       

  
}
</SCRIPT>
</HEAD>

<BODY  onload="window.setTimeout(SubmitMe, 2000);setInterval('recursiveCloseWindow()',1000);">
<center>
<form name="frmDati" method="post">

	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
	</center>
</form>
</BODY>
</HTML>
