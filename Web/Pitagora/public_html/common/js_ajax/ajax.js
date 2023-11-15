function handler_generico(http,callbackOk,callbackErr)
{

  if (http.readyState == 4) {
      if (http.status == 200) 
              {
      
                  orologio.style.visibility='hidden';
                  orologio.style.display='none';
                  maschera.style.visibility='visible';
                  maschera.style.display='inline';

                  eval(http.responseText);
          if(dati.length>0)
          {
                if(dati[0].messaggio!=null)
                   callbackErr(dati);
                 else
                   callbackOk(dati);
          
          }
          else
                     callbackOk(dati);
                 
              }
      else if (http.status == 404) 
              {
                  alert("ERRORE\n\nl'URL non esiste_1");
              }
      else if ((http.status == 401) || (http.status == 403)) 
              {
                   alert("ERRORE\n\nAccesso negato");
              }
       else   {
                  alert("ERRORE\n\nCodice di stato della richiesta: " + http.status);
              }
    }

}

function handler_dinamicTable(http,callbackOk,callbackErr)
{

  if (http.readyState == 4) {
      if (http.status == 200) 
              {
      
                  orologio.style.visibility='hidden';
                  orologio.style.display='none';
                  maschera.style.visibility='visible';
                  maschera.style.display='inline';
                
                  eval(http.responseText);
                   
          if(dati.length>0)
          {
                if(dati[0].messaggio!=null)
                   callbackErr(dati);
                 else
                   callbackOk(dati,headerTab,pag_tab,max_pag,tot_rows);
          
          }
          else
                     callbackOk(dati,headerTab,pag_tab,max_pag,tot_rows);
                 
              }
      else if (http.status == 404) 
              {
                  alert("ERRORE\n\nl'URL non esiste_1");
              }
      else if ((http.status == 401) || (http.status == 403)) 
              {
                   alert("ERRORE\n\nAccesso negato");
              }
       else   {
                  alert("ERRORE\n\nCodice di stato della richiesta: " + http.status);
              }
    }

}

function getHTTPObject() {
  var http_request;
  if (window.XMLHttpRequest) { // Mozilla, Safari,...
            http_request = new XMLHttpRequest();
            if (http_request.overrideMimeType) {
                http_request.overrideMimeType('text/html');
                
               }
        } else if (window.ActiveXObject) { // IE
            try {
                http_request = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                try {
                    http_request = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e) {}
            }
        }

        if (!http_request) {
            alert('Giving up :( Non riesco a creare una istanza XMLHTTP');
            return false;
        }
  return http_request;
}

function chiamaRichiesta(sendMessage,nomeFunzione,callback)
{
  orologio.style.visibility='visible';
  orologio.style.display='inline';
  maschera.style.visibility='hidden';
  maschera.style.display='none';
   var url = "../../servletStrutturaWeb";
  // configurazione della richiesta
  http.open("POST", url, true);

  //definizione della callback chiamata quando viene ricevuta la risposta
  http.onreadystatechange = callback;

  // imposto il giusto header
  http.setRequestHeader("content-type", "application/x-www-form-urlencoded");
  http.send(sendMessage+'&action='+nomeFunzione);
}

function riempiSelect(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length;a++)
      {
         eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
      }
}

function riempiSelectServizi(select, div1, input, dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length-1;a++)
      {
         eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
      }
    
    eval('document.formPag.'+input+'.value = dati[a].value;');
    livello = document.getElementById(div1);
    
    if(dati[a].value != 0 ) {
       livello.innerHTML='Ultimo Congelamento ' + dati[a].text;
    } else {
       livello.innerHTML=dati[a].text;
    }
}



function spostaElemento(selectT,selectT2)
{
  eval('var select=document.formPag.'+selectT+';');
  eval('var select2=document.formPag.'+selectT2+';');
  var indice=select.selectedIndex;
  if(indice!=-1)
  {
    var optionSel=select.options[indice];
    var lung=select2.length;
    select2.options[select2.length]=new Option(optionSel.text,optionSel.value);
    select.options[indice]=null;
    select.selectedIndex=indice-1;
  }
}
function spostaElemento(selectT,selectT2)
{
  eval('var select=document.formPag.'+selectT+';');
  eval('var select2=document.formPag.'+selectT2+';');
  var indice=select.selectedIndex;
  if(indice!=-1)
  {
    var optionSel=select.options[indice];
    var lung=select2.length;
    select2.options[select2.length]=new Option(optionSel.text,optionSel.value);
    select.options[indice]=null;
    select.selectedIndex=indice-1;
  }


}
function spostaElementi(selectT,selectT2)
{

  eval('var select=document.formPag.'+selectT+';');
  eval('var select2=document.formPag.'+selectT2+';');

  var length=select.length;
for(indice=0;indice<length;indice++)
{

  var optionSel=select.options[0];
  select2.options[select2.length]=new Option(optionSel.text,optionSel.value);
  select.options[0]=null;
    
}

select.selectedIndex=-1;

}

function riempiTabellaSelezionabile(divTabella,dati,nomiColonne,posValore,onselected)
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

        for(j=0;j<nomiColonne.length;j++)
        {
           eval('colonna=dati[i].colonna'+j+';');
           if(!colonna)
            break;
     
           tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';

        }
        tabella+="</tr>";
        primo='';
      }
  }
  tabella+="</table>";

  divTabella.innerHTML=tabella;
}




