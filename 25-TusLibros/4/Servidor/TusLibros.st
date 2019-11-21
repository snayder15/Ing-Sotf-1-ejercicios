!classDefinition: #CartTest category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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


!classDefinition: #RestInterfaceInternalPartTest category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'ns 11/15/2019 22:07:44'!
test11ListValidClientAndPasswordNoPurchases

	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	self assert: ((testRestInterface listPurchasesFor: self defaultClientId and: self defaultClientPassword) size) equals: 0.



! !

!RestInterfaceInternalPartTest methodsFor: 'test' stamp: 'ns 11/15/2019 22:07:50'!
test12ListValidClientAndPasswordOnePurchase

	| aCartID aClientId aClientPassword |

	aCartID := self defaultInterfaceCartId.
	aClientId := self defaultClientId.
	aClientPassword := self defaultClientPassword.


	testRestInterface linkMerchantProcessor: (MockMerchantProcessor debitWith: []).

	testRestInterface add: 'Valid item'  withQuantity: 1 to: aCartID.

	testRestInterface checkoutWith: aCartID and: self defaultCreditCard and: aClientId.

	self assert: ((testRestInterface listPurchasesFor: aClientId and: aClientPassword) size) equals: 1.



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


!classDefinition: #Cart category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:59:32'!
with: aSalesBook

	^ self new initializeWith: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'car 11/4/2019 20:14:30'!
with: aSalesBook using: aMerchantProcessor

	^ self new initializeWith: aSalesBook using: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'car 11/4/2019 19:34:34'!
withName: aName andNumber: aNumber andExpiration: aGregorianDate

	^ self new initializeWithName: aName andNumber: aNumber andExpiration: aGregorianDate.! !


!classDefinition: #MockClock category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!classDefinition: 'MockClock class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
MockClock class
	instanceVariableNames: ''!

!MockClock class methodsFor: 'instance creation' stamp: 'car 11/7/2019 20:26:08'!
create

	^ self new initialize ! !


!classDefinition: #MockMerchantProcessor category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
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

!classDefinition: 'MockMerchantProcessor class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'instance creation' stamp: 'car 11/11/2019 17:39:58'!
debitWith: aClosure

	^self new initializeDebitWith: aClosure
	
	! !


!classDefinition: #RestInterfaceInternalPart category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Object subclass: #RestInterfaceInternalPart
	instanceVariableNames: 'cartNumber cartDB clock cartClocks merchantProcessor clientPurchases clientDB'
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

!RestInterfaceInternalPart methodsFor: 'private' stamp: 'ns 11/18/2019 23:44:18'!
initializeInterfaceWith: aClock.

	cartNumber := 0.
	cartDB := Dictionary new.
	clientPurchases := Dictionary new.
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

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'ns 11/15/2019 22:07:06'!
checkoutWith: aCartID and: aCreditCard and: aClientId

	| clientPurchasesList aCart aTicket |
	
	self checkCartExpiration: aCartID.

	merchantProcessor debit.
	
	clientPurchasesList := clientPurchases at: aClientId ifAbsent: [OrderedCollection new].

	aCart := cartDB at: aCartID.
	
	aTicket := Ticket withProducts: aCart products andTotal: aCart getProductsTotalCost.

	clientPurchasesList add: aTicket.

	clientPurchases at: aClientId put: clientPurchasesList.
	
	^aTicket.! !

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

!RestInterfaceInternalPart methodsFor: 'Interface' stamp: 'ns 11/15/2019 22:03:00'!
listPurchasesFor: aClientId and: aClientPassword
	
	self checkClientInformationWith: aClientId and: aClientPassword.
	^ clientPurchases at: aClientId ifAbsent: [OrderedCollection new].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceInternalPart class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
RestInterfaceInternalPart class
	instanceVariableNames: 'cartNumber cartDB'!

!RestInterfaceInternalPart class methodsFor: 'instance creation' stamp: 'car 11/7/2019 20:27:58'!
createInterfaceWith: aClock

	^ self new initializeInterfaceWith: aClock.! !


!classDefinition: #RestInterfaceInternalServer category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Object subclass: #RestInterfaceInternalServer
	instanceVariableNames: 'restInterface port webServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/19/2019 22:01:32'!
add: anItem  withQuantity: aQuantity to: aCartID

	[
		restInterface add: anItem  withQuantity: aQuantity to: aCartID.
		^'0|OK|'.
	] 
	on: Error 
	do: [ :anError |
		^ self errorWithMessage: anError messageText.].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:01:19'!
