package robin.jetty;

import org.eclipse.jetty.plus.webapp.EnvConfiguration;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ServerConnector;
import org.eclipse.jetty.server.Slf4jRequestLog;
import org.eclipse.jetty.webapp.Configuration;
import org.eclipse.jetty.webapp.WebAppContext;
import org.eclipse.jetty.webapp.WebInfConfiguration;
import org.eclipse.jetty.webapp.WebXmlConfiguration;

import javax.naming.NamingException;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;


class JettyMain {
    private static String env = "dev";
    private static String baseDir = "/app";

    static {
        setConfigs();
    }

    public static void main(String[] args) throws Exception {

        startServer();
    }

    public static void startServer() throws Exception {
        Server server = new Server();
        ServerConnector http = new ServerConnector(server);
        http.setPort(Integer.valueOf(System.getProperty("jetty.http.port", "80")));
        System.setProperty("org.mortbay.xml.XmlParser.Validating", "false");
        server.addConnector(http);
        moreSettings(server);
        Slf4jRequestLog rl = new Slf4jRequestLog();
        rl.setLogDateFormat(null);
        rl.setLogLatency(true);
        server.setRequestLog(rl);

        WebAppContext context = new WebAppContext();
        context.setServer(server);
        context.setParentLoaderPriority(true);
        context.setContextPath("/");
        setupJndiResources(context);
        context.setWar(System.getProperty("war.file", "/wars/app.war"));
        server.setHandler(context);
        server.start();

        System.in.read();
        server.stop();
        server.join();
    }

    public static void setupJndiResources(WebAppContext context) throws NamingException {
        try {
            EnvConfiguration envConfiguration = new EnvConfiguration();
            File file = new File(baseDir + "/jetty-"+env +".xml");
            URL url;
            if(file.exists() && !file.isDirectory()) {
                url = file.toURI().toURL();
            }else{
                url = JettyMain.class.getClassLoader().getResource("jetty-"+env +".xml");
            }

            if (url != null){
                envConfiguration.setJettyEnvXml(url);
                context.setConfigurations(new Configuration[]{
                        new WebInfConfiguration(),
                        envConfiguration,
                        new WebXmlConfiguration()
                });
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    public static void moreSettings(Server server) {
        System.setProperty("java.naming.factory.url.pkgs",
                "org.eclipse.jetty.jndi");
        System.setProperty("java.naming.factory.initial",
                "org.eclipse.jetty.jndi.InitialContextFactory");

    }

    public static void setConfigs() {
        if (!"".equals(System.getProperty("base.dir", ""))) {
            baseDir = System.getProperty("base.dir", "dev");
        }
        try {
            Properties prop = new Properties();
            File f = new File(baseDir + "/jvm.properties");
            InputStream is = null;
            if (f.exists() && !f.isDirectory()) {
                is = new FileInputStream(baseDir + "/jvm.properties");
            }
            if (is != null) {
                prop.load(is);
                for (Object key : prop.keySet()) {
                    System.setProperty((String) key, (String) prop.get(key));
                }
            }

        } catch (Exception e) {
        }

        if (!"".equals(System.getProperty("env", ""))) {
            env = System.getProperty("env", "dev");
        }
        if ("".equals(System.getProperty("catalina.home", ""))) {
            System.setProperty("catalina.home", baseDir + "/" + env);
        }
    }
}

