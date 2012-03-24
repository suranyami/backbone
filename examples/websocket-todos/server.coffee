http = require("http")
url = require("url")
path = require("path")
fs = require("fs")
port = 8888

http.createServer((request, response) ->
  uri = url.parse(request.url).pathname
  filename = path.join(process.cwd(), uri)
  
  path.exists filename, (exists) ->
    unless exists
      response.writeHead 404,
        "Content-Type": "text/plain"

      response.write "404 Not Found\n"
      response.end()
      return
    
    filename += "/index.html"  if fs.statSync(filename).isDirectory()
    
    fs.readFile filename, "binary", (err, file) ->
      if err
        response.writeHead 500,
          "Content-Type": "text/plain"

        response.write err + "\n"
        response.end()
        return
      response.writeHead 200
      response.write file, "binary"
      response.end()
).listen parseInt(port, 10)

console.log "Static file server running at\n  => http://localhost: #{port} /\nCTRL + C to shutdown"

io = require("socket.io").listen(4000, {origins: "*:*"})

io.set "origins", "*:*"
io.set "log level", 1

create = (socket, signature) ->
  e = event("create", signature)
  data = []
  
  socket.emit e, {id: 1}
  
  console.log "created"

read = (socket, signature) ->
  e = event("read", signature)
  data = undefined
  data.push {}
  socket.emit e, data
  console.log "read"

update = (socket, signature) ->
  e = event("update", signature)
  data = []
  
  socket.emit e, {success: true}

  console.log "update"

destroy = (socket, signature) ->
  e = event("delete", signature)
  data = []
  
  socket.emit e, {success: true}

  console.log "destroy"

event = (operation, sig) ->
  "#{operation}: #{sig.endPoint}#{(":" + sig.ctx)  if sig.ctx}"

io.sockets.on "connection", (socket) ->
  socket.on "create", (data) ->
    create socket, data.signature

  socket.on "read", (data) ->
    read socket, data.signature

  socket.on "update", (data) ->
    update socket, data.signature

  socket.on "delete", (data) ->
    destroy socket, data.signature
