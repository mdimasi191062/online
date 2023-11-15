package com.taglib.sec;

import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.Vector;
import com.utl.SecurityInfoTransf;
import com.utl.StaticContext;
import com.usr.clsInfoUser;

import com.ejbSTL.Security;
import java.io.IOException;


public class ShowButtons extends TagSupport 
{

  private HttpServletResponse response = null;
  private HttpServletRequest request = null;
  private HttpSession session = null; 
  private JspWriter out = null;
  private clsInfoUser locClsInfoUser = null;
  private Vector locVector = null;
  private boolean RedirectEnabled = true;


  /*
  tag attribute: td_class
  */
  private String force_singleButton = "";
  /*
  tag attribute: td_class
  */
  private String td_class = "textB";
  /*
  tag attribute: td_bgcolor
  */
  private String td_bgcolor = "#D5DDF1";
  /*
  tag attribute: td_align
  */
  private String td_align = "center";
  /*
  tag attribute: VectorName
  */
  private String VectorName = "buttons";
  private String PageName = null;



  public int doStartTag() { return EVAL_PAGE; }

  public int doEndTag()
  {
    try
    {
        JspWriter out = pageContext.getOut();

        if (PageName!=null)
          reloadTable();
        else
        {
          Vector QueryResult=(Vector)super.pageContext.getAttribute(this.getVectorName());
      
         if (QueryResult!= null) {
              showVector (QueryResult,out);
          }
        }
    }
    catch(Exception e)
    {
      System.out.println(e.getMessage());
      e.printStackTrace();
    }
    return EVAL_PAGE;
  }

  public void setForce_singleButton(String buttonName)
  {
    force_singleButton = buttonName;
  }

  public String getForce_singleButton()
  {
    return force_singleButton;
  }

  public void setTd_class(String value)
  {
    td_class = value;
  }


  public String getTd_class()
  {
    return td_class;
  }


  public void setTd_bgcolor(String value)
  {
    td_bgcolor = value;
  }


  public String getTd_bgcolor()
  {
    return td_bgcolor;
  }


  public void setTd_align(String value)
  {
    td_align = value;
  }


  public String getTd_align()
  {
    return td_align;
  }

  public void setVectorName(String value)
  {
    VectorName = value;
  }

  public String getVectorName()
  {
    return VectorName;
  }

  public void setPageName(String value)
  {
    PageName = value;
  }

  public String getPageName()
  {
    return PageName;
  }

private void reloadTable() throws JspException {

    response = (HttpServletResponse)super.pageContext.getResponse();
    request = (HttpServletRequest)super.pageContext.getRequest();
    session = request.getSession(false); 
    out = pageContext.getOut();
    
    try
    {

      request = (HttpServletRequest)super.pageContext.getRequest();
      session = request.getSession(false); 

      locClsInfoUser=(clsInfoUser) session.getAttribute(StaticContext.ATTRIBUTE_USER);
      Security remote=locClsInfoUser.getRemoteInterface();

      locVector=remote.findAllOpEl  (locClsInfoUser.getUserProfile(),getPageName().toUpperCase());
      if (RedirectEnabled==true) 
      {
        if (locVector==null)
          StaticContext.RedirectPageToLogin (request,out,false);
        else
            showVector (locVector,out);
      }
    }
    catch(Exception exception)
    {
        System.out.println(exception.getMessage());
        exception.printStackTrace();
        throw new JspException(exception.toString());
    }
  }

public void showVector (Vector theVector,JspWriter out) throws java.io.IOException
        {
          out.println ("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align='"+td_align+"'>");
          out.println ("  <tr>");
          
          Iterator iterFittizio = theVector.iterator();
          boolean   intFittizio = false;
          while (iterFittizio.hasNext()) {
              SecurityInfoTransf mySecInfo = (SecurityInfoTransf)iterFittizio.next();
              if ( mySecInfo.getCode_op_elem().equals("FITTIZIO") ) {
                intFittizio = true;
              }
          }

          out.println ("    <td class=\""+td_class+"\" bgcolor=\""+td_bgcolor+"\" align=\""+td_align+"\"");
          if ( intFittizio ) 
          {
            out.println ("height=\"25\"");
          }
          out.println (">");

          if ( intFittizio ) 
          {
            out.println ("        <input class=\""+td_class+"\" type=\"hidden\">");
          }
          else {
            Iterator iter = theVector.iterator();
            while (iter.hasNext())
            {
                SecurityInfoTransf mySecInfo = (SecurityInfoTransf)iter.next();
                //System.out.println("force_singleButton " +force_singleButton);
                //System.out.println("desc_label " +mySecInfo.getDesc_label());
                if(force_singleButton.equalsIgnoreCase(""))
                {
                    out.println ("        <input class=\""+td_class+"\" type=\"button\" name=\""+mySecInfo.getCode_op_elem()+"\" value=\""+mySecInfo.getDesc_label()+"\" onClick=\""+mySecInfo.getCode_op_exec()+";\">");            
                }
                else {
                    if(force_singleButton.equalsIgnoreCase(mySecInfo.getDesc_label()))
                    {
                        out.println ("        <input class=\""+td_class+"\" type=\"button\" name=\""+mySecInfo.getCode_op_elem()+"\" value=\""+mySecInfo.getDesc_label()+"\" onClick=\""+mySecInfo.getCode_op_exec()+";\">");                                  
                    }
                    
                }
            }
          }
          out.println ("    </td>");
          out.println ("  </tr>");
          out.println ("</table>");
        }

}