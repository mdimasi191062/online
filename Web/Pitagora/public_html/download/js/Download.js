function CodeFunz()
{
  var carica = function(dati){onCaricaSelectCodeFunz(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('','DownloadReport_Funzionalita',asyncFunz);
  
  ResetCombo(formPag.Cicli,'Selezionare Periodo','');
  ResetCombo(formPag.Servizi,'Selezionare Servizio','');
  ResetCombo(formPag.Account,'Selezionare Account','');
  formPag.Cicli.disabled = 'true';
  formPag.Servizi.disabled = 'true';
  formPag.Account.disabled = 'true';
  formPag.TipoReport.disabled = 'true';
  formPag.TipoDettaglio.disabled = 'true';
}

function CodeFunzCL()
{
  var carica = function(dati){onCaricaSelectCodeFunz(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  chiamaRichiesta('','DownloadReport_FunzionalitaCL',asyncFunz);
  
  ResetCombo(formPag.Cicli,'Selezionare Periodo','');
  ResetCombo(formPag.Servizi,'Selezionare Servizio','');
  ResetCombo(formPag.Account,'Selezionare Account','');
  formPag.Cicli.disabled = 'true';
  formPag.Servizi.disabled = 'true';
  formPag.Account.disabled = 'true';
  formPag.TipoReport.disabled = 'true';
  formPag.TipoDettaglio.disabled = 'true';
}

function onCaricaSelectCodeFunz(dati)
{
  //riempiSelect('CodeFunz',dati);
  riempiSelectFunzionalita('CodeFunz',dati);
  selectTE=document.formPag.CodeFunz;
  for(i=0;i<selectTE.options.length;i++)
  {
      selectTE.options[i].path=dati[i].path;   
  }
}

function riempiSelectFunzionalita(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  for(a=0;a < dati.length;a++)
  {
    eval('document.formPag.'+select+'.options[a] = new Option(dati[a].text,dati[a].value);');
    eval('document.formPag.'+select+'.options[a].tipo_funz=dati[a].tipo_funz;');
    eval('document.formPag.'+select+'.options[a].query_servizi=dati[a].query_servizi;');
    eval('document.formPag.'+select+'.options[a].query_periodi=dati[a].query_periodi;');
    eval('document.formPag.'+select+'.options[a].query_account=dati[a].query_account;');   
    eval('document.formPag.'+select+'.options[a].estensione_file=dati[a].estensione_file;');
    eval('document.formPag.'+select+'.options[a].estensione_file_storico=dati[a].estensione_file_storico;');
    eval('document.formPag.'+select+'.options[a].path_report=dati[a].path_report;');
    eval('document.formPag.'+select+'.options[a].path_report_storici=dati[a].path_report_storici;');
    eval('document.formPag.'+select+'.options[a].path_file_zip=dati[a].path_file_zip;');
    eval('document.formPag.'+select+'.options[a].flag_sys=dati[a].flag_sys;');
  }
}

function TipoBatch()
{
  indice2= document.formPag.CodeFunz.selectedIndex;
  CaricaCampiFunzHidden(document.formPag.CodeFunz,indice2);
  
  ResetCampiSearchHidden();
  
  ClearCombo(document.formPag.comboDisponibili);  
  ClearCombo(document.formPag.comboDaScaricare);  

  document.formPag.TipoReport.value = '';
  document.formPag.TipoReport.disabled = 'true';

  if(codeFunz != ''){
    /*REPORT VALORIZZAZIONE*/

    if ((codeFunz == 'REP_CMV_CLASSIC')||(codeFunz == 'REP_FSAV_CLASSIC')||(codeFunz == 'REP_FSAR_CLASSIC')||(codeFunz == 'REP_FSV_SPECIAL')||(codeFunz == 'REP_FSR_SPECIAL')){
      ElencoServizi(codeFunz,tipoBatch,queryServizi,flagSys,'');
      formPag.Servizi.disabled = false;
      ClearCombo(document.formPag.Cicli);
      ResetCombo(formPag.Cicli,'Selezionare Periodo','');
      formPag.Cicli.disabled = 'true';     
      formPag.TipoDettaglio.value='';
      formPag.TipoDettaglio.disabled = 'true';
      ClearCombo(document.formPag.Account);
      ResetCombo(formPag.Account,'Selezionare Account','');
      formPag.Account.disabled = 'true';
      formPag.TipoReport.disabled = 'true';
    }
    else
    if (tipoBatch == 'V'){
    
      Cicli(codeFunz,tipoBatch,queryPeriodi,flagSys);
      formPag.Cicli.disabled = false;
      formPag.TipoDettaglio.disabled = false;
      ClearCombo(document.formPag.Servizi);
      ResetCombo(formPag.Servizi,'Selezionare Servizio','');
      formPag.Servizi.disabled = 'true';
      ClearCombo(document.formPag.Account);
      ResetCombo(formPag.Account,'Selezionare Account','');
      formPag.Account.disabled = 'true';
      if (codeFunz == 'REP_VAL_CLASSIC')
      {
        formPag.TipoDettaglio.value='';
        formPag.TipoDettaglio.disabled = 'true';
      }    
      formPag.TipoReport.disabled = 'true';
    }
    /*REPORT REPRICING*/
    else if(tipoBatch == 'R'){
      ElencoServizi(codeFunz,tipoBatch,queryServizi,flagSys,'');
      formPag.Servizi.disabled = false;
      ClearCombo(document.formPag.Cicli);
      ResetCombo(formPag.Cicli,'Selezionare Periodo','');
      formPag.Cicli.disabled = 'true';
      if (codeFunz == 'REP_REP_CLASSIC')
      {
        formPag.TipoDettaglio.value='';
        formPag.TipoDettaglio.disabled = 'true';
      }       
      formPag.TipoDettaglio.value='';
      formPag.TipoDettaglio.disabled = 'true';
      ClearCombo(document.formPag.Account);
      ResetCombo(formPag.Account,'Selezionare Account','');
      formPag.Account.disabled = 'true';
      formPag.TipoReport.disabled = 'true';
    }
    
     /*REPORT MANUALE*/
    else if(tipoBatch == 'M'){
      ElencoServizi(codeFunz,tipoBatch,queryServizi,flagSys,'');
      formPag.Servizi.disabled = false;
      ClearCombo(document.formPag.Cicli);
      ResetCombo(formPag.Cicli,'Selezionare Periodo','');
      formPag.Cicli.disabled = 'true';
      
      formPag.TipoDettaglio.value='';
      formPag.TipoDettaglio.disabled = 'true';
      ClearCombo(document.formPag.Account);
      ResetCombo(formPag.Account,'Selezionare Account','');
      formPag.Account.disabled = 'true';
      formPag.TipoReport.disabled = 'true';
    }
    else if(tipoBatch == 'A'){
      ElencoFile(codeFunz,'','',tipoBatch,flagSys,'','','',pathReport,pathReportStorici,estensioneFile,estensioneFileStorici,'');
      ClearCombo(document.formPag.Cicli);
      ResetCombo(formPag.Cicli,'Selezionare Periodo','');
      formPag.Cicli.disabled = 'true';
   
      formPag.TipoDettaglio.value='';
      formPag.TipoDettaglio.disabled = 'true';
      ClearCombo(document.formPag.Servizi);
      ResetCombo(formPag.Servizi,'Selezionare Servizio','');
      formPag.Servizi.disabled = 'true';
      ClearCombo(document.formPag.Account);
      ResetCombo(formPag.Account,'Selezionare Account','');
      formPag.Account.disabled = 'true';
      formPag.TipoReport.value = '';
      formPag.TipoReport.disabled = 'true';
    }
  }else{
    ResetCampiFunzHidden();
    ClearCombo(document.formPag.Cicli);
    ResetCombo(formPag.Cicli,'Selezionare Periodo','');
    formPag.Cicli.disabled = 'true';
    
    formPag.TipoDettaglio.value='';
    formPag.TipoDettaglio.disabled = 'true';
    ClearCombo(document.formPag.Servizi);
    ResetCombo(formPag.Servizi,'Selezionare Servizio','');
    formPag.Servizi.disabled = 'true';
    ClearCombo(document.formPag.Account);
    ResetCombo(formPag.Account,'Selezionare Account','');
    formPag.Account.disabled = 'true';
    formPag.TipoReport.value = '';
    formPag.TipoReport.disabled = 'true';
  }
}

function onCaricaSelectCiclo(dati)
{
  riempiSelect('Cicli',dati);
  selectTE=document.formPag.Cicli;
  for(i=0;i<selectTE.options.length;i++)
  {
      selectTE.options[i].path=dati[i].path;
  }
}

function onCaricaSelectElencoServizi(dati)
{
  riempiSelect('Servizi',dati);
  selectTE=document.formPag.Servizi;
  for(i=0;i<selectTE.options.length;i++)
  {
      selectTE.options[i].path=dati[i].path;
  }
}



function Cicli(codeFunz,tipoBatch,queryPeriodi,flagSys)
{
  var carica = function(dati){onCaricaSelectCiclo(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var parametri = 'codeFunz='+codeFunz+'&tipoBatch='+tipoBatch+'&flagSys='+flagSys+'&queryPeriodi='+queryPeriodi;
  chiamaRichiesta(parametri,'DownloadReport_Periodi',asyncFunz);
}

function ElencoServizi(codeFunz,tipoBatch,queryServizi,flagSys,codeCiclo)
{
  
  var carica = function(dati){onCaricaSelectElencoServizi(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var parametri = 'codeFunz='+codeFunz+'&tipoBatch='+tipoBatch+'&flagSys='+flagSys+'&codeCiclo='+codeCiclo+'&queryServizi='+queryServizi;
  chiamaRichiesta(parametri,'DownloadReport_Servizi',asyncFunz);
}

function CaricaCampiFunzHidden(obj,indice){
  document.formPag.codeFunzHidden.value = obj.options[indice2].value;  
  document.formPag.tipoBatchHidden.value = obj.options[indice2].tipo_funz;
  document.formPag.queryServiziHidden.value = obj.options[indice2].query_servizi;
  document.formPag.queryPeriodiHidden.value = obj.options[indice2].query_periodi;
  document.formPag.queryAccountHidden.value = obj.options[indice2].query_account;
  document.formPag.estensioneFileHidden.value = obj.options[indice2].estensione_file;
  document.formPag.estensioneFileStoriciHidden.value = obj.options[indice2].estensione_file_storico;
  
  document.formPag.pathReportHidden.value = obj.options[indice2].path_report;
  document.formPag.pathReportStoriciHidden.value = obj.options[indice2].path_report_storici;
  document.formPag.pathFileZipHidden.value = obj.options[indice2].path_file_zip;
  document.formPag.flagSysHidden.value = obj.options[indice2].flag_sys;
  
  codeFunz = document.formPag.codeFunzHidden.value;
  tipoBatch = document.formPag.tipoBatchHidden.value;
  queryServizi = document.formPag.queryServiziHidden.value;
  queryPeriodi = document.formPag.queryPeriodiHidden.value;
  queryAccount = document.formPag.queryAccountHidden.value;
  estensioneFile = document.formPag.estensioneFileHidden.value;
  estensioneFileStorici = document.formPag.estensioneFileStoriciHidden.value;
  pathReport = document.formPag.pathReportHidden.value;
  pathReportStorici = document.formPag.pathReportStoriciHidden.value;
  pathFileZip = document.formPag.pathFileZipHidden.value;    
  flagSys = document.formPag.flagSysHidden.value;
}

function ResetCampiSearchHidden(){
  document.formPag.cicloHidden.value = '';
  document.formPag.servizioHidden.value = '';
  document.formPag.accountHidden.value = '';
  document.formPag.descAccountHidden.value = '';
  document.formPag.tipoReportHidden.value = '';
  document.formPag.tipoDettaglioHidden.value = '';
  
}

function ResetCampiFunzHidden(){
  document.formPag.codeFunzHidden.value = '';
  document.formPag.tipoBatchHidden.value = '';
  document.formPag.queryServiziHidden.value = '';
  document.formPag.queryPeriodiHidden.value = '';
  document.formPag.queryAccountHidden.value = '';
  document.formPag.estensioneFileHidden.value = '';
  document.formPag.estensioneFileStoriciHidden.value = '';
  document.formPag.pathReportHidden.value = '';
  document.formPag.pathReportStoriciHidden.value = '';
  document.formPag.pathFileZipHidden.value = '';
  document.formPag.flagSysHidden.value = '';
  codeFunz = '';
  tipoBatch = '';
  queryServizi = '';
  queryPeriodi = '';
  queryAccount = '';
  estensioneFile = '';
  estensioneFileStorici = '';
  pathReport = '';
  pathReportStorici = '';
  pathFileZip = '';
  flagSys = '';
}


function gestisciMessaggio(messaggio)
{
   dinMessage.innerHTML=messaggio;
   orologio.style.visibility='hidden';
   orologio.style.display='none';
   maschera.style.visibility='hidden';
   maschera.style.display='none';
   dvMessaggio.style.display='block';
   dvMessaggio.style.visibility='visible';
}


function Ciclo()
{
  indice= document.formPag.Cicli.selectedIndex;
  var codeCiclo=document.formPag.Cicli.options[indice].value;
  var flagSys=document.formPag.flagSysHidden.value;
  var codeFunz=document.formPag.codeFunzHidden.value;
  var tipoBatch=document.formPag.tipoBatchHidden.value;
  var queryServizi=document.formPag.queryServiziHidden.value;
  
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboDaScaricare);
  
  
  if(codeCiclo != ''){
    document.formPag.cicloHidden.value = codeCiclo;    
    ElencoServizi(codeFunz,tipoBatch,queryServizi,flagSys,codeCiclo)
    formPag.Servizi.disabled = false;
    ClearCombo(document.formPag.Account);
    ResetCombo(formPag.Account,'Selezionare Account','');
    
    formPag.Account.disabled = 'true';
    ClearCombo(document.formPag.comboDisponibili);
  }else{
    ResetCampiSearchHidden();
    ClearCombo(document.formPag.Servizi);
    ResetCombo(formPag.Servizi,'Selezionare Servizio','');
    formPag.Servizi.disabled = 'true';
    ClearCombo(document.formPag.Account);
    ResetCombo(formPag.Account,'Selezionare Account','');
    formPag.Account.disabled = 'true';
    formPag.TipoReport.value = '';
    formPag.TipoReport.disabled = 'true';
  }
}

function onCaricaSelectServizi(dati)
{
  riempiSelect('Servizi',dati);
  selectTE=document.formPag.Servizi;
  for(i=0;i<selectTE.options.length;i++)
  {
      selectTE.options[i].path=dati[i].path;
  }
}

function Servizio()
{
  indice= document.formPag.Servizi.selectedIndex;
  var codeServizio=document.formPag.Servizi.options[indice].value;
  
  var flagSys=document.formPag.flagSysHidden.value;
  var codeFunz=document.formPag.codeFunzHidden.value;
  var tipoBatch=document.formPag.tipoBatchHidden.value;
  var codeCiclo=document.formPag.cicloHidden.value;
  var queryAccount=document.formPag.queryAccountHidden.value;
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboDaScaricare);
  document.formPag.accountHidden.value = '';
  document.formPag.descAccountHidden.value = '';

  if(codeServizio != ''){
    document.formPag.servizioHidden.value = codeServizio;
    Account(codeFunz,codeCiclo,codeServizio,tipoBatch,queryAccount,flagSys);
    if ((codeServizio != 98)&&(codeServizio!= 99)){
        formPag.Account.disabled = false;
        formPag.TipoReport.disabled = false;
    }
    else
    {
        formPag.Account.disabled = true;
        formPag.TipoReport.disabled = true;
    }
  }else{
    document.formPag.servizioHidden.value = '';
    document.formPag.tipoReportHidden.value = '';
    document.formPag.tipoDettaglioHidden.value = '';
  
    ClearCombo(document.formPag.Account);
    ResetCombo(formPag.Account,'Selezionare Account','');
    formPag.Account.disabled = 'true';
    formPag.TipoReport.value = '';
    formPag.TipoReport.disabled = 'true';
  }
}

function Account(codeFunz,codeCiclo,codeServizio,tipoBatch,queryAccount,flagSys)
{
  var carica = function(dati){onCaricaSelectAccount(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var parametri = 'codeFunz='+codeFunz+'&tipoBatch='+tipoBatch+'&flagSys='+flagSys;
  
  parametri = parametri +'&codeCiclo='+codeCiclo+'&codeServizio='+codeServizio+'&queryAccount='+queryAccount;
  chiamaRichiesta(parametri,'DownloadReport_Account',asyncFunz);
}

function onCaricaSelectAccount(dati)
{
  riempiSelect('Account',dati);
  selectTE=document.formPag.Account;
  for(i=0;i<selectTE.options.length;i++)
  {
    selectTE.options[i].path=dati[i].path;
  }
  //  indice2= document.formPag.tipoDettaglio.selectedIndex;
  var codeFunz=document.formPag.codeFunzHidden.value;
  var codeCiclo=document.formPag.cicloHidden.value;
  var codeServizio=document.formPag.servizioHidden.value;
  var tipoBatch=document.formPag.tipoBatchHidden.value;
  var flagSys=document.formPag.flagSysHidden.value;
  var codeAccount=document.formPag.accountHidden.value;
  var descAccount=document.formPag.descAccountHidden.value;
  var tipoFile=document.formPag.tipoReportHidden.value;
  var tipoDett=document.formPag.tipoDettaglioHidden.value;
  var pathReport=document.formPag.pathReportHidden.value;
  var pathReportStorici=document.formPag.pathReportStoriciHidden.value;  
  var estensione_file=document.formPag.estensioneFileHidden.value;
  var estensione_file_storico=document.formPag.estensioneFileStoriciHidden.value;  
  ElencoFile(codeFunz,codeCiclo,codeServizio,tipoBatch,flagSys,codeAccount,tipoFile,tipoDett,pathReport,pathReportStorici,estensione_file,estensione_file_storico,descAccount)
}

function AccountSel()
{
  indice= document.formPag.Account.selectedIndex;
  var tipoDett=document.formPag.tipoDettaglioHidden.value;
  var codeAccount=document.formPag.Account.options[indice].value;
  var descAccount=document.formPag.Account.options[indice].text;
  document.formPag.accountHidden.value = codeAccount;
  document.formPag.descAccountHidden.value = descAccount;
  var flagSys=document.formPag.flagSysHidden.value;
  var codeFunz=document.formPag.codeFunzHidden.value;
  var tipoBatch=document.formPag.tipoBatchHidden.value;
  var codeCiclo=document.formPag.cicloHidden.value;
  var codeServizio=document.formPag.servizioHidden.value;
  var tipoFile=document.formPag.tipoReportHidden.value;
  var pathReport=document.formPag.pathReportHidden.value;
  var pathReportStorici=document.formPag.pathReportStoriciHidden.value; 
  var estensione_file=document.formPag.estensioneFileHidden.value;
  var estensione_file_storico=document.formPag.estensioneFileStoriciHidden.value; 
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboDaScaricare);
 
  if(codeAccount != ''){
      ElencoFile(codeFunz,codeCiclo,codeServizio,tipoBatch,flagSys,codeAccount,tipoFile,tipoDett,pathReport,pathReportStorici,estensione_file,estensione_file_storico,descAccount)
      formPag.Account.disabled = false;
  }else{
    //ClearCombo(document.formPag.comboDaScaricare);
      ElencoFile(codeFunz,codeCiclo,codeServizio,tipoBatch,flagSys,codeAccount,tipoFile,tipoDett,pathReport,pathReportStorici,estensione_file,estensione_file_storico,descAccount)
 }
}

function ElencoFile(codeFunz,codeCiclo,codeServizio,tipoBatch,flagSys,codeAccount,tipoFile,tipoDett,pathReport,pathReportStorici,estensione_file,estensione_file_storico,descAccount)
{
  var carica = function(dati){onCaricaSelectElencoFile(dati);};
  var errore = function(dati){gestisciMessaggio(dati[0].messaggio);};
  var asyncFunz=  function(){ handler_generico(http,carica,errore);};
  var descServizio= '';
  if (codeServizio == 1)
    descServizio = 'pp';
  if (codeServizio == 2)
    descServizio = 'mp';
  if (codeServizio == 3)
    descServizio = 'rpvd';
  if (codeServizio == 4)
    descServizio = 'atm';
  if (codeServizio == 5)
    descServizio = 'itc';
  if (codeServizio == 6)
    descServizio = 'itc_rev';
  
  
  
  if ((codeFunz == 'REP_VAL_CLASSIC')||(codeFunz == 'REP_REP_CLASSIC'))
  {
    pathReport=pathReport + descServizio + '/';
  }    
  
  if ((codeFunz == 'REP_CMV_CLASSIC')||(codeFunz == 'REP_CMR_CLASSIC'))
  {
    pathReport=pathReport  + 'SWN/';
  } 
  
  if ((codeFunz == 'REP_FSAV_CLASSIC')||(codeFunz == 'REP_FSAR_CLASSIC')||(codeFunz == 'REP_FSR_SPECIAL')||(codeFunz == 'REP_FSV_SPECIAL'))
  {
    pathReport=pathReport  + 'SAP/';
  }   
  var parametri = 'codeFunz='+codeFunz+'&tipoBatch='+tipoBatch+'&flagSys='+flagSys;
  
  parametri = parametri + '&codeCiclo='+codeCiclo+'&codeServizio='+codeServizio;
  
  parametri = parametri + '&codeAccount='+codeAccount+'&tipoFile='+tipoFile+'&tipoDett='+tipoDett;
  
  parametri = parametri + '&pathReport='+pathReport+'&pathReportStorici='+pathReportStorici;
  
  parametri = parametri + '&estensione='+estensione_file+'&estensioneStorico='+estensione_file_storico; 
  
  parametri = parametri + '&descAccount='+descAccount; 
  
  if (flagSys=='C')
  {
    chiamaRichiesta(parametri,'DownloadReport_ElencoFileCl',asyncFunz);
  }
  else
  {
    chiamaRichiesta(parametri,'DownloadReport_ElencoFile',asyncFunz);
  }
}
function onCaricaSelectElencoFile(dati)
{
  riempiSelectElencoFile('comboDisponibili',dati);
}

function selectTipoReportDettaglio()
{
  indice= document.formPag.TipoReport.selectedIndex;
  indice2= document.formPag.TipoDettaglio.selectedIndex;
  var tipoDett=document.formPag.TipoDettaglio.options[indice2].value;
  var tipoFile=document.formPag.TipoReport.options[indice].value;
  document.formPag.tipoReportHidden.value = tipoFile;
  document.formPag.tipoDettaglioHidden.value = tipoDett;
  ClearCombo(document.formPag.comboDisponibili);
  ClearCombo(document.formPag.comboDaScaricare);
    
  var codeFunz=document.formPag.codeFunzHidden.value;
  var codeCiclo=document.formPag.cicloHidden.value;
  var codeServizio=document.formPag.servizioHidden.value;
  var tipoBatch=document.formPag.tipoBatchHidden.value;
  var flagSys=document.formPag.flagSysHidden.value;
  var codeAccount=document.formPag.accountHidden.value;
  var descAccount=document.formPag.descAccountHidden.value;
  var tipoFile=document.formPag.tipoReportHidden.value;
  var pathReport=document.formPag.pathReportHidden.value;
  var pathReportStorici=document.formPag.pathReportStoriciHidden.value;
  var estensione_file=document.formPag.estensioneFileHidden.value;
  var estensione_file_storico=document.formPag.estensioneFileStoriciHidden.value;  
ElencoFile(codeFunz,codeCiclo,codeServizio,tipoBatch,flagSys,codeAccount,tipoFile,tipoDett,pathReport,pathReportStorici,estensione_file,estensione_file_storico,descAccount)
}

function addOptionToCombo(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
	var myOpt = null;
  var classe = 'textList';
  
	if(index != -1)
	{
		myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource));
    myOpt.path_file = cboSource.options[index].path_file;
		DelOptionByIndex(cboSource,index);
	}
}

function removeOptionToCombo(cboSource,cboDestination){
	var index = getComboIndex(cboSource);
  var myOpt = null;
  if(index != -1)
  {
    myOpt = addOption(cboDestination,getComboText(cboSource),getComboValue(cboSource))
    myOpt.path_file = cboSource.options[index].path_file;
    DelOptionByIndex(cboSource,index);
  }  
}

function addAllOptionsToCombo(cboSource,cboDestination){
	var myOpt = null;
	var i = 0;
  while (cboSource.length > i)
	{
		myOpt = addOption(cboDestination,getComboTextByIndex(cboSource,i),getComboValueByIndex(cboSource,i));
    myOpt.path_file = cboSource.options[i].path_file;
		DelOptionByIndex(cboSource,i);
	}
}

function selectAllComboElements(cboSource)
{
  var len = cboSource.length;
  var x=0;
  for (x=0;x<len;x++)
  {
    cboSource.options[x].selected = true;
    document.formPag.pathReportHidden.value = cboSource.options[x].path_file;
  }
}

function riempiSelectElencoFile(select,dati)
{
  eval('document.formPag.'+select+'.length=0');
  var b = 0;
  for(a=0;a < dati.length;a++)
  {
    if(checkPresenzaFileDaScaricare(dati[a].text)){
      eval('document.formPag.'+select+'.options[b] = new Option(dati[a].text,dati[a].value);');
      eval('document.formPag.'+select+'.options[b].path_file=dati[a].path_file;');
      b++;
    }
  }
}

function Replace(inputString, fromString, toString) {
   // Goes through the inputString and replaces every occurrence of fromString with toString
   var temp = inputString;
   if (fromString == "") {
      return inputString;
   }
   if (toString.indexOf(fromString) == -1) { // If the string being replaced is not a part of the replacement string (normal situation)
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } else { // String being replaced is part of replacement string (like "+" being replaced with "++") - prevent an infinite loop
      var midStrings = new Array("~", "`", "_", "^", "#");
      var midStringLen = 1;
      var midString = "";
      // Find a string that doesn't exist in the inputString to be used
      // as an "inbetween" string
      while (midString == "") {
         for (var i=0; i < midStrings.length; i++) {
            var tempMidString = "";
            for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
            if (fromString.indexOf(tempMidString) == -1) {
               midString = tempMidString;
               i = midStrings.length + 1;
            }
         }
      } // Keep on going until we build an "inbetween" string that doesn't exist
      // Now go through and do two replaces - first, replace the "fromString" with the "inbetween" string
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + midString + toTheRight;
      }
      // Next, replace the "inbetween" string with the "toString"
      while (temp.indexOf(midString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(midString));
         var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } // Ends the check to see if the string being replaced is part of the replacement string or not
   return temp; // Send the updated string back to the user
}

function ONRESET()
{
  ClearCombo(document.formPag.comboDisponibili);  
  ClearCombo(document.formPag.comboDaScaricare);
  document.formPag.CodeFunz.value = '';
  ResetCampiFunzHidden();
  ClearCombo(document.formPag.Cicli);
  ResetCombo(document.formPag.Cicli,'Selezionare Periodo','');
  document.formPag.Cicli.disabled = 'true';
  document.formPag.TipoDettaglio.disabled = 'true';
  
  ClearCombo(document.formPag.Servizi);
  ResetCombo(document.formPag.Servizi,'Selezionare Servizio','');
  document.formPag.Servizi.disabled = 'true';
  ClearCombo(document.formPag.Account);
  ResetCombo(document.formPag.Account,'Selezionare Account','');
  document.formPag.Account.disabled = 'true';
  document.formPag.TipoReport.value = '';
  document.formPag.TipoReport.disabled = 'true';
  document.formPag.nomeFileCompresso.value = '';
}

function checkPresenzaFileDaScaricare(textSearch){
  var selectTEMP = document.formPag.comboDaScaricare;
  var check = null;
  var i = 0;
  if(selectTEMP.options.length > 0){
    for(i=0;i<selectTEMP.options.length;i++)
    {
      if(selectTEMP.options[i].text == textSearch){
        return false;
      }
    }
    return true;
  }else{
    return true;
  }
}

