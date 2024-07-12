esCero :: Int -> Bool
esCero 0 = True
esCero _ = False

cuadradoDelAnterior :: Int -> Int
cuadradoDelAnterior x  = (x-1)*(x-1)

longitudDeUnaListaDeNums :: [Int] -> Int
longitudDeUnaListaDeNums [] = 0
longitudDeUnaListaDeNums (x:xs) = 1 + longitudDeUnaListaDeNums xs


comunes :: String -> String -> String -- letras comunes entre dos strings
comunes (x:xs) ys | esta x ys = x : comunes xs (sacaRepe x ys)
                  | otherwise = comunes xs ys

sacaRepe :: Char -> String -> String
sacaRepe _ [] = []
sacaRepe x (y:ys) | x == y = sacaRepe x ys
                  | otherwise = y : sacaRepe x ys

esta :: Char -> String -> Bool
esta _ [] = False
esta x (y:ys) | x /= y = esta x ys
              | otherwise = True


intervalo :: [Int] -> Int -> Int -> [Int]  -- Me da un rango de numeros de una lista pasandole el numero de la lista nical hasta el final
intervalo [] _ _ = []
intervalo (x:xs) 1 1 = [x]
intervalo (x:xs) 1 n = x : intervalo xs 1 (n-1)
intervalo (x:xs) m n = intervalo xs (m-1) (n-1)
