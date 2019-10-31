!classDefinition: #TestCarrito category: #'Ejercicio-TusLibros' stamp: 'car 10/31/2019 02:03:01'!
TestCase subclass: #TestCarrito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:08:44'!
test01CrearUnCarritoQueEstaVacio

	| unCarrito |
	unCarrito := Carrito new.
	
	self assert: unCarrito estaVacio.! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:15:52'!
test02AlCarritoLeAgregamosUnItem

	| unCarrito unItem unaCantidad |
	unCarrito := Carrito new.
	unaCantidad := 1.
	unItem := 'tipo A'.
	unCarrito agregar: unItem con: unaCantidad.
	
	self deny: unCarrito estaVacio .! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:28:48'!
test03AlCarritoLeAgregamosMasDeUnElementoDelMismoTipo

	| unCarrito unItem unaCantidad |
	unCarrito := Carrito new.
	unaCantidad := 5.
	unItem := 'tipo A'.
	unCarrito agregar: unItem con: unaCantidad.
	
	self assert: (unCarrito estaEsteItem: unItem).
	self assert: 5 = (unCarrito cantidadDe: unItem) ! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:38:31'!
test04AgragarMasDeUnaVezUnMismoItemAlCarrito

	| unCarrito |
	unCarrito := Carrito new.
	unCarrito agregar: 'tipo A' con: 1.
	unCarrito agregar: 'tipo A' con: 2.
	
	self assert: (unCarrito estaEsteItem: 'tipo A').
	self assert: 3 = (unCarrito cantidadDe: 'tipo A') ! !


!classDefinition: #Carrito category: #'Ejercicio-TusLibros' stamp: 'car 10/31/2019 02:03:01'!
Object subclass: #Carrito
	instanceVariableNames: 'elementos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!

!Carrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:46:47'!
agregar: unItem con: unaCantidad 

	|cantidad|
	
	(self estaEsteItem: unItem) ifFalse: [elementos at: unItem put: unaCantidad] 
	ifTrue: [cantidad  := elementos at: unItem.
			 elementos at: unItem put: (unaCantidad + cantidad).].
	! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:35:43'!
cantidadDe: unItem 
	
	^elementos at: unItem ifAbsent: [''].! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:32:45'!
estaEsteItem: unItem 
	
	^ elementos includesKey: unItem ! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:20:30'!
estaVacio
	
	^ elementos isEmpty.! !

!Carrito methodsFor: 'as yet unclassified' stamp: 'car 10/31/2019 01:19:59'!
initialize
	
	elementos := Dictionary new.! !