function nascondiErrore()
{
   maschera.style.visibility='visible';
   maschera.style.display='block';
   dvMessaggio.style.display='none';
   dvMessaggio.style.visibility='hidden';
}

function gestisciMessaggioConFunzioneRitorno(messaggio,onCliks)
{

   eval(onCliks);
  gestisciMessaggio(messaggio);
}

function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='inline';
   dvMessaggio.style.visibility='visible';
}

function riempiTabella(divTabella,dati,nomiColonne)
{
  var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
  tabella+="<tr>";
  for(i=0;i<nomiColonne.length;i++)
  {
    tabella+='<td class=\"textB\">'+nomiColonne[i]+'</td>';
  }
  tabella+="</tr>";
  if(dati.length==0)
  {
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>Dati Assenti</td></tr>';
  }
  else
  {        
      for(i=0;i<dati.length;i++)
      {
         if(i%2==0)
            bgcol="#cfdbe9";
           else
             bgcol="#ebf0f0";
         
        tabella+='<tr>';
        for(j=0;j<nomiColonne.length;j++)
        {
           eval('colonna=dati[i].colonna'+j+';');
           if(!colonna)
            break;
     
           tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
        }
        tabella+="</tr>";

      }
  }
  tabella+="</table>";
  divTabella.innerHTML=tabella;


}

function tabMod(labelColonna, mod, vis)
{
  this.labelColonna = labelColonna;
  this.mod = mod;
  this.vis = vis;
}

function riempiTabellaModificabile(divTabella,dati,colonne)
{
  var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
  tabella+="<tr>";
  for(i=0;i<colonne.length;i++)
  {
    if(colonne[i].vis)
    {
      tabella+='<td class=\"textB\">'+colonne[i].labelColonna+'</td>';
    }
  }
  tabella+="</tr>";
  if(dati.length==0)
  {
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(colonne.length+1)+'>Dati Assenti</td></tr>';
  }
  else
  {        
      for(i=0;i<dati.length;i++)
      {
         if(i%2==0)
            bgcol="#cfdbe9";
         else
            bgcol="#ebf0f0";
         
         tabella+='<tr>';
         for(j=0;j<colonne.length;j++)
         {
          eval('colonna=dati[i].colonna'+j+';');
       //   if(!colonna)
        //    break;
          var idColonna=i+"_"+j;
          if(!colonne[j].vis)
          {
            tabella+="<input value=\""+colonna+"\" id="+idColonna+" name="+idColonna+" type=\"hidden\" maxlength=\"255\"/>";
          }
          else if(!colonne[j].mod)
          {
            tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
            tabella+="<input value=\""+colonna+"\" id="+idColonna+" name="+idColonna+" type=\"hidden\" maxlength=\"255\"/>";
          }
          else
          {
            var escCol = colonna.split(' ').join('&nbsp;');
            
            tabella+="<td class=\"text\" bgcolor="+bgcol+"><input value=\""+colonna+"\" id="+idColonna+" name="+idColonna+" type=\"text\" maxlength=\"255\"/></td>"; 
          }
        }
        tabella+="</tr>";
      }
  }
  tabella+="</table>";
  divTabella.innerHTML=tabella;
}

//function riempiTabellaModificabile(divTabella,dati,nomiColonne,nomiColonneModificabili)
//{
//  var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
//  tabella+="<tr>";
//  for(i=0;i<nomiColonne.length;i++)
//  {
//    tabella+='<td class=\"textB\">'+nomiColonne[i]+'</td>';
//  }
//  tabella+="</tr>";
//  if(dati.length==0)
//  {
//    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>Dati Assenti</td></tr>';
//  }
//  else
//  {        
//      for(i=0;i<dati.length;i++)
//      {
//         if(i%2==0)
//            bgcol="#cfdbe9";
//         else
//            bgcol="#ebf0f0";
//         
//         tabella+='<tr>';
//         for(j=0;j<nomiColonne.length;j++)
//         {
//           var mod = false;
//           eval('colonna=dati[i].colonna'+j+';');
//           if(!colonna)
//             break;
//           for(k=0;k<nomiColonneModificabili.length;k++)
//           {
//              if(nomiColonne[j] == nomiColonneModificabili[k])
//              {
//               // è una colonna modificabile
//               mod = true;
//               break;
//              }
//            }
//            if(!mod)
//              tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
//            else
//            {
//              //var escCol = colonna.replace(' ', '&nbsp;');
//              var escCol = colonna.split(' ').join('&nbsp;');
//              tabella+="<td class=\"text\" bgcolor="+bgcol+"><input type=\"text\" value="+escCol+" id="+nomiColonne[j]+"/></td>"; 
//              //tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
//            }
//          }
//          tabella+="</tr>";
//
//      }
//  }
//  tabella+="</table>";
//  divTabella.innerHTML=tabella;
//}

