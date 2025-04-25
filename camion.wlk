import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.reaccionAlSerCargado()
	}

	method puedeViajar() {
		return self.totalBultos() + almacen.totalBultos() <= almacen.cantBultosSoportados
	}
     
	method descargar(unaCosa) {
          almacen.deposito.add(unaCosa)
		  cosas.remove(unaCosa)
	}

	method descargarTodo() {
		cosas.each({unaCosa => self.descargar(unaCosa)})
	}

	method hayAlgunoQuePesa(peso) {
		return cosas.any({cosa => cosa.peso() == peso})
	}

	method todoPesoPar() {
          cosas.all({cosa => cosa.peso() % 2 == 0})
	}

	method cargaDeCamion() {
		return cosas.sum({cosa => cosa.peso()})
	}

	method elDeNivel(nivel) {
		return cosas.itemConMismoNivel(nivel)
	}

	method itemConMismoNivel(nivel) {
		return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	
    method pesoTotal() {
	    return  self.cargaDeCamion() + tara
	}

	method excedidoDePeso() {
		return self.pesoTotal() >= 2500
	} 

	method objetosQueSuperanPeligrosidad(nivel) {
	      cosas.filter({ unaCosa => unaCosa.nivelPeligrosidad() > nivel })
	}

    method objetosMasPeligrososQue(cosa) {
		cosas.filter({ unaCosa => unaCosa.nivelPeligrosidad() > cosa.nivelPeligrosidad()})
	}

    method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		 return !self.excedidoDePeso() && self.totalPeligrosidad() < nivelMaximoPeligrosidad
	}

	method totalPeligrosidad() {
		return cosas.sum({cosa => cosa.nivelPeligrosidad()})
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({cosa => (cosa.peso() > min) && (cosa.peso() < max)})
	}

	method cosaMasPesada() {
		return cosas.max({cosa => cosa.peso()})
	}

	method pesos() {
		return cosas.map({cosa => cosa.peso()})
	}

	method totalBultos() {
        return cosas.sum({unaCosa => unaCosa.bultos()})
	}

	method transportar(destino, camino) {
		if (camino.puedeUsarCamino()) {
            self.descargarTodo()
		}
	}
 }

 object almacen {
	const deposito = #{}
	var property cantBultosSoportados = 3

	method totalBultos() {
		return deposito.sum({unaCosa => unaCosa.bultos()})
	}

 }

 object ruta9 {
       const nivelPeligroSoportado = 11

	   method puedeUsarCamino() {
		return camion.puedeViajar() && camion.puedeCircularEnRuta(nivelPeligroSoportado)
	   }
 }

 object caminosVecinales {
	var property pesoMaxSoportado = 50

    method puedeUsarCamino() {
		return camion.puedeViajar() && camion.pesoTotal() < pesoMaxSoportado
	   }
 }