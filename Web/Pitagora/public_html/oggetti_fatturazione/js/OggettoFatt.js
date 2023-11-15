
function check_form()
{

if (document.OggettoFatt.classefatt.options[document.OggettoFatt.classefatt.selectedIndex].value==-1)
  {
  window.alert("Seleziona Classe di Fatturazione");
  document.OggettoFatt.classefatt.focus();
  return false;
  }

if (document.OggettoFatt.desc.value=="")
  {
  window.alert("Digitare Descrizione");
  document.OggettoFatt.desc.focus();
  return false;
  }

return true;
}

function check_form_ie()
{
if (document.OggettoFatt.classefatt.options[document.OggettoFatt.classefatt.selectedIndex].value==-1)
  {
//    Disable(document.OggettoFatt.CONFERMA);  
    return;
  }

Enable(document.OggettoFatt.CONFERMA);
return;
}

function change_combo()
{
  if (document.OggettoFatt.act.value=='insert')
  {
    if ((document.OggettoFatt.classefatt.options[document.OggettoFatt.classefatt.selectedIndex].text=='Altro')||
        (document.OggettoFatt.classefatt.options[document.OggettoFatt.classefatt.selectedIndex].value==-1))
    {
      document.OggettoFatt.assPs.checked=false;
      document.OggettoFatt.assPs.value='no';
    }
    else
    {
      document.OggettoFatt.assPs.checked = true;
      document.OggettoFatt.assPs.value='yes';
    }
  }
//if (isie)
//  check_form_ie();
}

function handleblur(objElement)
{
if (isie)
  check_form_ie();
}

function handleonchange()
{
}

function handlekeypress()
{
}

function ONCONFERMA()
{

if ((document.OggettoFatt.act.value=="insert")||(document.OggettoFatt.act.value=="aggiorna"))
  if (document.OggettoFatt.classefatt.options[document.OggettoFatt.classefatt.selectedIndex].value==-1)
    {
    window.alert("Seleziona Classe di Fatturazione");
    document.OggettoFatt.classefatt.focus();
    return false;
    }

if ((document.OggettoFatt.act.value=="disattiva")&&
    (document.OggettoFatt.data_fine.value==''))
  {
      window.alert("Digitare Data Fine");
      return false;
  }
  
if (document.OggettoFatt.desc.value=="")
  {
      window.alert("Digitare Descrizione");
      document.OggettoFatt.desc.focus();
      return false;
  }

 if ((document.OggettoFatt.data_fine.value!=document.OggettoFatt.data_fine_hidden.value)
     &&(document.OggettoFatt.data_fine.value != ''))
  {
    var appo_data_fine = document.OggettoFatt.data_fine.value.substring(6,10)
                       + document.OggettoFatt.data_fine.value.substring(3,5)
                       + document.OggettoFatt.data_fine.value.substring(0,2);
    var appo_data_ini  = document.OggettoFatt.data_ini.value.substring(6,10)
                       + document.OggettoFatt.data_ini.value.substring(3,5)
                       + document.OggettoFatt.data_ini.value.substring(0,2);
    var appo_data_oggi = document.OggettoFatt.data_oggi.value.substring(6,10)
                       + document.OggettoFatt.data_oggi.value.substring(3,5)
                       + document.OggettoFatt.data_oggi.value.substring(0,2);
    if (!(appo_data_fine > appo_data_ini))
    {
      window.alert("La data fine validità deve essere maggiore della data inizio validità");
      return false;
    }
    if (appo_data_oggi > appo_data_fine)
    {
      window.alert("La data fine validità deve essere maggiore o uguale alla data odierna");
      return false;
    }
  } 

      Enable(document.OggettoFatt.classefatt);
      Enable(document.OggettoFatt.data_ini);
      Enable(document.OggettoFatt.data_fine);

      if (document.OggettoFatt.act.value=="aggiorna")
        {
        var ret=window.confirm("Si conferma l'aggiornamento dell'oggetto di fatturazione ?");
        if (ret) document.OggettoFatt.submit();
        else
          {
           Disable(document.OggettoFatt.classefatt);
           Disable(document.OggettoFatt.data_ini);
           Disable(document.OggettoFatt.data_fine);
          }
        }
    if (document.OggettoFatt.act.value=="insert")
        {
        var ret=window.confirm("Si conferma l'inserimento dell'oggetto di fatturazione ?");
        if (ret) document.OggettoFatt.submit();
        else
          {
           //Disable(document.OggettoFatt.classefatt);
           Disable(document.OggettoFatt.data_ini);
           Disable(document.OggettoFatt.data_fine);
          }
        }
      if (document.OggettoFatt.act.value=="disattiva")
        {
        var ret=window.confirm("Si conferma la disattivazione dell'oggetto di fatturazione ?");
        if (ret) document.OggettoFatt.submit();
        else
          {
           Disable(document.OggettoFatt.classefatt);
           Disable(document.OggettoFatt.data_ini);
           Disable(document.OggettoFatt.data_fine);
          }
        }
      
        
   return false;           
}

function ONANNULLA()
{
//  document.OggettoFatt.classefatt.selectedIndex=0;
//  document.OggettoFatt.desc.value='';
//  document.OggettoFatt.data_ini.value=document.OggettoFatt.data_oggi.value;
//  document.OggettoFatt.assPs.checked=true;
//  document.OggettoFatt.assPs.value='yes';
//window.alert("document.OggettoFatt.assPs.value="+document.OggettoFatt.assPs.value);

if (document.OggettoFatt.sel_classe_hidden.value==0)
  document.OggettoFatt.classefatt.selectedIndex=document.OggettoFatt.sel_classe_hidden.value;
else
  document.OggettoFatt.classefatt.selectedIndex=document.OggettoFatt.sel_classe_hidden.value-1;
  document.OggettoFatt.desc.value=appo_desc;
  document.OggettoFatt.data_ini.value=document.OggettoFatt.data_ini_hidden.value;
  document.OggettoFatt.data_fine.value=document.OggettoFatt.data_fine_hidden.value;

  
  if (document.OggettoFatt.assPs_hidden.value=="S")
    document.OggettoFatt.assPs.checked=true;
  else
    document.OggettoFatt.assPs.checked=false;
//  document.OggettoFatt.assPs.value='no';
//  Disable(document.OggettoFatt.CONFERMA);  
}

function cancelLink ()
{
  return false;
}

function cancelCalendar ()
{
  document.OggettoFatt.data_fine.value="";
}

function showMessage (field)
{
	if (field=='seleziona1')
		self.status=msg1;
	else
    if (field=='seleziona2')
  		self.status=msg2;
  	else
  		self.status=msg3;
}

//function disableLink (link)
//{
//  if (link.onclick)
//    link.oldOnClick = link.onclick;
//  link.onclick = cancelLink;
//  if (link.style)
//    link.style.cursor = 'default';
//}
