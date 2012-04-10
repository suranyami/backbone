(function() {

  Backbone.sync = function(method, model, options) {
    var create, destroy, event, read, signature, socket, update;
    socket = window.socket;
    signature = function() {
      var sig;
      sig = {};
      sig.endPoint = model.url + (model.id ? "/" + model.id : "");
      if (model.ctx) sig.ctx = model.ctx;
      return sig;
    };
    event = function(operation, sig) {
      return "" + operation + ":" + sig.endPoint + (sig.ctx ? ":" + sig.ctx : void 0);
    };
    create = function() {
      var e, sign;
      sign = signature(model);
      e = event("create", sign);
      socket.emit("create", {
        signature: sign,
        item: model.attributes
      });
      return socket.once(e, function(data) {
        model.id = data.id;
        return console.log(model);
      });
    };
    read = function() {
      var e, sign;
      sign = signature(model);
      e = event("read", sign);
      socket.send({
        name: "read",
        signature: sign
      });
      return socket.once(e, function(data) {
        return options.success(data);
      });
    };
    update = function() {
      var e, sign;
      sign = signature(model);
      e = event("update", sign);
      socket.emit("update", {
        signature: sign,
        item: model.attributes
      });
      return socket.once(e, function(data) {
        return console.log(data);
      });
    };
    destroy = function() {
      var e, sign;
      sign = signature(model);
      e = event("delete", sign);
      socket.emit("delete", {
        signature: sign,
        item: model.attributes
      });
      return socket.once(e, function(data) {
        return console.log(data);
      });
    };
    switch (method) {
      case "create":
        return create();
      case "read":
        return read();
      case "update":
        return update();
      case "delete":
        return destroy();
    }
  };

}).call(this);
