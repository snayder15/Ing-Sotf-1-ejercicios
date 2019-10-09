!classDefinition: #MarsRoverTest category: #'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:15'!
test01NoMove

	|marsRover north |
	
	north := North new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: '') position equals: 0@0.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:20'!
test02MoveForward

	|marsRover north |
	
	north := North new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: 'f') position equals: 0@1.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:24'!
test03MoveBackward

	|marsRover north |
	
	north := North new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: 'b') position equals: 0@-1.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:27'!
test04RotateRight

	|marsRover north east |
	
	north := North new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: 'r') position equals: 0@0.

	self assert: marsRover direction equals: east.! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:31'!
test05RotateLeft

	|marsRover north west |
	
	north := North new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: 'l') position equals: 0@0.

	self assert: marsRover direction equals: west.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:34'!
test06MoveSouthForwardAndRotateRight

	|marsRover south west |
	
	south := South new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: south.

	self assert: (marsRover execute: 'fffr') position equals: 0@-3.

	self assert: marsRover direction equals: west.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:37'!
test07MoveSouthBackwardAndRotateRight

	|marsRover south west |
	
	south := South new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: south.

	self assert: (marsRover execute: 'bbbr') position equals: 0@3.

	self assert: marsRover direction equals: west.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:40'!
test08MoveSouthForwardAndRotateLeft

	|marsRover east south |
	
	south := South new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: south.

	self assert: (marsRover execute: 'fffl') position equals: 0@-3.

	self assert: marsRover direction equals: east.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:44'!
test09MoveSouthBackwardAndRotateLeft

	|marsRover east south |
	
	south := South new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: south.

	self assert: (marsRover execute: 'bbbl') position equals: 0@3.

	self assert: marsRover direction equals: east.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:46'!
test10MoveEastForwardAndRotateRight

	|marsRover east south |
	
	south := South new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: east.

	self assert: (marsRover execute: 'fffr') position equals: 3@0.

	self assert: marsRover direction equals: south.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:49'!
test11MoveEastBackwardAndRotateRight

	|marsRover east south |
	
	south := South new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: east.

	self assert: (marsRover execute: 'bbbr') position equals: -3@0.

	self assert: marsRover direction equals: south.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:52'!
test12MoveEastForwardAndRotateLeft

	|marsRover east north |
	
	north := North new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: east.

	self assert: (marsRover execute: 'fffl') position equals: 3@0.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:55'!
test13MoveEastBackwardAndRotateLeft

	|marsRover east north |
	
	north := North new.
	east := East new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: east.

	self assert: (marsRover execute: 'bbbl') position equals: -3@0.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:29:58'!
test14MoveWestForwardAndRotateRight

	|marsRover north west |
	
	north := North new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: west.

	self assert: (marsRover execute: 'fffr') position equals: -3@0.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:30:01'!
test15MoveWestBackwardAndRotateRight

	|marsRover north west |
	
	north := North new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: west.

	self assert: (marsRover execute: 'bbbr') position equals: 3@0.

	self assert: marsRover direction equals: north.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:30:05'!
test16MoveWestForwardAndRotateLeft

	|marsRover south west |
	
	south := South new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: west.

	self assert: (marsRover execute: 'fffl') position equals: -3@0.

	self assert: marsRover direction equals: south.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:30:08'!
test17MoveWestBackwardAndRotateLeft

	|marsRover south west |
	
	south := South new.
	west := West new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: west.

	self assert: (marsRover execute: 'bbbl') position equals: 3@0.

	self assert: marsRover direction equals: south.
! !

!MarsRoverTest methodsFor: 'test' stamp: 'car 10/7/2019 12:30:11'!
test18MoveAround

	|marsRover north |
	
	north := North new.
	
	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self assert: (marsRover execute: 'ffrfffffbrffflllbbrfff') position equals: 6@2.

	self assert: marsRover direction equals: north.
! !


!MarsRoverTest methodsFor: 'test-error' stamp: 'car 10/7/2019 12:30:14'!
test19InvalidInstructionShouldRaiseAnError

	|marsRover north |
	
	north := North new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self 
		should: [marsRover execute: 'ffrjkuqweao0']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: (MarsRover uknownInstruction) ].! !

!MarsRoverTest methodsFor: 'test-error' stamp: 'car 10/7/2019 12:30:19'!
test20InvalidInstructionShouldNotMoveMarsRover

	|marsRover north |
	
	north := North new.

	marsRover := MarsRover withInitialPosition: 0@0 andDirection: north.

	self 
		should: [marsRover execute: 'ffrjkuqweao0']
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: (MarsRover uknownInstruction).
			self assert: marsRover position equals: 0@0.
			self assert: marsRover direction equals: north.
		].! !


!classDefinition: #CardinalPoints category: #'MarsRover-Ejercicio'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 22:40:47'!
= anObject

	^self class = anObject class! !

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 22:35:53'!
rotateLeft
	
	^self subclassResponsibility ! !

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:11:20'!
rotateRight
	
	^self subclassResponsibility ! !

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:02:55'!
xxxB: aObject

	^self subclassResponsibility ! !

!CardinalPoints methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:02:46'!
yyyF: aObject

	^self subclassResponsibility ! !


