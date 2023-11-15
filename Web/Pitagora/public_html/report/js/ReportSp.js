function carPeriodi()
{
    
    if (document.reportForm.comboFunz.options[document.reportForm.comboFunz.selectedIndex].value == "-1")
    {
    
       Disable(document.reportForm.comboPeriodo);
       document.reportForm.caricaPeriodi.value="false";
       document.reportForm.caricaDatiCli.value="false";
       document.reportForm.comboFunzSelez.value = "-1";
       document.reportForm.PeriodoRifSelez.value = "-1";
       document.reportForm.descPeriodoSelez.value = "";
       document.reportForm.submit(); 
     } 
    else
    {
//inserici il controllo per verificare se l'hai già caricato
      if (document.reportForm.comboFunzSelez.value == document.reportForm.comboFunz.value)
      {
         document.reportForm.caricaPeriodi.value="false";
        
      }
      else
      {
     
	document.reportForm.comboFunzSelez.value =document.reportForm.comboFunz.options[document.reportForm.comboFunz.selectedIndex].value;
        document.reportForm.caricaPeriodi.value="true";
        document.reportForm.caricaDatiCli.value="false";
        document.reportForm.PeriodoRifSelez.value = "-1";
        document.reportForm.descPeriodoSelez.value = "";
        document.reportForm.submit(); 
      }
    }

}

function carDatiCli()
{
    if(document.reportForm.comboPeriodo.options[document.reportForm.comboPeriodo.selectedIndex].value == "-1")
    {
       document.reportForm.caricaDatiCli.value="false";
       document.reportForm.PeriodoRifSelez.value = "-1";
       document.reportForm.descPeriodoSelez.value = "";
       document.reportForm.submit();  
     } 
    else
    {
//inserici il controllo per verificare se l'hai già caricato
      if (document.reportForm.PeriodoRifSelez.value == document.reportForm.comboPeriodo.value)
      {
         document.reportForm.caricaDatiCli.value="false";
        
      }
      else
      {
        document.reportForm.PeriodoRifSelez.value = document.reportForm.comboPeriodo.options[document.reportForm.comboPeriodo.selectedIndex].value;
        
        document.reportForm.descPeriodoSelez.value = document.reportForm.comboPeriodo.options[document.reportForm.comboPeriodo.selectedIndex].text;
        
        document.reportForm.caricaDatiCli.value="true";
        document.reportForm.submit(); 
      }
    }

}


