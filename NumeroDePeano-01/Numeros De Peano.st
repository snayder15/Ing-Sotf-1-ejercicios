!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 00:11:09'!
* unNumeroDePeano

	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 18:51:10'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 00:10:41'!
- unNumeroDePeano

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 9/1/2019 23:40:29'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'numeros negativos no soportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 9/1/2019 20:58:03'!
isUno

	^ true! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 18:25:56'!
next

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:11'!
restaConArgumentosCambiados: unNumeroDePeano
	^unNumeroDePeano previous! !


!classDefinition: #II category: #'Numeros De Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 00:24:33'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 18:54:28'!
+ unNumerodePeano

	^self previous + unNumerodePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:05:59'!
- unNumeroDePeano
	^unNumeroDePeano restaConArgumentosCambiados: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'NumeroDePeano 9/4/2019 14:51:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 9/1/2019 20:58:15'!
isUno

	^ false! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 19:03:52'!
next
	
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 19:01:36'!
previous
	
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 19:07:19'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano ! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 8/26/2019 18:38:41'!
removeAllNext



	next ifNotNil:

	[

		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:05:59'!
restaConArgumentosCambiados: unNumeroDePeano
	^unNumeroDePeano previous - self previous! !


!classDefinition: #III category: #'Numeros De Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros De Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
+ unNumerodePeano

	^self previous + unNumerodePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
- unNumeroDePeano
	^unNumeroDePeano restaConArgumentosCambiados: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'NumeroDePeano 9/4/2019 14:51:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
isUno

	^ false! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
next
	
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
previous
	
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano ! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
removeAllNext



	next ifNotNil:

	[

		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:46'!
restaConArgumentosCambiados: unNumeroDePeano
	^unNumeroDePeano previous - self previous! !


!classDefinition: #IIII category: #'Numeros De Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros De Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
+ unNumerodePeano

	^self previous + unNumerodePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
- unNumeroDePeano
	^unNumeroDePeano restaConArgumentosCambiados: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NumeroDePeano 9/4/2019 14:51:11'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
isUno

	^ false! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
next
	
	next ifNil: [
		next _ self cloneNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
previous
	
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
previous: unNumeroDePeano 
	previous _ unNumeroDePeano ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
removeAllNext



	next ifNotNil:

	[

		next removeAllNext.

		next removeFromSystem.

		next := nil.

	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'car 9/2/2019 17:06:51'!
restaConArgumentosCambiados: unNumeroDePeano
	^unNumeroDePeano previous - self previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!