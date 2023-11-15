<%@ taglib uri="http://xmlns.oracle.com/jsp/taglibs/ejbtaglib.tld" prefix="EJB" %>
<%@ taglib uri="/webapp/pg" prefix="pg" %>
<%@ taglib uri="/webapp/sec" prefix="sec" %>
<%@ taglib uri="/webapp/logtag" prefix="logtag" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="javax.naming.*,javax.rmi.*,java.util.*,com.utl.*,com.ejbSTL.*,com.ejbBMP.*,,com.usr.*,java.text.*" %>
<%@ page errorPage = "../../common/jsp/TrackingErrorPage.jsp"%>
<logtag:logData id="<%= ((clsInfoUser)session.getAttribute(StaticContext.ATTRIBUTE_USER)).getUserName() %>">
<%=StaticMessages.getMessage(3006,"NuovaColWf.jsp")%>
</logtag:logData>


<%

// act
boolean caricaOggFatt=false;
String msg="";
String flg_ClassFatt="false";

Vector sito=null;
Integer numeroTariffe=new Integer("0");


int numElabBatch;
String codTar="";
String act              = request.getParameter("act");
String cod_PS           = request.getParameter("cod_PS");
String utrSelez         = request.getParameter("utrSelez");
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

String sitoSelez=request.getParameter("sitoSelez");
String accountSelez1=request.getParameter("accountSelez1");

String      dateFormat =  "dd/MM/yyyy";
String data_ini_jsp=null;
DateFormat  data_iniFormat = new SimpleDateFormat(dateFormat);
Date  data_ini_1;
String  dataIniValAccDB=null;
DateFormat  dataIniValAccFormat = new SimpleDateFormat(dateFormat);


if ((act!=null)&& ((act.equalsIgnoreCase("insert")) || (act.equalsIgnoreCase("cancel")) || (act.equalsIgnoreCase("update")) ))
{%>
   <EJB:useHome id="home" type="com.ejbBMP.ElaborBatchBMPHome" location="ElaborBatchBMP" />
   <EJB:useHome id="ElencoAccounthome" type="com.ejbSTL.ElencoAccountPsSTLHome" location="ElencoAccountPsSTL" />
   <EJB:useHome id="Sitohome" type="com.ejbSTL.SitoSTLHome" location="SitoSTL" />
   <EJB:useHome id="Controllihome" type="com.ejbSTL.ControlliSTLHome" location="ControlliSTL" />

    <%   
         msg = "";
         //elabBatch(request,response);
         int numeroElab=home.findElabBatchInCorso().getElabBatch();
         //System.out.println("ENTRO per insert o update o cancel");
 				 if (numeroElab==0)
				 {
            if ( (act.equalsIgnoreCase("insert")) || (act.equalsIgnoreCase("update") ))
            {
              //System.out.println("ENTRO per insert o update");
              data_ini_jsp = request.getParameter("data_ini");
              data_ini_1=data_iniFormat.parse(data_ini_jsp);
              ElencoAccountPsSTL ElencoAccountremote= ElencoAccounthome.create();
              dataIniValAccDB =ElencoAccountremote.findDataIniValAcc(accountSelez1).getDataIniValAcc();
              Date dataIniValAcc=dataIniValAccFormat.parse(dataIniValAccDB);
              if (dataIniValAcc.after(data_ini_1))
              {
                msg = "no_data";
              } 
              else
              {
               //System.out.println("ENTRO per insert");
                if (act.equalsIgnoreCase("insert"))
                {
                   int getTarXSitoVerEs =Sitohome.create().findTarXSito(sitoSelez,accountSelez1).getNumTariffe();
                   int getInventPsSpVerEs=Controllihome.create().getInventPsSpVerEs(sitoSelez,accountSelez1).getNumTariffe();
                   if ((getTarXSitoVerEs!=0)||(getInventPsSpVerEs!=0))
                   {
                      msg = "no_acc_sito";
                   }
                }   
             } 
           }
          }
          else
          {
             msg = "no_elab";
          }
}
     

if ((act!=null)&&(act.equalsIgnoreCase("sito")))
{
%>
   <EJB:useHome id="homeSito" type="com.ejbSTL.SitoSTLHome" location="SitoSTL" />
<%
    SitoSTL remoteSito= homeSito.create();
    sito=remoteSito.getSito(utrSelez);
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

<SCRIPT LANGUAGE='Javascript'>
IExplorer =document.all?true:false;
Navigator =document.layers?true:false;
function SubmitMe()
{

<%
// insert, cancel, update
if ((act!=null)&& ((act.equalsIgnoreCase("insert")) || (act.equalsIgnoreCase("cancel")) || (act.equalsIgnoreCase("update")) ))
  {%>
  if (opener && !opener.closed)
    { 
     <%if (!msg.equals("")) 
       {%>
          opener.document.account.msg.value="<%=msg%>";
          //if ("<%//=msg%>"=="no_data")
          //{   
             //opener.document.account.dataIniValAcc.value="<%//=dataIniValAccDB%>"; 
          //}    
     <%}%>      
    opener.dialogWin.returnFunc();
    }
 	else{ 
		alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
	}
<%
  }
%>
    <%

    ////////////////////////////
    if ((act!=null)&&(act.equalsIgnoreCase("sito")))
    {
      
      %>
      if (opener && !opener.closed)
      {
              opener.clear_all_combo("sito");
              opener.add_combo_elem("sito","-1","[Seleziona Opzione]                             ");
        <%
        
         if ((sito!=null)&&(sito.size()!=0))
         {
            
              for(Enumeration e = sito.elements();e.hasMoreElements();)
              {
                             
                   SitoElem elem4=new SitoElem();
                   elem4=(SitoElem)e.nextElement();
                  
                 %>
                     opener.add_combo_elem("sito","<%=elem4.getCodeSito()%>","<%=elem4.getDescSito().replace('"','\'')%>");
                 <%
              }
        } 
        
        %> 
        opener.document.account.sito[0].selected=true;
        opener.dialogWin.returnFunc();
      }
      else
      { 
        alert("You have closed the main window.\n\nNo action will be taken on the choices in this dialog box.")
      }
    <%  
    }
    ///////////////////////////
    %>

    // chiusura window
      self.close();
}
</SCRIPT>


  
</HEAD>

<BODY  onload="window.setTimeout(SubmitMe, 2000)">
<form name="frmDati" method="post">
	<center>
		<font class="red">ELABORAZIONE IN CORSO...</font><br>
		<img src="../../common/images/body/orologio.gif" width="60" height="50" alt="" border="0">
	</center>
<!-- INIZIO -->



<!-- FINE -->


  
</form>
</BODY>
</HTML>
