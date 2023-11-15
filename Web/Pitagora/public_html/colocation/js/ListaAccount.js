var isnn,isie

if(navigator.appName=='Microsoft Internet Explorer') //check the browser
{
 isie=true;
}

if(navigator.appName=='Netscape')
{
 isnn=true; 
}

function caraccount()
{
  if (document.account.account.selectedIndex==0)
    {
        selezione=-1;
    }
    else
    {
        selezione=document.account.account[document.account.account.selectedIndex].value;
    }
  
  if  (selezione!=-1)
  {
    document.account.accountSelez.value=selezione;
    
    
//    alert('document.account.accountSelez.value '+document.account.accountSelez.value);
   }

}


function carsiti()
{
  if (document.account.utr.selectedIndex==0)
  {
        selezione=-1;
  }
  else
  {
        selezione=document.account.utr[document.account.utr.selectedIndex].value;
  }
  
  if  (selezione!=-1)
  {
    document.account.utrSelez.value=selezione;
    document.account.desUtrSelez.value=document.account.utr[document.account.utr.selectedIndex].text;
//    alert('document.account.utrSelez.value '+document.account.utrSelez.value);
    document.account.caricasiti.value='true';
    document.account.sitoSelez.value=-1;
    document.account.caricaLista.value='false';
    document.account.submit();
  }
  else
  { 
    document.account.utrSelez.value=selezione;
    document.account.caricasiti.value='false';
    document.account.caricaLista.value='false';
    document.account.submit();
  }
}

function carlista()
{
//  alert('carlista');
  if (document.account.sito.selectedIndex==0)
  {
//        alert('AAAA');
        selezione=-1;
  }
  else
  {
//        alert('BBBBB');
        selezione=document.account.sito[document.account.sito.selectedIndex].value;
  }
  
  if  (selezione!=-1)
  {
    document.account.sitoSelez.value=selezione;
    document.account.desSitoSelez.value=document.account.sito[document.account.sito.selectedIndex].text;
    document.account.caricaLista.value='false';//M 18/10/02
    document.account.submit();
  }
  else
  { 
    document.account.sitoSelez.value=selezione;
    document.account.caricaLista.value='false';
    document.account.submit();
  }
}


function check_form()
{
if (document.account.utr[document.account.utr.selectedIndex].value==-1)
  {
  window.alert("Selezionare un U.T.R.");
   return false;
  }

if (document.account.sito[document.account.sito.selectedIndex].value==-1)
  {
  window.alert("Selezionare un sito");
   return false;
  } 

return true;
}

function showMessage (field)
{
	if (field=='cancella')
		self.status='Click per cancellare la data selezionata';
 	else
 	    self.status='Click per selezionare una data';  
}

function cancelLink ()
{
  return false;
}

function cancelCalendar ()
{
  document.account.data_ini.value="";
}



function disableLink (link)
{
//alert("link style "+link.style+ "link.onclick "+link.onclick);
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

function dis_calendario()
{
    attivaCalendario=false;
    document.account.calendario.src='../../common/images/calendario_dis.gif';
    message1="Link disabilitato";
    disableLink (document.links[0]);
    document.account.cancella_data.src='../../common/images/cancella_dis.gif';
    message2="Link disabilitato";
    disableLink (document.links[1]);
}

function abi_calendario()
{
    attivaCalendario=true;
    document.oggFattForm.calendario.src='../../common/images/calendario.gif';
    message1="Click per selezionare la data";
    enableLink (document.links[0]);
    document.oggFattForm.cancella_data.src='../../common/images/cancella.gif';
    message2="Click per cancellare la data selezionata";
    enableLink (document.links[1]);
}

function ChangeSel(codice, descrizione)
{
  document.account.accountSelez.value =codice;
  document.account.desAccountSelez.value =descrizione.replace('Æ','\'');
}


