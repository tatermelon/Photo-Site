// feedback div must be child of parent div
function Tagger(parentId, feedbackId, imgId, xId, yId, widthId, heightId) {
  this.parent = document.getElementById(parentId);
  this.image = document.getElementById(imgId);
  this.feedback = document.getElementById(feedbackId);
  this.xDiv = document.getElementById(xId);
  this.yDiv = document.getElementById(yId);
  this.widthDiv = document.getElementById(widthId);
  this.heightDiv = document.getElementById(heightId);
   
  this.isMouseDown = false;
  this.parent.onmousedown = this.wrap(this, "mouseDown");
  this.parent.onmousemove = this.wrap(this, "mouseMove");
  document.onmouseup = this.wrap(this, "mouseUp");
}

Tagger.prototype.wrap = function(obj, method) {
  return function(event) {
    obj[method](event);
  }
}

Tagger.prototype.mouseDown = function(event) {
  event.preventDefault();
  
  this.xpos = event.pageX - this.parent.offsetLeft;
  this.ypos = event.pageY - this.parent.offsetTop;
  this.feedback.style.visibility = "visible";
  this.feedback.style.left = this.xpos + "px";
  this.feedback.style.top = this.ypos + "px";
  this.feedback.style.width = "0px";
  this.feedback.style.height = "0px";
  this.isMouseDown = true;
  
  var obj = this;
  this.oldMoveHandler = document.body.onmousemove;
  document.body.onmousemove = function(event) {
      obj.mouseMove(event);
  }
}

Tagger.prototype.mouseMove = function(event) {
  if (!this.isMouseDown) {
    return;
  }
  tempx = Math.max(event.pageX - this.parent.offsetLeft, 0);
  tempx = Math.min(tempx, this.image.width);
  tempy = Math.max(event.pageY - this.parent.offsetTop, 0);
  tempy = Math.min(tempy, this.image.height);
  console.log(this.image.borderWidth);
  this.width = Math.abs(tempx - this.xpos);
  this.height = Math.abs(tempy - this.ypos);
  this.feedback.style.width = this.width + "px";
  this.feedback.style.height = this.height + "px";
  this.feedback.style.left = Math.min(tempx, this.xpos) + "px";
  this.feedback.style.top = Math.min(tempy, this.ypos) + "px";
}

Tagger.prototype.mouseUp = function(event) {
  this.isMouseDown = false;
  document.body.onmousemove = this.oldMoveHandler;
  this.xDiv.innerHTML = "<input id='tag_x_coord' name='tag[x_coord]' type='hidden' value="+this.feedback.style.left+">";
  this.yDiv.innerHTML = "<input id='tag_y_coord' name='tag[y_coord]' type='hidden' value="+this.feedback.style.top+">";
  this.widthDiv.innerHTML = "<input id='tag_width' name='tag[width]' type='hidden' value="+this.width+">";
  this.heightDiv.innerHTML = "<input id='tag_height' name='tag[height]' type='hidden' value="+this.height+">";
}
