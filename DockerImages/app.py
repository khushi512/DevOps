from http.server import BaseHTTPRequestHandler, HTTPServer


class HelloWorldHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Hello World from Docker multi-stage build")


server = HTTPServer(("0.0.0.0", 8080), HelloWorldHandler)

print("Server running on port 8080")

server.serve_forever()