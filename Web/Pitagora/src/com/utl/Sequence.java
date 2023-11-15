package com.utl;

public class Sequence  extends AbstractSequenceBean
{
  public Sequence()
  {
  }
  public String NewSequence(String NomeSequence)  
  {
    String strNewPrimaryKey = null;
    try 
    {  
      strNewPrimaryKey = getSequenceValue(NomeSequence);
    }
    catch(Throwable ex)
    {
      ex.printStackTrace();      
      /*
      throw new java.lang.Exception(ex.getMessage());*/
    }  
    return strNewPrimaryKey;
  }
}