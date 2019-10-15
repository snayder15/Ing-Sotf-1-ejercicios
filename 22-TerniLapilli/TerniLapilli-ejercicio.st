!classDefinition: #TerniLapilliTest category: #'TerniLapilli-ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:04:02'!
test01XBeginsOnEmptyBoard

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	juegoTerniLapilli putXAt: 0@1.

	self assert: (juegoTerniLapilli isXAt: 0@1).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:04:46'!
test02OPlaysAfterX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@0.

	self assert: (juegoTerniLapilli isOAt: 0@0).! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:05:21'!
test03OCantPlayBeforeX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	self should: [juegoTerniLapilli putOAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorOCantPlayBeforeX.
							self deny: (juegoTerniLapilli isOAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:06:09'!
test04XCantPlayTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	
	self should: [juegoTerniLapilli putXAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorXCantPlayTwoTimesInARow.
						      self deny: (juegoTerniLapilli isXAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:06:37'!
test05OCantPlayTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@2.
	
	self should: [juegoTerniLapilli putOAt: 0@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText  equals: TerniLapilli errorOCantPlayTwoTimesInARow.
						      self deny: (juegoTerniLapilli isOAt: 0@0)]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:06:59'!
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

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:07:29'!
test07InvalidPositionForX

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.

	self should: [juegoTerniLapilli putXAt: 3@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isXAt: 3@0)]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/11/2019 02:07:49'!
test08InvalidPositionForO

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.

	self should: [juegoTerniLapilli putOAt: 3@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isOAt: 3@0).]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 12:15:39'!
test09XCantMoveIfAllTilesAreNotPlaced

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.

	self should: [juegoTerniLapilli moveXFrom: 0@0 to: 1@0] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMoveBeforeAllTilesArePlaced.
							self deny: (juegoTerniLapilli isXAt: 1@0).]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 12:17:16'!
test10XCanMoveWhenAllTilesArePlaced

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 1@1 to: 2@1.
	
	self deny: (juegoTerniLapilli isXAt: 1@1).
	self assert: (juegoTerniLapilli isXAt: 2@1).
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 12:19:34'!
test11XCantMoveToAnInvalidPosition

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	
	self should: [juegoTerniLapilli  moveXFrom: 1@1 to: 6@1.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isXAt: 6@1)]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 12:22:59'!