create200ResponseWith: aClosure and: aRequest
		| responseAsJson |

		responseAsJson := WebUtils jsonEncode: (aClosure value).
		aRequest send200Response: (responseAsJson asUtf8) 
		contentType: 'application/json; charset=utf-8' do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/19/2019 22:02:22'!
createCart
	| aCartId |.
	
	[
		aCartId := restInterface createCart.
		^'0|', aCartId.
	] 
	on: Error 
	do: [ :anError |
		^ self errorWithMessage: anError messageText].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:43:57'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/19/2019 22:02:07'!
errorWithMessage: anErrorMessage

	^ '1|', anErrorMessage.! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:26:12'!
getListFor: aList
	| products listResult productQuantity |
	products := Dictionary new.
	listResult := '0'.
	aList do: [
		:anItem | 
		productQuantity := products at: anItem ifAbsent: 0.
		products at: anItem put: (productQuantity + 1).
	].
	products keysDo: [:aProduct | listResult := listResult, '|', aProduct , '|' products at: aProduct].
	^ listResult.! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:15:51'!
initializeWith: aPortNumber
	
	restInterface := RestInterfaceInternalPart new.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	webServer addService: '/createCart' action:[:request | | responseAsJson cartId clientId password |
	
	[
		clientId := request fields at: 'clientId'.
		password := request fields at: 'password'.
		restInterface checkClientInformationWith: clientId and: password.
		self create200ResponseWith: [self createCart] and: request.
	 ]
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].


	webServer addService: '/addToCart' action:[:request | | bookIsbn bookQuantity cartId |
	
	[	cartId := request fields at: 'cartId'.
		bookIsbn := request fields at: 'bookIsbn'.
		bookQuantity := request fields at: 'bookQuantity'.
		"TODO VALIDAR PARAMETROS"
		self create200ResponseWith: [self add: bookIsbn withQuantity: bookQuantity to: cartId] and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].


	webServer addService: '/listCart' action:[:request | | cartId |
	
	[
		cartId := request fields at: 'cartId'.
		self create200ResponseWith: [self listCart: cartId] and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].

	webServer addService: '/checkoutCart' action:[:request | | cartId ccn cced cco |
	
	[	cartId := request fields at: 'cartId'.
		ccn := request fields at: 'ccn'.
		cced := request fields at: 'cced'.
		cco := request fields at: 'cco'.
		"TODO VALIDAR PARAMETROS Y HACER EL METODO CHECKOUT"
		self create200ResponseWith: [self checkout] and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].


	webServer addService: '/listPurchases' action:[:request | | clientId password |
	
	[	clientId := request fields at: 'clientId'.
		password := request fields at: 'password'.
		restInterface checkClientInformationWith: clientId and: password.
		self create200ResponseWith: [self listPurchasesFor: clientId and: password] and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (anError messageText) ]].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:26:57'!
listCart: aCartID
	| cartProducts |
	[
		cartProducts := restInterface listCart: aCartID.
		self getListFor: cartProducts.
	] 
	on: Error 
	do: [ :anError |
		^ self errorWithMessage: anError messageText.].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:31:12'!
listPurchasesFor: aClientId and: aClientPassword

	| purchases purchasesTotal ticketProducts |
	
	[
		purchases := restInterface listPurchasesFor: aClientId and: aClientPassword. 
		purchasesTotal := 0.
		ticketProducts := OrderedCollection new.
		purchases do: [
			"para cada ticket"
			:aTicket |
			purchasesTotal := purchasesTotal + aTicket total.
			ticketProducts addAll: aTicket products.
		].
		^ self getListFor: ticketProducts, '|', purchasesTotal asString.
	] 
	on: Error 
	do: [ :anError |
		^ self errorWithMessage: anError messageText.].
	
	! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:42:52'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:43:03'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.! !

!RestInterfaceInternalServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:42:57'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceInternalServer class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
RestInterfaceInternalServer class
	instanceVariableNames: ''!

!RestInterfaceInternalServer class methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:41:27'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #Ticket category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Object subclass: #Ticket
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'as yet unclassified' stamp: 'ns 11/15/2019 21:58:52'!
initializewithProducts: products andTotal: aTotal

	total := aTotal.
	items := products.! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'ns 11/19/2019 22:32:02'!
products

	^ items.! !

!Ticket methodsFor: 'as yet unclassified' stamp: 'ns 11/20/2019 23:18:29'!
total

	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros stamp: 'ns 11/20/2019 23:34:26'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'as yet unclassified' stamp: 'ns 11/15/2019 21:58:30'!
withProducts: products andTotal: aTotal

	^ self new initializewithProducts: products andTotal: aTotal! !
