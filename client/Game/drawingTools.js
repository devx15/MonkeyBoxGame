var drawCircle = function (x,y, radius, imageSrc) {
    var img = new Image();
    img.src = imageSrc;
    context.drawImage(img, x, y, 2*radius, 2*radius)
    context.fill()
}

var drawStick = function (x1, y1, x2, y2, width, imageSrc) {

    var img = new Image();
    img.src = imageSrc;
   
    var length = Math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
    var angle = Math.atan2(y2 - y1, x2 - x1);
    context.translate(x1, y1);
    context.rotate(angle);
    context.drawImage(img, 15, -width/2 + 10, length, width);
    context.rotate(-angle);
    context.translate(-x1, -y1);
}

var drawBanana = function (x, y, width, height, image) {
    var img = new Image();
    img.src = image;
    
    var halfHeight = height / 2;
    context.save();
    context.translate(x, y + halfHeight);
    context.drawImage(img, 0, -halfHeight, width, height);
    context.restore();
}

var drawRectangle = function (x, y, width, height, color) {
    drawBanana(x, y, width, height, color)
}

var drawRectangleColored = function (x, y, width, height, color) {
    context.beginPath();
    context.moveTo(x, y+(height/2));
    context.lineTo(x+width, y+(height/2));
    context.lineWidth = height;
    context.strokeStyle = color;
    context.stroke();
}

var drawText = function(text, color, font, x, y) {
    context.fillStyle = color
    context.font = font
    context.fillText(text, x, y)
}

var drawPng = function(path, x, y) {
    drawing = new Image()
    drawing.src = path
    context.drawImage(drawing,x,y)
    return drawing
}

function getSin(degree) { return parseFloat( Math.sin(Math.PI * degree / 180).toFixed(3) ) }
function getCos(degree) { return parseFloat( Math.cos(Math.PI * degree / 180).toFixed(3) ) }