import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class HelloWorld {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(
            new InetSocketAddress("0.0.0.0", 8080),
            0
        );

        server.createContext("/", exchange -> {
            String response = "Hello World";
            exchange.sendResponseHeaders(200, response.length());

            try (OutputStream output = exchange.getResponseBody()) {
                output.write(response.getBytes());
            }
        });

        server.start();

        System.out.println("Server running on port 8080");
    }
}