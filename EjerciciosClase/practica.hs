esPar :: Integer -> Bool
esPar = even

cuadruple :: Integer -> Integer
cuadruple numero = 4 * numero

siguiente :: Integer -> Integer
siguiente numero = numero + 1

siguienteEsPar :: Integer -> Bool
siguienteEsPar numero = (even. siguiente) numero

type Persona = (String, Integer)

clara :: Persona
clara = ("Clara", 30)

edad :: Persona -> Integer
edad (_, _edad) = _edad


mayorDeEdad :: Integer -> Bool
mayorDeEdad anios =  anios >= 18

personaMayor :: Persona -> Bool
personaMayor persona = (mayorDeEdad.edad) persona


-- acoplamiento de funciones, acoplameinto alto es un requerimeinto extra y que me tenga que cambiar todo el codigo, el acoplamiento bajo es cuando no necesito cambiar mucho de mi codigo