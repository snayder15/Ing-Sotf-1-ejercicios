!classDefinition: #TerniLapilliTest category: #'TerniLapilli-ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:40:03'!
test01XBeginsOnEmptyBoard

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 0@1.
	
	juegoTerniLapilli putXAt: aPosition.

	self assert: ((juegoTerniLapilli positions: #X) includes: aPosition).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 19:51:04'!
test02OPlaysAfterX

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 0@0.
	
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: aPosition.

	self assert: ((juegoTerniLapilli positions: #O) includes: aPosition).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 21:28:36'!
test03OCantPlayBeforeX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	self should: [juegoTerniLapilli putOAt: 0@0] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: TerniLapilli errorOCantPlayBeforeX.
		self assert: (juegoTerniLapilli positions: #O) isEmpty.
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:47'!
test04XCantPlayTwoTimesInARow

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 0@0.
	juegoTerniLapilli putXAt: 0@1.
	
	self should: [juegoTerniLapilli putXAt: aPosition] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: (TerniLapilli errorCantPlayTwoTimesInARow: 'X').
		self deny: ((juegoTerniLapilli positions: #X) includes: aPosition).
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:51'!
test05OCantPlayTwoTimesInARow

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 0@0.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@2.
	
	self should: [juegoTerniLapilli putOAt: aPosition] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: (TerniLapilli errorCantPlayTwoTimesInARow: 'O').
		self deny: ((juegoTerniLapilli positions: #O) includes: aPosition).
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:22:26'!
test06XCantPlaceMoreThanThreeTiles

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 0@0.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 2@0.

	self should: [juegoTerniLapilli putXAt: aPosition] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: (TerniLapilli errorCantPlaceMoreThanThreeTiles: 'X').
		self deny: ((juegoTerniLapilli positions: #X) includes: aPosition).
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:34:48'!
test07InvalidPositionForX

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 3@0.

	self should: [juegoTerniLapilli putXAt: aPosition] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: TerniLapilli errorInvalidPosition.
		self deny: ((juegoTerniLapilli positions: #X) includes: aPosition).
		]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:35:23'!
test08InvalidPositionForO

	| aPosition juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	aPosition := 3@0.
	juegoTerniLapilli putXAt: 0@0.

	self should: [juegoTerniLapilli putOAt: aPosition] raise: Error - MessageNotUnderstood withExceptionDo: [
		:anError| self assert: anError messageText  equals: TerniLapilli errorInvalidPosition.
		self deny: ((juegoTerniLapilli positions: #O) includes: aPosition).
		]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playersPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:32:23'!
initializeStartGame

	playersPositions := Dictionary new.
	playersPositions add: #X->OrderedCollection new; add: #O->OrderedCollection new.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:33:25'!
isInvalid: aPosition

	^ (aPosition x > 2 or: aPosition x < 0) or: (aPosition y > 2 or: aPosition y < 0).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:34:13'!
positions: aPlayer
	^ playersPositions at: aPlayer! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:36:37'!
putOAt: aPosition
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	(playersPositions at: #X) isEmpty ifTrue: [^ TerniLapilli error: TerniLapilli errorOCantPlayBeforeX ].
	(playersPositions at:#O) size  =  (playersPositions at: #X) size ifTrue: [^TerniLapilli error: (TerniLapilli errorCantPlayTwoTimesInARow: 'O')].
	(playersPositions at: #O) add: aPosition .! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:32:13'!
putXAt: aPosition
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	(playersPositions at: #X) size = 3 ifTrue: [^TerniLapilli error: (TerniLapilli errorCantPlaceMoreThanThreeTiles: 'X')]. 
	(playersPositions at:#X) size  >  (playersPositions at: #O) size ifTrue: [^TerniLapilli error: (TerniLapilli errorCantPlayTwoTimesInARow: 'X')].
	(playersPositions at: #X) add: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:05'!
errorCantPlaceMoreThanThreeTiles: aPlayer
	^aPlayer,'cant place more than three tiles'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:19'!
errorCantPlayTwoTimesInARow: aPlayer
	^aPlayer,'cant play two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:34:04'!
errorInvalidPosition
	
	^'Invalid position'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:32'!
errorOCantPlayBeforeX
	^'O can not play before X'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:24:39'!
startGame
	^self new initializeStartGame! !
