
f :: Integer -> String
f 1 = "recibi 1"
f 0 = "recibi 0"

conjuncion :: Bool -> Bool -> Bool
conjuncion True True = True
conjuncion True False = False
conjuncion False True = False
conjuncion False False = False

varAnonima :: Int -> String
varAnonima 0 = "recibi 0"
varAnonima _ = "recibi otra cosa"

