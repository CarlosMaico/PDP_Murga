data Animal = Raton {
    nombre :: String,
    edad :: Double,
    peso :: Double,
    enfermedades :: [String]
} deriving Show

cerebro :: Animal
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampion", "tuberculosis"]

enfermedadesInfecciosas :: [String]
enfermedadesInfecciosas = ["brucelosis, tuberculosis"]

--1

modificarNombre :: (String -> String) -> Animal -> Animal
modificarNombre f animal = animal { nombre = (f.nombre) animal}

modificarEdad :: (Double-> Double) -> Animal -> Animal
modificarEdad f animal = animal {edad = (f.edad) animal}

modificarPeso :: (Double -> Double) -> Animal -> Animal
modificarPeso f animal = animal{ peso = (f.peso)animal}

modificarEnfermedades :: ([String]->[String]) -> Animal -> Animal
modificarEnfermedades f animal = animal{enfermedades = (f.enfermedades) animal}

--2
type Hierba = Animal -> Animal

hierbaBuena :: Hierba
hierbaBuena = modificarEdad sqrt

hierbaVerde :: String -> Hierba
hierbaVerde enfermedadAQuitar = modificarEnfermedades (filter (/= enfermedadAQuitar))   -- me da una lista con lo que no tienen a esa enfermada

alcachofa :: Hierba
alcachofa = modificarPeso nuevoPeso

nuevoPeso :: Double -> Double
nuevoPeso peso | peso > 2 = peso * 0.9        
               | otherwise = peso * 0.95

hierbaMagica :: Hierba
hierbaMagica = modificarEnfermedades (const []) . modificarEdad (*0) -- const []  hace que la lista de enfermedades quede vacia

--3
medicamento :: [Hierba] -> Animal -> Animal
medicamento hierbas animal = foldr ($) animal hierbas

antiAge :: Animal -> Animal
antiAge = medicamento (replicate 3 hierbaBuena++[alcachofa]) 
 
reduceFatFast :: Int -> Animal -> Animal
reduceFatFast nro = medicamento (replicate nro alcachofa ++ [hierbaVerde "obesidad"])

hierbaMilagrosa :: Animal -> Animal
hierbaMilagrosa = medicamento (map hierbaVerde enfermedadesInfecciosas) 

--4
cantidadIdeal :: (Int -> Bool) -> Int
cantidadIdeal condicion = (head . filter condicion)  [1..] -- Da el valor que primero cumple con la condicion

estanMejoresQueNunca :: [Animal] -> (Animal -> Animal) -> Bool
estanMejoresQueNunca animales unMedicamento = all ((<1). peso . unMedicamento) animales

potenciaIdeal :: [Animal] -> Int
potenciaIdeal animales = cantidadIdeal (estanMejoresQueNunca animales . reduceFatFast) 