object pepita {
  var energia = 100

  method energia() = energia  //getter

  method energia(unaEnergia) {
    energia = unaEnergia
  }

  method volar() {
    energia = energia - 10
  }

  method comer(cantdad) {
    energia = energia + cantdad*2
  }
}