function riempiTabellaPadding(divTabella,dati,nomiColonne,padding)
{

  var tabella="<table width=\"100%\" height=\"100%\" style=\"text-align:center\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding="+padding+'>';
  tabella+='<thead ><tr>';
  for(i=0;i<nomiColonne.length;i++)
  {
    tabella+='<th class=\"textB\">'+nomiColonne[i]+'</th>';
  }
  tabella+='</tr></thead>';
  if(dati.length==0)
  {
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>Dati Assenti</td></tr><tbody>';
  }
  else
  {        
      for(i=0;i<dati.length;i++)
      {
         if(i%2==0)
            bgcol="#cfdbe9";
           else
             bgcol="#ebf0f0";
         
        tabella+='<tr>';
        for(j=0;j<nomiColonne.length;j++)
        {
           eval('colonna=dati[i].colonna'+j+';');
           if(!colonna)
            break;
     
           tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
        }
        tabella+="</tr>";

      }
  }
  tabella+="</tbody></table>";
  divTabella.innerHTML=tabella;


}

function riempiTabellaNoCache(divTabella,
                                                  dati,
                                                  nomiColonne,
                                                  page,
                                                  numPage,
                                                  onPager
                                                  )
{

   riempiTabellaPadding(divTabella,dati,nomiColonne,4);

   table='<table width=\"100%\" height=\"100%\" align=\"center\"><tr><td >'
   table+=divTabella.innerHTML;
   table+="</td></tr><tr><td bgcolor=\"#0a6b98\"  class=\"white\" >";
  if(page>5)
  {
    table+='<a onclick="'+onPager+'('+(page-6)+')";><<&nbsp</a>';
    k=page-5;
  }
  else
    k=0;
  for(j=0;j<10;j++)
  {
    if(k>=numPage)
      break;
    if(j==9)
      table+='<a  style="cursor:Hand" onclick="'+onPager+'('+k+');">>>&nbsp</a>';
    else
      table+='<a style="cursor:Hand" onclick="'+onPager+'('+k+');" >'+k+'&nbsp</a>';
    k++;
    
  }
  table+="</td></tr></table>";  
  divTabella.innerHTML=table; 
}

function riempiTabellaSelezionabilePagerEricerca(divTabella,
                                                  dati,
                                                  nomiColonne,
                                                  posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                                  onPager
                                                  )
{
   var _datiPager=new Array();
   eval('txtBox=document.formPag.'+idRicerca+';');
   eval('cmbMaxRow=document.formPag.'+idRicerca+'_combo;');

   
   var valoreRicerca='';
   if(txtBox!=null)
   {
    valoreRicerca=txtBox.value;
   }
   j=0;
   k=0;


  var numDati=0;
  var finito=false;
   for(i=0;i<dati.length;i++)
   {
      
      if((j==maxRow)&&(k<page))
      {
        k++;
        j=0;
        startRow=i;
      }
      else if((j==maxRow)&&(k==page))
      {
        finito=true;
      }
        
      eval('colonna=dati[i].colonna'+colonnaRicerca+';');
      if(cmbMaxRow!=null)
      {
          indCom=cmbMaxRow.selectedIndex;
          maxRow=cmbMaxRow.options[indCom].value;
      }
      if(txtBox!=null)
      {
         valoreRicerca=txtBox.value;
        if(colonna.toLowerCase().match(".*"+valoreRicerca.toLowerCase()+".*"))
        {
            if(finito==false)
            {
             _datiPager[j]=dati[i];
              j++;
            }
            numDati++;

        }
                 
      }
      else
      {
            if(finito==false)
            {
              _datiPager[j]=dati[i];
                j++;
            }
          numDati++;

      }
    

   }
    datiPager=new Array();
    for(z=0;z<j;z++)
    {
        datiPager[z]=_datiPager[z];
    }

    if(onselected=='')
      riempiTabella(divTabella,datiPager,nomiColonne);
    else
      riempiTabellaSelezionabile(divTabella,datiPager,nomiColonne,posValore,onselected);

   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
 
  table='<table width=\"100%\" height=\"100%\" align=\"center\"> <tr align=\"left\" '+ricercaVisibile+'><td> <input type="text" id="'+idRicerca+'" value="'+valoreRicerca+'" />'+
  '<input type="button" class="textB" Value="Ricerca" onclick="'+onRicerca+'();"/> </td>'+
  '<td class="textB"> Righe per pag. &nbsp<select name='+idRicerca+'_combo id='+idRicerca+'_combo onChange="'+onRicerca+'();"><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> </tr><tr><td colspan=2>';
 
   table+=divTabella.innerHTML;
  numPage=numDati/maxRow;
  table+="</td></tr><tr><td colspan=2 bgcolor=\"#0a6b98\"  class=\"white\" >";
  if(page>5)
  {
    table+='<a onclick="'+onPager+'('+(page-6)+')";><<&nbsp</a>';
    k=page-5;
  }
  else
    k=0;
  for(j=0;j<10;j++)
  {
    if(k>=numPage)
      break;
    if(j==9)
      table+='<a  style="cursor:Hand" onclick="'+onPager+'('+k+');">>>&nbsp</a>';
    else
      table+='<a style="cursor:Hand" onclick="'+onPager+'('+k+');" >'+k+'&nbsp</a>';
    k++;
    
  }
  table+="</td></tr></table>";  
  divTabella.innerHTML=table; 
  return datiPager.length;
}


