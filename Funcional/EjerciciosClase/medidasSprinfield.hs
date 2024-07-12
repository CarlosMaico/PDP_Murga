type Bien = (String,Float)
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float, cantidadDeHijos :: Float, bienes :: [Bien]} deriving Show

homero :: Ciudadano
homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa", 50000), ("deuda", -70000)]
frink :: Ciudadano
frink = UnCiudadano "Profesor" 12000 1 []
krabappel :: Ciudadano
krabappel = UnCiudadano "Profesor" 12000 0 [("casa", 35000)]
burns :: Ciudadano
burns = UnCiudadano "Empresario" 300000 1 [("empresa", 1000000), ("empresa", 500000), ("auto",200000)]

type Ciudad = [Ciudadano]
sprinfield :: Ciudad
sprinfield = [homero, burns, frink, krabappel]

--1
diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio ciudad = (patrimonio . ciudadanoSegun  mayorPatrimonio) ciudad - (patrimonio . ciudadanoSegun  menorPatrimonio) ciudad

patrimonio :: Ciudadano -> Float
patrimonio ciudadano = foldl (\sem (_, valor) -> sem + valor) (sueldo ciudadano) (bienes ciudadano)

ciudadanoSegun :: (Ciudadano->Ciudadano->Ciudadano) -> Ciudad -> Ciudadano
ciudadanoSegun f ciudad = foldl1 f ciudad

mayorPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
mayorPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano > patrimonio otroCiudadano = unCiudadano
                                           | otherwise = otroCiudadano

menorPatrimonio :: Ciudadano -> Ciudadano -> Ciudadano
menorPatrimonio unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                           | otherwise = otroCiudadano

--2
tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama unCiudadano = (any gamaAlta . bienes) unCiudadano

gamaAlta :: Bien -> Bool
gamaAlta ("auto", valor) = valor > 100000
gamaAlta _ = False

--3
type Medida = Ciudadano -> Ciudadano

auh :: Medida               --Aca este modficarSueldo va de Ciudadano -> Ciudadano, (              esto es un valor Float   )
auh unCiudadano = aplicarMedidaSegun (patrimonio unCiudadano < 0) (modificarSueldo ((incremento.cantidadDeHijos) unCiudadano)) unCiudadano

modificarSueldo :: Float -> Ciudadano -> Ciudadano
modificarSueldo valor unCiudadano = unCiudadano {sueldo = sueldo unCiudadano + valor}

aplicarMedidaSegun :: Bool -> (Ciudadano -> Ciudadano) -> Ciudadano -> Ciudadano
aplicarMedidaSegun condicion f ciudadano | condicion = f ciudadano
                                         | otherwise = ciudadano

incremento :: Float -> Float
incremento hijos = hijos * 1000

impuestoGanancias :: Float -> Medida
impuestoGanancias minimoSueldo unCiudadano = aplicarMedidaSegun (sueldo unCiudadano > minimoSueldo) (modificarSueldo (diferencia minimoSueldo (sueldo unCiudadano))) unCiudadano

diferencia :: Float -> Float -> Float
diferencia minimoSueldo sueldo = (minimoSueldo -sueldo) * 0.3

impuestoAltaGama :: Medida --Aca se supone que ya tiene auto alta gama
impuestoAltaGama ciudadano = aplicarMedidaSegun (tieneAutoAltaGama ciudadano) (modificarSueldo ((impuesto.bienes) ciudadano)) ciudadano

impuesto :: [Bien] -> Float
impuesto bienes = ((*(-0.1)).snd.head.filter gamaAlta) bienes


negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion unaProfesion porcentaje ciudadano =  
    aplicarMedidaSegun (((== unaProfesion).profesion)ciudadano)  (modificarSueldo (aumento porcentaje (sueldo ciudadano))) ciudadano

aumento :: Float -> Float -> Float
aumento porcentaje sueldo = (sueldo * porcentaje)/100

data Gobierno = UnGobierno {años :: [Float], medidas :: [Medida]}

gobiernoA :: Gobierno
gobiernoA = UnGobierno [1999..2003] [impuestoGanancias 30000, negociarSueldoProfesion "Profesor" 10, negociarSueldoProfesion "Empresario" 40, impuestoAltaGama, auh ]

gobiernoB :: Gobierno
gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40000, negociarSueldoProfesion "Profesor" 30 , negociarSueldoProfesion "Camionero" 40]

gobernarUnAño :: Gobierno -> Ciudad -> Ciudad
gobernarUnAño gobierno ciudad = map (aplicarMedidas gobierno)  ciudad

aplicarMedidas :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedidas gobierno ciudadano = foldl  (flip ($))  ciudadano (medidas gobierno)  -- tengo que aplicar la medida al ciudadano por eso el flip

gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto gobierno ciudad = 
    foldl (\unaCiudad _ -> gobernarUnAño gobierno unaCiudad)  ciudad (años gobierno) -- tiene que gobernarunAño tantos años tenga
 
distribuyoRiqueza :: Gobierno -> Ciudad -> Bool
distribuyoRiqueza gobierno ciudad =  diferenciaDePatrimonio ciudad > (diferenciaDePatrimonio.gobernarPeriodoCompleto gobierno) ciudad



kane :: Ciudadano
kane = UnCiudadano "Empresario" 100000 0 infinitosTrineos

infinitosTrineos :: [(String, Float)]
infinitosTrineos = [("Rosebud", valor)| valor <- [5,10..]]

--5
--b i.  No temrina por lo bienes ya que son infintos y en impuestosAltaGama usa bienees y se va a quedar buscando si hay algun autoAltaGama, y por el auh tambien
--  ii. Termina deejecutar pero no logra imprimrlo por que los biens son infinitos

