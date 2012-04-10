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
mongoose = require 'mongoose'

TodoSchema = new mongoose.Schema(
  title: String
  order: Number
  done: Boolean
)

Todo = mongoose.model 'Todo', TodoSchema

mongoose.connect 'mongodb://localhost/todos'

io.set "origins", "*:*"
io.set "log level", 1

create = (socket, data) ->
  e = event("create", data.signature)
  todo = new Todo(data.item)
  console.log todo
  todo.save ->
    socket.emit e, {id: todo.objectId}
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
  e = operation + ':'
  e += sig.endPoint
  e += (':' + sig.ctx) if (sig.ctx)
  e   

io.sockets.on "connection", (socket) ->
  socket.on "create", (data) ->
    create socket, data

  socket.on "read", (data) ->
    read socket, data

  socket.on "update", (data) ->
    update socket, data

  socket.on "delete", (data) ->
    destroy socket, data
