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
public class ActionEstrazioneNDCCessate implements ActionInterface
{
  public ActionEstrazioneNDCCessate()
  {
  }
   public String esegui(HttpServletRequest request, HttpServletResponse response) throws Exception
  {
    return  new ActionFactory().getAction("lancioBatchRepricing").esegui(request,response);
  }
}