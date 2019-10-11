!classDefinition: #TerniLapilliTest category: #'TerniLapilli-ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:04:02'!
test01XBeginsOnEmptyBoard

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	juegoTerniLapilli putXAt: 0@1.

	self assert: (juegoTerniLapilli isXAt: 0@1).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:04:46'!
test02OPlaysAfterX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@0.

	self assert: (juegoTerniLapilli isOAt: 0@0).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:05:21'!
test03OCantPlayBeforeX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	self should: [juegoTerniLapilli putOAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorOCantPlayBeforeX.
							self deny: (juegoTerniLapilli isOAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:06:09'!
test04XCantPlayTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	
	self should: [juegoTerniLapilli putXAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorXCantPlayTwoTimesInARow.
						      self deny: (juegoTerniLapilli isXAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:06:37'!
test05OCantPlayTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@2.
	
	self should: [juegoTerniLapilli putOAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorOCantPlayTwoTimesInARow.
						      self deny: (juegoTerniLapilli isOAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:06:59'!
test06XCantPlaceMoreThanThreeTiles

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 2@0.

	self should: [juegoTerniLapilli putXAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorXCantPlaceMoreThanThreeTiles.
							self deny: (juegoTerniLapilli isXAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:07:29'!
test07InvalidPositionForX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	self should: [juegoTerniLapilli putXAt: 3@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isXAt: 3@0)]! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:07:49'!
test08InvalidPositionForO

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.

	self should: [juegoTerniLapilli putOAt: 3@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isOAt: 3@0).]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'positionsX positionsO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:34:15'!
initializeStartGame

	positionsX:= OrderedCollection new.
	positionsO:= OrderedCollection new.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:33:25'!
isInvalid: aPosition

	^ (aPosition x > 2 or: aPosition x < 0) or: (aPosition y > 2 or: aPosition y < 0).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:02:57'!
isOAt: aPosition

	^ positionsO includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:03:06'!
isXAt: aPosition

	^ positionsX includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:28:13'!
positionsO

	^positionsO! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:28:06'!
positionsX

	^positionsX! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:43:51'!
putOAt: aPosition
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	positionsX isEmpty ifTrue: [^ TerniLapilli error: TerniLapilli errorOCantPlayBeforeX ].
	positionsO size  =  positionsX  size ifTrue: [^TerniLapilli error: TerniLapilli errorOCantPlayTwoTimesInARow].
	positionsO add: aPosition .! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:44:13'!
putXAt: aPosition
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	positionsX size = 3 ifTrue: [^TerniLapilli error: TerniLapilli errorXCantPlaceMoreThanThreeTiles]. 
	positionsX size  >  positionsO size ifTrue: [^TerniLapilli error: TerniLapilli errorXCantPlayTwoTimesInARow].
	positionsX add: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:34:04'!
errorInvalidPosition
	
	^'Invalid position'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:32'!
errorOCantPlayBeforeX
	^'O can not play before X'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:37:47'!
errorOCantPlayTwoTimesInARow
	^'O cant play two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:36:52'!
errorXCantPlaceMoreThanThreeTiles
	^ 'X cant place more than three tiles'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:37:42'!
errorXCantPlayTwoTimesInARow
	^'X cant play two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:24:39'!
startGame
	^self new initializeStartGame! !
