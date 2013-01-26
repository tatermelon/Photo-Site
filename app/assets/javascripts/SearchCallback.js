function AJAX(url, onReady, requestType)
{
  this.url = url;
  this.resultHandler = onReady;
  this.requestType = requestType;
}

AJAX.prototype.wrap = function(obj, method) 
{
  return function(event) {
    obj[method](event);
  }
}

// Public method to perform an AJAX request with a 
// case insensitive query
AJAX.prototype.getData = function(query) 
{
  this.xhr = new XMLHttpRequest();
  this.xhr.onreadystatechange = this.wrap(this, "xhrHandler");
  safeQuery = encodeURIComponent(query).toLowerCase();
  this.xhr.open(this.requestType, this.url + safeQuery, false);
  this.xhr.send();
}

AJAX.prototype.xhrHandler = function() 
{
  if (this.xhr.readyState != 4) {
    return;
  }
  if (this.xhr.status != 200) {
    // Handle error
    console.log("ERROR!");
    return;
  }
  this.resultHandler(this.xhr.responseText);
}