test12XCantMoveToAPositionWithAnotherXTile

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 1@1.
	
	self should: [juegoTerniLapilli  moveXFrom: 0@2 to: 1@2.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorPositionNotEmpty.
							self assert: (juegoTerniLapilli isXAt: 0@2).
							self assert: (juegoTerniLapilli isXAt: 1@2)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:41:59'!
test13XCantMoveToAPositionWithAnOTile

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	
	self should: [juegoTerniLapilli  moveXFrom: 0@2 to: 1@2.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorPositionNotEmpty.
							self assert: (juegoTerniLapilli isXAt: 0@2).
							self deny: (juegoTerniLapilli isXAt: 1@2).
							self assert: (juegoTerniLapilli isOAt: 1@2).
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/15/2019 17:38:28'!
test14XCantMoveMoreThanOneStep

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	
	self should: [juegoTerniLapilli  moveXFrom: 0@2 to: 2@2.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMakeThatMove.
							self assert: (juegoTerniLapilli isXAt: 0@2).
							self deny: (juegoTerniLapilli isXAt: 2@2)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:04:25'!
test15XCantMoveTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 0@0 to: 1@1.
	
	self should: [juegoTerniLapilli  moveXFrom: 1@1 to: 2@2.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMoveTwoTimesInARow.
							self assert: (juegoTerniLapilli isXAt: 1@1).
							self deny: (juegoTerniLapilli isXAt: 2@2)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:35:25'!
test16OCantMoveIfAllTilesAreNotPlaced

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	
	self should: [juegoTerniLapilli moveOFrom: 0@1 to: 1@1] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMoveBeforeAllTilesArePlaced.
							self deny: (juegoTerniLapilli isOAt: 1@1).]! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:37:00'!
test17OCanMoveWhenAllTilesArePlaced

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 1@1 to: 2@1.
	juegoTerniLapilli  moveOFrom: 1@2 to: 1@1.	
	
	self deny: (juegoTerniLapilli isOAt: 1@2).
	self assert: (juegoTerniLapilli isOAt: 1@1).
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:38:49'!
test18OCantMoveToAnInvalidPosition

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 1@1 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 1@2 to: 6@1.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorInvalidPosition.
							self deny: (juegoTerniLapilli isOAt: 6@1)]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:40:23'!
test19OCantMoveToAPositionWithAnotherOTile

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli  moveXFrom: 1@2 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 1@0 to: 1@1.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorPositionNotEmpty.
							self assert: (juegoTerniLapilli isOAt: 1@0).
							self assert: (juegoTerniLapilli isOAt: 1@1)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:43:35'!
test20OCantMoveToAPositionWithAnXTile

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 1@1 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 1@2 to: 2@2.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorPositionNotEmpty.
							self assert: (juegoTerniLapilli isOAt: 1@2).
							self deny: (juegoTerniLapilli isOAt: 2@2).
							self assert: (juegoTerniLapilli isXAt: 2@2).
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/15/2019 17:38:28'!
test21OCantMoveMoreThanOneStep

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 1@1 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 0@1 to: 2@1.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMakeThatMove.
							self assert: (juegoTerniLapilli isOAt: 0@1).
							self deny: (juegoTerniLapilli isOAt: 2@1)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'a 10/12/2019 13:47:04'!
test22OCantMoveTwoTimesInARow

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli  moveXFrom: 0@0 to: 1@1.
	juegoTerniLapilli  moveOFrom: 1@2 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 2@2 to: 1@1.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| self assert: anError messageText equals: TerniLapilli errorCantMoveTwoTimesInARow.
							self assert: (juegoTerniLapilli isOAt: 2@2).
							self deny: (juegoTerniLapilli isOAt: 1@1)
							]
	
	
! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:16:22'!
test23XWinsByPlacingTheLastTileAndBuildingAStraightLineInRowOne

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 0@2.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:36:55'!
test24XWinsByPlacingTheLastTileAndBuildingAStraightLineInRowTwo

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 2@0.
	juegoTerniLapilli putXAt: 1@2.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:37:03'!
test25XWinsByPlacingTheLastTileAndBuildingAStraightLineInRowThree

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 2@0.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 2@2.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:37:08'!
test26XWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnOne

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 2@2.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli putXAt: 2@0.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:37:12'!
test27XWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnTwo

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 2@2.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 2@1.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:37:16'!
test28XWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnThree

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 2@2.
	
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:38:26'!
test29OWinsByPlacingTheLastTileAndBuildingAStraightLineInRowOne

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 2@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 2@2.
	juegoTerniLapilli putOAt: 0@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:19'!
test30OWinsByPlacingTheLastTileAndBuildingAStraightLineInRowTwo

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 2@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 2@2.
	juegoTerniLapilli putOAt: 1@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:25'!
test31OWinsByPlacingTheLastTileAndBuildingAStraightLineInRowThree

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 2@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 2@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 2@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:29'!
test32OWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnOne

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@0.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 2@0.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:32'!
test33OWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnTwo

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 2@1.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:35'!
test34OWinsByPlacingTheLastTileAndBuildingAStraightLineInColumnThree

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 2@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:43'!
test35XWinsByPlacingTheLastTileAndBuildingAMainDiagonal

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 1@2.
	juegoTerniLapilli putXAt: 2@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:49'!
test36XWinsByPlacingTheLastTileAndBuildingASecondaryDiagonal

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 2@2.
	juegoTerniLapilli putXAt: 2@0.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerXWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:53'!
test37OWinsByPlacingTheLastTileAndBuildingAMainDiagonal

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 2@2.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 16:39:58'!
test38OWinsByPlacingTheLastTileAndBuildingASecondaryDiagonal

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 2@0.
	self assert: juegoTerniLapilli isOver.
	self assert: juegoTerniLapilli hasPlayerOWon.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 17:08:47'!
test39OCantPlaceTileIfXPlacesTheLastTileAndWins

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 2@1.
	juegoTerniLapilli putXAt: 1@1.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 2@2.
	
	self should: [juegoTerniLapilli putOAt: 2@0.] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorOCantPlaceTileIfTheGameIsOver.
							self deny: (juegoTerniLapilli isOAt: 2@0).
							self assert: juegoTerniLapilli hasPlayerXWon.].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 17:07:58'!
test40XCantMoveTilesIfOPlacesTheLastTileAndWins

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@1.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 2@2.
	
	self should: [juegoTerniLapilli  moveXFrom: 0@1 to: 0@2.] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorXCantMoveTilesIfTheGameIsOver.
							self deny: (juegoTerniLapilli isXAt: 0@2).
							self assert: (juegoTerniLapilli isXAt: 0@1).
							self assert: juegoTerniLapilli hasPlayerOWon.].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 17:30:32'!
