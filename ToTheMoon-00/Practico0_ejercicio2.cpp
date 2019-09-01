/*Ejercicio 2*/

#define  velocidadSueloCompacto 150;
#define  tiempoSueloCompacto 10; 
#define  velociadSueloPoroso 100;
#define  tiempoSueloPoroso 5; 
int objeto;


void tomarObjetoEnSueloCompacto(){
	
	girarMechaEnSentidoReloj(tiempoSueloCompacto,velocidadSueloCompacto);
	cerramosLaPinsas(objeto);
	girarMechaEnSentidoContrarioReloj(tiempoSueloCompacto,velocidadSueloCompacto);
}

void tomarObjetoEnSueloPoroso(){
	girarMechaEnSentidoContrarioReloj(tiempoSueloPoroso,velocidadSueloPoroso);
	cerramosLaPinsas(objeto);
	girarMechaEnSentidoReloj(tiempoSueloPoroso,velocidadSueloPoroso);
}

void tomarObjetoEnSueloPoroso(){
	girarMechaEnSentidoReloj(tiempoSueloPoroso,velocidadSueloCompacto);
	cerramosLaPinsas(objeto);
	girarMechaEnSentidoContrarioReloj(tiempoSueloCompacto,velocidadSueloPoroso);
}



int main(int argc, char const *argv[])
{
	int dureza = argv[1];
	int porosidad = argv[2];
	
	/*Aqui una desicion que tomamos es:
		Suelo duro compacto : dureza > 0 y porosidad = 0
		Suelo suave poroso  : dureza = 0 y porosidad > 0
		Suelo Mixto         : dureza > 0 y porosidad > 0 
		Si dureza = 0 y porosidad = 0 entonces el robot no ejecuta accion
	*/
	
	if(dureza = 0 && porosidad = 0){
		exit(0);
	}
	
	if(dureza > 0 && porosidad = 0){
		tomarObjetoEnSueloCompacto();
	}
	
	if(dureza = 0 && porosidad > 0){
		tomarObjetoEnSueloPoroso();
	}

	if(dureza > 0 && porosidad > 0){
		tomarObjetoEnSueloMixto();
	}
	
	return 0;
}