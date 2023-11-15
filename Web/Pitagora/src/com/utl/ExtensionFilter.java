package com.utl;

import java.io.*;

public class ExtensionFilter implements FilenameFilter
{
  private String extensionName;
  
  public ExtensionFilter(String extensionName)
  {
//    this.extensionName = "."+extensionName;
    this.extensionName = extensionName;    
  }
  
  public boolean accept(File path, String name){
    //System.out.println("path => ["+path+"]");
    //System.out.println("name => ["+name+"]");    
    return name.endsWith(extensionName);
  }
}
