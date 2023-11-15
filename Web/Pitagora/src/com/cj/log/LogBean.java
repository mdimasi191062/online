

package com.cj.log;


public class LogBean
{

    public LogBean()
    {
        fileName = null;
        onState = true;
        lock = new Object();
    }

    public String getFileName()
    {
        return fileName;
    }

    public Object getLock()
    {
        return lock;
    }

    public boolean getOnState()
    {
        return onState;
    }

    public void setFileName(String s)
    {
        fileName = s;
    }

    public void setOnState(boolean flag)
    {
        onState = flag;
    }

    private String fileName;
    private boolean onState;
    private Object lock;
}