function filtra_submit()
{
document.ListaOf.submit();
return false;
}

function page_sub(path,selection)
{
if (selection.value=="Nuovo")
    document.ListaOf.act.value="nuovo";
if (selection.value=="Aggiorna")
    document.ListaOf.act.value="aggiorna";
if (selection.value=="Visualizza")
    document.ListaOf.act.value="visualizza";
if (selection.value=="Disattiva")
    document.ListaOf.act.value="disattiva";    
//document.ListaOf.action=path+"/Jsp/special/Oggetto_Fatt.jsp";
document.ListaOf.action="Oggetto_Fatt.jsp";
document.ListaOf.submit();  
return false;
}