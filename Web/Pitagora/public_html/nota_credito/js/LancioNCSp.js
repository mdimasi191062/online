
function handleblur(ogg)
{
}

function cancelLink ()
{
  return false;
}

function cancelCalendar ()
{
  document.lancioNCForm.dataFineA.value="";
}

function showMessage (field)
{
	if (field=='seleziona1')
		self.status=message1;
 	else
 		self.status=message2;
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
    document.lancioNCForm.calendario.src='../../common/images/body/calendario_dis.gif';
    message1="Link disabilitato";
    disableLink (document.links[0]);
    document.lancioNCForm.cancella_data.src='../../common/images/body/cancella_dis.gif';
    message2="Link disabilitato";
    disableLink (document.links[1]);
}

function abi_calendario()
{
    attivaCalendario=true;
    document.lancioNCForm.calendario.src='../../common/images/body/calendario.gif';
    message1="Click per selezionare la data";
    enableLink (document.links[0]);
    document.lancioNCForm.cancella_data.src='../../common/images/body/cancella.gif';
    message2="Click per cancellare la data selezionata";
    enableLink (document.links[1]);
}

function convertiData(data)
{
    var appo_data = data.substring(6,10) + data.substring(3,5) + data.substring(0,2);
    return appo_data;
}

//SCHEDULAZIONE
function f_calendarioSched(obj)
{
  if(obj.checked){
    attivaCalendarioSched=true;
    document.lancioNCForm.dataSched.value="";
    EnableLink(document.links[2],document.lancioNCForm.calendarioSched);
    EnableLink(document.links[3],document.lancioNCForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.lancioNCForm.LANCIOBATCH.value = "Schedula Batch";
  }else{
    attivaCalendarioSched=false;
    document.lancioNCForm.dataSched.value="";
    DisableLink(document.links[2],document.lancioNCForm.calendarioSched);
    DisableLink(document.links[3],document.lancioNCForm.cancella_dataSched);
    msg1=message1;
    msg2=message2;
    document.lancioNCForm.LANCIOBATCH.value = "Lancio Batch";    
  }
}