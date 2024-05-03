suma :: Int -> Int -> Int
suma num1 num2 = num1 +num2

color :: String -> String
color "limon" = "gris"
color _ = "gris"


--Guardas
signo :: Int -> Char
signo nro | nro >0 = '+'
          | nro < 0 = '-'
          |otherwise = '0'



nombreCompleto :: [Char] -> [Char] -> [Char]
nombreCompleto nombre apellido = apellido ++ ", " ++  nombre

data Figura = Triangulo {base :: Double, altura :: Double} |
              Rectangulo {base :: Double, altura:: Double} |
              Circulo {radio:: Double}

circulo :: Figura
circulo = Circulo 8

triangulo :: Figura
triangulo = Triangulo 2 2

rectangulo :: Figura
rectangulo = Rectangulo 4 4

area :: Figura -> Double
area (Triangulo base altura) = (base*altura)/2
area (Rectangulo base altura) = base*altura
area (Circulo radio) = pi * radio^2


type Dia = String
type Hora = Int

horaCierre :: Dia -> Bool -> Hora
horaCierre "domingo" True = 13
horaCierre "sabado" False = 21
horaCierre _ True = 20
horaCierre dia False = 12 + length dia
