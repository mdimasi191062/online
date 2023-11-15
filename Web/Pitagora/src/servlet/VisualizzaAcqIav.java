package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.Vector;

import javax.servlet.*;
import javax.servlet.http.*;

public class VisualizzaAcqIav extends HttpServlet {

    private static final String CONTENT_TYPE = "text/html; charset=UTF-8";
    private Vector<String> listAcqIav;

    public void init(ServletConfig config) throws ServletException {
        loadListAcqIav();
        super.init(config);
    }
    
    private void loadListAcqIav(){
        listAcqIav = new Vector<String>();
        listAcqIav.add("Assurance Mensile");
        listAcqIav.add("Assurance Timestrale");
        listAcqIav.add("Provisioning BTS");
        listAcqIav.add("Provisioning ULL");
        listAcqIav.add("Provisioning WLR");
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {response.setContentType(CONTENT_TYPE);        
        request.setAttribute("name", "value");
        request.getRequestDispatcher("/visualizza_acq_iav/jsp/listaolo.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {response.setContentType(CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head><title>GestAcqIav</title></head>");
        out.println("<body>");
        out.println("<p>The servlet has received a POST. This is the reply.</p>");
        out.println("</body></html>");
        out.close();
    }
}
