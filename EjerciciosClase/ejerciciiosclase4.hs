

find':: (a -> Bool) -> [a] -> a
find' condicion lista = (head.filter condicion) lista

data Politico = Politico {
    proyectosPresentados :: [String],
    sueldo :: Integer,
    edad :: Integer
} deriving Show


politicos :: [Politico]
politicos = [Politico ["ser libres", "libre estacionamieento coches politicos","ley no fumar", "ley 19182"] 20000 81,
             Politico ["tratar de reconquistar luchas sociales"] 10000 63,
             Politico ["tolerancia 100 para delitos"] 15500 49]

type Nombre = String
type Notas = [Int]
data Alumno = Alumno {nombreAlumno :: Nombre, notas :: Notas} deriving Show

promedioAlumnos :: [Alumno] -> [(Nombre, Int)]
promedioAlumnos alumnos = map (\alumno -> (nombreAlumno alumno, (promedioq.notas) alumno)) alumnos

promedioq :: Notas -> Int
promedioq notas = (sum notas) `div` (length notas )

promedioSinAplazos :: [Notas] -> [Int]
promedioSinAplazos notas = map promedioq (map (filter (>=6)) notas)

--otraforma que se ve mas clara
promedioSinAplazos' :: [[Int]] -> [Int]
promedioSinAplazos' notas = map (promedioq . filter (>= 6)) notas

aprobo :: Alumno -> Bool
aprobo alumno = all (>=6) (notas alumno)

aprobaron :: [Alumno] -> [Nombre]
aprobaron alumnos = (map nombreAlumno . filter aprobo) alumnos

productos :: [String] -> [Int] -> [(String, Int)]
productos nombres precios = zip nombres precios

productos' :: [String] -> [Int] -> [(String, Int)]
productos' nombres precios = zipWith(\nom precio -> (nom, precio)) nombres precios 

