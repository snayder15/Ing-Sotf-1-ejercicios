!classDefinition: #TestCarrito category: #'Ejercicio-TusLibros' stamp: 'ns 10/31/2019 16:53:43'!
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

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:42:16'!
test04AgregarMasDeUnaVezUnMismoItemAlCarrito

	| unCarrito |
	unCarrito := Carrito new.
	unCarrito agregar: 'tipo A' con: 1.
	unCarrito agregar: 'tipo A' con: 2.
	
	self assert: (unCarrito estaEsteItem: 'tipo A').
	self assert: 3 = (unCarrito cantidadDe: 'tipo A') ! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:44:49'!
test05RemoverDeUnCarritoVacio

	| unCarrito |
	unCarrito := Carrito new.
	
	self should: [unCarrito remover: 'tipo A' cantidad: 1] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | 
							self assert: anError messageText equals: Carrito errorCannotRemoveFromCart].! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:47:50'!
test06RemoverDeUnCarritoUnItemAgregado

	| unCarrito |
	unCarrito := Carrito new.
	unCarrito agregar: 'tipo A' con: 3.
	unCarrito remover: 'tipo A' cantidad: 1.
	
	self assert: (unCarrito estaEsteItem: 'tipo A').
	self assert: 2 = (unCarrito cantidadDe: 'tipo A') 
! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:50:13'!
test07RemoverDeUnCarritoUnaCantidadMayorALaAgregadaDeUnItem

	| unCarrito |
	unCarrito := Carrito new.
	unCarrito agregar: 'tipo A' con: 1.
	
	self should: [unCarrito remover: 'tipo A' cantidad: 3] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError | 
							self assert: anError messageText equals: Carrito errorCannotRemoveFromCart].
! !

!TestCarrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:51:58'!
test08RemoverDeUnCarritoTodosLosElementosDeUnItem

	| unCarrito |
	unCarrito := Carrito new.
	unCarrito agregar: 'tipo A' con: 2.
	unCarrito remover: 'tipo A' cantidad: 2.	
	
	self deny: (unCarrito estaEsteItem: 'tipo A').

	
! !


!classDefinition: #Carrito category: #'Ejercicio-TusLibros' stamp: 'ns 10/31/2019 16:53:43'!
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

!Carrito methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:53:21'!
remover: unItem cantidad: unaCantidad 
	| cantidad |
	
	(self estaEsteItem: unItem) ifFalse: [^ Carrito error: Carrito errorCannotRemoveFromCart] 
	ifTrue: [cantidad  := elementos at: unItem.
			cantidad < unaCantidad ifTrue: [^ Carrito error: Carrito errorCannotRemoveFromCart].
			cantidad = unaCantidad ifTrue: [
				elementos removeKey: unItem.
			] ifFalse: [
				elementos at: unItem put: (cantidad - unaCantidad).
			]
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #'Ejercicio-TusLibros' stamp: 'ns 10/31/2019 16:53:43'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'ns 10/31/2019 16:46:39'!
errorCannotRemoveFromCart

	^'Cannot remove item from cart'! !
