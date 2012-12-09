function jsNewImage(_) {
  return [1, 0, new Image()]
}

function jsLoadImage(src, cb, _) {
    var image = new Image()
    image.onload = function() {
	A(cb, [[1, image], 0])
    }
    image.src = src
    return [1, 0]
}