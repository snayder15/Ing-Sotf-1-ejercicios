!classDefinition: #CartTest category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'hasDebit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'car 11/11/2019 20:44:24'!
defaultCart

	| aCatalog |
	
	aCatalog := Dictionary new.
	
	aCatalog add: 'itemA'->10; add: 'itemB'->3.
	
	^ Cart acceptingItemsOf: aCatalog.
	
	! !

!CashierTest methodsFor: 'support' stamp: 'car 11/11/2019 17:57:12'!
defaultCashierWith: anAction
	| mockMerchantProcessor |

	mockMerchantProcessor := MockMerchantProcessor debitWith: anAction.	

	^ Cashier with: OrderedCollection new using: mockMerchantProcessor .! !

!CashierTest methodsFor: 'support' stamp: 'car 11/4/2019 19:42:57'!
defaultCreditCard
	
	^ CreditCard withName: 'Juan Lopez' andNumber: 1234567891234567 andExpiration: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 4).! !


!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:44:16'!
test01CheckoutWithEmptyCart

	| aCashier |
	
	aCashier := self defaultCashierWith: [].
		
	self should: [aCashier checkoutWith: (self defaultCart) and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [
		:anError | 
			self assert: anError messageText equals: 'Cannot do checkout from an empty cart'.
			self deny: (aCashier didSell: 0).
		]! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:44:42'!
test02CheckoutWithCartWithOneItem

	| aCashier aCart |	

	aCashier := self defaultCashierWith: [].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	
	self deny: aCart isEmpty.	

	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 10.  
	
	self assert: aCart isEmpty.! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:45:01'!
test03CheckoutWithValidCreditCard

	| aCashier aCart |

	aCashier := self defaultCashierWith: [].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	
	self deny: aCart isEmpty.	

	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 10.  
	
	self assert: aCart isEmpty.! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:45:14'!
test04CheckoutWithExpiredCreditCard

	| aCashier aCart dateToCheck |

	dateToCheck := FixedGregorianDate fromDate: (Date newDay: 12 month: #December year: 2021).
	
	aCashier := self defaultCashierWith: [].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	
	self should: [aCashier checkoutWith: aCart and: self defaultCreditCard on: dateToCheck]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [
		:anError | 
			self assert: anError messageText equals: 'Credit Card is expired'
		]! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:45:26'!
test05CheckoutWithValidCreditCardMultipleItems

	| aCashier aCart |

	aCashier := self defaultCashierWith: [].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.  
	
	self assert: aCart isEmpty.
! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:45:39'!
test06CheckoutWithValidCreditCardMultipleItemsAndRegisterCheckout

	| aCashier aCart |

	aCashier := self defaultCashierWith: [].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.
	
	self assert: (aCashier didSell: 13).
	
	self assert: aCart isEmpty.
! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:45:52'!
test07CheckoutWithOkFromMerchantProcessor

	| aCashier aCart |

	aCashier := self defaultCashierWith: [hasDebit := true].
	
	aCart := self defaultCart.
	
	aCart add: 'itemA'.
	aCart add: 'itemB'.
	
	self assert: (aCashier checkoutWith: aCart and: self defaultCreditCard on: (FixedGregorianDate fromDate: Date today)) equals: 13.
	
	self assert: (aCashier didSell: 13).
	
	self assert: aCart isEmpty.

	self assert: hasDebit! !

!CashierTest methodsFor: 'test' stamp: 'car 11/11/2019 20:46:05'!
test08CheckoutWithErrorFromMerchantProcessor

	| aCashier aCart |

	aCashier := self defaultCashierWith: [self class error: 'Error'].
	
	aCart := self defaultCart.
	
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


!classDefinition: #RestInterfaceInternalPartTest category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
TestCase subclass: #RestInterfaceInternalPartTest
	instanceVariableNames: 'testRestInterface mockClock hasDebit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceInternalPartTest methodsFor: 'support' stamp: 'car 11/11/2019 18:34:36'!
defaultClientId
	
	^ 'Test Client ID'! !

!RestInterfaceInternalPartTest methodsFor: 'support' stamp: 'car 11/11/2019 18:35:05'!
defaultClientPassword
	
	^ 'Test password'! !

!RestInterfaceInternalPartTest methodsFor: 'support' stamp: 'car 11/7/2019 21:15:00'!
defaultCreditCard
	
	^ CreditCard withName: 'Juan Lopez' andNumber: 1234567891234567 andExpiration: (GregorianMonthOfYear yearNumber: 2020 monthNumber: 4).! !

!RestInterfaceInternalPartTest methodsFor: 'support' stamp: 'car 11/11/2019 20:47:30'!
defaultInterfaceCartId
	
	^ testRestInterface createCartWith: self defaultClientId and: self defaultClientPassword! !


!RestInterfaceInternalPartTest methodsFor: 'setup' stamp: 'car 11/11/2019 20:52:57'!
setUp

	mockClock := MockClock create.

	testRestInterface := RestInterfaceInternalPart createInterfaceWith: mockClock.
	
	testRestInterface register: self defaultClientId with: self defaultClientPassword.
	
	hasDebit := false.! !


!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:47:30'!
test01ListEmptyCart

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	self assert: (testRestInterface listCart: aCartID) size equals: 0! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:47:30'!
test02ListCartWithOneItem

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	self assert: (testRestInterface listCart: aCartID) size equals: 1! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 19:09:04'!
test03ListInvalidCart


	self should: [testRestInterface listCart: 80 ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo:[:anError | 
			self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:47:30'!
test04ListExpiredCart

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	mockClock addMinutes: 31.

	self should: [testRestInterface listCart: aCartID ] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo:[:anError | 
			self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:47:30'!
test05ListCartWithMoreThanOneElement

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	testRestInterface add: 'Valid item B'  withQuantity: 5 to: aCartID.

	self assert: (testRestInterface listCart: aCartID) size equals: 6! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:47:30'!
test06AddToExpiredCart

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	mockClock addMinutes: 29.

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	mockClock addMinutes: 3.

	self should: [testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Cart ID is invalid'.] 

! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:53:58'!
test07AddToInvalidCart

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: [hasDebit := true]).
	
	self should: [testRestInterface add: 'Valid item'  withQuantity: 1 to: 'Invalid Cart'.] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Cart ID is invalid'.				
				]
! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:50:29'!
test08CheckoutCartWithOneElement

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: [hasDebit := true]).

	testRestInterface checkoutWith: aCartID and: self defaultCreditCard and: self defaultClientId.

	self assert: hasDebit.

! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:50:14'!
test09CheckoutExpiredCart

	| aCartID |

	aCartID := self defaultInterfaceCartId.

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	mockClock addMinutes: 31.

	self should: [testRestInterface checkoutWith: aCartID and: self defaultCreditCard and: self defaultClientId ] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Cart ID is invalid'.] 



! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:58'!
test10CheckoutInvalidCart

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	self should: [testRestInterface checkoutWith: 'Invalid cart' and: self defaultCreditCard and: self defaultClientId ] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Cart ID is invalid'.
				self deny: hasDebit.
				] 



! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:53'!
test11ListValidClientAndPasswordNoPurchases

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	self assert: ((testRestInterface listPurchasesFor: self defaultClientId and: self defaultClientPassword) keys size) equals: 0.



! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:47'!
test12ListValidClientAndPasswordOnePurchase

	| aCartID aClientId aClientPassword |

	aCartID := self defaultInterfaceCartId.
	aClientId := self defaultClientId.
	aClientPassword := self defaultClientPassword.


	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	testRestInterface checkoutWith: aCartID and: self defaultCreditCard and: aClientId.

	self assert: ((testRestInterface listPurchasesFor: aClientId and: aClientPassword) keys size) equals: 1.



! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:42'!
test13ListValidClientInvalidPasswordPurchases

	| aClientId aClientPassword |

	aClientId := self defaultClientId.
	aClientPassword := self defaultClientPassword.
	
	testRestInterface  register: aClientId with: aClientPassword , 'test'.
	
	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	self should: [testRestInterface listPurchasesFor: aClientId and: aClientPassword] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Invalid Client ID or Password'.] 


! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:36'!
test14ListInvalidClientPurchases

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	self should: [testRestInterface listPurchasesFor: 'Invalid Client' and: self defaultClientPassword] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Invalid Client ID or Password'.] 


! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:22'!
test15CreateCartInvalidClient

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).	

	self should: [testRestInterface createCartWith: 'Invalid Client' and: 'Any password'] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Invalid Client ID or Password'.] 


! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'car 11/11/2019 20:57:02'!
test16CreateCartInvalidPassword

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).	

	self should: [testRestInterface createCartWith: self defaultClientId and: 'Any password'] 
			raise:  Error - MessageNotUnderstood 
			withExceptionDo:[:anError | 
				self assert: anError messageText equals: 'Invalid Client ID or Password'.] 


