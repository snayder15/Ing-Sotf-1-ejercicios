!classDefinition: #MarsRoverTest category: #'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:02:00'!
test01NoMove

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'N'.

	self assert: (marsRover move: '') position equals: 0@0.

	self assert: marsRover direction equals: 'N'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:09:15'!
test02MoveForward

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'N'.

	self assert: (marsRover move: 'f') position equals: 0@1.

	self assert: marsRover direction equals: 'N'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:21:16'!
test03MoveBackward

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'N'.

	self assert: (marsRover move: 'b') position equals: 0@-1.

	self assert: marsRover direction equals: 'N'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:29:34'!
test04RotateRight

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'N'.

	self assert: (marsRover move: 'r') position equals: 0@0.

	self assert: marsRover direction equals: 'E'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:29:40'!
test05RotateLeft

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'N'.

	self assert: (marsRover move: 'l') position equals: 0@0.

	self assert: marsRover direction equals: 'W'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:36:55'!
test06MoveSouthForwardAndRotateRight

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'S'.

	self assert: (marsRover move: 'fffr') position equals: 0@-3.

	self assert: marsRover direction equals: 'W'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:37:46'!
test07MoveSouthBackwardAndRotateRight

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'S'.

	self assert: (marsRover move: 'bbbr') position equals: 0@3.

	self assert: marsRover direction equals: 'W'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:40:47'!
test08MoveSouthForwardAndRotateLeft

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'S'.

	self assert: (marsRover move: 'fffl') position equals: 0@-3.

	self assert: marsRover direction equals: 'E'.
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:41:30'!
test09MoveSouthBackwardAndRotateLeft

	|marsRover|

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: 'S'.

	self assert: (marsRover move: 'bbbl') position equals: 0@3.

	self assert: marsRover direction equals: 'E'.
! !


!classDefinition: #MarsRover category: #'MarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:08:32'!
direction

	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:07:04'!
initializeWithInitialPosition: aPosition andDirection: aDirection

	position := aPosition.
	direction := aDirection.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:33:13'!
move: aSetOfInstructions
	
	aSetOfInstructions do: [
		:instruction |
		instruction = $f ifTrue: [self moveForward ].
		instruction = $b ifTrue: [self moveBackward ].
		instruction = $r ifTrue: [self rotateRight ].
		instruction = $l ifTrue: [self rotateLeft ].
	].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:34:37'!
moveBackward
	
	direction = 'N' ifTrue: [position := position - (0@1)].
	direction = 'S' ifTrue: [position := position + (0@1)].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:34:20'!
moveForward
	
	direction = 'N' ifTrue: [position := position + (0@1)].
	direction = 'S' ifTrue: [position := position - (0@1)].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:08:20'!
position

	^position! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:40:27'!
rotateLeft
	direction = 'N' ifTrue: [direction := 'W'].
	direction = 'S' ifTrue: [direction := 'E'].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:35:36'!
rotateRight
	direction = 'N' ifTrue: [direction := 'E'].
	direction = 'S' ifTrue: [direction := 'W'].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:06:03'!
withInitialPosition: aPosition andDirection: aDirection

	^ self new initializeWithInitialPosition: aPosition andDirection: aDirection.! !
