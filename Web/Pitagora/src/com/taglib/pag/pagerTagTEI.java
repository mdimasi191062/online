package com.taglib.pag;
import javax.servlet.jsp.tagext.TagData;
import javax.servlet.jsp.tagext.TagExtraInfo;
import javax.servlet.jsp.tagext.VariableInfo;
import java.util.ArrayList;

public class pagerTagTEI extends TagExtraInfo 
{
  /**
   * This method is called to set up the scripting variables for this tag.
   */
  public VariableInfo[] getVariableInfo(TagData data)
  {
    ArrayList vars = new ArrayList();
    VariableInfo pagerMaxItems_Var = new VariableInfo("pagerMaxItems", "Integer", true, VariableInfo.NESTED);
    vars.add(pagerMaxItems_Var);
    VariableInfo pagerOffset_Var = new VariableInfo("pagerOffset", "Integer", true, VariableInfo.NESTED);
    vars.add(pagerOffset_Var);
    VariableInfo pagerPageNumber_Var = new VariableInfo("pagerPageNumber", "Integer", true, VariableInfo.NESTED);
    vars.add(pagerPageNumber_Var);


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