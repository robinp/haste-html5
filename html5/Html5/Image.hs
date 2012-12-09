{-# LANGUAGE ForeignFunctionInterface #-}

-- | Module for manipulating Html5 images
module Html5.Image
  ( Image
  , unImage

  -- * Creating and loading images
  , newImage
  , loadImage
) where

import Haste.Prim (JSAny, JSString, Ptr, toJSStr, toPtr)

-- | Newtype for an Image object (wraps JSAny). 
newtype Image = Image JSAny
unImage (Image x) = x

foreign import ccall jsNewImage :: IO Image
foreign import ccall jsLoadImage :: JSString -> Ptr (Image -> IO ()) -> IO ()

-- | Constructs a new Image object.
newImage :: IO Image
newImage = jsNewImage

-- | Loads an Image from the given URL.
loadImage :: String -> (Image -> IO ()) -> IO ()
loadImage src cb = jsLoadImage (toJSStr src) (toPtr cb)
