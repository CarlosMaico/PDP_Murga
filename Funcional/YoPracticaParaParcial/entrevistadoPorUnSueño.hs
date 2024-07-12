data Postulante = UnPostulante {nombre :: Nombre,edad :: Double,remuneracion :: Double,conocimientos :: [String]} |Estudiante {legajo :: String,conocimientos :: [String]
} deriving Show

pepe :: Postulante
pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Wollok","C"]

tito :: Postulante
tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

maico :: Postulante
maico = Estudiante "2038900" ["Dota2", "LOL, Valorant", "Discreta"]

type Nombre = String

data Puesto = UnPuesto {
    puesto :: String,
    conocimientosRequeridos :: [String]
} deriving Show

jefe :: Puesto
jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Wollok"]

chePibe :: Puesto
chePibe = UnPuesto "cadete" ["ir al banco"]

apellidoDueno :: Nombre
apellidoDueno = "Gonzalez"

--1
type Requisito = Postulante -> Bool

tieneConocimientos :: Puesto -> Requisito
tieneConocimientos puesto postulante = (all (\conocimiento -> conocimiento `elem` conocimientos postulante). conocimientosRequeridos ) puesto

edadAceptable :: Double -> Double -> Requisito
edadAceptable edadMin edadMax postulante = edad postulante `elem` [edadMin .. edadMax]

sinArreglo :: Requisito
sinArreglo = (/= apellidoDueno) . last . words . nombre

--2

preseleccion :: [Postulante] -> [Requisito] -> [Postulante]
preseleccion postulantes requisitos = filter (cumplenTodos requisitos) postulantes

cumplenTodos :: [Requisito]-> Postulante -> Bool
cumplenTodos requisitos postualnte = all ($ postualnte) requisitos -- aplica un postualnte a requisito que es una funcion

--ghci> preseleccion [pepe, tito] [tieneConocimientos jefe, edadAceptable 30 40, sinArreglo ]
--[UnPostulante {nombre = "Jose Perez", edad = 35.0, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C"]}]

--ghci> preseleccion [pepe, tito] [tieneConocimientos jefe, edadAceptable 30 40, sinArreglo,(not .elem "repetir logica". conocimientos)]
--[UnPostulante {nombre = "Jose Perez", edad = 35.0, remuneracion = 15000.0, conocimientos = ["Haskell","Prolog","Wollok","C"]}]

--3

incrementarEdad :: Postulante -> Postulante
incrementarEdad postulante = postulante {edad = edad postulante + 1}

aumentarSueldo :: Double -> Postulante -> Postulante
aumentarSueldo porcentaje postulante = postulante { remuneracion = remuneracion postulante + remuneracion postulante * (porcentaje/100)}

actualizarPostulantes :: [Postulante] -> [Postulante]
actualizarPostulantes postulantes =  [(aumentarSueldo 27. incrementarEdad)postulante | postulante <- postulantes]

actualizarPostulantes' :: [Postulante]-> [Postulante]
actualizarPostulantes'  = map (aumentarSueldo 27 .incrementarEdad)

--prefiero el map ya que es mas delcarativo y expresivo delgeo mas tareas al momtor
--si la lista de postulantes es infinita como map requiere que pase uno por uno en cada postulante para transformarlo esta se va a ir a un bucle

--4
capacitar :: Postulante -> String -> Postulante 
capacitar (UnPostulante nombre edad remuneracion conocimientos) conocimiento  = UnPostulante nombre edad remuneracion (agregarConocimiento conocimiento conocimientos)
capacitar (Estudiante legajo conocimientos) conocimiento = Estudiante legajo (agregarConocimiento conocimiento (init conocimientos))

agregarConocimiento :: String -> [String] -> [String]
agregarConocimiento conocimiento conocimientos = conocimiento:conocimientos

capacitacion :: Puesto -> Postulante -> Postulante
capacitacion puesto postulante = foldl capacitar postulante (conocimientosRequeridos puesto) 
