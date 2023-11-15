package com.taglib.sec;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Vector;
import com.utl.StaticContext;
import com.utl.clsApplication;
import com.usr.clsInfoUser;
import com.ejbSTL.Security;

public class ChkUserAuth extends TagSupport 
{

  private HttpServletResponse response = null;
  private HttpServletRequest request = null;
  private HttpSession session = null; 
  private JspWriter out = null;
  private clsInfoUser locClsInfoUser = null;
  private Vector locVector = null;
  String theActionIndicator=null;
  /*
  tag attribute: RedirectEnabled
  */

  private boolean RedirectEnabled = true;
  /*
  tag attribute: VectorName
  */
  private String VectorName = "buttons";
  /*
  tag attribute: isModal
  */
  private boolean isModal = false;


  /**
   * Method called at start of tag.
   * @return SKIP_BODY
   */
  public int doStartTag()
  {
    return SKIP_BODY;
  }

  public int doEndTag() throws JspException
  { 
    try
    {
      String my_param="";
      
      response = (HttpServletResponse)super.pageContext.getResponse();
      request = (HttpServletRequest)super.pageContext.getRequest();
      session = request.getSession(false); 
      out = pageContext.getOut();
      if(session.getAttribute(StaticContext.ATTRIBUTE_USER) == null)
      {
        StaticContext.RedirectPageToLogin (request,out,isModal);
        return SKIP_PAGE;
      }
      locClsInfoUser=(clsInfoUser) session.getAttribute(StaticContext.ATTRIBUTE_USER);
      Security remote=locClsInfoUser.getRemoteInterface();
      my_param=remote.chk_param();
      if((my_param!="")&&(my_param!=null))
      {
          System.out.println("Utente Amministratore: "+locClsInfoUser.getAdminIndicator());

        if((my_param.equals("ALL"))&&(StaticContext.ADMIN_INDICATOR.equals(locClsInfoUser.getAdminIndicator())))
        {
          System.out.println("servlet trovato parametro: "+my_param.toString());
          System.out.println("Utente Amministratore: "+locClsInfoUser.getAdminIndicator());
        }
        else
        {

          StaticContext.RedirectPageDisconnect (request,out,isModal,my_param);
          return SKIP_PAGE;
        }
      }
      
      locVector=remote.findAllOpEl  (locClsInfoUser.getUserProfile(),StaticContext.getJspName(request));
      if (RedirectEnabled==true) 
      {
        if (locVector==null) 
        {
          session.invalidate();
          StaticContext.RedirectPageNoIusses(request,out,isModal);
          return SKIP_PAGE;
        }
        else 
          super.pageContext.setAttribute(this.getVectorName(),locVector);
      }
    }
    catch(Exception exception)
    {
        throw new JspException(exception.toString());
    }
    return EVAL_PAGE;

  }


  public void setRedirectEnabled(boolean value)
  {
    RedirectEnabled = value;
  }


  public boolean getRedirectEnabled()
  {
    return RedirectEnabled;
  }

  public void setVectorName(String value)
  {
    VectorName = value;
  }


  public String getVectorName()
  {
    return VectorName;
  }


  public void setIsModal(boolean value)
  {
    isModal = value;
  }


  public boolean getIsModal()
  {
    return isModal;
  }
}