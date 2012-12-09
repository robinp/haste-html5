{-# LANGUAGE ForeignFunctionInterface #-}

module Html5.Canvas.Ctx2D 
  ( Ctx2D
  , createCanvas
  , getCtx

  , beginPath
  , closePath
  , clearCtx
  
  , setFillStyleC
  , fill
  , stroke
  , rect
  
  , drawImage
  , drawSubImage
)  where

import Control.Monad.Trans.Reader

import Haste.Prim (JSAny, JSString, toJSStr)
import Haste.DOM (Elem(..))

import Html5.Image (Image, unImage)

-- TODO newtype
type Ctx2D    = JSAny
type JSCanvas = JSAny

foreign import ccall jsCreateCanvas :: Int -> Int -> IO JSCanvas
foreign import ccall jsGetCtx2D   :: JSCanvas -> IO Ctx2D
foreign import ccall jsClearCtx   :: Int -> Int -> Ctx2D -> IO ()
foreign import ccall jsBeginPath  :: Ctx2D -> IO ()
foreign import ccall jsClosePath  :: Ctx2D -> IO ()
foreign import ccall jsFill       :: Ctx2D -> IO ()
foreign import ccall jsStroke     :: Ctx2D -> IO ()
foreign import ccall jsRect       :: Int -> Int -> Int -> Int -> Ctx2D -> IO ()
foreign import ccall jsSetFillStyleC :: JSString -> Ctx2D -> IO ()
foreign import ccall jsDrawImage  :: Int -> Int -> JSAny -> Ctx2D -> IO ()
foreign import ccall jsDrawSubImage  :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> JSAny -> Ctx2D -> IO ()

-- TODO rects

createCanvas :: Int -> Int -> IO Elem
createCanvas w h = fmap Elem $ jsCreateCanvas w h

getCtx :: Elem -> IO Ctx2D
getCtx (Elem e) = jsGetCtx2D e

beginPath :: ReaderT Ctx2D IO ()
beginPath = ReaderT jsBeginPath

closePath :: ReaderT Ctx2D IO ()
closePath = ReaderT jsClosePath

fill = ReaderT jsFill
stroke = ReaderT jsStroke

rect :: Int -> Int -> Int -> Int -> ReaderT Ctx2D IO ()
rect a b c d = ReaderT $ jsRect a b c d

clearCtx w h = ReaderT $ jsClearCtx w h

setFillStyleC :: String -> ReaderT Ctx2D IO ()
setFillStyleC col = ReaderT $ jsSetFillStyleC (toJSStr col)

drawImage :: Int -> Int -> Image -> ReaderT Ctx2D IO ()
drawImage x y img = ReaderT $ jsDrawImage x y (unImage img)

drawSubImage :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Image -> ReaderT Ctx2D IO ()
drawSubImage sx sy sw sh tx ty tw th img = ReaderT $ jsDrawSubImage sx sy sw sh tx ty tw th  (unImage img)
