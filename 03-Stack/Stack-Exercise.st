!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:06:01'!
test01StackShouldBeEmptyWhenCreated



	| stack |
	
	
	
	stack := OOStack new.
	
	
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:06:15'!
test02PushAddElementsToTheStack



	| stack |
	
	
	
	stack := OOStack new.
	
	stack push: 'Something'.
	
	
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:06:34'!
test03PopRemovesElementsFromTheStack



	| stack |
	
	
	
	stack := OOStack new.
	
	stack push: 'Something'.
	
	stack pop.
	
	
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:06:50'!
test04PopReturnsLastPushedObject



	| stack pushedObject |
	
	
	
	stack := OOStack new.
	
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:07:17'!
test05StackBehavesLIFO



	| stack firstPushedObject secondPushedObject |
	
	
	
	stack := OOStack new.
	
	firstPushedObject := 'First'.
	
	secondPushedObject := 'Second'.
	
	
	
	stack push: firstPushedObject.
	
	stack push: secondPushedObject.
	
	
	
	self assert: stack pop = secondPushedObject.
	
	self assert: stack pop = firstPushedObject.
	
	self assert: stack isEmpty 
	
	! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:07:37'!
test06TopReturnsLastPushedObject



	| stack pushedObject |
	
	
	
	stack := OOStack new.
	
	pushedObject := 'Something'.
	
	
	
	stack push: pushedObject.
	
	
	
	self assert: stack top = pushedObject.
	
	! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:08:00'!
test07TopDoesNotRemoveObjectFromStack



	| stack pushedObject |
	
	
	
	stack := OOStack new.
	
	pushedObject := 'Something'.
	
	
	
	stack push: pushedObject.
	
	
	
	self assert: stack size = 1.
	
	stack top.
	
	self assert: stack size = 1.
	
	! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:08:20'!
test08CanNotPopWhenThereAreNoObjectsInTheStack



	| stack  |
	
	
	
	stack := OOStack new.
	
	self
	
		should: [ stack pop ]
		
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo: [ :anError |
			
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
		
		
! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:08:46'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects



	| stack  |
	
	
	
	stack := OOStack new.
	
	stack push: 'Something'.
	
	stack pop.
	
	
	
	self
	
		should: [ stack pop ]
		
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo: [ :anError |
			
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
		
		
! !

!OOStackTest methodsFor: 'test' stamp: 'car 9/17/2019 00:09:06'!
test10CanNotTopWhenThereAreNoObjectsInTheStack



	| stack  |
	
	
	
	stack := OOStack new.
	
	self
	
		should: [ stack top ]
		
		raise: Error - MessageNotUnderstood 
		
		withExceptionDo: [ :anError |
			
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
		
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #NameOfSubclass category: #'Stack-Exercise'!
Object subclass: #NameOfSubclass
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'store'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:16:02'!
initialize

	|x|
	
	x := YYY new.
	
	store:= OrderedCollection with: x.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:25:29'!
isEmpty

	^ store size = 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:08:02'!
pop
	|x|
	x := store last.
	^x popStack: self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:23:50'!
popYYY: YYY

	^self error: OOStack stackEmptyErrorDescription ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:32:49'!
popZZZ: ZZZ
	|x|
	
	x := ZZZ value.
	
	store removeLast.
	
	^x

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:15:54'!
push: something	
	
	|x|
	
	x := ZZZ with: something.
	
	store add: x. 	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:25:51'!
size

	^store size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:08:14'!
top

	|x|
	
	x := store last.
	
	^x topStack: self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:24:10'!
topYYY: YYY

	^self error: OOStack stackEmptyErrorDescription! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:11:58'!
topZZZ: ZZZ

	^store last value.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'car 9/17/2019 00:42:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #XXX category: #'Stack-Exercise'!
Object subclass: #XXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!XXX methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:44:29'!
popStack: stack

	^self subclassResponsibility ! !

!XXX methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:44:33'!
topStack: stack

	^self subclassResponsibility ! !


!classDefinition: #YYY category: #'Stack-Exercise'!
XXX subclass: #YYY
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!YYY methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:08:38'!
popStack: stack

	^stack popYYY: self! !

!YYY methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:08:44'!
topStack: stack

	^stack topYYY: self! !


!classDefinition: #ZZZ category: #'Stack-Exercise'!
XXX subclass: #ZZZ
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ZZZ methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:41:59'!
initialize: aSomething

	value := aSomething! !

!ZZZ methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:08:54'!
popStack: stack

	^stack popZZZ: self ! !

!ZZZ methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 01:09:00'!
topStack: stack

	^stack topZZZ: self! !

!ZZZ methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:31:36'!
value

	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZZZ class' category: #'Stack-Exercise'!
ZZZ class
	instanceVariableNames: ''!

!ZZZ class methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:53:56'!
with: aSomething

	 ^self new initialize: aSomething! !
