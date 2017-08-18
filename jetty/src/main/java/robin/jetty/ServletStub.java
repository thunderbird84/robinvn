package robin.jetty;

import javax.mail.Session;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by tuanvu on 8/4/17.
 */
public class ServletStub extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type
        response.setContentType("text/html");
        StringBuilder sb = new StringBuilder();
        try {
            InitialContext ic = new InitialContext();
            String snName = "java:comp/env/mail/SmtpServer";
            Session session = (Session) ic.lookup(snName);
        } catch (Exception ex) {
            sb.append("Could not find mail session. " + ex.getMessage());
            ex.printStackTrace();
        }

        // Actual logic goes here.
        PrintWriter out = response.getWriter();
        out.println("<h1>Message" + sb.toString() +"</h1>");
    }
}
