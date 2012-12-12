{-# LANGUAGE ForeignFunctionInterface #-}

module Html5.Canvas.Ctx2D 
  ( Ctx2D
  , createCanvas
  , getCtx
  , save, restore

  , beginPath, closePath
  , clearCtx
 
  , translate
  , rotate
  , scale
 
  , Rect(..)
  , setFillStyleC
  , alpha
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

-- TODO to Double or not to Double, that is the question

-- TODO consistent JS fun names (to avoid coillision)
-- TODO sensible function / export order

foreign import ccall jsGlobalAlphaCtx :: Double -> Ctx2D -> IO ()
foreign import ccall jsScale      :: Double -> Double -> Ctx2D -> IO ()
foreign import ccall jsRotate     :: Double -> Ctx2D -> IO ()
foreign import ccall jsTranslate  :: Int -> Int -> Ctx2D -> IO ()
foreign import ccall jsSaveState    :: Ctx2D -> IO ()
foreign import ccall jsRestoreState :: Ctx2D -> IO ()
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

data Rect = Rect {
  _rectX :: Int,
  _rectY :: Int,
  _rectW :: Int,
  _rectH :: Int
}

--save :: ReaderT Ctx2D IO ()
save = ReaderT $ jsSaveState

--restore :: ReaderT Ctx2D IO ()
restore = ReaderT $ jsRestoreState

alpha :: Double -> ReaderT Ctx2D IO ()
alpha a = ReaderT $ jsGlobalAlphaCtx a

scale :: Double -> Double -> ReaderT Ctx2D IO ()
scale sx sy = ReaderT $ jsScale sx sy

rotate :: Double -> ReaderT Ctx2D IO ()
rotate rad = ReaderT $ jsRotate rad

translate :: Int -> Int -> ReaderT Ctx2D IO ()
translate x y = ReaderT $ jsTranslate x y

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

rect :: Rect -> ReaderT Ctx2D IO ()
rect (Rect x y w h) = ReaderT $ jsRect x y w h

clearCtx w h = ReaderT $ jsClearCtx w h

setFillStyleC :: String -> ReaderT Ctx2D IO ()
setFillStyleC col = ReaderT $ jsSetFillStyleC (toJSStr col)

drawImage :: Int -> Int -> Image -> ReaderT Ctx2D IO ()
drawImage x y img = ReaderT $ jsDrawImage x y (unImage img)

drawSubImage :: Rect -> Rect -> Image -> ReaderT Ctx2D IO ()
drawSubImage (Rect sx sy sw sh) (Rect tx ty tw th) img = ReaderT $ jsDrawSubImage sx sy sw sh tx ty tw th  (unImage img)
