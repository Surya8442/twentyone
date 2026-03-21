const http = require('http');

const server = http.createServer((req, res) => {
  res.end("Hello from Kubernetes + Jenkins 🚀");
});

server.listen(3000);