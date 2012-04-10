Backbone.sync = (method, model, options) ->
  socket = window.socket
  signature = ->
    sig = {}
    sig.endPoint = model.url + (if model.id then ("/" + model.id) else "")
    sig.ctx = model.ctx  if model.ctx
    sig

  event = (operation, sig) ->
    "#{operation}:#{sig.endPoint}#{(":" + sig.ctx)  if sig.ctx}"

  create = ->
    sign = signature(model)
    e = event("create", sign)
    
    socket.emit "create",
      signature: sign
      item: model.attributes

    socket.once e, (data) ->
      model.id = data.id
      console.log model

  read = ->
    sign = signature(model)
    e = event("read", sign)
    socket.send
      name: "read"
      signature: sign

    socket.once e, (data) ->
      options.success data

  update = ->
    sign = signature(model)
    e = event("update", sign)
    socket.emit "update",
      signature: sign
      item: model.attributes

    socket.once e, (data) ->
      console.log data

  destroy = ->
    sign = signature(model)
    e = event("delete", sign)
    socket.emit "delete",
      signature: sign
      item: model.attributes

    socket.once e, (data) ->
      console.log data

  switch method
    when "create"
      create()
    when "read"
      read()
    when "update"
      update()
    when "delete"
      destroy()
