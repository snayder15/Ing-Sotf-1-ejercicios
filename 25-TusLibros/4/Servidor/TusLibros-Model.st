!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'car 11/25/2019 19:16:39'!
emptyCartErrorMessage

	^self class emptyCartErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'car 11/25/2019 19:21:15'!
notInCartErrorMessage

	^self class notInCartErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'ns 12/1/2019 16:59:19'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'car 11/25/2019 19:16:23'!
signalEmptyCart

	self error: self emptyCartErrorMessage 
	! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error signal' stamp: 'car 11/25/2019 19:21:04'!
signalNotInCart

	self error: self notInCartErrorMessage 
	! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

!Cart methodsFor: 'adding' stamp: 'ns 12/2/2019 00:49:29'!
removeAllItems

	items := Bag new.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'car 11/25/2019 19:22:28'!
remove: anItem 
	
	self assertIsValidItem: anItem.
	
	self isEmpty ifTrue: [ self signalEmptyCart ].
	
	(items includes: anItem) ifFalse: [self signalNotInCart ].
	
	items remove: anItem .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'car 11/25/2019 19:17:04'!
emptyCartErrorMessage

	^'Can not remove from empty cart'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'car 11/25/2019 19:21:37'!
notInCartErrorMessage

	^'Item does not belong to cart'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'ns 11/23/2019 11:25:40'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear )
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut! !

!CartSession methodsFor: 'cart' stamp: 'car 11/25/2019 19:27:45'!
remove:  bookIsbn

	^cart remove: bookIsbn! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ns 12/2/2019 00:41:00'!
emptyCart

	^ cart removeAllItems
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'ns 12/1/2019 17:03:48'!
totalOf: anItem quantity: aQuantity
	| itemInformation |
	itemInformation := cart catalog at: anItem.
	^(itemInformation at: 'price') * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'ns 12/2/2019 00:36:58'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.
	self emptyCart.

	^ ticket! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'ns 11/23/2019 11:54:05'!
quantity

	^ quantity! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ns 11/23/2019 11:14:48'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ns 11/30/2019 19:37:25'!
getCatalog

	^ catalog! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:33:49'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'car 11/25/2019 19:27:59'!
remove:  bookIsbn fromCartIdentifiedAs: aCartId 

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession remove:  bookIsbn]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'ns 11/23/2019 12:22:17'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal oldQty newQty itemDict |
		itemDict := salesOrderedByBook at: aLineItem item ifAbsentPut:[Dictionary new].
		oldTotal := itemDict at: 'total' ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		oldQty := itemDict at: 'qty' ifAbsentPut: [ 0 ].
		newQty := oldQty + aLineItem quantity.
		itemDict at: 'total' put: newTotal.		
		itemDict at: 'qty' put: newQty.
		salesOrderedByBook at: aLineItem item put: itemDict ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !


!classDefinition: #TusLibrosSystemFacadeServer category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacadeServer
	instanceVariableNames: 'restInterface port webServer testObjectsFactory clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/30/2019 19:35:51'!
create200ResponseWith: aValue and: aRequest
		| responseAsJson |

		responseAsJson := WebUtils jsonEncode: (aValue).
		aRequest send200Response: (responseAsJson asUtf8) 
		contentType: 'application/json; charset=utf-8' do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/23/2019 11:27:33'!
createDateWith: monthAndYear
	| month year |
	month := monthAndYear copyFrom: 1 to: 2.
	year := '20', (monthAndYear copyFrom: 3 to: 4).
	^ Month month: month asNumber year: year asNumber.! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/2/2019 03:05:00'!
defaultCatalog

		^ Dictionary new
at: 'book1' put:
  (Dictionary new
  	at: 'name' put: 'The Terry Pratchett Diary';
 	 at: 'price' put: 10;
 	 at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4732/9781473208339.jpg';
  	at: 'author' put: 'Author';
    at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
    yourself);
