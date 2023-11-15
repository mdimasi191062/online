package com.strutturaWeb.View;
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
import java.util.*;

public abstract class ViewInterface 
{
  protected Vector _vettore=null;
  public Vector getVector()
  {
    return _vettore;
  }
}