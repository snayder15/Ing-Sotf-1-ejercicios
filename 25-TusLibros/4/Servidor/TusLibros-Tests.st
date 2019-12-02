!classDefinition: #CartTest category: #'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'car 11/25/2019 19:09:26'!
test09RemoveElementFromCart

	| cart |

	cart := testObjectsFactory createCart.

	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	cart remove: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 1! !

!CartTest methodsFor: 'tests' stamp: 'car 11/25/2019 19:12:02'!
test10CanNotRemoveItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore .
	self
		should: [ cart remove: testObjectsFactory itemNotSellByTheStore.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 1 ]! !

!CartTest methodsFor: 'tests' stamp: 'car 11/25/2019 19:14:50'!
test11CanNotRemoveItemsFromEmptyCart

	| cart |

	cart := testObjectsFactory createCart.
	self
		should: [ cart remove: testObjectsFactory itemSellByTheStore.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart emptyCartErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'car 11/25/2019 19:20:28'!
test12CanNotRemoveItemsThatDoNotBelongToCart

	| cart |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore .
	self
		should: [ cart remove: testObjectsFactory anotherItemSellByTheStore .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart notInCartErrorMessage.
			self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 1 ]! !

!CartTest methodsFor: 'tests' stamp: 'ns 12/2/2019 00:38:20'!
test13RemoveAllItems

	| cart |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore .
	cart removeAllItems.
	self assert: cart isEmpty.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ns 12/1/2019 16:54:35'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	self
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemFacadeTest category: #'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'car 11/21/2019 20:28:57'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) occurrencesOf: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'car 11/21/2019 20:29:06'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: testObjectsFactory invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'car 11/21/2019 20:29:15'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart ' stamp: 'car 11/21/2019 20:29:30'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'ns 11/23/2019 12:33:30'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory validUserPassword.

	self assert: ((purchases at: self validBook) at: 'total') equals: (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: ((purchases at: self anotherValidBook) at: 'total') equals: testObjectsFactory anotherItemSellByTheStorePrice.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'car 11/21/2019 20:29:57'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: testObjectsFactory invalidUser authenticatingWith: testObjectsFactory validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'car 11/21/2019 20:30:04'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'car 11/21/2019 20:25:33'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'car 11/21/2019 20:30:13'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: testObjectsFactory invalidUser authenticatedWith: testObjectsFactory validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'car 11/21/2019 20:30:17'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'car 11/21/2019 20:25:21'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: testObjectsFactory validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'ns 11/23/2019 12:32:36'!
test10CanCheckoutACart

	| cartId purchases |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory validUserPassword.

	self assert: ((purchases at: self validBook) at: 'total') equals: testObjectsFactory itemSellByTheStorePrice.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'car 11/21/2019 20:30:51'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: testObjectsFactory invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'car 11/21/2019 20:31:40'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			self assert: (systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'car 11/21/2019 20:31:34'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'car 11/21/2019 20:31:25'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self assert: (systemFacade listPurchasesOf: testObjectsFactory validUser authenticatingWith: testObjectsFactory validUserPassword) isEmpty ]


	! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'car 11/21/2019 20:31:52'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'car 11/21/2019 20:31:55'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: testObjectsFactory invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'car 11/21/2019 20:32:00'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent occurrencesOf: self validBook) equals: 1.
	self assert: (cartContent occurrencesOf: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'car 11/21/2019 20:32:10'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: testObjectsFactory validUser authenticatedWith: testObjectsFactory validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!classDefinition: #ManualClock category: #'TusLibros-Tests'!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore

	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore

	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice

	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart

	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ns 12/1/2019 16:51:50'!
defaultCatalog

	^ Dictionary new
		at: self itemSellByTheStore put:   (Dictionary new
		  	at: 'name' put: self itemSellByTheStore;
		 	 at: 'price' put:self itemSellByTheStorePrice;
		 	 at: 'src' put: '';
		  	at: 'author' put: 'test';
		    yourself);
		at: self anotherItemSellByTheStore put:    (Dictionary new
		  	at: 'name' put: self anotherItemSellByTheStore;
		 	 at: 'price' put:self anotherItemSellByTheStorePrice;
		 	 at: 'src' put: '';
		  	at: 'author' put: 'test';
		    yourself);
		yourself! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today

	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !

!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'car 11/21/2019 20:40:20'!
merchantProcessor

	^TusLibrosSystemFacadeTest new! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:48:48'!
createSalesBook

	^OrderedCollection new! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:27:57'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:27:32'!
invalidPassword

	^'invalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:27:19'!
invalidUser

	^'invalidUser'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:24:17'!
validUser

	^'validUser'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'car 11/21/2019 20:24:38'!
validUserPassword

	^'validUserPassword'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'ns 12/1/2019 17:06:15'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !
