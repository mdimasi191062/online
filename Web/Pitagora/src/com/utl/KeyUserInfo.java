package com.utl;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.UserInfo;

import java.io.File;

public class KeyUserInfo

            implements UserInfo

{

    

    /** Creates a new instance of KeyUserInfo */

    public KeyUserInfo( JSch jsch, String sshHome, String keyFileName, String knownHostFileName ) 

            throws JSchException

    {

            jsch.addIdentity( new File( sshHome, keyFileName ).getAbsolutePath() );

            jsch.setKnownHosts( new File( sshHome, knownHostFileName ).getAbsolutePath() );

    }

    

    public String getPassphrase()

    {

            return null;

    }

    

    public String getPassword()

    {

            return null;

    }

    

    public boolean promptPassword(String string)

    {

            return true;

    }

    

    public boolean promptPassphrase(String string)

    {

            return true;

    }

    

    public boolean promptYesNo(String string)

    {

            return true;

    }

    

    public void showMessage(String string)

    {

    }

    

}
