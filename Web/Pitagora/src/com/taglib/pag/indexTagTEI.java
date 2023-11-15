package com.taglib.pag;
import javax.servlet.jsp.tagext.TagData;
import javax.servlet.jsp.tagext.TagExtraInfo;
import javax.servlet.jsp.tagext.VariableInfo;
import java.util.ArrayList;

public class indexTagTEI extends TagExtraInfo 
{
  /**
   * This method is called to set up the scripting variables for this tag.
   */
  public VariableInfo[] getVariableInfo(TagData data)
  {
    ArrayList vars = new ArrayList();
    VariableInfo pagerNumber_Var = new VariableInfo("pageNumber", "Integer", true, VariableInfo.NESTED);
    vars.add(pagerNumber_Var);
    VariableInfo pageUrl_Var = new VariableInfo("pageUrl", "String", true, VariableInfo.NESTED);
    vars.add(pageUrl_Var);


    return (VariableInfo[])vars.toArray(new VariableInfo[0]);

  }

  /**
   * This method is called to verify that the attributes are valid. 
   * @return true or false
   */
  public boolean isValid(TagData data)
  {
    return true;
  }
}