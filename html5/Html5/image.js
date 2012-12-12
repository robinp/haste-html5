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

// pure
function jsImageWidth(img, _) {
  return [1, 0, img.width]
}

// pure
function jsImageHeight(img, _) {
  return [1, 0, img.height]
}
