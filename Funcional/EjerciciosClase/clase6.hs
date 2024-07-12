
--1
--Cuenta elementos de una lista
cantidadDeElementos :: [(Int, Int)] -> Int
cantidadDeElementos listaDeTuplas = foldl (\semilla _ -> semilla + 1) 0 listaDeTuplas -- vemos que foldl la funcion es recibe 2 argumentos el primero tipo semilla y el segundo un elemento de la lista

cantidadDeElementos' :: [(Int, Int)] -> Int
cantidadDeElementos' listaDeTuplas = foldr (\_ semilla -> semilla + 1) 0 listaDeTuplas


--2
empleadoMasGastador :: [(String, Int)] -> (String, Int)
empleadoMasGastador (cab: cola) = foldl mayorGasto cab cola  -- cab seria la primera tupla y cola seria la lista con las otras tuplas

empleadoMasGastador' :: [(String, Int)] -> (String, Int)
empleadoMasGastador' (cab: cola) = foldr mayorGasto cab cola

mayorGasto :: (String, Int) -> (String, Int) -> (String,Int)
mayorGasto emple otroEmple | snd emple > snd otroEmple = emple
                           | otherwise =  otroEmple
--3
gastoTotal :: [(String, Int)] -> Int
gastoTotal listaEmple = foldl (\sem (_,gasto) -> sem + gasto) 0 listaEmple

gastoTotal' :: [(String, Int)] -> Int
gastoTotal' listaEmple = foldr (\(_,gasto) sem -> sem + gasto) 0 listaEmple

--4
-- foldl (\acc f -> f acc) 2 [(3+), (*2), (5+)]  acc es semilla 

-- foldl (\f acc -> f acc) 2 [(3+), (*2)

--5
type Nombre = String
type InversinInicial = Int
type Profesionales = [String]


data Proyecto = Proy {nombre :: Nombre,
                      inversionInicial :: InversinInicial,
                      profesionales :: Profesionales} deriving Show

proyectos :: [Proyecto]
proyectos = [Proy "red social de arte" 20000 ["ing. en sistemas", "contador"],
             Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"],
             Proy "ventaChurros" 1000 ["cocinero"]]


maximoProyecto :: (Proyecto -> Int) -> [Proyecto] -> Proyecto
maximoProyecto function (proyecto:proyectos) = foldl (maximoSegun function) proyecto proyectos

maximoProyecto' :: (Proyecto -> Int) -> [Proyecto] -> Proyecto
maximoProyecto' function (proyecto:proyectos) = foldr (maximoSegun function) proyecto proyectos

maximoSegun :: (Proyecto-> Int) -> Proyecto -> Proyecto -> Proyecto
maximoSegun function unProyecto otroProyecto | function unProyecto > function otroProyecto = unProyecto
                                             | otherwise = otroProyecto
             
maximoProyectoSegun'' :: (Proyecto -> Int) -> [Proyecto] -> Proyecto
maximoProyectoSegun'' f proyectos =  foldl1 (maximoSegun f) proyectos