at: 'book2' put:
  (Dictionary new
  at: 'name' put: 'Bridget Jones: The Edge of Reason';
  at: 'price' put: 100;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/3303/9780330367356.jpg';
  at: 'author' put: 'Author';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book3' put:
  (Dictionary new
  at: 'name' put: 'Under the Jaguar Sun';
  at: 'price' put: 20;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/1411/9780141189727.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book4' put:
  (Dictionary new
  at: 'name' put: 'QI The Pocket Book of Animals';
  at: 'price' put: 30;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/5712/9780571245130.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book5' put:
  (Dictionary new
  at: 'name' put: 'The Help';
  at: 'price' put: 500;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/1410/9780141039282.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book6' put:
  (Dictionary new
  at: 'name' put: 'Meditations';
  at: 'price' put: 10;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/7538/9780753820162.jpg';
  at: 'author' put: 'Author';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book7' put:
  (Dictionary new
  at: 'name' put: 'The Magic of Reality';
  at: 'price' put: 100;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/5527/9780552778053.jpg';
  at: 'author' put: 'Author';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book8' put:
  (Dictionary new
  at: 'name' put: 'Death Cure';
  at: 'price' put: 20;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/9084/9781908435200.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book9' put:
  (Dictionary new
  at: 'name' put: 'Hallucinations';
  at: 'price' put: 30;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4472/9781447208266.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book10' put:
  (Dictionary new
  at: 'name' put: 'Snow Crash';
  at: 'price' put: 500;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/2419/9780241953181.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book11' put:
  (Dictionary new
  at: 'name' put: 'Anatomy of the Spirit';
  at: 'price' put: 10;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/5535/9780553505276.jpg';
  at: 'author' put: 'Author';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book12' put:
  (Dictionary new
  at: 'name' put: 'The End of the Affair';
  at: 'price' put: 100;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9780/0994/9780099478447.jpg';
  at: 'author' put: 'Author';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book13' put:
  (Dictionary new
  at: 'name' put: 'The Samurai';
  at: 'price' put: 20;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/8452/9781845299477.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book14' put:
  (Dictionary new
  at: 'name' put: 'Fullmetal Alchemist Vol. 1';
  at: 'price' put: 30;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4215/9781421599779.jpg';
  at: 'author' put: 'Author1';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book15' put:
  (Dictionary new
  at: 'name' put: 'Death Note Black Edition, Vol. 1';
  at: 'price' put: 500;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4215/9781421539645.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);

at: 'book16' put:
  (Dictionary new
  at: 'name' put: 'Dragon Ball Z, Vol. 1';
  at: 'price' put: 150;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4215/9781421520643.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book17' put:
  (Dictionary new
  at: 'name' put: 'Dragon Ball Z, Vol. 2';
  at: 'price' put: 20;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4215/9781421520650.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
at: 'book18' put:
  (Dictionary new
  at: 'name' put: 'Dragon Ball Z, Vol. 3';
  at: 'price' put: 300;
  at: 'src' put: 'https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/mid/9781/4215/9781421520667.jpg';
  at: 'author' put: 'Author2';
  at: 'description' put: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean neque leo, rhoncus quis maximus a, placerat non arcu. Pellentesque in iaculis felis. Ut accumsan posuere libero, sed vulputate quam scelerisque vitae. Suspendisse vehicula elementum mi id pharetra. Ut sollicitudin at est at pellentesque. Ut nisi erat, tincidunt a convallis at, molestie nec orci. Vivamus sagittis eros non dapibus vulputate. Ut pulvinar enim a eros ultrices lacinia. Nam bibendum, enim non bibendum rhoncus, lorem velit accumsan dolor, ut condimentum est risus sit amet erat. Aenean vitae condimentum odio. Nullam aliquet mollis dolor eget congue. Praesent gravida rutrum magna vitae lacinia. Sed dui urna, malesuada vitae nibh ut, aliquam feugiat augue. Nam elementum sit amet lacus vel pulvinar. Donec ut risus non felis aliquet accumsan.';
  yourself);
yourself! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/1/2019 20:34:58'!
defaultCced

	^ '1230'! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/1/2019 20:34:46'!
defaultCcn

	^ 123456! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/1/2019 20:35:11'!
defaultCco

	^ 'validOwner'! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/2/2019 09:17:21'!
defaultExpiredCced

	^ '1117'! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:43:57'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/2/2019 09:23:51'!
getCardExpirationFor: aClient

	aClient = 'expiredCardUser' ifTrue: [^ self defaultExpiredCced ].
	^ self defaultCced.! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/23/2019 12:28:40'!
getCartSummary: aProductList
	| products productQuantity |
	products := Dictionary new.
	aProductList do: [
		:anItem | 
		productQuantity := products at: anItem ifAbsent: 0.
		products at: anItem put: (productQuantity + 1).
	].
	^ products.! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/23/2019 12:28:00'!
getTicketSummary: ticket
	| ticketSummary |
	ticketSummary := Dictionary new.
	ticket lineItemsDo: [
		:anItem | | itemDict |
			itemDict := Dictionary new.
			itemDict at: 'total' put: anItem total.
			itemDict at: 'qty' put: anItem quantity.
			ticketSummary at: anItem item put: itemDict
	].

	^ ticketSummary.! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/2/2019 09:32:47'!
initializeWith: aPortNumber
	
	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	restInterface :=TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: self defaultCatalog
		registeringOn: testObjectsFactory createSalesBook
		debitingThrought: testObjectsFactory merchantProcessor
		measuringTimeWith: clock.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	webServer addService: '/createCart' action:[:request | | responseAsJson cartId clientId password |
	
	[
		clientId := request fields at: 'clientId'.
		password := request fields at: 'password'.
		cartId  := restInterface createCartFor: clientId authenticatedWith: password.
		self create200ResponseWith: cartId and: request.
	 ]
	on: Error 
	do: [ :anError |
				request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].

	webServer addService: '/addToCart' action:[:request | | bookIsbn bookQuantity cartId |
	
	[	cartId := request fields at: 'cartId'.
		bookIsbn := request fields at: 'bookIsbn'.
		bookQuantity := request fields at: 'bookQuantity'.
		restInterface add: (bookQuantity asNumber) of: bookIsbn toCartIdentifiedAs: (cartId asNumber).
		self create200ResponseWith: 'OK' and: request.
	] 
	on: Error 
	do: [ :anError |
		
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].


	webServer addService: '/listCart' action:[:request | | cartId cartProducts |
	
	[
		cartId := request fields at: 'cartId'.
		cartProducts := restInterface listCartIdentifiedAs: cartId asNumber.
		self create200ResponseWith: (self getCartSummary: cartProducts) and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].

	webServer addService: '/checkoutCart' action:[:request | | cartId clientId ticket |
	
	[	cartId := request fields at: 'cartId'.
		clientId := request fields at: 'clientId'.
		ticket := restInterface checkOutCartIdentifiedAs: (cartId asNumber) withCreditCardNumbered: (self defaultCcn) ownedBy: (self defaultCco) expiringOn: (self createDateWith: (self getCardExpirationFor: clientId)).
		self create200ResponseWith: (self getTicketSummary: ticket) and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].


	webServer addService: '/listPurchases' action:[:request | | clientId password purchases |
	
	[	clientId := request fields at: 'clientId'.
		password := request fields at: 'password'.
		purchases := restInterface listPurchasesOf: clientId authenticatingWith: password.
		self create200ResponseWith: purchases and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].
	
	webServer addService: '/removeFromCart' action:[:request | | bookIsbn cartId |
	
	[	cartId := request fields at: 'cartId'.
		bookIsbn := request fields at: 'bookIsbn'.
		restInterface remove:  bookIsbn fromCartIdentifiedAs: (cartId asNumber).
		self create200ResponseWith: 'OK' and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].


	webServer addService: '/getCatalog' action:[:request | | cartId |
	
	[	"cartId := request fields at: 'cartId'."
		"self create200ResponseWith: (restInterface getCatalog: (cartId asNumber)) and: request."
		self create200ResponseWith: (restInterface getCatalog) and: request.
	] 
	on: Error 
	do: [ :anError |
		request send404Response: (WebUtils jsonEncode: (anError messageText)) do: [:resp | 
		resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]]].
! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:42:52'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:43:03'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:42:57'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !

!TusLibrosSystemFacadeServer methodsFor: 'as yet unclassified' stamp: 'ns 12/2/2019 09:17:51'!
validUsersAndPasswords

	^Dictionary new
		at: 'validUser' put: 'validPassword';
		at: 'expiredCardUser' put: 'expiredCardUserPassword';
		yourself! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacadeServer class' category: #'TusLibros-Model'!
TusLibrosSystemFacadeServer class
	instanceVariableNames: ''!

!TusLibrosSystemFacadeServer class methodsFor: 'as yet unclassified' stamp: 'ns 11/18/2019 23:41:27'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