test41XCantMoveTilesIfOWon

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 2@2.
	juegoTerniLapilli  moveXFrom: 2@1 to: 2@0.
	juegoTerniLapilli  moveOFrom: 2@2 to: 2@1.
	
	self should: [juegoTerniLapilli  moveXFrom: 0@2 to: 1@2.] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorXCantMoveTilesIfTheGameIsOver.
							self deny: (juegoTerniLapilli isXAt: 1@2).
							self assert: (juegoTerniLapilli isXAt: 0@2).
							self assert: juegoTerniLapilli hasPlayerOWon.].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/13/2019 17:46:10'!
test42OCantMoveTilesIfXWon

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@2.
	juegoTerniLapilli putOAt: 1@1.
	juegoTerniLapilli putXAt: 1@2.
	juegoTerniLapilli putOAt: 0@0.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 2@0.
	juegoTerniLapilli  moveXFrom: 2@1 to: 2@2.
	
	self should: [juegoTerniLapilli  moveOFrom: 1@1 to: 1@0.] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorOCantMoveTilesIfTheGameIsOver.
							self deny: (juegoTerniLapilli isOAt: 1@0).
							self assert: (juegoTerniLapilli isOAt: 1@1).
							self assert: juegoTerniLapilli hasPlayerXWon.].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/15/2019 17:39:46'!
test43XCantMoveToAPositionThatIsNotOnTheLineOfTheGame

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 2@0.
	juegoTerniLapilli putXAt: 2@1.
	juegoTerniLapilli putOAt: 2@2.
	
	self should: [juegoTerniLapilli  moveXFrom: 2@1 to: 1@2] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorCantMakeThatMove.
							self deny: (juegoTerniLapilli isXAt: 1@2).
							self assert: (juegoTerniLapilli isXAt: 2@1)].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/15/2019 17:43:22'!
test44OCantMoveToAPositionThatIsNotOnTheLineOfTheGame

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 2@2.
	juegoTerniLapilli putOAt: 2@1.
	juegoTerniLapilli  moveXFrom: 2@2 to: 1@1.
	
	self should: [juegoTerniLapilli  moveOFrom: 0@1 to: 1@2] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorCantMakeThatMove.
							self deny: (juegoTerniLapilli isOAt: 1@2).
							self assert: (juegoTerniLapilli isOAt: 0@1)].! !

!TerniLapilliTest methodsFor: 'test' stamp: 'car 10/15/2019 17:53:05'!
test45OCantPlaceTilesWhenTheGameHasSixTiles

	| juegoTerniLapilli |
	juegoTerniLapilli :=  TerniLapilli startGame.
	juegoTerniLapilli putXAt: 0@0.
	juegoTerniLapilli putOAt: 0@1.
	juegoTerniLapilli putXAt: 1@0.
	juegoTerniLapilli putOAt: 0@2.
	juegoTerniLapilli putXAt: 2@2.
	juegoTerniLapilli putOAt: 2@1.
	juegoTerniLapilli  moveXFrom: 2@2 to: 1@1.
	
	self should: [juegoTerniLapilli putOAt: 2@2.] 
	       raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError| 
							self assert: anError messageText equals: TerniLapilli errorOCantPlaceMoreThanThreeTiles.
							self deny: (juegoTerniLapilli isOAt: 2@2)].! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'positionsX allowedMovements positionsO playing winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ejercicio'!

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 03:40:27'!
OBuiltAColumn

	^(positionsO select: [:aPosition| (aPosition y) = 0]) size = 3 or:
	  (positionsO select: [:aPosition| (aPosition y) = 1]) size = 3 or:
	  (positionsO select: [:aPosition| (aPosition y) = 2]) size = 3! !

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 04:05:15'!
OBuiltADiagonal

	^(positionsO select: [:aPosition| (aPosition x) = (aPosition y)]) size = 3 or:
	  (positionsO select: [:aPosition| (aPosition x) + (aPosition y) = 2]) size = 3 ! !

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 03:29:36'!
OBuiltARow

	^(positionsO select: [:aPosition| (aPosition x) = 0]) size = 3 or:
	  (positionsO select: [:aPosition| (aPosition x) = 1]) size = 3 or:
	  (positionsO select: [:aPosition| (aPosition x) = 2]) size = 3! !

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 03:12:28'!
XBuiltAColumn

	^ (positionsX select: [:aPosition| (aPosition y) = 0]) size = 3 or: 
	   (positionsX select: [:aPosition| (aPosition y) = 1]) size = 3 or:
	   (positionsX select: [:aPosition| (aPosition y) = 2]) size = 3 
	! !

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 03:58:06'!
XBuiltADiagonal

	^ (positionsX select: [:aPosition| (aPosition x) = (aPosition y)]) size = 3 or:
	   (positionsX select: [:aPosition| (aPosition x) + (aPosition y) = 2]) size = 3
	! !

