package com.strutturaWeb;
import java.util.*;
import java.lang.reflect.*;
import com.strutturaWeb.View.*;
public class Java2JavaScript 
{

  public String execute(StringBuffer sb) throws Exception
  {
    StringBuffer javascript=new StringBuffer();
    javascript.append("var dati = new Array(");
    javascript.append("{text:'");
    javascript.append(sb);
    javascript.append("',value:''});");
    return javascript.toString();
  }

  public String execute(ViewInterface view,String nomiCampi[],String mapCampi[]) throws Exception
  {
      Vector vettore=view.getVector();
      String javascript="var dati = new Array(";


  try 
  {
      Class classe=null;
      if(vettore.size()>0)
      {
          Object obj=vettore.get(0);
          classe=obj.getClass();
      }
        for(int k=0;k<vettore.size();k++)
        {
          javascript+="{";
          for(int j=0;j<nomiCampi.length;j++)
          {
              Field field=classe.getDeclaredField(nomiCampi[j]);
              field.setAccessible(true);
             Object objV=field.get(vettore.get(k));
             String stemp=""+objV;
int cur=0;
            for(;;)
            {

             cur=stemp.indexOf("'",cur);
            if(cur==-1)
              break;
             String start= stemp.substring(0,cur);
             String end;
             if(cur<stemp.length()-1)
               end = stemp.substring(cur+1,stemp.length());
            else
               end="";
             stemp=start+"\\'"+end;
             cur+=2;
            }
            
             javascript+=mapCampi[j]+":'"+stemp+"'";
            if(j!=nomiCampi.length-1)
              javascript+=",";
            
          }
          javascript+="}";
          if(k!=vettore.size()-1)
              javascript+=",";
        }

        return javascript+");";
    
  }
    catch (Exception e)
    {
          throw new Exception("Errore nell'elaborazione della richiesta");
    }

  }
 
  public String executeTable(ViewTabella view,String[] nomiCampi,int page,int maxPages,int totRows) throws Exception
  {


      StringBuffer javascript=new StringBuffer("var dati = new Array(");
      int numeroRighe=view.getNumeroRighe();
       StringBuffer headerJavascript=new StringBuffer("");
  try 
  {

        for(int k=0;k<numeroRighe;k++)
        {
        if(k==0)
           headerJavascript.append("var headerTab=new Array(");
          javascript.append("{");

          for(int j=0;j<nomiCampi.length;j++)
          {
            if(k==0)
            { 
              headerJavascript.append("'");
              headerJavascript.append(nomiCampi[j]);
              headerJavascript.append("'");          
            }
             javascript.append("colonna"+j);
             javascript.append(":'");
             javascript.append(view.getValore(nomiCampi[j],k).compareTo("")==0?" ":view.getValore(nomiCampi[j],k).replaceAll("'"," "));
             javascript.append("'");
            if(j!=nomiCampi.length-1)
            {
              javascript.append(",");
              if(k==0)
                headerJavascript.append(",");
            }
            
          }
          javascript.append("}");
          if(k!=numeroRighe-1)
              javascript.append(",");
        }

        javascript.append(");");
        if(headerJavascript.toString().compareTo("")==0)
          headerJavascript.append("var headerTab=new Array(");
        javascript.append(headerJavascript);
        javascript.append(");");
        javascript.append("var pag_tab=");
        javascript.append(page);
        javascript.append(";var max_pag=");
        javascript.append(maxPages);
    javascript.append(";");
    javascript.append(";var tot_rows=");
    javascript.append(totRows);
    javascript.append(";");
        return javascript.toString().replace("\\","\\\\");
        
    
  }
    catch (Exception e)
    {
          throw new Exception("Errore nell'elaborazione della richiesta");
    }

  }
 
  
}