function TrimLongLinks(stringa){
var ritorno;

if(stringa.length>23)
{
  ritorno="<acronym title='"+stringa+"'>"+stringa.substr(0,20)+" … </acronym>";
}
else
{
  ritorno=stringa;
}
return ritorno;
}


function riempiTabellaLink(divTabella,dati,nomiColonne,campoLink,nomiCampiFunction,functionLink)
{
	var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
  tabella+="<tr>";
  
  var campiFunction = '';

  for(i=0;i<nomiColonne.length;i++)
  {
    tabella+='<td class=\"textB\">'+nomiColonne[i]+'</td>';
  }
  tabella+="</tr>";
  if(dati.length==0)
  {
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>Dati Assenti</td></tr>';
  }
  else
  {
  	for(i=0;i<dati.length;i++)
    {
    	if(i%2==0)
      	bgcol="#cfdbe9";
      else
      	bgcol="#ebf0f0";
        
      campiFunction = '';   
      
      tabella+='<tr>';
      for(j=0;j<nomiColonne.length;j++)
      {
      	eval('colonna=dati[i].colonna'+j+';');
        if(!colonna)
        	break;

        /*campi necesari alla funzione richiamata dal link*/
        for(k=0;k<nomiCampiFunction.length;k++)
        {
          if(nomiColonne[j] == nomiCampiFunction[k]){
            if(campiFunction == '')
              campiFunction = campiFunction + colonna;
            else
              campiFunction = campiFunction + ','+ colonna;
          }
        }
        
     		if(nomiColonne[j] == campoLink){
     			if(colonna != null && colonna != '' && colonna != '0'){
     				tabella+='<td class=\'text\' bgcolor='+bgcol+' ><a href="javascript:'+functionLink+'('+campiFunction+')">Dettagli...</a></td>';
     			}else{
            colonna = '';
     				tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
          }
     		}else{
          if(colonna.length>23)
          {
              tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+TrimLongLinks(colonna)+'</td>';
          }else
          {
              tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
          }
          if(j==nomiColonne.length-1)
          {
            document.formPag.desc_listino_applicato.value=colonna;
            document.formPag.desc_listino_applicato_old.value=colonna;
          }
          else
          {
            document.formPag.desc_listino_applicato.value='';
            document.formPag.desc_listino_applicato_old.value='';
          }
          
        }
      }
      tabella+="</tr>";

    }
  }
  divTabella.innerHTML=tabella;
}


function riempiTabellaLinkMore(divTabella,dati,nomiColonne,campoLink,nomiCampiFunction,functionLink,nomeLink)
{
	var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"2\" cellpadding=\"2\">";
  tabella+="<tr>";
  
  var campiFunction = '';

  for(i=0;i<nomiColonne.length;i++)
  {
    tabella+='<td class=\"textB\">'+nomiColonne[i]+'</td>';
  }
  tabella+="</tr>";
  if(dati.length==0)
  {
    tabella+='<tr><td bgcolor=\"#ffffff\" width=\'2%\' colspan='+(nomiColonne.length+1)+'>'+nomeLink+'</td></tr>';
  }
  else
  {
  	for(i=0;i<dati.length;i++)
    {
    	if(i%2==0)
      	bgcol="#ebf0f0";
      else
      	bgcol="#cfdbe9";
        
      campiFunction = '';   
      
      tabella+='<tr>';
      for(j=0;j<nomiColonne.length;j++)
      {
       	eval('colonna=dati[i].colonna'+j+';');
        /*campi necesari alla funzione richiamata dal link*/
        for(k=0;k<nomiCampiFunction.length;k++)
        {
          if(nomiColonne[j] == nomiCampiFunction[k]){
            if(campiFunction == '')
              campiFunction = campiFunction + '\''+colonna+'\'';
            else
              campiFunction = campiFunction + ',\''+colonna+'\'';
          }
        }
        
     		if(nomiColonne[j] == campoLink){
            //alert('<td class=\'text\' bgcolor='+bgcol+' ><a href="javascript:'+functionLink+'('+campiFunction+')">'+nomeLink+'</a></td>')
     				tabella+='<td class=\'text\' bgcolor='+bgcol+' ><a href="javascript:'+functionLink+'('+campiFunction+')">'+nomeLink+'</a></td>';
        }else{
        	tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
        }
      }
      tabella+="</tr>";

    }
  }
  divTabella.innerHTML=tabella;
}

function riempiSelectByElementName(selectName,datiServizi)
{
document.getElementsByName(selectName)[0].innerText = null;
  for(a=0;a <= datiServizi.length-1;a++)
  {
        var option = document.createElement("option");
        option.text=datiServizi[a].text;
        option.value=datiServizi[a].value;
        document.getElementsByName(selectName)[0].add(option);
  }
}


