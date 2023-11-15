package com.filter;
import javax.servlet.ServletResponse;
import javax.servlet.Filter;
import javax.servlet.ServletException;
import javax.servlet.FilterConfig;
import javax.servlet.ServletRequest;
import javax.servlet.FilterChain;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;   
import com.utl.RequestWrapper;

public class CrossScriptingFilter implements Filter 
{
  private FilterConfig filterConfig = null;

  public void init(FilterConfig filterConfig) throws ServletException
  {
    this.filterConfig = filterConfig;
  }

  public void destroy()
  {
    this.filterConfig = null;
  }

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
  {
    chain.doFilter(new RequestWrapper((HttpServletRequest) request), response);
  }
}