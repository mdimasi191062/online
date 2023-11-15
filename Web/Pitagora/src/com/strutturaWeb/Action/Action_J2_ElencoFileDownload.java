package com.strutturaWeb.Action;

import javax.servlet.http.*;

import java.io.*;

import java.util.*;

import com.ejbSTL.*;

import com.utl.*;

import com.strutturaWeb.View.*;
import com.strutturaWeb.*;


public class Action_J2_ElencoFileDownload implements ActionInterface
{
  public Action_J2_ElencoFileDownload()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

    String codiceFunzione = request.getParameter("codiceFunzione");
    String path1 = "";
    String filterName = "";
    int lung = 0;
    
    /* Spazio dedicato ad EJB */
    Ent_DownloadParamHome home = (Ent_DownloadParamHome)EjbConnector.getHome("Ent_DownloadParam", Ent_DownloadParamHome.class);
    DB_DownloadParam ritorno = home.create().getDownloadParam(codiceFunzione);

    if(ritorno != null){
      path1 = ritorno.getPATH();
      filterName = ritorno.getNAME_FINDER();
      lung = filterName.length();
    }
    else
    {
      throw new Exception("Codice Funzione errato nella tabella j2_download_param!");
    }

    Vector vect = new Vector();
    File path;
    String[] lista;

    try
    {
      path = new File(path1);
      lista = path.list();
      
      if(lista == null)
      {
        throw new Exception("Path errato nella tabella j2_download_param!");
      }
      
      // Create a list
      List list = new ArrayList();

      for (int i = 0; i < lista.length; i++)
      {
        list.add(lista[i]);
      }

      // Sort
      Collections.sort(list, Collections.reverseOrder());

      for (int i = 0; i < list.size(); i++)
      {
        if (list.get(i).toString().length() >= filterName.length())
        {
          if (list.get(i).toString().substring(0, lung).compareToIgnoreCase(filterName) == 0)
          {
            ClassFileEstrazioni temp = new ClassFileEstrazioni();
            temp.setPath_file(path1);
            temp.setNome_file((String)list.get(i));
            vect.add(temp);
          }
        }
      }

    } catch (Exception e)
    {
      throw new Exception(e.getMessage());
    }

    ViewGenerica view2 = new ViewGenerica(vect);
    return new Java2JavaScript().execute(view2, new String[] { "nome_file", "path_file" }, new String[] { "text", "value" });
  }
}