function riempiTabellaSelezionabilePagerEricercaCombo(divTabella,
                                                  dati,
                                                  nomiColonne,
                                                  posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                                  onPager                                                  
                                                  )
{
   var _datiPager=new Array();
  
   eval('cmbMaxRow=document.formPag.'+idRicerca+'_combo;');  
   eval('txtBox=document.formPag.'+idRicerca+';');
      var valoreRicerca='';

   j=0;
   k=0;
  var numDati=0;
  var finito=false;
   for(i=0;i<dati.length;i++)
   {      
      if((j==maxRow)&&(k<page))
      {
        k++;
        j=0;
        startRow=i;
      }
      else if((j==maxRow)&&(k==page))
      {
        finito=true;
      }
        
      eval('colonna=dati[i].colonna'+colonnaRicerca+';');
      if(cmbMaxRow!=null)
      {
          indCom=cmbMaxRow.selectedIndex;
          maxRow=cmbMaxRow.options[indCom].value;
      }

            if(finito==false)
            {
              _datiPager[j]=dati[i];
                j++;
            }
          numDati++;

   }
    datiPager=new Array();
    for(z=0;z<j;z++)
    {
        datiPager[z]=_datiPager[z];
    }
    if(onselected=='')
      riempiTabella(divTabella,datiPager,nomiColonne);
    else
      riempiTabellaSelezionabile(divTabella,datiPager,nomiColonne,posValore,onselected);
       if(dati.length===0 ){
        divTabella.childNodes[0].deleteRow(0);    
        }
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
     
      table='<table width=\"75%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" >'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6>&nbsp;Risultati di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr><td colspan=10>';
     
      table+=divTabella.innerHTML;
      numPage=numDati/maxRow;
      table+="</td></tr><tr><td colspan=10 bgcolor=\"#0a6b98\"  class=\"white\" >";
      if(page>5)
      {
        table+='<a onclick="'+onPager+'('+(page-6)+')";><<&nbsp</a>';
        k=page-5;
      }
      else
        k=0;
  for(j=0;j<10;j++)
  {
    if(k>=numPage)
      break;
    if(j==9)
      table+='<a  style="cursor:Hand" onclick="'+onPager+'('+k+');">>>&nbsp</a>';
    else
      table+='<a style="cursor:Hand" onclick="'+onPager+'('+k+');" >'+k+'&nbsp</a>';
    k++;
    
  }
  table+="</td></tr></table>";  
  divTabella.innerHTML=table;
  return datiPager;
}

function riempiTabellaRicerca(divTabella,
                       dati,
                       nomiColonne,
                       posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                                  onPager                                                  
                                                  )
{
   var valoreRicerca='';
   var _datiPager=new Array();
   var datiPager=new Array();
  
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
     
      table='<table width=\"75%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" id=\"tableRicerca\">'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Filtro di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Servizi</td>'+
      '<td  width="20%" align="left" nowrap><select name="Servizi" id="Servizi" class="text" onchange="Servizio()" ><option value="" selected disabled >Selezionare Servizio</option></select></td>'+      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Codice Area Raccolta</td>'+
      '<td  > <input type="text" class="text" id="'+idRicerca+'" name="'+idRicerca+'"value="'+valoreRicerca+'" /></td>'+
      '<td class="textB" align="right"> Righe per pag. &nbsp</td>'+
      '<td ><select class="text" name='+idRicerca+'_combo id='+idRicerca+'_combo onChange="'+onRicerca+'();"><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> '+
      '<td ><input type="button" class="textB" Value="Ricerca" onclick="'+onRicerca+'();"/> </td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" width="5%" align="left" style="padding-left: 25px;" nowrap>Account</td>'+
      '<td width="20%"  align="left" nowrap colspan=6><select name="Account" class="text" id="Account" ><option value="" selected disabled >Selezionare Account</option></select></td>'+
      '</tr>'+
      '<tr height=\"5px\"><td></td></tr></table>';
      
       table+=divTabella.innerHTML;
    
  divTabella.innerHTML=table;
  return datiPager;
}

