!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 19:48:01'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self evaluateThe: [customerBook addCustomerNamed: 'John Lennon'.]   AndResultConditionLess: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 19:48:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self evaluateThe: [customerBook removeCustomerNamed: paulMcCartney.]   AndResultConditionLess: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/2/2019 20:57:23'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self closureFail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 19:45:58'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self closureFail ]
		on: NotFound 
		do: [ :anError | 
			self theCustomer: johnLennon BelongTo: customerBook AndtotalCustomersInTheCustomerBookIs: 1 ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 18:44:37'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerAndSupend: paulMcCartney.
	
	self notActiveCustomersAndExistsACustomerSuspendedAndIsTheOnlyCustomerOfThe: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 18:42:55'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerAndSupend: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self notActiveCustomersAndNotACustomerSuspendedAndEmpty: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 19:46:05'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self closureFail ]
		on: CantSuspend 
		do: [ :anError | 
			self theCustomer: johnLennon BelongTo: customerBook AndtotalCustomersInTheCustomerBookIs: 1 ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'car 9/7/2019 19:46:14'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerAndSupend: johnLennon.

	
	[ customerBook suspendCustomerNamed: johnLennon.
	self closureFail ]
		on: CantSuspend 
		do: [ :anError | 
			self theCustomer: johnLennon BelongTo: customerBook AndtotalCustomersInTheCustomerBookIs: 1 ]
! !


!CustomerBookTest methodsFor: 'closureErrorMessages' stamp: 'car 9/2/2019 20:56:41'!
closureFail

	self fail! !


!CustomerBookTest methodsFor: 'testingNotActiveCustomers' stamp: 'car 9/5/2019 21:27:33'!
notActiveCustomersAndExistsACustomerSuspendedAndIsTheOnlyCustomerOfThe:  customerBook

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'testingNotActiveCustomers' stamp: 'car 9/7/2019 14:49:00'!
notActiveCustomersAndNotACustomerSuspendedAndEmpty:  customerBook

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.! !


!CustomerBookTest methodsFor: 'testingTimeLimitToEvaluateTheClosure' stamp: 'car 9/7/2019 19:47:29'!
evaluateThe: closure   AndResultConditionLess: time 

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time * millisecond)
	! !


!CustomerBookTest methodsFor: 'testingTheCustomerIsInTheCustomer BookAndIsTheOnlyOne ' stamp: 'car 9/7/2019 19:45:36'!
theCustomer: name BelongTo: customerBook AndtotalCustomersInTheCustomerBookIs: number 

	self assert: customerBook numberOfCustomers = number.
	self assert: (customerBook includesCustomerNamed: name)! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'car 9/7/2019 19:55:26'!
AreThereNoCustomersActive

	^active isEmpty! !

!CustomerBook methodsFor: 'testing' stamp: 'car 9/7/2019 19:55:14'!
AreThereNoCustomersSuspeded

	^suspended isEmpty! !

!CustomerBook methodsFor: 'testing' stamp: 'car 9/7/2019 20:03:15'!
includesCustomerNamed: aName

	^(self IsCustomerIncludedInTheActiveCustomerBook: aName) 
		or: [ self IsCustomerIncludedInTheSuspendedCustomerBook: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'car 9/7/2019 19:55:39'!
isEmpty
	
	^ self AreThereNoCustomersActive and: [ self AreThereNoCustomersSuspeded ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 20:01:11'!
IsCustomerIncludedInTheActiveCustomerBook: aName

	^active includes: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 20:01:22'!
IsCustomerIncludedInTheSuspendedCustomerBook: aName

	^suspended includes: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 17:55:50'!
addCustomerActive: aName

	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 18:46:01'!
addCustomerAndSupend:  aName

	self addCustomerNamed: aName.
	self suspendCustomerNamed: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 20:02:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((self IsCustomerIncludedInTheActiveCustomerBook: aName) 
		or: [self IsCustomerIncludedInTheSuspendedCustomerBook: aName]) 
		ifTrue: [ self signalCustomerAlreadyExists ].
	
	self addCustomerActive: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 18:01:04'!
addCustomerSuspended: aName

	suspended add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 16:19:10'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 17:41:29'!
removeActiveCustomerNamed: aName
	|index|

	index _ active findFirst: [:customer | customer = aName].
	active removeAt: index! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 18:06:47'!
removeCustomerNameThatExistsEnActiveCustomers: aName

	active remove: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 20:02:08'!
removeCustomerNamed: aName 
 
	(self IsCustomerIncludedInTheActiveCustomerBook: aName) 
		ifTrue: [self removeActiveCustomerNamed: aName. ^aName].
	(self IsCustomerIncludedInTheSuspendedCustomerBook: aName) 
		ifTrue: [self removeSuspendedCustomerNamed: aName. ^aName].
	^ NotFound signal.
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 17:43:08'!
removeSuspendedCustomerNamed: aName
	|index|

	index _ suspended findFirst: [:customer | customer = aName].
	suspended removeAt: index! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'car 9/7/2019 20:01:36'!
suspendCustomerNamed: aName 
	
	(self IsCustomerIncludedInTheActiveCustomerBook: aName) ifFalse: [^CantSuspend signal].
	
	self removeCustomerNameThatExistsEnActiveCustomers: aName.
	
	self addCustomerSuspended: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
