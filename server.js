var net = require("net"),
    repl = require("repl");

net.createServer(function (socket) {
    var remote = repl.start({
        prompt: "",
        input: socket,
        output: socket
    });
}).listen(5000, "localhost");
