package com.strutturaWeb.Action;

import javax.servlet.http.*;

import java.io.*;

import java.util.*;

import com.ejbSTL.*;

import com.utl.*;

import com.strutturaWeb.View.*;
import com.strutturaWeb.*;


public class Action_J2_ElencoFileDownloadJpub2 implements ActionInterface
{
  public Action_J2_ElencoFileDownloadJpub2()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {

    String codiceFunzione = request.getParameter("codiceFunzione");
    String codiceFunzione1 = codiceFunzione.substring(0,14);
    String codeservizio1   = codiceFunzione.substring(14,15);   
    String cicloAnno   = codiceFunzione.substring(codiceFunzione.length()-4,codiceFunzione.length());
    String cicloMese   = codiceFunzione.substring(15,codiceFunzione.length()-7);
    String scicloMese  = cicloMese;
    String sciclo = scicloMese.toUpperCase()+"_"+cicloAnno;
    if (cicloMese.equals("Gennaio"))
                    cicloMese = "01";
    else
        if (cicloMese.equals("Febbraio"))
                        cicloMese = "02";
        else        
            if (cicloMese.equals("Marzo"))
                            cicloMese = "03";
            else       
                if (cicloMese.equals("Aprile"))
                                cicloMese = "04";
                else       
                    if (cicloMese.equals("Maggio"))
                                    cicloMese = "05";
                    else       
                        if (cicloMese.equals("Maggio"))
                                        cicloMese = "05";
                        else    
                            if (cicloMese.equals("Giugno"))
                                            cicloMese = "06";
                            else    
                                if (cicloMese.equals("Luglio"))
                                                cicloMese = "07";
                                else    
                                    if (cicloMese.equals("Agosto"))
                                                    cicloMese = "08";
                                    else    
                                        if (cicloMese.equals("Settembre"))
                                                        cicloMese = "09";
                                        else    
                                            if (cicloMese.equals("Ottobre"))
                                                            cicloMese = "10";
                                            else    
                                                if (cicloMese.equals("Novembre"))
                                                                cicloMese = "11";
                                                else    
                                                    if (cicloMese.equals("Dicembre"))
                                                                    cicloMese = "12";
                                                    else    
                                                        cicloMese = "";

    String ciclo = "";
    String ciclo2 = "";
    if (codiceFunzione.contains("Attuale")) 
    {
          GregorianCalendar gc = new GregorianCalendar();
          String acicloMese = String.valueOf(gc.get(Calendar.MONTH));
          int nMese = Integer.parseInt(acicloMese);
          if (nMese < 10)
              acicloMese = "0"+acicloMese;
          String acicloAnno = String.valueOf(gc.get(Calendar.YEAR));
          ciclo =acicloAnno + acicloMese; 
          if (acicloMese.equals("01"))
              scicloMese = "GENNAIO";
          else     
              if (acicloMese.equals("02"))
                  scicloMese = "FEBBRAIO";
              else
                    if (acicloMese.equals("03"))
                      scicloMese = "MARZO";
                    else
                        if (acicloMese.equals("04"))
                            scicloMese = "APRILE";
                        else
                            if (acicloMese.equals("05"))
                                scicloMese = "MAGGIO";
                            else
                                if (acicloMese.equals("06"))
                                    scicloMese = "GIUGNO";
                                else
                                    if (acicloMese.equals("07"))
                                        scicloMese = "LUGLIO";
                                    else
                                        if (acicloMese.equals("08"))
                                            scicloMese = "AGOSTO";
                                        else
                                            if (acicloMese.equals("09"))
                                                scicloMese = "SETTEMBRE";
                                            else
                                                if (acicloMese.equals("10"))
                                                    scicloMese = "OTTOBRE";
                                                else
                                                    if (acicloMese.equals("11"))
                                                        scicloMese = "NOVEMBRE";
                                                    else
                                                        if (acicloMese.equals("12"))
                                                            scicloMese = "DICEMBRE";
          sciclo = scicloMese+"_"+acicloAnno;
          ciclo2 = acicloAnno.substring(2)+acicloMese;
    }
    else
    {
          ciclo = cicloAnno + cicloMese;     
          ciclo2 = cicloAnno.substring(2)+cicloMese;
    }
    int codeservizio = Integer.parseInt(codeservizio1);
    String servizio = "";

       switch (codeservizio) { 
               case 1: 
                       servizio = "rpvd";
                       break; 
               case 2: 
                       servizio = "mp";
                       break; 
               case 3: 
                       servizio = "itc";
                       break; 
               case 4: 
                       servizio = "itc_rev";
                       break; 
               case 5: 
                       servizio = "pp";
                       break; 
               case 6: 
                       servizio = "atm";
                       break; 
               case 7: 
                       servizio = "SAP";
                       break; 
               case 8: 
                       servizio = "SWN";
                       break;                        
               default:
                       servizio = "";
       }

    String path1 = "";
    String filterName = "";
    int lung = 0;
    
    /* Spazio dedicato ad EJB */
    Ent_DownloadParamHome home = (Ent_DownloadParamHome)EjbConnector.getHome("Ent_DownloadParam", Ent_DownloadParamHome.class);
    DB_DownloadParam ritorno = home.create().getDownloadParam(codiceFunzione1);

    if(ritorno != null){
      path1 = ritorno.getPATH();
      path1 = path1 + File.separator + servizio;
      filterName = ciclo;
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

     /*old 
      for (int i = 0; i < list.size(); i++)
      {
        if (list.get(i).toString().length() >= filterName.length())
        {
           if (list.get(i).toString().contains(filterName))
          {
            ClassFileEstrazioni temp = new ClassFileEstrazioni();
            temp.setPath_file((String)path1.replaceAll("\\\\","/"));
            temp.setNome_file((String)list.get(i));
            vect.add(temp);
          }
        }
      }old*/
      for (int i = 0; i < list.size(); i++)
      {

        if (list.get(i).toString().length() >= filterName.length())
        {
           if (servizio.equals("SWN"))
           {
               if ((list.get(i).toString().contains(filterName))||(list.get(i).toString().contains(sciclo)))
              {
                ClassFileEstrazioni temp = new ClassFileEstrazioni();
                temp.setPath_file((String)path1.replaceAll("\\\\","/"));
                temp.setNome_file((String)list.get(i));
                vect.add(temp);
              }
           }
           else
               if (servizio.equals("SAP"))
               {
                   if ((list.get(i).toString().contains(filterName))||(list.get(i).toString().contains(ciclo2)))
                  {
                    ClassFileEstrazioni temp = new ClassFileEstrazioni();
                    temp.setPath_file((String)path1.replaceAll("\\\\","/"));
                    temp.setNome_file((String)list.get(i));
                    vect.add(temp);
                  }
               }
               else
                   if (list.get(i).toString().contains(filterName))
                   {
                    ClassFileEstrazioni temp = new ClassFileEstrazioni();
                    temp.setPath_file((String)path1.replaceAll("\\\\","/"));
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
