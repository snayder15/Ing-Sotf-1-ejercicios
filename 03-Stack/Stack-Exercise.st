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
	instanceVariableNames: 'sentenceFinderByPrefix AnEmptyStack aStackWithOneSentence aStackWithOneSentenceThatIncludeSpaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/18/2019 23:36:08'!
setUp
	|aEmptyStack aStackWithASentence aStackWithASentenceWithSpaces|
	
	aEmptyStack := OOStack new.
	aStackWithASentence:= OOStack new.
	aStackWithASentenceWithSpaces:= OOStack new.
	
	aStackWithASentence push: 'Winter'.
	aStackWithASentenceWithSpaces push: 'Wi n t er'.
	
	AnEmptyStack :=aEmptyStack.
	aStackWithOneSentence := aStackWithASentence .
	aStackWithOneSentenceThatIncludeSpaces :=aStackWithASentenceWithSpaces.
	
	sentenceFinderByPrefix := SentenceFinderByPrefix new.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 02:50:22'!
should: aBlockToRun raise: anExceptionType asserting: aVerificationBlock

	[ aBlockToRun value.
	self fail ]
		on: anExceptionType 
		do: aVerificationBlock ! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 01:52:52'!
test01NoPuedoEncontrarPrefijosEnUnaPilaVacia
	|prefix prefixes|
	prefix := 'Wint'.
	prefixes := sentenceFinderByPrefix find: prefix on: AnEmptyStack .
	
	self assert: prefixes size = 0.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 01:53:05'!
test02PuedoEncontrarFraseQueEsPrefijoEnUnaPilaQueContieneUnSoloElemento
	|prefix prefixes|
	prefix := 'Win'.
	prefixes := sentenceFinderByPrefix find: prefix on: aStackWithOneSentence.
	
	self assert: prefixes size = 1.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/18/2019 23:36:08'!
test03NoPuedoEncontrarFraseQueEsPrefijoEnUnaPilaQueContieneUnSoloElementoQueTieneEspacios
	|prefix prefijos|
	prefix := 'Win'.
	prefijos := sentenceFinderByPrefix find: prefix on: aStackWithOneSentenceThatIncludeSpaces.
	
	self assert: prefijos size = 0.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 03:28:13'!
test04CanNotFinderSentenceByPrefixEmptyInAStackEmpty

	self
		should: [ sentenceFinderByPrefix find: '' on: AnEmptyStack ]
		raise: Error
		asserting: [ :anError |  
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription]! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 03:29:16'!
test05CanNotFinderSentenceByPrefixEmptyInAStackNotEmpty

	self
		should: [ sentenceFinderByPrefix find: '' on: aStackWithOneSentence ]
		raise: Error
		asserting: [ :anError |  
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription]! !


!classDefinition: #Element category: #'Stack-Exercise'!
Object subclass: #Element
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:44:29'!
popStack: stack

	^self subclassResponsibility ! !

!Element methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:44:33'!
topStack: stack

	^self subclassResponsibility ! !


!classDefinition: #ElementWithMeaning category: #'Stack-Exercise'!
Element subclass: #ElementWithMeaning
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementWithMeaning methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:14:30'!
giveMeTheElementOfTheTopOfTheStack: stack

	^stack printAnElementWithMeaning: self! !

!ElementWithMeaning methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:41:59'!
initialize: aSomething

	value := aSomething! !

!ElementWithMeaning methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:03:24'!
popTheElementOfTheTopOfTheStack: stack

	^stack popAnElementWithMeaning: self ! !

!ElementWithMeaning methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:31:36'!
value

	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementWithMeaning class' category: #'Stack-Exercise'!
ElementWithMeaning class
	instanceVariableNames: ''!

!ElementWithMeaning class methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:53:56'!
with: aSomething

	 ^self new initialize: aSomething! !


!classDefinition: #ElementWithoutMeaning category: #'Stack-Exercise'!
Element subclass: #ElementWithoutMeaning
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementWithoutMeaning methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:02:35'!
giveMeTheElementOfTheTopOfTheStack: stack

	^stack printAnElementWithoutMeaning: self! !

!ElementWithoutMeaning methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:03:56'!
popTheElementOfTheTopOfTheStack: stack

	^stack popAnElementWithoutMeaning: self! !


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

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 21:54:31'!
initialize

	|x|
	
	x := ElementWithoutMeaning new.
	
	store:= OrderedCollection with: x.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:25:29'!
isEmpty

	^ store size = 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 21:57:31'!
pop
	|x|
	x := store last.
	^x popTheElementOfTheTopOfTheStack: self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:03:05'!
popAnElementWithMeaning: anElement
	|x|
	
	x := anElement value.
	
	store removeLast.
	
	^x

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:03:45'!
popAnElementWithoutMeaning: anElement

	^self error: OOStack stackEmptyErrorDescription ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:01:38'!
printAnElementWithMeaning: anElement

	^store last value.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:02:21'!
printAnElementWithoutMeaning: anElement

	^self error: OOStack stackEmptyErrorDescription! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 21:54:48'!
push: something	
	
	|x|
	
	x := ElementWithMeaning with: something.
	
	store add: x. 	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'car 9/17/2019 00:25:51'!
size

	^store size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 9/17/2019 22:00:29'!
top

	|x|
	
	x := store last.
	
	^x giveMeTheElementOfTheTopOfTheStack: self! !

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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 03:21:35'!
find: prefix on: aStack
	
	|prefixes elements|
	
	(prefix = '') ifTrue:[ self signalPrefixEmptyErrorDescription ].
	
	prefixes := OrderedCollection new.
	
	elements  := OrderedCollection new.
	
	[aStack isEmpty not] whileTrue:[ |element| element := aStack pop.
					    		     (element value beginsWith: prefix ) ifTrue:[ prefixes add: element value. ].
								     elements add: element.
								   ].
							
	self restore: elements on: aStack.
	
	^prefixes.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 01:30:41'!
restore: elements on: aStack

	[elements isEmpty not] whileTrue:[
										 	aStack push: elements removeLast.
									     ].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 03:17:41'!
signalPrefixEmptyErrorDescription 

	self error: self class prefixEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'car 9/19/2019 03:01:15'!
prefixEmptyErrorDescription
	
	^ 'Prefix cannot be empty'! !
