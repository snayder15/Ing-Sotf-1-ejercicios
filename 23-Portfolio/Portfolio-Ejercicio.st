!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'a 10/17/2019 20:34:17'!
test01CreatePortfolio
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'test' stamp: 'a 10/17/2019 20:34:38'!
test02AgregarCuenta
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 0.! !

!PortfolioTest methodsFor: 'test' stamp: 'a 10/17/2019 20:34:49'!
test03AgregarCuentaConDeposito
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 100.
! !

!PortfolioTest methodsFor: 'test' stamp: 'a 10/17/2019 20:39:54'!
test04AgregarCuentaConDepositoYExtraccion
	
	| portfolio account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio balance) equals: 50.
! !

!PortfolioTest methodsFor: 'test' stamp: 'car+ 10/20/2019 18:06:22'!
test05AgregarCuentaConDepositoYVerSiEstaRegistradaLaTransaccion
	
	| portfolio account deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'test' stamp: 'car+ 10/20/2019 18:06:45'!
test06PortfolioNoPermiteRegistrarTransaccion
	
	| portfolio deposit |
	
	portfolio := Portfolio new.
	deposit := Deposit register: 100 on: portfolio.


	self deny: (portfolio hasRegistered: deposit).
! !

!PortfolioTest methodsFor: 'test' stamp: 'car+ 10/20/2019 18:11:52'!
test07PortfolioConoceSusTransacciones

	| account1 deposit1 portfolio |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
	
	portfolio := Portfolio new.

	portfolio add: account1.
	
	self assert: 1 equals: (portfolio amountTransactions) .
	self assert: (portfolio hasRegistered: deposit1).
! !

!PortfolioTest methodsFor: 'test' stamp: 'car+ 10/20/2019 18:14:02'!
test09AgregarCuentaQueNoEstaEnElArbolAUnPortfolio

	| account1 portfolio1 portfolio2 portfolio3 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio3 add: portfolio2.	
	portfolio3 add: account1.

	self assert: portfolio3 amountTransactions equals: 1.
	self assert: portfolio1 amountTransactions equals: 1.
	! !


!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:13:40'!
test08AgregarUnaCuentaEnUnPortfolioBQueNoTieneCuentasPeroLaCuentaEstaEnUnPortfolioAQueContieneAlPorfolioB

	| account portfolioA portfolioB |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: account.
	portfolioA add: portfolioB.	
	
	self should: [portfolioB add: account] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolioA  amountTransactions equals: 1.
			self assert: portfolioB  amountTransactions equals: 0.
		].
! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:14:24'!
test10AgregarCuentaQueEstaEnElArbolAUnPortfolio

	| account1 portfolio1 portfolio2 portfolio3 portfolio4 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio3 add: portfolio2.	
	portfolio3 add: account1.
	portfolio2 add: portfolio4.
	
	self should: [portfolio4 add: account1] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolio1 amountTransactions equals: 1.
			self assert: portfolio3 amountTransactions equals: 1.
			self assert: portfolio4 amountTransactions equals: 0.
		].

	! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:14:38'!
test11AgregarLaMismaCuentaDosVecesAlMismoPortfolio

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolio := Portfolio new.
	portfolio add: account.	
	
	self should: [portfolio add: account] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolio amountTransactions equals: 1.
		].
! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:14:48'!
test12AgregarUnaCuentaAlPortfolioAElCualContieneUnPortfolioBQueTieneEsaCuenta
	| account portfolioA portfolioB |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: portfolioB.
	portfolioB add: account.
		
	
	self should: [portfolioA add: account] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolioA amountTransactions equals: 1.
		].
! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:15:34'!
test13AgregoAlPortfolioAElMismoPorfolioA
	| account portfolioA |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.

	portfolioA := Portfolio new.
	
	portfolioA add: account .	
	
	self should: [portfolioA add: portfolioA ] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolioA amountTransactions equals: 1.
		].
! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:15:56'!
test14AgregarUnPortfolioQueEstaEnElArbolAUnPortfolio

	| account1 portfolio1 portfolio2 portfolio3 portfolio4 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio3 add: portfolio2.	
	portfolio3 add: account1.
	portfolio2 add: portfolio4.
	
	self should: [portfolio4 add: portfolio1] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolio1 amountTransactions equals: 1.
			self assert: portfolio3 amountTransactions equals: 1.
			self assert: portfolio4 amountTransactions equals: 0.
		].

	! !

!PortfolioTest methodsFor: 'testing - error' stamp: 'car+ 10/20/2019 18:16:45'!
test15AgregarAlPortfolioAMasDeUnaVezUnPortfioBVacio

	| account1 portfolioA portfolioB |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.

	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: account1.
	portfolioA add: portfolioB.

	self should: [portfolioA add: portfolioB.] 
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio errorCannotAddSameAccountPortfolio.
			self assert: portfolioA amountTransactions equals: 1.
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

!BankGroups methodsFor: 'private' stamp: 'a 10/18/2019 00:00:30'!
hasChild: anAccountOrPortfolio
	| res  |
	res := false.
	
	(accountsPortfolios includes: anAccountOrPortfolio) ifTrue: [^ true].
	
	accountsPortfolios do: [
		:anAccount | ^ res or: (anAccount hasChild: anAccountOrPortfolio).
	].

	^ false.

	
	! !

!BankGroups methodsFor: 'private' stamp: 'a 10/18/2019 00:00:49'!
isAlreadyAdded: anAccountOrPortfolio
	| res  |
	res := false.
	self = anAccountOrPortfolio ifTrue: [^ true].
	parents do: [
		:anAccount | ^ res or: (anAccount isAlreadyAdded: anAccountOrPortfolio).
	].

	^ self hasChild: anAccountOrPortfolio.

	
	! !

!BankGroups methodsFor: 'private' stamp: 'a 10/18/2019 00:01:08'!
setParent: aPortfolio

	parents add: aPortfolio.! !


!BankGroups methodsFor: 'testing' stamp: 'car+ 10/20/2019 18:10:31'!
amountTransactions

	self subclassResponsibility ! !

!BankGroups methodsFor: 'testing' stamp: 'a 10/17/2019 20:30:06'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BankGroups methodsFor: 'balance' stamp: 'a 10/17/2019 20:29:56'!
balance

	self subclassResponsibility ! !


!BankGroups methodsFor: 'transactions' stamp: 'a 10/17/2019 20:30:15'!
register: aTransaction

	self subclassResponsibility ! !

!BankGroups methodsFor: 'transactions' stamp: 'a 10/17/2019 20:30:24'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
BankGroups subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'car+ 10/20/2019 18:12:48'!
amountTransactions

	^self transactions size! !

!Portfolio methodsFor: 'testing' stamp: 'a 10/17/2019 23:59:21'!
hasRegistered: aTransaction
	| res |
	res := false.
	accountsPortfolios size = 0 ifTrue: [^false].
	accountsPortfolios do: [
		:anAccount | ^ res or: (anAccount hasRegistered: aTransaction).
	].! !


!Portfolio methodsFor: 'initialization' stamp: 'a 10/17/2019 23:58:39'!
initialize
	
	accountsPortfolios := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'a 10/19/2019 21:40:39'!
transactions
	
	| res |
	
	res := OrderedCollection new.
	
	accountsPortfolios do: [
		:anAccount | res addAll: anAccount transactions.
	].
	
	^res.! !


!Portfolio methodsFor: 'balance' stamp: 'a 10/17/2019 23:59:16'!
balance
	
	accountsPortfolios size = 0 ifTrue: [^0].
	
	^ accountsPortfolios sum: [
		:anAccount | anAccount balance.
	].! !


!Portfolio methodsFor: 'adding' stamp: 'a 10/19/2019 22:18:38'!
add: anAccountOrPortfolio

	(self isAlreadyAdded: anAccountOrPortfolio) ifTrue: [^ Portfolio error: Portfolio errorCannotAddSameAccountPortfolio].
	
	accountsPortfolios add: anAccountOrPortfolio.
	anAccountOrPortfolio setParent: self.! !

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


!ReceptiveAccount methodsFor: 'testing' stamp: 'car+ 10/20/2019 18:13:03'!
amountTransactions

	^self transactions size! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
