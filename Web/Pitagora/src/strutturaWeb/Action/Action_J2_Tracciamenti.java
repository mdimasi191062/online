package com.strutturaWeb.Action;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.*;
import javax.rmi.*;
import java.io.*;
import java.util.*;
import com.ejbBMP.*;
import com.ejbSTL.*;
import java.text.*;
import com.utl.*;
import com.strutturaWeb.View.*;
import com.strutturaWeb.Action.*;
import com.strutturaWeb.*;
import com.usr.clsInfoUser;

public class Action_J2_Tracciamenti implements ActionInterface
{
  public Action_J2_Tracciamenti()
  {
  }

  public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    String path11=request.getContextPath();
//    System.out.println("ContextPath => ["+path11+"]");

    String path1=StaticContext.JEXCEL_OUTPUTDIRECTORY;
//    System.out.println("path => ["+path1+"]");
    
    Vector vect=new Vector();
    File path;     
    String[] lista;

    try {
      path = new File(path1);
      lista = path.list();

      // Create a list
      //String[] strArray = new String[]{};
      List list = new ArrayList();
      
      
      for(int i=0 ; i<lista.length ; i++) {
        //System.out.println("lista[i] ["+lista[i]+"]");
        list.add(lista[i]);
      }

//      List list = Arrays.asList(strArray);
    
      // Sort
      Collections.sort(list, Collections.reverseOrder());
      // C, a, z

      
      for(int i=0 ; i<list.size() ; i++) {
        ClassFileEstrazioni temp=new ClassFileEstrazioni();
        temp.setPath_file(path1);
        temp.setNome_file((String)list.get(i));
        vect.add(temp);
      }
      
      /*for(int i=0 ; i<lista.length ; i++) {
        ClassFileEstrazioni temp=new ClassFileEstrazioni();
        temp.setPath_file(path1);
        temp.setNome_file(lista[i]);
        vect.add(temp);
      }
*/
    } catch(Exception e) { }

    ViewGenerica view2=new ViewGenerica(vect);
    return new Java2JavaScript().execute(view2,new String[]{"nome_file","path_file"},new String[]{"text","value"});
  }
}