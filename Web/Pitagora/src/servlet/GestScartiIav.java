package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.Vector;

import javax.servlet.*;
import javax.servlet.http.*;

public class GestScartiIav extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";
    private Vector<String> listScartiIav;

    public void init(ServletConfig config) throws ServletException {
        loadListScartiIav();
        super.init(config);
    }
    
    private void loadListScartiIav(){
        listScartiIav = new Vector<String>();
        listScartiIav.add("Assurance Mensile");
        listScartiIav.add("Assurance Timestrale");
        listScartiIav.add("Provisioning BTS");
        listScartiIav.add("Provisioning ULL");
        listScartiIav.add("Provisioning WLR");
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {response.setContentType(CONTENT_TYPE);
       /* PrintWriter out = response.getWriter();
       for(String str: listScartiIav){
            out.println( str + ';');
        }
        out.close();*/
        
        request.setAttribute("name", "value");
        request.getRequestDispatcher("/gest_scarti_iav/jsp/listaolo.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head><title>GestScartiIav</title></head>");
        out.println("<body>");
        out.println("<p>The servlet has received a POST. This is the reply.</p>");
        out.println("</body></html>");
        out.close();
    }
}