//DOR ADD -Begin-
function riempiTabellaRicercaPromozioniProgetto(divTabella,
                                                dati,
                                                nomiColonne,
                                                posValore,
                                                onselected,
                                                page,
                                                maxRow,
                                                colonnaRicerca,
                                                idRicerca,
                                                onRicerca,
                                                onPager )
{
   var valoreRicerca='';
   var _datiPager=new Array();
   var datiPager=new Array();
  
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
     
      table='<table width=\"75%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" id=\"tableRicerca\">'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Filtro di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Servizi</td>'+
      '<td  width="20%" align="left" nowrap><select name="Servizi" id="Servizi" class="text" onchange="Servizio()" ><option value="" selected disabled >Selezionare Servizio</option></select></td>'+      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Codice Progetto</td>'+
      '<td  > <input type="text" class="text" id="'+idRicerca+'" name="'+idRicerca+'"value="'+valoreRicerca+'" maxlength="10" /></td>'+
      '<td class="textB" align="right"> Righe per pag. &nbsp</td>'+
      '<td ><select class="text" name='+idRicerca+'_combo id='+idRicerca+'_combo onChange="'+onRicerca+'();"><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> '+
      '<td ><input type="button" class="textB" Value="Ricerca" onclick="'+onRicerca+'();"/> </td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+      
      '<td class="textB" width="5%" align="left" style="padding-left: 25px;" nowrap>Account</td>'+      
      '<td width="20%"  align="left" nowrap colspan=6><select name="Account" class="text" id="Account" onchange="onAccount();" ><option value="" selected disabled >Selezionare Account</option></select></td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Codice Promozione</td>'+
      '<td  colspan=6> <select name="Promozioni" class="text" id="Promozioni" ><option value="" selected disabled >Selezionare Codice Promozione</option></select></td>'+
      '</tr>'+
/* 	'  <tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
        '    <TD  class="textB" >'+
        '      Data inizio Validit&agrave; :&nbsp;'+
        '    </TD>'+
	'    <TD width="30%">'+
        '      <INPUT class="text" id="txtDataInizioValidita" name="txtDataInizioValidita" readonly obbligatorio="si" tipocontrollo="data" label="Data inizio validità" value="" size="20" Update="false">'+
        '      <a name="calDIV" id="calDIV "href="javascript:showCalendar(\'formPag.txtDataInizioValidita\',\'\');"  onMouseOver="javascript:showMessage(\'seleziona\'); return true;" onMouseOut="status=\'\';return true"><img name="imgCalendar" alt="Seleziona data" src="../../common/images/body/ICOCalendar.gif" border="0"></a>'+
        '      <a name="cancDIV" id="cancDIV" href="javascript:clearField(frmDati.txtDataInizioValidita);" onMouseOver="javascript:showMessage(\'cancella\');  return true;" onMouseOut="status=\'\';return true"><img name="imgCancel" alt="Cancella data"  src="../../common/images/body/remove.gif"   border="0"></a>'+
        '      <input type="hidden" id="txtDataInizioValiditaOld">'+
        '    </TD>'+
        '         '+
        '    <TD  class="textB"  >'+
        '      Data fine Validit&agrave; :&nbsp;'+
        '    </TD>'+
	'    <TD width="30%">'+
        '      <INPUT class="text" id="txtDataFineValidita" name="txtDataFineValidita" readonly  tipocontrollo="data" label="Data Fine validità" value="" size="20" Update="false">'+
        '      <a  name="calDFV" id="calDFV" href="javascript:showCalendar(\'formPag.txtDataFineValidita\',\'\');"  onMouseOver="javascript:showMessage(\'seleziona\'); return true;" onMouseOut="status=\'\';return true"><img name="imgCalendar" alt="Seleziona data" src="../../common/images/body/ICOCalendar.gif" border="0"></a>'+
        '      <a name="cancDFV" id="cancDFV"  href="javascript:clearField(frmDati.txtDataFineValidita);" onMouseOver="javascript:showMessage(\'cancella\');  return true;" onMouseOut="status=\'\';return true"><img name="imgCancel" alt="Cancella data"  src="../../common/images/body/remove.gif"   border="0"></a>'+
        '      <input type="hidden" id="txtDataFineValiditaOld">'+
        '    </TD>'+
	'		<TD colspan=3></TD>'+
	'  </tr>'+*/
      '<tr height=\"5px\"><td></td></tr></table>';
      
       table+=divTabella.innerHTML;
    
  divTabella.innerHTML=table;
  return datiPager;
}

function riempiTabellaRicercaCodiceProgetto(divTabella,
                                                  dati,
                                                  nomiColonne,
                                                  posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                            onPager )
{
   var valoreRicerca='';
   var _datiPager=new Array();
   var datiPager=new Array();
  
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
   {      
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
      }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
      /*
       var cancellaBt = "<a href=\"javascript:cancelCalendar();\" onMouseOver=\"javascript:showMessage('cancella'); return true;\" onMouseOut=\"status='';return true\"><img name='cancel' src=\"../../common/images/body/cancella.gif\" border=\"0\"></a>";
        var dataInputTxt ="<input type=\"text\" class=\"text\" name=\"txtDataDiRiferimento\" id=\"txtDataDiRiferimento\" maxlength=\"10\" size=\"10\" disabled=\"true\">";
        var calendario ="<a href=\"javascript:showCalendar('formPag.txtDataDiRiferimento','sysdate');\" onMouseOver=\"javascript:showMessage('seleziona'); return true;\" onMouseOut=\"status='';return true\">";
        var calendarioImg ="<img name=\"calendar\" src=\"../../common/images/body/calendario.gif\" border=\"no\"></a>";
        divDataDiRiferimento.innerHTML = "<table><tr><td>"+dataInputTxt+"</td><td>"+calendario+calendarioImg+"</td><td>"+cancellaBt+"</td></tr></table>";
*/

      table='<table width=\"75%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" id=\"tableRicerca\">'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Filtro di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+ 
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Servizi Logici</td>'+
      '<td  width="20%" align="left" nowrap><select name="Servizi" id="Servizi" class="text" onchange="Servizio()" ><option value="" selected disabled >Selezionare Servizio</option></select></td>'+      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Codice Progetto</td>'+
      '<td  > <input type="text" class="text" id="'+idRicerca+'" name="'+idRicerca+'"value="'+valoreRicerca+'" maxlength="10" /></td>'+
      '<td class="textB" align="right"> Righe per pag. &nbsp</td>'+
      '<td ><select class="text" name='+idRicerca+'_combo id='+idRicerca+'_combo onChange="'+onRicerca+'();"><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> '+
      '<td ><input type="button" class="textB" Value="Ricerca" onclick="'+onRicerca+'();"/> </td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" width="5%" align="left" style="padding-left: 25px;" nowrap>Account</td>'+
      '<td width="20%"  align="left" nowrap colspan=6><select name="Account" class="text" id="Account" ><option value="" selected disabled >Selezionare Account</option></select></td>'+
      '</tr>'+
      '<tr align="left" bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">' +
          
          
          //'<td input type=\"text\" class=\"text\" name=\"txtDataDiRiferimento\" id=\"txtDataDiRiferimento\" maxlength=\"10\" size=\"10\" disabled=\"true\">' +
      //'<td class="text" align="left" >' + calendario + calendarioImg + cancellaBt + '</td>' +
      /*
      '<tr align="left" bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">' +
          '<td  class="textB" width="5%" align="left" style="padding-left: 25px;" nowrap>Data di riferimento</td>' +
          '<td class="text" align="left" >' + calendario + calendarioImg + cancellaBt + '</td>' +
          '<input type=\"text\" class=\"text\" name=\"txtDataDiRiferimento\" id=\"txtDataDiRiferimento\" maxlength=\"10\" size=\"10\" disabled=\"true\">'+
          '<td colspan="6">' +dataInputTxt+ '</td>' +
      '</tr>' +
      */
      '<tr height=\"5px\"><td></td></tr></table>';

      
      /*
      table='<table width=\"75%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" id=\"tableRicerca\">'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Filtro di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Servizi</td>'+
      '<td  width="20%" align="left" nowrap><select name="Servizi" id="Servizi" class="text" onchange="Servizio()" ><option value="" selected disabled >Selezionare Servizio</option></select></td>'+      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Codice Progetto</td>'+
      '<td  > <input type="text" class="text" id="'+idRicerca+'" name="'+idRicerca+'"value="'+valoreRicerca+'" maxlength="10" /></td>'+
      '<td class="textB" align="right"> Righe per pag. &nbsp</td>'+
      '<td ><select class="text" name='+idRicerca+'_combo id='+idRicerca+'_combo onChange="'+onRicerca+'();"><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> '+
      '<td ><input type="button" class="textB" Value="Ricerca" onclick="'+onRicerca+'();"/> </td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '</tr>'+
      '<tr height=\"5px\"><td></td></tr></table>';
      */
       table+=divTabella.innerHTML;
    
  divTabella.innerHTML=table;
  return datiPager;
}
//DOR ADD -End-

