!classDefinition: #CartTest category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
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


!classDefinition: #Cart category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:59:32'!
with: aSalesBook

	^ self new initializeWith: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 20:14:30'!
with: aSalesBook using: aMerchantProcessor

	^ self new initializeWith: aSalesBook using: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'car 11/4/2019 21:40:03'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'car 11/4/2019 19:34:34'!
withName: aName andNumber: aNumber andExpiration: aGregorianDate

	^ self new initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.! !
