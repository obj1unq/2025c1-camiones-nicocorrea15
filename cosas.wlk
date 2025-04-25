object knightRider {
	
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultos() = 1 
	method reaccionAlSerCargado() { }
}

object bumblebee {
	
	var estado = modoAuto
	
	method cambiarModo(modo) {
		estado = modo
	}

	method peso() {return 800}
    
	method nivelPeligrosidad() {
	 return estado.peligrosidad()
    }   

	method bultos() = 2

	method reaccionAlSerCargado() {
		self.cambiarModo(modoRobot)
	}
}

object modoAuto {

	method peligrosidad() {return 15}
}

object modoRobot {
  
  method peligrosidad() {return 30}
}

object paqueteDeLadrillos {
     
	 var property cantLadrillos = 0
	 
	 method peso() {
	  return cantLadrillos * 2
	}

	method bultos() {
        if (cantLadrillos <= 100) 
            1
        else if (cantLadrillos <= 300)
            2
        else 
            3
    }
	
	method nivelPeligrosidad() { return 2 }

	method reaccionAlSerCargado() {
	 cantLadrillos += 12	
	}
}


object arenaAGranel {
	var property peso = 0

	method nivelPeligrosidad() { return 1}
	method bultos() = 1

	method reaccionarAlSerCargado() {
    peso = peso + 20
}

}

object bateriaAntiaerea {
      
	  var estado = sinMisiles
      const peso = 200 
	  
	  method cambiarModo(modo) {
		estado = modo
	  }

	  method pesoTotal() {
		 return peso + estado.peso()
	  }

	  method bultos() { 
		return 
		   if (estado == sinMisiles) 
		            1 
		       else 2
	  }

	  method reaccionarAlSerCargado() {
           self.cambiarModo(conMisiles)
      }
}

object sinMisiles {
       method nivelPeligrosidad() {return 0}
	   method peso() { return 0}
}
object conMisiles {
	   method nivelPeligrosidad() {return 100}
	   method peso() {return 100}
}

object contenedorPortuario {
	 const objetos = #{}
	 const peso = 100

	 method pesoTotal() { 
		 return peso + self.pesoDeObjetos()
	 }

	 method pesoDeObjetos() {
		return objetos.sum({ objeto => objeto.peso()})
	 }

	 method nivelPeligrosidad() {
		if (objetos.isEmpty()) 
			0
		else self.nivelDelObjetoMasPeligroso()
	 }

	 method nivelDelObjetoMasPeligroso() {
		return objetos.max({objeto => objeto.nivelPeligrosidad()}).nivelPeligrosidad()
	 }

	 method bultos() {
		return 1 + objetos.sum({objeto => objeto.bultos()})
	 }

	 method reaccionarAlSerCargado() {
          objetos.each({objeto => objeto.reaccionarAlSerCargado()})
     }     

}


object residuosRadioactivos {
	var property peso = 200 

	method nivelPeligrosidad() { return 200}
	method bultos() = 1
	method reaccionAlSerCargado() {}
}

object embalajeDeSeguridad {
	const objetos = #{}

	method peso() {
		return self.pesoDeObjetos()
	}

	method pesoDeObjetos() {
		return objetos.sum({ objeto => objeto.peso()})
	 }

    method nivelPeligrosidad() {
		return self.nivelDePeligrosidadDeObjetos() / 2
	}

	method nivelDePeligrosidadDeObjetos() {
		return objetos.sum({objeto => objeto.nivelPeligrosidad()})
	}

	method bultos() = 2
}