!TerniLapilli methodsFor: 'finish-private' stamp: 'car 10/13/2019 03:11:50'!
XBuiltARow

	^ (positionsX select: [:aPosition| (aPosition x) = 0]) size = 3 or: 
	   (positionsX select: [:aPosition| (aPosition x) = 1]) size = 3 or:
	   (positionsX select: [:aPosition| (aPosition x) = 2]) size = 3 
	! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/14/2019 21:52:11'!
allowedPositionsOf: aPosition 

	^allowedMovements at: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 12:15:54'!
areStillTilesToPlace

	^ positionsX size < 3 or: positionsO size < 3.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 16:38:49'!
hasPlayerOWon
	^winner = #O! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 16:26:23'!
hasPlayerXWon
	^winner = #X! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/14/2019 22:07:09'!
initializeAllowedMovements.

	allowedMovements := Dictionary new.
	allowedMovements at: 0@0 put: (OrderedCollection with: 0@1 with: 1@0 with: 1@1).
	allowedMovements at: 0@1 put: (OrderedCollection with: 0@0 with: 0@2 with: 1@1).
	allowedMovements at: 0@2 put: (OrderedCollection with: 0@1 with: 1@1 with: 1@2).
	allowedMovements at: 1@0 put: (OrderedCollection with: 0@0 with: 2@0 with: 1@1).
	allowedMovements at: 1@1 put: (1@1) eightNeighbors .
	allowedMovements at: 1@2 put: (OrderedCollection with: 0@2 with: 2@2 with: 1@1).	
	allowedMovements at: 2@0 put: (OrderedCollection with: 1@0 with: 2@1 with: 1@1).
	allowedMovements at: 2@1 put: (OrderedCollection with: 2@0 with: 2@2 with: 1@1).
	allowedMovements at: 2@2 put: (OrderedCollection with: 2@1 with: 1@2 with: 1@1).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/14/2019 21:47:24'!
initializeStartGame

	positionsX:= OrderedCollection new.
	positionsO:= OrderedCollection new.
	self initializeAllowedMovements.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:33:25'!
isInvalid: aPosition

	^ (aPosition x > 2 or: aPosition x < 0) or: (aPosition y > 2 or: aPosition y < 0).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/12/2019 21:29:41'!
isNotAllowedFrom: aPosition to: anotherPosition

	^((self allowedPositionsOf: aPosition) includes: anotherPosition) not. 
	
	
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:02:57'!
isOAt: aPosition

	^ positionsO includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 13:47:28'!
isPlayingO

	^ playing = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 13:06:32'!
isPlayingX

	^ playing = #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 12:25:41'!
isPositionNotEmpty: anotherPosition

	^ (self isXAt: anotherPosition) or: (self isOAt: anotherPosition).! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 02:03:06'!
isXAt: aPosition

	^ positionsX includes: aPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/15/2019 17:38:28'!
