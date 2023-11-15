package com.jexcel;

import java.io.*;
import java.util.*;

public class FileReader 
{
  private String filePath;
  private BufferedReader in;
  
  private int lineNumber=0;
  
  
  private User user;
  
  
  public FileReader(String filePath)
  {
    this.filePath = filePath;
  }

  public boolean open(){
    boolean res = false;
    try {
      in = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)));
      res=true;
    }catch(Exception ex){
      System.out.println("Exception FileReader.open: "+ex.toString());    
    }
    return res;
  }

  public boolean next(){
    boolean res = false;
    lineNumber++;
    try {
      String line = null;
      if ((line=in.readLine())!=null){
        if (line.indexOf("CONNECTED")>=0){
          user=null;
          parseLine(line);
          if (user!=null){
            res = true;
          }else {
            return next();
          }
        } else {
          return next();
        }
      }
    }catch(Exception ex){
      System.out.println("Exception FileReader.next: "+ex.toString());
    }
    return res;
  }
  
  private void parseLine(String line){
    user=new User();
    try {
      // INFO 14/05/2004 13:52:14 10.173.164.105 UTENTE : ADMIN    CONNECTED 14/05/2004 13:47:02 DISCONNECTED 14/05/2004 13:52:14
      StringTokenizer stz = new StringTokenizer(line, " ");
      stz.nextToken();  //INFO
      stz.nextToken();  //14/05/2004
      stz.nextToken();  //13:52:14
      stz.nextToken();  //10.173.164.105
      if (stz.nextToken().indexOf("UTENTE")>=0){     //UTENTE
        stz.nextToken();  //:
        user.setUserID(stz.nextToken());  //ADMIN
        stz.nextToken();  //CONNECTED
        user.setDataInizioAccesso(stz.nextToken()+" "+stz.nextToken()); //14/05/2004 13:47:02
        if(stz.hasMoreElements()){
          stz.nextToken();//DISCONNECTED
          user.setDataFineAccesso(stz.nextToken()+" "+stz.nextToken()); //14/05/2004 13:52:14
        }
      }else {
        user=null;
      }
    }catch(Exception ex){
      user = null;
      System.out.println("Exception FileReader.parseLine: "+ex.toString());
    }
  }


  public User getUser(){
    return user;
  }

  public int getLineNumber(){
    return lineNumber;
  }


}