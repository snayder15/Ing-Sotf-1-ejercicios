!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:34:17'!
test01CreatePortfolio
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:34:38'!
test02AgregarCuenta
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:34:49'!
test03AgregarCuentaConDeposito
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 100.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:39:54'!
test04AgregarCuentaConDepositoYExtraccion
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 50.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:41:44'!
test05AgregarCuentaConDepositoYVerSiEstaRegistradaLaTransaccion
	
	| portfolio account transaction |
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction) equals: true.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:45:46'!
test06PortfolioNoPermiteRegistrarTransaccion
	
	| portfolio transaction |
	
	portfolio := Portfolio new.
	transaction := Deposit register: 100 on: portfolio.


	self deny: (portfolio hasRegistered: transaction).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:58:00'!
test07PortfolioConoceSusTransacciones

	| account1 deposit1 portfolio |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
	
	portfolio := Portfolio new.

	portfolio add: account1.
	
	self assert: 1 equals: portfolio transactions size .
	self assert: (portfolio transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:05:37'!
test08AgregarPortfolioRepetido

	| account portfolio portfolio1 |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio1 := Portfolio new.
	
	portfolio add: account.
	portfolio add: portfolio1.	
	
	self should: [portfolio1 add: account] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: (portfolio transactions) size equals: 1.
		].
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'a 10/17/2019 23:53:33'!
balanceValue

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'a 10/17/2019 20:48:15'!
register: aValue on: account

	| transaction |
	
	account class = ReceptiveAccount ifTrue: [
		transaction := self for: aValue.
		account register: transaction.
			
		^ transaction
	]
! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'a 10/17/2019 23:53:45'!
balanceValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'a 10/17/2019 18:33:34'!
value

	^  value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'a 10/17/2019 23:53:54'!
balanceValue

	^ -1 * value. ! !

!Withdraw methodsFor: 'value' stamp: 'a 10/17/2019 18:37:48'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankGroups category: #'Portfolio-Ejercicio'!
Object subclass: #BankGroups
	instanceVariableNames: 'accountsPortfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:29:56'!
balance

	self subclassResponsibility ! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:00:30'!
hasChild: anAccountOrPortfolio
	| res  |
	res := false.
	
	(accountsPortfolios includes: anAccountOrPortfolio) ifTrue: [^ true].
	
	accountsPortfolios do: [
		:anAccount | ^ res or: (anAccount hasChild: anAccountOrPortfolio).
	].

	^ false.

	
	! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:30:06'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:00:49'!
isAlreadyAdded: anAccountOrPortfolio
	| res  |
	res := false.
	self = anAccountOrPortfolio ifTrue: [^ true].
	parents do: [
		:anAccount | ^ res or: (anAccount isAlreadyAdded: anAccountOrPortfolio).
	].

	^ self hasChild: anAccountOrPortfolio.

	
	! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:30:15'!
register: aTransaction

	self subclassResponsibility ! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:01:08'!
setParent: aPortfolio

	parents add: aPortfolio.! !

!BankGroups methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 20:30:24'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
BankGroups subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:10:17'!
add: anAccountOrPortfolio

	(self isAlreadyAdded: anAccountOrPortfolio) ifTrue: [^ Portfolio error: Portfolio errorCannotAddSameAccountPortfolio].
	
	accountsPortfolios add: anAccountOrPortfolio.
	anAccountOrPortfolio setParent: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 23:59:16'!
balance
	
	accountsPortfolios size = 0 ifTrue: [^0].
	
	^ accountsPortfolios sum: [
		:anAccount | anAccount balance.
	].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 23:59:21'!
hasRegistered: aTransaction
	| res |
	res := false.
	accountsPortfolios size = 0 ifTrue: [^false].
	accountsPortfolios do: [
		:anAccount | ^ res or: (anAccount hasRegistered: aTransaction).
	].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 23:58:39'!
initialize
	
	accountsPortfolios := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 23:59:27'!
transactions
	
	| res |
	
	res := OrderedCollection new.
	accountsPortfolios size = 0 ifTrue: [
		^ res.
	].
	
	^ accountsPortfolios do: [
		:anAccount | ^ res addAll: anAccount transactions.
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'a 10/17/2019 18:44:37'!
create

	^ self new create.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'a 10/18/2019 00:02:05'!
errorCannotAddSameAccountPortfolio

	^ 'Cannot add same account or portfolio'.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
BankGroups subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'a 10/17/2019 23:59:45'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.
	accountsPortfolios := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'a 10/17/2019 23:54:13'!
balance

	^transactions sum: [ :aTransaction |
		aTransaction balanceValue.
	] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
