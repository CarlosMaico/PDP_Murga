data Pais = Pais {
    ingresoPerCapita :: Float,
    activosPublico :: Float,
    activosPrivado :: Float,
    recursosNaturales :: [Recurso],
    deuda :: Float
} deriving Show

type Recurso = String

--1
namibia :: Pais
namibia = Pais 4140 400000 650000 ["Mineria", "EcoTurismo"] 50

--2
type Estrategia = Pais -> Pais


prestarPlata :: Float -> Estrategia
prestarPlata cuanto pais = pais{deuda = deuda pais + cobrarInteres cuanto}

cobrarInteres :: Float -> Float
cobrarInteres cuanto = cuanto * 1.5

reducirPuestos :: Float -> Estrategia
reducirPuestos cantPuestos pais = pais {activosPublico = activosPublico pais - cantPuestos,
                                        ingresoPerCapita = ingresoPerCapita pais * reduccionIngreso cantPuestos
                                       }

reduccionIngreso :: Float -> Float
reduccionIngreso cantPuestos | cantPuestos > 100 = 0.8
                             | otherwise = 0.85

explotar :: Recurso -> Estrategia
explotar recurso pais = pais {deuda = deuda pais - 20,
                              recursosNaturales = quitarRecurso recurso (recursosNaturales pais)}

quitarRecurso :: Recurso -> [Recurso] -> [Recurso]
quitarRecurso recurso = filter (/=recurso)

blindaje :: Estrategia
blindaje pais = (prestarPlata (pbi pais *0.5). reducirPuestos 500) pais

pbi :: Pais -> Float
pbi pais = ingresoPerCapita pais * poblacionActiva pais

poblacionActiva :: Pais -> Float
poblacionActiva pais = activosPrivado pais +activosPublico pais

--3
type Receta = [Estrategia]

receta :: Receta
receta = [prestarPlata 2000, explotar "Mineria"]

aplicarReceta :: Receta -> Pais -> Pais
aplicarReceta recetas pais = foldr ($) pais recetas

--4
puedenZafar :: [Pais] -> [Pais]
puedenZafar = filter poseePetroleo  --aca usamos orden superio por filter y en posee petroleo usamos composicion y aplicacoin parcial

poseePetroleo :: Pais -> Bool
poseePetroleo = elem "Petroleo"  . recursosNaturales

deudaTotal :: [Pais] -> Float
deudaTotal = foldr ((+).deuda) 0 --aca usamos orden superior y dentor de la condicon composicion

--5

estaOrdenadalaReceta :: Pais -> [Receta] -> Bool
estaOrdenadalaReceta pais [receta] = True
estaOrdenadalaReceta pais (receta1 : receta2 : recetas) =
    revisarPbi receta1 pais <= revisarPbi receta2 pais && estaOrdenadalaReceta pais (receta2 : recetas)


revisarPbi :: Receta -> Pais -> Float
revisarPbi recetap = pbi . aplicarReceta recetap -- pongo recetap por que hay una funcion receta

--6

recursosNaturalesInfinitos :: [String]
recursosNaturalesInfinitos = "Energia" : recursosNaturalesInfinitos

argentina :: Pais
argentina = Pais 100 200 300 recursosNaturalesInfinitos 200

--a  No termina ya que el filter intenta ver en essos recursos naturales infinito si hay alguno de petroleo y al tener eso infinto simepre va intentar buscarlo
--b aca si logra ejecutar debido a la evaluacion diferida ya que haskell evalua lo que necesita en el momento que lo necesita es deir como en esa funcion de totalDeuda no se requiere a los recursos naturales que es infinito si termina