! !


!classDefinition: #Cart category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'car 11/4/2019 20:14:48'!
initializeWith: aSalesBook using: aMerchantProcessor

	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'car 11/4/2019 21:34:59'!
checkoutWith: aCart and: aCreditCard on: aDate
	
	| cartTotal |
	(aCart isEmpty ) ifTrue: [Cashier error: 'Cannot do checkout from an empty cart'].	
	(aCreditCard isExpiredOn: aDate ) ifTrue: [Cashier error: 'Credit Card is expired'].	
	cartTotal := aCart getProductsTotalCost.
	
	merchantProcessor debit.
	
	aCart emptyCart.
	salesBook add: cartTotal.
	^ cartTotal.! !


!Cashier methodsFor: 'queries' stamp: 'car 11/4/2019 19:59:11'!
didSell: aSale

	^ salesBook includes: aSale! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:59:32'!
with: aSalesBook

	^ self new initializeWith: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 20:14:30'!
with: aSalesBook using: aMerchantProcessor

	^ self new initializeWith: aSalesBook using: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'queries' stamp: 'car 11/4/2019 19:39:45'!
isExpiredOn: aDate
	| dateYear dateMonth |
	dateYear := aDate year.
	dateMonth := aDate month.
	^ expirationDate year < dateYear or: (expirationDate year = dateYear and: expirationDate month < dateMonth).		
	! !


