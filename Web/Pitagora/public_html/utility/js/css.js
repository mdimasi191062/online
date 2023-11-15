var objOld = null;

function swapClass(obj, cls) {
  obj.className = cls;
}

function swapTR(obj, cls) {
  if (obj.selezionato != 'true')
    obj.className = cls;
}

function selected(obj, cls) {
  if( objOld != null ) { 
      objOld.selezionato = 'false';
      swapTR(objOld,'trOut');
  }
  
  obj.selezionato = 'true';
  obj.className = cls;
  objOld = obj;
}

function blanckPagina(){
  alert('Blanck Pagina');
}
