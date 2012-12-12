module Main (main) where

import Control.Monad
import Control.Monad.Trans.Reader

import Haste (writeLog)

import Html5.Image
import Html5.Canvas.Ctx2D

main = do
  loadImage "http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Drag_%282563573605%29.jpg/320px-Drag_%282563573605%29.jpg" withImg

withImg img = do
  ctx <- getCtx =<< createCanvas 480 320 
  writeLog "Hello"
  draw img ctx

draw img = runReaderT $ do
  beginPath
  setFillStyleC "#aabb33"
  rect $ Rect 5 5 50 40
  save
  setFillStyleC "#ff0000"
  restore
  fill
  closePath
  --
  translate 240 160
  mapM_ (gyik img) [i / 10.0 | i <- [1..10]]

gyik :: Image -> Double -> ReaderT Ctx2D IO ()
gyik img rot = do
  save
  alpha $ rot
  rotate rot
  let dx = - (imageW img `div` 2)
  let dy = - (imageH img `div` 2)
  translate dx dy
  drawImage 0 0 img
  restore