!CreditCard methodsFor: 'initialization' stamp: 'car 11/4/2019 19:30:50'!
initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.

	name := aName.
	number := aNumber.
	expirationDate := aGregorianDate.	! !


!CreditCard methodsFor: 'accessing' stamp: 'car 11/4/2019 20:17:51'!
expiration

	^ expirationDate
	! !

!CreditCard methodsFor: 'accessing' stamp: 'car 11/4/2019 20:17:35'!
name

	^ name
	! !

!CreditCard methodsFor: 'accessing' stamp: 'car 11/4/2019 20:18:02'!
number

	^ number
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:34:34'!
withName: aName andNumber: aNumber andExpiration: aGregorianDate

	^ self new initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.! !


!classDefinition: #MockClock category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Object subclass: #MockClock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockClock methodsFor: 'initialization' stamp: 'car 11/7/2019 20:26:28'!
initialize

	time := 0.! !


!MockClock methodsFor: 'accessing' stamp: 'car 11/7/2019 20:27:22'!
getTime

	^time ! !


!MockClock methodsFor: 'adding' stamp: 'car 11/7/2019 20:27:05'!
addMinutes: aQuantity

	time := time + aQuantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockClock class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
MockClock class
	instanceVariableNames: ''!

!MockClock class methodsFor: 'instance creation' stamp: 'car 11/7/2019 20:26:08'!
create

	^ self new initialize ! !


!classDefinition: #MockMerchantProcessor category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Object subclass: #MockMerchantProcessor
	instanceVariableNames: 'behavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockMerchantProcessor methodsFor: 'debit' stamp: 'car 11/11/2019 17:43:47'!
debit
	
	behavior value! !


!MockMerchantProcessor methodsFor: 'initialization' stamp: 'car 11/11/2019 17:40:40'!
initializeDebitWith: aClosure

	behavior := aClosure 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'instance creation' stamp: 'car 11/11/2019 17:39:58'!
debitWith: aClosure

	^self new initializeDebitWith: aClosure
	
	! !


