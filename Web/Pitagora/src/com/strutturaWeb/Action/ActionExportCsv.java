package com.strutturaWeb.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionExportCsv implements ActionInterface
{
  public ActionExportCsv()
  {
  }
  
  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
  
     String codGest = request.getParameter("codGest") ;
     codGest = ( "".equals(codGest) || codGest == null ) ? null : codGest;
    
     String codAccount =  request.getParameter("codAccount");
     codAccount = ( "".equals(codAccount) || codAccount == null ) ? null : codAccount;
    
     String dataInizio =request.getParameter("dataInizio");
     dataInizio = ( "".equals(dataInizio) || dataInizio == null ) ? null : dataInizio;
     
     String dataFine = request.getParameter("dataFine");
     dataFine = ( "".equals(dataFine) || dataFine == null ) ? null : dataFine;
    
     String flagFunzione = request.getParameter("flagFunzione");
     flagFunzione = ( "".equals(flagFunzione) || flagFunzione == null ) ? null : flagFunzione;
     
     String rifFattura = request.getParameter("rifFattura");
     rifFattura = ( "".equals(rifFattura) || rifFattura == null ) ? null : rifFattura;
    
     return  new ActionFactory().getAction("lancioBatchRepricing").esegui(request,response);

  }
  
}