function riempiTabellaRicercaCinqueAnni(divTabella,
                       dati,
                       nomiColonne,
                       posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                                  onPager                                                  
                                                  )
{
   var valoreRicerca='';
   var _datiPager=new Array();
   var datiPager=new Array();
  
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
     
      table='<table width=\"85%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" id=\"tableRicerca\">'+ 
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Filtro di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Servizi</td>'+
      '<td  width="20%" align="left" nowrap><select name="Servizi" id="Servizi" class="text" onchange="Servizio()" ><option value="" selected disabled >Selezionare Servizio</option></select></td>'+      
      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Fino a Data Da</td>'+
      '<td  width="20%" align="left" nowrap><select name="dataDa" id="dataDa" class="text" onChange="onDataDaChange()"><option value="" selected disabled >Selezionare fino a Data Da</option></select></td>'+      

      '<td class="textB" align="right"></td>'+
      '<td class="textB" align="right"> Righe per pag. &nbsp</td>'+

      '<td ><select class="text" name='+idRicerca+'_combo id='+idRicerca+'_combo ><option value="5" '+selected1+'>5</option><option value="10" '+selected2+'>10</option><option value="50" '+selected3+'>50</option></select></td> '+
   
      '</tr>'+
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+      
      '<td class="textB" width="5%" align="left" style="padding-left: 25px;" nowrap>Account</td>'+      
      '<td width="20%"  align="left" nowrap ><select name="Account" class="text" id="Account" onChange="onAccountChange()"><option value="" selected disabled >Selezionare Account</option></select></td>'+
      
      '<td class="textB" style="padding-left: 25px;" width="5%" align="left" nowrap>Risorsa</td>'+
      '<td  width="20%" colspan=5 align="left" nowrap><select name="risorsa" id="risorsa" class="text" onChange="onRisorsaChange()"><option value="" selected disabled >Selezionare Risorsa</option></select></td>'+      

      '</tr>'+
    
      '<tr align=\"center\" height=\"5px\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0"><td class="textB" colspan=7 style="padding-left: 25px;" width="5%" align="left" nowrap></td></tr>'+     
      
      '<tr align=\"center\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0">'+      
        '<td class="textB" style="padding-left: 25px;" width="5%" align="center" colspan=7 nowrap><input type="button" class="textB" Value="Ricerca" id="Ricerca" onclick="'+onRicerca+'();"colspan=7 disabled/> </td>'+
      '</tr>'+

      '<tr height=\"5px\"><td></td></tr>'+     
      '</table>';
      
       table+=divTabella.innerHTML;
    
  divTabella.innerHTML=table;
  return datiPager;
}