moveOFrom: aPosition to: anotherPosition
	(self isOver) ifTrue:[^TerniLapilli error: TerniLapilli errorOCantMoveTilesIfTheGameIsOver].
	self isPlayingO ifTrue: [^TerniLapilli error: TerniLapilli errorCantMoveTwoTimesInARow ].
	(self areStillTilesToPlace) ifTrue: [^TerniLapilli error: TerniLapilli errorCantMoveBeforeAllTilesArePlaced].
	(self isInvalid: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorInvalidPosition ].
	(self isPositionNotEmpty: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorPositionNotEmpty].
	(self isNotAllowedFrom: aPosition to: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorCantMakeThatMove].
	positionsO remove: aPosition.
	positionsO add: anotherPosition.
	playing := #O.
	(self isOver ) ifTrue: [winner := #O].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/15/2019 17:38:28'!
moveXFrom: aPosition to: anotherPosition
	(self isOver) ifTrue:[^TerniLapilli error: TerniLapilli errorXCantMoveTilesIfTheGameIsOver].
	self isPlayingX ifTrue: [^TerniLapilli error: TerniLapilli errorCantMoveTwoTimesInARow ].
	(self areStillTilesToPlace) ifTrue: [^TerniLapilli error: TerniLapilli errorCantMoveBeforeAllTilesArePlaced].
	(self isInvalid: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorInvalidPosition ].
	(self isPositionNotEmpty: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorPositionNotEmpty].
	(self isNotAllowedFrom: aPosition to: anotherPosition) ifTrue: [TerniLapilli error: TerniLapilli errorCantMakeThatMove].
	positionsX remove: aPosition.
	positionsX add: anotherPosition.
	playing := #X.
	(self isOver ) ifTrue: [winner := #X].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:28:13'!
positionsO

	^positionsO! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:28:06'!
positionsX

	^positionsX! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/15/2019 18:04:37'!
putOAt: aPosition
	(self isOver ) ifTrue: [^TerniLapilli error: TerniLapilli errorOCantPlaceTileIfTheGameIsOver].
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	positionsO size = 3 ifTrue: [^TerniLapilli error: TerniLapilli errorOCantPlaceMoreThanThreeTiles]. 
	positionsX isEmpty ifTrue: [^ TerniLapilli error: TerniLapilli errorOCantPlayBeforeX ].
	self isPlayingO ifTrue: [^TerniLapilli error: TerniLapilli errorOCantPlayTwoTimesInARow].
	positionsO add: aPosition .
	playing := #O.
	(self isOver ) ifTrue: [winner := #O]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 16:36:34'!
putXAt: aPosition
	(self isInvalid: aPosition) ifTrue: [^TerniLapilli error: TerniLapilli errorInvalidPosition].
	positionsX size = 3 ifTrue: [^TerniLapilli error: TerniLapilli errorXCantPlaceMoreThanThreeTiles]. 
	self isPlayingX ifTrue: [^TerniLapilli error: TerniLapilli errorXCantPlayTwoTimesInARow].
	positionsX add: aPosition .
	playing := #X.
	(self isOver ) ifTrue: [winner := #X]! !


!TerniLapilli methodsFor: 'finish' stamp: 'car 10/13/2019 03:23:24'!
isOver
	
	^ self isTheWinnerX or: self isTheWinnerO
	
	! !

!TerniLapilli methodsFor: 'finish' stamp: 'car 10/13/2019 04:03:05'!
isTheWinnerO
	
	^ self OBuiltARow or: self OBuiltAColumn or:  self OBuiltADiagonal! !

!TerniLapilli methodsFor: 'finish' stamp: 'car 10/13/2019 03:50:09'!
isTheWinnerX 
	
	^ self XBuiltARow or: self XBuiltAColumn or: self XBuiltADiagonal
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-ejercicio'!
TerniLapilli class
	instanceVariableNames: 'allowedPositions'!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/15/2019 17:38:28'!
errorCantMakeThatMove
	
	^'Cant move more than one step'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 12:12:15'!
errorCantMoveBeforeAllTilesArePlaced
	
	^'Cant move a tile before all tiles are placed'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 13:04:37'!
errorCantMoveTwoTimesInARow
	
	^'Cant move two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:34:04'!
errorInvalidPosition
	
	^'Invalid position'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 17:43:19'!
errorOCantMoveTilesIfTheGameIsOver
	
	^'O cant move tiles if the game is over'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/15/2019 18:04:02'!
errorOCantPlaceMoreThanThreeTiles
	^ 'O cant place more than three tiles'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 17:08:47'!
errorOCantPlaceTileIfTheGameIsOver

	^'O cant place tile if the gama is over'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 20:23:32'!
errorOCantPlayBeforeX
	^'O can not play before X'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:37:47'!
errorOCantPlayTwoTimesInARow
	^'O cant play two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a 10/12/2019 12:23:17'!
errorPositionNotEmpty
	
	^'Position is not empty'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/13/2019 17:07:57'!
errorXCantMoveTilesIfTheGameIsOver

	^'X cant move tiles if the game is over'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:36:52'!
errorXCantPlaceMoreThanThreeTiles
	^ 'X cant place more than three tiles'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/11/2019 01:37:42'!
errorXCantPlayTwoTimesInARow
	^'X cant play two times in a row'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'car 10/10/2019 18:24:39'!
startGame
	^self new initializeStartGame! !
