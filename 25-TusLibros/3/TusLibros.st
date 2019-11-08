!classDefinition: #CartTest category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'car 11/4/2019 19:01:34'!
defaultCatalog
	| catalog |
	
	catalog := Dictionary new.
	catalog add: 'validBook'->10.
	^ catalog.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'hasDebit action'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 21:35:41'!
debit
	
	action value! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 21:35:53'!
debitWith: anAction
	
	action := anAction! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 21:31:40'!
defaultCashier		
	
	^ Cashier with: OrderedCollection new using: self.! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 19:42:57'!
defaultCreditCard
	
	^ CreditCard withName: 'Juan Lopez' andNumber: 1234567891234567 andExpiration: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 4).! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:43:02'!
test01CheckoutWithEmptyCart

	| aCashier aCatalogo |
	aCatalogo := Dictionary new.
	
	aCatalogo add: 'itemA'->10; add: 'itemB'->3.
	aCashier := self defaultCashier.
		
	self should: [aCashier checkoutWith: (Cart acceptingItemsOf: aCatalogo) and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [
		:anError | 
			self assert: anError messageText equals: 'Cannot do checkout from an empty cart'.
			self deny: (aCashier didSell: 0).
		]! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:01:35'!
test02CheckoutWithCartWithOneItem

	| aCashier aCatalogo aCart |
	aCatalogo := Dictionary new.
	
	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	
	self deny: aCart isEmpty.	

	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 10.  
	
	self assert: aCart isEmpty.! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:01:40'!
test03CheckoutWithValidCreditCard

	| aCashier aCatalogo aCart |
	aCatalogo := Dictionary new.

	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	
	self deny: aCart isEmpty.	

	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 10.  
	
	self assert: aCart isEmpty.! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:01:47'!
test04CheckoutWithExpiredCreditCard

	| aCashier aCatalogo aCart dateToCheck |
	aCatalogo := Dictionary new.
	dateToCheck := FixedGregorianDate fromDate: (Date newDay: 12 month: #December year: 2021).
	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	
	self should: [aCashier checkoutWith: aCart and: self defaultCreditCard on: dateToCheck]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [
		:anError | 
			self assert: anError messageText equals: 'Credit Card is expired'
		]! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:01:51'!
test05CheckoutWithValidCreditCardMultipleItems

	| aCashier aCatalogo aCart |
	aCatalogo := Dictionary new.

	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.  
	
	self assert: aCart isEmpty.
! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 20:01:55'!
test06CheckoutWithValidCreditCardMultipleItemsAndRegisterCheckout

	| aCashier aCatalogo aCart |
	aCatalogo := Dictionary new.

	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.
	
	self assert: (aCashier didSell: 13).
	
	self assert: aCart isEmpty.
! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 21:39:08'!
test07CheckoutWithOkFromMerchantProcessor

	| aCashier aCatalogo aCart |
	self debitWith: [hasDebit := true].

	aCatalogo := Dictionary new.	
	
	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier.
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.
	
	self assert: (aCashier didSell: 13).
	
	self assert: aCart isEmpty.

	self assert: hasDebit! !

!CashierTest methodsFor: 'test' stamp: 'car 11/4/2019 21:38:49'!
test08CheckoutWithErrorFromMerchantProcessor

	| aCashier aCatalogo aCart |
	
	self debitWith: [self class error: 'Error'].
	
	aCatalogo := Dictionary new.	
	
	aCatalogo add: 'itemA'->10; add: 'itemB'->3.

	aCashier := self defaultCashier .
	
	aCart := Cart acceptingItemsOf: (aCatalogo).
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self should: [aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [
		:anError | 
			self assert: anError messageText equals: 'Error'.
			self deny: (aCashier didSell: 13).
			self deny: aCart isEmpty.
		].
	
	
	
! !


!classDefinition: #RestInterfaceInternalPartTest category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
TestCase subclass: #RestInterfaceInternalPartTest
	instanceVariableNames: 'testRestInterface mockClock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 21:15:00'!
defaultCreditCard
	
	^ CreditCard withName: 'Juan Lopez' andNumber: 1234567891234567 andExpiration: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 4).! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:39:08'!
setUp

mockClock := MockClock create.

testRestInterface := RestInterfaceInternalPart createInterfaceWith: mockClock.! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:39:47'!
test01ListEmptyCart

| aCartID |

aCartID := testRestInterface createCart.

self assert: (testRestInterface listCart: aCartID) size equals: 0! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:40:01'!
test02ListCartWithOneItem

| aCartID |

aCartID := testRestInterface createCart.

testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

self assert: (testRestInterface listCart: aCartID) size equals: 1! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:40:10'!
test03ListInvalidCart


self should: [testRestInterface listCart: 80 ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo:[:anError | 
			self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:40:27'!
test04ListExpiredCart

| aCartID |

aCartID := testRestInterface createCart.

mockClock addMinutes: 31.

self should: [testRestInterface listCart: aCartID ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo:[:anError | 
			self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:51:29'!
test05AddToExpiredCart

| aCartID |

aCartID := testRestInterface createCart.

mockClock addMinutes: 29.

testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

mockClock addMinutes: 3.

self should: [testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo:[:anError | 
			self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 21:09:12'!
test06ListCartWithMoreThanOneElement

| aCartID |

aCartID := testRestInterface createCart.

testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

testRestInterface add: 'Valid item B'  withQuantity: 5 to: aCartID.

self assert: (testRestInterface listCart: aCartID) size equals: 6! !


!classDefinition: #Cart category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'car 11/4/2019 19:02:44'!
assertIsValidItem: anItem

	catalog at: anItem ifAbsent: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'car 11/4/2019 19:03:40'!
getProductsTotalCost 
	
	^ items inject: 0 into: [
		:total :item | 
		catalog at: item ifAbsent: [^ Cashier error: 'Item not in Catalog'].
		total + (catalog at: item).
	].! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'car 11/7/2019 19:42:29'!
products 
	
	^ items.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'adding' stamp: 'car 11/4/2019 18:55:30'!
emptyCart

	items := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Cashier methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 21:34:59'!
checkoutWith: aCart and: aCreditCard on: aDate
	
	| cartTotal |
	(aCart isEmpty ) ifTrue: [Cashier error: 'Cannot do checkout from an empty cart'].	
	(aCreditCard isExpiredOn: aDate ) ifTrue: [Cashier error: 'Credit Card is expired'].	
	cartTotal := aCart getProductsTotalCost.
	
	merchantProcessor debit.
	
	aCart emptyCart.
	salesBook add: cartTotal.
	^ cartTotal.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:59:11'!
didSell: aSale

	^ salesBook includes: aSale! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:59:24'!
initializeWith: aSalesBook

	salesBook := aSalesBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 20:14:48'!
initializeWith: aSalesBook using: aMerchantProcessor

	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:59:32'!
with: aSalesBook

	^ self new initializeWith: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 20:14:30'!
with: aSalesBook using: aMerchantProcessor

	^ self new initializeWith: aSalesBook using: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 20:17:51'!
expiration

	^ expirationDate
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:30:50'!
initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.

	name := aName.
	number := aNumber.
	expirationDate := aGregorianDate.	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:39:45'!
isExpiredOn: aDate
	| dateYear dateMonth |
	dateYear := aDate year.
	dateMonth := aDate month.
	^ expirationDate year < dateYear or: (expirationDate year = dateYear and: expirationDate month < dateMonth).		
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 20:17:35'!
name

	^ name
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 20:18:02'!
number

	^ number
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:34:34'!
withName: aName andNumber: aNumber andExpiration: aGregorianDate

	^ self new initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.! !


!classDefinition: #MockClock category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Object subclass: #MockClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockClock methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:27:05'!
addMinutes: aQuantity

	time := time + aQuantity ! !

!MockClock methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:27:22'!
getTime

	^time ! !

!MockClock methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:26:28'!
initialize

	time := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockClock class' category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
MockClock class
	instanceVariableNames: ''!

!MockClock class methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:26:08'!
create

	^ self new initialize ! !


!classDefinition: #RestInterfaceInternalPart category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
Object subclass: #RestInterfaceInternalPart
	instanceVariableNames: 'cartNumber cartDB clock cartClocks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:53:26'!
add: anItem  withQuantity: aQuantity to: aCartID

	|aCart |
	
	self checkCartExpiration: aCartID.
	
	aCart := cartDB at: aCartID ifAbsent: [^ RestInterfaceInternalPart error: 'Cart ID is invalid'].
	
	aCart add: aQuantity of: anItem! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:53:05'!
checkCartExpiration: aCartId
	| now aCartTime |
	now := clock getTime.
	aCartTime := cartClocks at: aCartId ifAbsent:  [^ RestInterfaceInternalPart error: 'Cart ID is invalid'].
	now - aCartTime > 30 ifTrue: [
		cartDB removeKey: aCartId.
		cartClocks removeKey: aCartId.
	].! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 21:21:07'!
checkOutCart: aSmallInteger with: aCreditCard 
	self shouldBeImplemented.! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 21:08:46'!
createCart
	| catalog |
	catalog := Dictionary new.
	catalog add: 'Valid item'->10; add: 'Valid item B'->8.

	cartDB at: cartNumber put: (Cart acceptingItemsOf: catalog).
	cartClocks at: cartNumber put: (clock getTime).	
	^ cartNumber.! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 19:33:59'!
initializeInterface

	cartNumber := 0.
	cartDB := Dictionary new.! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:35:51'!
initializeInterfaceWith: aClock.

	self initializeInterface .
	clock := aClock .
	cartClocks := Dictionary new.! !

!RestInterfaceInternalPart methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:54:51'!
listCart: aCartId
	
	| aCart |
	
	self checkCartExpiration: aCartId.
	
	aCart := cartDB at: aCartId ifAbsent: [^ RestInterfaceInternalPart error: 'Cart ID is invalid'].
	
	^ aCart products.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceInternalPart class' category: #TusLibros stamp: 'car 11/7/2019 21:53:22'!
RestInterfaceInternalPart class
	instanceVariableNames: 'cartNumber cartDB'!

!RestInterfaceInternalPart class methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 19:37:04'!
createInterface

	^ self new initializeInterface.! !

!RestInterfaceInternalPart class methodsFor: 'as yet unclassified' stamp: 'car 11/7/2019 20:27:58'!
createInterfaceWith: aClock

	^ self new initializeInterfaceWith: aClock.! !
