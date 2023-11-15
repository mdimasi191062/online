package com.strutturaWeb.Action;

import com.ejbSTL.ContrattoSTLHome;

import com.strutturaWeb.EjbConnector;
import com.strutturaWeb.Java2JavaScript;
import com.strutturaWeb.View.ViewContratti;

import com.strutturaWeb.View.ViewTabella;

import com.utl.ContrattoElem;

import java.io.BufferedReader;
import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ActionMostraCsv implements ActionInterface
{
  public ActionMostraCsv()
  {
    
  }

  public String esegui(HttpServletRequest request, 
                       HttpServletResponse response) throws Exception
  {
    BufferedReader br=null;
  try{
    String nomeFile=request.getParameter("nomeFile");
    String path1=request.getParameter("path");

    int pagina=Integer.parseInt(request.getParameter("page"));
    int maxRigheXPagina=Integer.parseInt(request.getParameter("maxRow"));
    int maxRowTot=0;
    String[] header=null;
    int righePrese=maxRigheXPagina;
    maxRowTot=Integer.parseInt(request.getParameter("totRows"));
    if(maxRowTot==-1)
    {
      maxRowTot=calcolaRighe(path1+"/"+nomeFile);
    }

    int maxPages=maxRowTot/maxRigheXPagina;
  if((maxRowTot-2)%maxRigheXPagina!=0)
    maxPages++;
    
    int rowToSkip=pagina*maxRigheXPagina;
    if(rowToSkip>maxRowTot)
      rowToSkip=(maxRowTot-maxRigheXPagina/maxRigheXPagina);
    if(rowToSkip<0)
      rowToSkip=0;
    HashMap<String,ArrayList<String>> tabellaDati=new HashMap<String,ArrayList<String>>();
    br=new BufferedReader(new InputStreamReader(new FileInputStream(path1+"/"+nomeFile)));
    String row=null;
    row=br.readLine();
    ArrayList<String>[] colonne=null;
    if(row!=null)
    {
      header=row.split(";");
      colonne= (ArrayList<String>[])new ArrayList[header.length];
      for(int i=0;i<header.length;i++)
      {
        colonne[i]=new ArrayList<String>();
        tabellaDati.put(header[i],colonne[i]);
      }
    }
    
    for(int i=0;i<rowToSkip ;i++)
    {
      br.readLine();
    }
    while((row=br.readLine())!=null)
    {
      
      righePrese--;
      String[] cell=row.split(";");
      if(cell.length!=colonne.length)
        continue;
      for(int i=0;i<cell.length;i++)
      {
        colonne[i].add(cell[i]);
      }
      if(righePrese==0)
        break;
    }

    ViewTabella view=new ViewTabella(tabellaDati);
    return new Java2JavaScript().executeTable(view,header,pagina,maxPages,maxRowTot);
  }catch(Exception e)
  {
    throw e;
  }
  finally
  {
    if(br!=null)
      br.close();
  }
  }

  private int calcolaRighe(String file) throws FileNotFoundException, 
                                               IOException
  {
    BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(file)));
    int nRow=0;
    while(br.readLine()!=null)
      nRow++;
    return nRow;
  }
}
