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
  rect 5 5 50 40
  fill
  closePath
  drawImage 10 10 img
