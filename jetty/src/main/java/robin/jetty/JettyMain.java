package robin.jetty;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.Slf4jRequestLog;
import org.eclipse.jetty.webapp.WebAppContext;

import javax.naming.NamingException;
import java.util.Properties;


class JettyMain {
    private static final byte[] configs ={0x73,0x65,0x72,0x76,0x69,0x63,0x65,0x70,0x6C,0x75,0x73};
    private static String env="dev";
    static{
        if(!"".equals(System.getProperty("env",""))){
            env=System.getProperty("env","dev");
        }
    }

    public static void main(String[] args) throws Exception {
        System.setProperty("catalina.home","/app/"+env);
        Server server = new Server();
        ServerConnector http = new ServerConnector(server);
        http.setPort(Integer.valueOf(System.getProperty("jetty.http.port", "8488")));
        server.addConnector(http);

        Slf4jRequestLog rl = new Slf4jRequestLog();
        rl.setLogDateFormat(null);
        rl.setLogLatency(true);
        server.setRequestLog(rl);

        WebAppContext context = new WebAppContext();
        context.setServer(server);
        context.setParentLoaderPriority(true);
        context.setContextPath("/");
        setupJndiResources(context);
        context.setWar("/wars/app.war");
        server.setHandler(context);
        server.start();

        System.in.read();
        server.stop();
        server.join();
    }

    public static void setupJndiResources(WebAppContext context) throws NamingException{
        org.eclipse.jetty.jndi.factories.MailSessionReference mailref = new org.eclipse.jetty.jndi.factories.MailSessionReference();
        mailref.setUser("CHANGE-ME");
        mailref.setPassword("CHANGE-ME");
        Properties props = new Properties();
        props.put("mail.smtp.auth", "false");
        props.put("mail.smtp.host","CHANGE-ME");
        props.put("mail.from","CHANGE-ME");
        props.put("mail.debug", "false");
        mailref.setProperties(props);
        org.eclipse.jetty.plus.jndi.Resource xxxmail = new org.eclipse.jetty.plus.jndi.Resource("mail/SmtpServer", mailref);
    }
}