package com.utl;
import com.jcraft.jsch.*;
import com.utl.KeyUserInfo;


public class Sftp{

	public static void  sftp(String user,
                           String host,
                           int port,
                           String sshHome, 
                           String keyFileName, 
                           String knownHostFileName, 
                           String sourcePath, 
                           String destinationPath, 
                           String fileName 
                           ) throws JSchException, SftpException
	{
    try{
      System.out.println("sftp - inizio");
	    
      System.out.println("sftp - user ["+user+"]");
	    System.out.println("sftp - host ["+host+"]");
	    System.out.println("sftp - port ["+port+"]");
	    System.out.println("sftp - sshHome ["+sshHome+"]");
	    System.out.println("sftp - keyFileName ["+keyFileName+"]");
	    System.out.println("sftp - knownHostFileName ["+knownHostFileName+"]");
	    System.out.println("sftp - sourcePath ["+sourcePath+"]");
	    System.out.println("sftp - destinationPath ["+destinationPath+"]");
	    System.out.println("sftp - fileName ["+fileName+"]");     
      
      JSch jsch = new JSch();
      Session session = jsch.getSession( user, host, port );
      UserInfo ui = new KeyUserInfo( jsch, sshHome, keyFileName, knownHostFileName );
      session.setUserInfo( ui );
      session.connect();
      Channel channel = session.openChannel("sftp");
      channel.connect();
      ChannelSftp c = (ChannelSftp) channel;
      c.lcd( sourcePath  );
      c.cd( destinationPath );
      c.put( fileName, ".", null, ChannelSftp.OVERWRITE );
      c.quit();
      session.disconnect();
      System.out.println("sftp - fine");
	  }catch(JSchException jsche){
      System.out.println(jsche.getMessage());
    }catch(SftpException sftpe){
      System.out.println(sftpe.getMessage());
    }catch(Exception e){
      System.out.println(e.getMessage());
    }
    
	}
  

  
	
  public static int main_sftp(String user,String host,int port,String sshHome,String keyFileName,
                              String knownHostFileName,String sourcePath,String destinationPath,String fileName){
    int ret = 0;
    try {
      System.out.println("main_sftp - inizio");
      sftp(user,host,port,sshHome,keyFileName,knownHostFileName,sourcePath,destinationPath,fileName);
      //sftp("jpubrac","10.50.16.8",22,"jpubrac","C:/prova.txt","/home/jpubrac/LOG");
      ret = 0;
      System.out.println("main_sftp - fine");
    } catch (JSchException e) {
      System.out.println(e.getMessage());
      e.printStackTrace();
      ret = 1;
    } catch (SftpException e) {
      System.out.println(e.getMessage());
      e.printStackTrace();
      ret = 2;
    } catch (Exception e){
      System.out.println(e.getMessage());
    }
    return ret;
  }
 
  public static class MyUserInfoN implements UserInfo{

    public String getPassphrase() {
  
      return null;
    }
  
    public String getPassword() {
      
      return null;
    }
  
    public boolean promptPassphrase(String arg0) {
      
      return true;
    }
  
    public boolean promptPassword(String arg0) {
      // TODO Auto-generated method stub
    
      return true;
    }
  
    public boolean promptYesNo(String arg0) {
      // TODO Auto-generated method stub
      return true;
    }
  
    public void showMessage(String arg0) {
      System.out.println(arg0);
      
    }
	  
  }
 
  public static class MyProgressMonitor implements SftpProgressMonitor{
   
    public void init(int op, String src, String dest, long max){
      System.out.println("init sfpt");
    }
    private long percent=-1;

    public void end(){
    	System.out.println("fine sfpt");
    }

    public boolean count(long arg0) {
      return true;
    }
  }
  

}

 