!classDefinition: #East category: #'MarsRover-Ejercicio'!
CardinalPoints subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!East methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:07:00'!
rotateLeft
	
	^ North new! !

!East methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:11:44'!
rotateRight

	^ South new! !

!East methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:08:27'!
xxxB: aObject

	^ aObject moveBackwardEast! !

!East methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:08:33'!
yyyF: aObject

	^ aObject moveForwardEast! !


!classDefinition: #North category: #'MarsRover-Ejercicio'!
CardinalPoints subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!North methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:07:19'!
rotateLeft
	
	^ West new! !

!North methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:13:08'!
rotateRight

	^ East new! !

!North methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:08:19'!
xxxB: aObject

	^ aObject moveBackwardNorth! !

!North methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:08:50'!
yyyF: aObject

	^ aObject moveForwardNorth! !


!classDefinition: #South category: #'MarsRover-Ejercicio'!
CardinalPoints subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!South methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:09:52'!
rotateLeft
	
	^ East new! !

!South methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:13:59'!
rotateRight

	^ West new! !

!South methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:09:55'!
xxxB: aObject

	^ aObject moveBackwardSouth! !

!South methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:10:03'!
yyyF: aObject

	^ aObject moveForwardSouth! !


!classDefinition: #West category: #'MarsRover-Ejercicio'!
CardinalPoints subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!West methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:10:13'!
rotateLeft
	
	^ South new! !

!West methodsFor: 'as yet unclassified' stamp: 'car 10/6/2019 23:14:16'!
rotateRight

	^ North new! !

!West methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:10:18'!
xxxB: aObject

	^ aObject moveBackwardWest! !

!West methodsFor: 'as yet unclassified' stamp: 'car 10/7/2019 11:10:26'!
yyyF: aObject

	^ aObject moveForwardWest! !


!classDefinition: #MarsRover category: #'MarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction allowedMovements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'a 10/5/2019 13:04:21'!
move: aSetOfInstructions
	
	| initialPosition initialDirection |

	initialPosition := position.
	initialDirection := direction.

	aSetOfInstructions do: [
		:instruction |
		instruction = $f ifTrue: [self moveForward ] ifFalse: [
			instruction = $b ifTrue: [self moveBackward ] ifFalse: [
				instruction = $r ifTrue: [self rotateRight ] ifFalse: [
					instruction = $l ifTrue: [self rotateLeft ] ifFalse: [
						position := initialPosition.
						direction := initialDirection.
						^self error: MarsRover uknownInstruction.
					]
				]
			]			
		]
	].! !


!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:12:06'!
moveBackwardEast

	position := position - (1@0)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:11:34'!
moveBackwardNorth

	position := position - (0@1)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:12:23'!
moveBackwardSouth

	position := position + (0@1)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:12:43'!
moveBackwardWest

	position := position + (1@0)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:20:05'!
moveForwardEast

	position := position + (1@0)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:20:25'!
moveForwardNorth

	position := position + (0@1)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:20:38'!
moveForwardSouth

	position := position - (0@1)! !

!MarsRover methodsFor: 'Private-move' stamp: 'car 10/7/2019 11:20:55'!
moveForwardWest

	position := position - (1@0)! !


!MarsRover methodsFor: 'initialization' stamp: 'a 10/8/2019 23:54:33'!
initializeWithInitialPosition: aPosition andDirection: aDirection

	position := aPosition.
	direction := aDirection.
	
	allowedMovements := Dictionary new.
  	allowedMovements at: $f put: [self moveForward].
  	allowedMovements at: $b put: [self moveBackward].
  	allowedMovements at: $r put: [self rotateRight].
  	allowedMovements at: $l put: [self rotateLeft].! !


!MarsRover methodsFor: 'actions' stamp: 'a 10/8/2019 23:54:49'!
execute: aSetOfInstructions
	
	| initialPosition initialDirection |

	initialPosition := position.
	initialDirection := direction.

	aSetOfInstructions do: [
		:instruction |
		allowedMovements at: instruction value ifAbsent: [
						position := initialPosition.
						direction := initialDirection.
						^self error: MarsRover uknownInstruction.
					].
		].! !

!MarsRover methodsFor: 'actions' stamp: 'car 10/7/2019 11:22:05'!
moveBackward
	
	direction xxxB: self! !

!MarsRover methodsFor: 'actions' stamp: 'car 10/7/2019 11:22:54'!
moveForward
	
	direction yyyF: self! !

!MarsRover methodsFor: 'actions' stamp: 'car 10/7/2019 11:52:13'!
rotateLeft
	direction := direction rotateLeft! !

!MarsRover methodsFor: 'actions' stamp: 'car 10/7/2019 11:52:29'!
rotateRight
	direction := direction rotateRight! !


!MarsRover methodsFor: 'accessing' stamp: 'a 10/3/2019 21:08:32'!
direction

	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'a 10/3/2019 21:08:20'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'a 10/5/2019 12:42:55'!
uknownInstruction

	^ 'Uknown Instruction'.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'a 10/3/2019 21:06:03'!
withInitialPosition: aPosition andDirection: aDirection

	^ self new initializeWithInitialPosition: aPosition andDirection: aDirection.! !
