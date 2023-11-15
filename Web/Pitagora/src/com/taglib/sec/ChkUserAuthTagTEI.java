package com.taglib.sec;
import javax.servlet.jsp.tagext.TagData;
import javax.servlet.jsp.tagext.TagExtraInfo;
import javax.servlet.jsp.tagext.VariableInfo;
import java.util.ArrayList;

public class ChkUserAuthTagTEI extends TagExtraInfo 
{
  /**
   * This method is called to set up the scripting variables for this tag.
   */
  public VariableInfo[] getVariableInfo(TagData data)
  {
    ArrayList vars = new ArrayList();
    String VectorName_Value = data.getAttributeString("VectorName");
    if (VectorName_Value == null)
    {
    }
      else
      {
        VariableInfo VectorName_attrVar = new VariableInfo(VectorName_Value, "java.util.Vector", true, VariableInfo.AT_BEGIN);
        vars.add(VectorName_attrVar);
      }

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