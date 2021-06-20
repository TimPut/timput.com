{-# LANGUAGE AllowAmbiguousTypes       #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TypeFamilies              #-}

import           Diagrams.Backend.SVG.CmdLine
import           Diagrams.Prelude

hilbert 0 = mempty
hilbert n = hilbert' (n-1) # reflectY <> vrule 1
         <> hilbert  (n-1) <> hrule 1
         <> hilbert  (n-1) <> vrule (-1)
         <> hilbert' (n-1) # reflectX
  where
    hilbert' m = hilbert m # rotateBy (1/4)

diagram :: Diagram B
diagram = strokeT (hilbert 2) # lc silver
                              # opacity 1

belt = (snug (- unitY) ((circle 4)
       <> dashed (rotate beta (vrule 8))
       <> (P (r2 (0,0)) ~~ P (r2 (0,-4))))
       ||| strutX 2
       ||| snug (- unitY) ((circle 1)
                           <> dashed (rotate beta (vrule 2))
       <> (P (r2 (0,0)) ~~ P (r2 (0,-1)))))
       <> dashed (translate (unitY) (P (r2 (0,0)) ~~ P (r2 (7,0))))
       <> snug (- unitY) (fromSegments [ straight (r2 (7,0)) ])
       <> (P (r2 (0,4)) ~~ P (r2 (7,1)))

  where
    text' s t = text t # fontSize (local s) <> strutY (s * 3.3)
    cc' = 7 -- projected cc
    rad1 = 4
    rad2 = 1
    beta = negate (atan ((rad1-rad2) / cc')) @@ rad
    dashed  = dashingN [0.01,0.01] 0
diagram' :: Diagram B
diagram' = frame 0.5 $ (belt) # lc black # lw 2



main :: IO ()
main = mainWith diagram'
