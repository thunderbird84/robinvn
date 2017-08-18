package robin.jetty;

class JettyMainLocal  extends JettyMain{
    public static void main(String[] args) throws Exception {
        System.setProperty("jetty.http.port","8489");
        System.setProperty("war.file","/tmp/app.war");
        startServer();
    }
}