!classDefinition: #RestInterfaceInternalPart category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
Object subclass: #RestInterfaceInternalPart
	instanceVariableNames: 'cartNumber cartDB clock cartClocks merchantProcessor clientPurchases clientsPurchasesTotals clientDB'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'car 11/11/2019 18:26:17'!
checkCartExpiration: aCartId
	| now aCartTime |
	now := clock getTime.
	aCartTime := cartClocks at: aCartId ifAbsent:  [^ RestInterfaceInternalPart error: 'Cart ID is invalid'].
	now - aCartTime > 30 ifTrue: [
		^ RestInterfaceInternalPart error: 'Cart ID is invalid'
	].! !

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'car 11/11/2019 19:26:59'!
checkClientInformationWith: aClientId and: aClientPassword
	
	| clientPassword |
	
	clientPassword := clientDB at: aClientId ifAbsent: [^ self class error: 'Invalid Client ID or Password'].
	
	clientPassword = aClientPassword ifFalse: [^ self class error: 'Invalid Client ID or Password'].! !

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'car 11/11/2019 21:01:19'!
initializeInterfaceWith: aClock.

	cartNumber := 0.
	cartDB := Dictionary new.
	clientPurchases := Dictionary new.
	clientsPurchasesTotals := Dictionary new.
	clientDB := Dictionary new.
	clock := aClock .
	cartClocks := Dictionary new.! !

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'car 11/11/2019 18:09:51'!
linkMerchantProcessor: aMerchantProcessor

	merchantProcessor := aMerchantProcessor 

	! !

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'car 11/11/2019 19:07:04'!
register: aClientId with: aPassword

	clientDB at: aClientId put: aPassword.! !


!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'car 11/11/2019 21:00:20'!
add: anItem  withQuantity: aQuantity to: aCartID

	|aCart |
	
	self checkCartExpiration: aCartID.
	
	aCart := cartDB at: aCartID.
	
	aCart add: aQuantity of: anItem! !

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'car 11/11/2019 18:58:34'!
checkoutWith: aCartID and: aCreditCard and: aClientId

	| clientPurchasesQty aCart anItemQty clientPurchasesAmount |
	
	self checkCartExpiration: aCartID.

	merchantProcessor debit.
	
	clientPurchasesQty := clientPurchases at: aClientId ifAbsent: [Dictionary new].

	aCart := cartDB at: aCartID ifAbsent: [].
	
	aCart products do: [
		:anItem |
			anItemQty := clientPurchasesQty at: anItem ifAbsent: [0].
			clientPurchasesQty at: anItem put: anItemQty + 1.
	].

	clientPurchases at: aClientId put: clientPurchasesQty.

	clientPurchasesAmount := clientsPurchasesTotals at: aClientId ifAbsent: [0].
	clientsPurchasesTotals at: aClientId put: clientPurchasesAmount  + (aCart getProductsTotalCost).! !

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'car 11/11/2019 19:29:10'!
createCartWith: aClientId and: aClientPassword
	
	| catalog |
	
	self checkClientInformationWith: aClientId  and: aClientPassword.
	
	catalog := Dictionary new.
	catalog add: 'Valid item'->10; add: 'Valid item B'->8.

	cartDB at: cartNumber put: (Cart acceptingItemsOf: catalog).
	cartClocks at: cartNumber put: (clock getTime).	
	^ cartNumber.! !

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'car 11/11/2019 18:27:04'!
listCart: aCartId
	
	| aCart |
	
	self checkCartExpiration: aCartId.
	
	aCart := cartDB at: aCartId ifAbsent: [].
	
	^ aCart products.! !

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'car 11/11/2019 19:28:08'!
listPurchasesFor: aClientId and: aClientPassword
	
	self checkClientInformationWith: aClientId and: aClientPassword.
	^ clientPurchases at: aClientId ifAbsent: [Dictionary new].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceInternalPart class' category: #TusLibros stamp: 'car 11/14/2019 21:50:27'!
RestInterfaceInternalPart class
	instanceVariableNames: 'cartNumber cartDB'!

!RestInterfaceInternalPart class methodsFor: 'instance creation' stamp: 'car 11/7/2019 20:27:58'!
createInterfaceWith: aClock

	^ self new initializeInterfaceWith: aClock.! !
