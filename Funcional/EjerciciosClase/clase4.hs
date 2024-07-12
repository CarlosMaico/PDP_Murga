--1
find':: (a -> Bool) -> [a] -> a
find' condicion = head.filter condicion
--1.1
data Politico = Politico {
    proyectosPresentados :: [String],
    sueldo :: Integer,
    edad :: Int
} deriving Show


politicos :: [Politico]
politicos = [Politico ["ser libres", "libre estacionamieento coches politicos","ley no fumar", "ley 19182"] 20000 81,
             Politico ["tratar de reconquistar luchas sociales"] 10000 63,
             Politico ["tolerancia 100 para delitos"] 15500 49]

--a find' ((<50).edad) politicos
--b  find' ((>3). length . proyectosPresentados) politicos
--c ghci> find' (any ((>3). length . words). proyectosPresentados ) politicos

--2
type Nombre = String
type Notas = [Int]
data Alumno = Alumno {nombreAlumno :: Nombre, notas :: Notas} deriving Show

promedioAlumnos :: [Alumno] -> [(Nombre, Int)]
promedioAlumnos = map (\alumno -> (nombreAlumno alumno, (promedioq.notas) alumno)) 

promedioq :: Notas -> Int
promedioq notas = sum notas `div` length notas 

--3
--otraforma que se ve mas clara
promedioSinAplazos :: [Notas] -> [Int]
promedioSinAplazos = map (promedioq . filter (>= 6))

--4
aprobo :: Alumno -> Bool
aprobo alumno = all (>=6) (notas alumno)

--5
aprobaron :: [Alumno] -> [Nombre]
aprobaron  = map nombreAlumno . filter aprobo

--6
productos :: [String] -> [Int] -> [(String, Int)]
productos = zip 

productos' :: [String] -> [Int] -> [(String, Int)]
productos'  = zipWith(\nom precio -> (nom, precio)) 

