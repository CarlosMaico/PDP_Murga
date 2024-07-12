

data Animal = Raton {nombre :: String ,edad :: Double , peso :: Double, enfermedades :: [String]} deriving Show

cerebro :: Animal
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampion", "tuberculosis"]


enfermedadesInfecciosas :: [String]
enfermedadesInfecciosas = ["brucelosis", "tuberculosis"]

modificarEdad :: (Double -> Double) -> Animal -> Animal
modificarEdad f unAnimal = unAnimal { edad =  (f.edad) unAnimal}

modificarNombre :: (String -> String) -> Animal -> Animal
modificarNombre f unAnimal = unAnimal {nombre = (f.nombre) unAnimal} 

modificarPeso  :: (Double -> Double) -> Animal -> Animal
modificarPeso f unAnimal = unAnimal {peso = (f.peso) unAnimal}

modificarEnfermedades  :: ([String] -> [String]) -> Animal -> Animal
modificarEnfermedades f unAnimal = unAnimal {enfermedades = (f.enfermedades) unAnimal}

hierbaBuena :: Animal -> Animal
hierbaBuena animal = modificarEdad sqrt animal

hierbaVerde :: String -> Animal -> Animal
hierbaVerde unaEnfermedad unAnimal = modificarEnfermedades (filter (/= unaEnfermedad)) unAnimal

alcachofa :: Animal -> Animal
alcachofa unAnimal = modificarPeso nuevoPeso  unAnimal


nuevoPeso :: Double -> Double
nuevoPeso peso | peso > 2 = peso * 0.9
               | otherwise = peso * 0.95

hierbaMagica :: Animal -> Animal
hierbaMagica raton = modificarEnfermedades(const []).modificarEdad (*0) $ raton


medicamento :: [(Animal -> Animal)] -> Animal -> Animal
medicamento hierbas raton = foldl (flip ($))  raton  hierbas

medicamento' :: [(Animal -> Animal)] -> Animal -> Animal
medicamento' hierbas raton = foldl (\unRaton unaHierba -> unaHierba unRaton) raton hierbas

antiAge :: Animal -> Animal
antiAge unRaton = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) unRaton