function riempiTabellaSelezionabileCinqueAnni(divTabella,
                                                  dati,
                                                  nomiColonne,
                                                  posValore,
                                                  onselected,
                                                  page,
                                                  maxRow,
                                                  colonnaRicerca,
                                                  idRicerca,
                                                  onRicerca,
                                                  onPager                                                  
                                                  )
{
   var _datiPager=new Array();
  
   eval('cmbMaxRow=document.formPag.'+idRicerca+'_combo;');  
   eval('txtBox=document.formPag.'+idRicerca+';');
      var valoreRicerca='';

   j=0;
   k=0;
  var numDati=0;
  var finito=false;
   for(i=0;i<dati.length;i++)
   {      
      if((j==maxRow)&&(k<page))
      {
        k++;
        j=0;
        startRow=i;
      }
      else if((j==maxRow)&&(k==page))
      {
        finito=true;
      }
        
      eval('colonna=dati[i].colonna'+colonnaRicerca+';');
      if(cmbMaxRow!=null)
      {
          indCom=cmbMaxRow.selectedIndex;
          maxRow=cmbMaxRow.options[indCom].value;
      }

            if(finito==false)
            {
              _datiPager[j]=dati[i];
                j++;
            }
          numDati++;

   }
    datiPager=new Array();
    for(z=0;z<j;z++)
    {
        datiPager[z]=_datiPager[z];
    }
    if(onselected=='')
      riempiTabella(divTabella,datiPager,nomiColonne);
    else
      riempiTabellaSelezionabileCheckBox(divTabella,datiPager,nomiColonne,posValore,onselected);
       if(dati.length===0 ){
        divTabella.childNodes[0].deleteRow(0);    
        }
   var selected1='';
   var selected2='';
   var selected3='';
  if(maxRow==5)
  {
    selected1="selected";
  }
  if(maxRow==10)
  {
     selected2="selected";
  }
  if(maxRow==50)
  {
    selected3="selected";
  }
  ricercaVisibile='';
  
  if(onRicerca=='')
      ricercaVisibile='style="visibility:hidden;display:none"';
     
      table='<table width=\"85%\" height=\"100%\" align=\"center\" cellspacing="0" cellpadding="3" >'+ 
       '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6 >&nbsp;Modalità di Inserimento</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%" ><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+ 
      '<tr align=\"left\" '+ricercaVisibile+' bgcolor="#CFDBE9" border="0" cellpadding="0" cellspacing="0" >'+
      '<td  class="textB" width="5%" align="center" style="padding-left: 25px;" nowrap colspan=7>'+
       'Includi tutti <input type="radio" name="statoAll" value="0" onclick="onRadio(this,false)"/> Escludi tutti  <input type="radio" name="statoAll" value="1" onclick="onRadio(this,false)"/>Seleziona <input type="radio" name="statoAll" value="2" checked="checked" onclick="onRadio(this,false)"/>'+
      '</td>'+  
      '</tr>'+       
      '<tr height=\"5px\"><td></td></tr>'+
      '<tr style="outline: thin solid #0a6b98"><td class="white" valign="top" bgcolor="#0a6b98" width="91%"colspan=6>&nbsp;Risultati di Ricerca</td>'+
      '<td class="white" bgcolor="#ffffff" align="center" width="9%"><img src="../../common/images/body/quad_blu.gif"></td>'+
      '</tr>'+
      '<tr><td colspan=10>';
     
      table+=divTabella.innerHTML;
      numPage=numDati/maxRow;
      table+="</td></tr><tr><td colspan=10 bgcolor=\"#0a6b98\"  class=\"white\" >";
      if(page>5)
      {
        table+='<a onclick="'+onPager+'('+(page-6)+')";><<&nbsp</a>';
        k=page-5;
      }
      else
        k=0;
  for(j=0;j<10;j++)
  {
    if(k>=numPage)
      break;
    if(j==9)
      table+='<a  style="cursor:Hand" onclick="'+onPager+'('+k+');">>>&nbsp</a>';
    else
      table+='<a style="cursor:Hand" onclick="'+onPager+'('+k+');" >'+k+'&nbsp</a>';
    k++;
    
  }
  table+="</td></tr></table>";  
  divTabella.innerHTML=table;
  return datiPager;
}

function riempiTabellaSelezionabileCheckBox(divTabella,dati,nomiColonne,posValore,onselected)
{
  var tabella="<table width=\"100%\" height=\"100%\" align=\'center\' border=\"0\" cellspacing=\"0\" cellpadding=\"2\">";
 // primo='checked';
  tabella+="<tr>";
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
           var valoreS='' ;
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
             
            tabella+='<tr>';
     
            if(i==0)
            {
                eval(onselected+'('+valoreS +');');
            }
            
            for(j=0;j<nomiColonne.length;j++)
            {
               if(nomiColonne[j]=='ESCLUDI'){
                     eval('colonna=dati[i].colonna'+j+';');
                     eval('colonnaID=dati[i].colonna1;');
                     if(!colonna)
                     break;
                     if(colonna=='1'){
                        tabella+='<td class=\'text\' bgcolor='+bgcol+'><input  type="checkbox"  name="options" checked value="'+i+'" onclick=onChangeStatus(\"'+colonnaID +'\",this);></td>';
                    }
                    else{
                        tabella+='<td class=\'text\' bgcolor='+bgcol+'><input  type="checkbox"  name="options" value="'+i+'" onclick=onChangeStatus(\"'+colonnaID +'\",this) ;></td>';
                    
                    }
                }else{
                    eval('colonna=dati[i].colonna'+j+';');
                    if(!colonna)
                    break;
         
                   tabella+='<td class=\'text\' bgcolor='+bgcol+'>'+colonna+'</td>';
                }
            }
            tabella+="</tr>";
            primo='';
     }
  }
  tabella+="</table>";

  divTabella.innerHTML=tabella;
}