function clickOnEntity(entity) {
  if(entity.open == "false") {
    expand(entity, true)
    frmDatiTree.entitySelezionato.value=entity.id+"|STATO="+entity.statoelemento
    //alert(frmDatiTree.entitySelezionato.value);
    
    
  }
  else {
    collapse(entity)
    frmDatiTree.entitySelezionato.value=entity.id+"|STATO="+entity.statoelemento;
  }
  window.event.cancelBubble = true
}

function expand(entity) {
  var oImage

  oImage = entity.childNodes(0).all["image"]
  oImage.src = entity.imageOpen

  for(i=0; i < entity.childNodes.length; i++) {
    if(entity.childNodes(i).tagName == "DIV") {
      entity.childNodes(i).style.display = "block"
    }
  }
  entity.open = "true"
}

function collapse(entity) {
  var oImage
  var i

  oImage = entity.childNodes(0).all["image"]
  oImage.src = entity.image

  // collapse and hide children
  for(i=0; i < entity.childNodes.length; i++) {
      if(entity.childNodes(i).tagName == "DIV") {
        if(entity.id != "folderTree") entity.childNodes(i).style.display = "none"
        collapse(entity.childNodes(i))
      }
    }
  entity.open = "false"
}

function expandAll(entity) {
  var oImage
  var i

  expand(entity, false)

  // expand children
  for(i=0; i < entity.childNodes.length; i++) {
    if(entity.childNodes(i).tagName == "DIV") {
      expandAll(entity.childNodes(i))
    }
  }
}


// mscatena 19-06-2008 inizio
// Expand dei primi n figli dell'albero
function expandTo(entity, numEnt){
  expand(entity.childNodes(0), false);
  entity = entity.childNodes(0);

  for(i=0; i < numEnt; i++){
    expand(entity.childNodes(1), false);
    entity = entity.childNodes(1);
  }
}
// mscatena 19-06-2008 fine