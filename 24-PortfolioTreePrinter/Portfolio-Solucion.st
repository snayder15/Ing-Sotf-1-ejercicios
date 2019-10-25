!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #ReportTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:47:45'!
test01TransferNetEmpty

	| report |
	report := TransferNetReport with: (ReceptiveAccount new).
	
	self assert: (report printReport) equals: 0.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:51:20'!
test02TransferNetAccountWithDeposit

	| report account |
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	report := TransferNetReport with: account.
	
	self assert: (report printReport) equals: 0.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:02:32'!
test03TransferNetAccountWithTransferDeposit

	| report report1 account account1 |
	account := ReceptiveAccount new.
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account.
	Transfer from: account  to: account1 withValue: 30. 
	report := TransferNetReport with: account.
	report1 := TransferNetReport with: account1.
	
	self assert: (report printReport) equals: -30.
	self assert: (report1 printReport) equals: 30.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 21:58:15'!
test04AccountSummaryReportEmpty

	| report account |
	account := ReceptiveAccount new.	
	report := AccountSummaryReport with: account.	
	
	self assert: (report printReport) equals: 'Balance = 0'.	! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 21:58:20'!
test05AccountSummaryWithDeposit

	| report account |
	account := ReceptiveAccount new.
	Deposit register: 40 on: account.
	report := AccountSummaryReport with: account.	
	
	self assert: (report printReport) equals: 'Deposito por 40. Balance = 40'.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'car 10/24/2019 17:13:25'!
test06AccountSummaryWithTransferTransactions

	| report account account1 report1 |
	account := ReceptiveAccount new.
	account1 := ReceptiveAccount new.
	Deposit register: 40 on: account.
	Deposit register: 100 on: account1.
	Transfer from: account to: account1 withValue: 20.
	Transfer from: account1 to: account withValue: 100.
	report := AccountSummaryReport with: account.
	report1 := AccountSummaryReport with: account1.	
	
	self assert: (report printReport) equals: 'Deposito por 40. Salida por transferencia de 20. Entrada por transferencia de 100. Balance = 120'.
	self assert: (report1 printReport) equals: 'Deposito por 100. Entrada por transferencia de 20. Salida por transferencia de 100. Balance = 20'.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'car 10/24/2019 17:11:55'!
test07AccountSummaryWithWithdraw

	| report account account1 report1 |
	account := ReceptiveAccount new.
	account1 := ReceptiveAccount new.
	Deposit register: 40 on: account.
	Deposit register: 100 on: account1.
	Transfer from: account to: account1 withValue: 20.
	Withdraw register: 20 on: account.
	
	report := AccountSummaryReport with: account.
	report1 := AccountSummaryReport with: account1.	
	
	self assert: (report printReport) equals: 'Deposito por 40. Salida por transferencia de 20. Extraccion por 20. Balance = 0'.
	self assert: (report1 printReport) equals: 'Deposito por 100. Entrada por transferencia de 20. Balance = 120'.! !


!classDefinition: #TransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:02:32'!
test01BasicTransfer
			
	| cuenta1 cuenta2 |
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	
	Deposit register: 100 on: cuenta1.
	Deposit register: 100 on: cuenta2.
	
	Transfer from: cuenta1 to: cuenta2 withValue: 50.
	
	self assert: 50 equals: cuenta1 balance. 
	self assert: 150 equals: cuenta2 balance.	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:09:51'!
test02TransferKnowsFromTo
			
	| cuenta1 cuenta2 transfer |
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	
	Deposit register: 100 on: cuenta1.
	Deposit register: 100 on: cuenta2.
	transfer := Transfer from: cuenta1 to: cuenta2 withValue: 50.
	
	self assert: transfer fromAccount equals: cuenta1.
	self assert: transfer toAccount equals: cuenta2.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:07:44'!
test03FromKnowsTo
			
	| cuenta1 cuenta2 transfer |
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	
	Deposit register: 100 on: cuenta1.
	Deposit register: 100 on: cuenta2.
	transfer := Transfer from: cuenta1 to: cuenta2 withValue: 50.
	
	self assert: (transfer fromTransaction) otraPata equals: cuenta2.
	self assert: (transfer toTransaction) otraPata equals: cuenta1.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:02:32'!
test04InvalidTransferInsufficientBalanceOnAccount
			
	| cuenta1 cuenta2 |
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	
	Deposit register: 40 on: cuenta1.
	Deposit register: 100 on: cuenta2.
	
	self should: [Transfer from: cuenta1 to: cuenta2 withValue: 50.] raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError| self assert: anError messageText equals: Transfer errorInsufficientBalance.
						self assert: 40 equals: cuenta1 balance. 
						self assert: 100 equals: cuenta2 balance.
		].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:02:32'!
test05CannotTransferToSameAccount
			
	| cuenta1 |
	cuenta1 := ReceptiveAccount new.	
	
	Deposit register: 100 on: cuenta1.	
	
	self should: [Transfer from: cuenta1 to: cuenta1 withValue: 50.] raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError| self assert: anError messageText equals: Transfer errorSameAccountTransfer.
						self assert: 100 equals: cuenta1 balance. 						
		].! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'car 10/21/2019 20:59:14'!
affectTransferBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'a 10/22/2019 21:53:25'!
printValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'car 10/21/2019 21:00:48'!
affectTransferBalance: aBalance

	^ aBalance! !

!Deposit methodsFor: 'value' stamp: 'a 10/22/2019 21:57:36'!
printValue

	^ 'Deposito por ', value asString.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositTransfer category: #'Portfolio-Solucion'!
AccountTransaction subclass: #DepositTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:17:54'!
affectBalance: aBalance

	^aBalance + (transfer value).! !

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:59:45'!
affectTransferBalance: aBalance

	^ aBalance + transfer value.! !

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:13:38'!
initializeWithTransfer: aTransfer and: anAccount
	
	transfer := aTransfer.
	anAccount register: self.! !

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:10:17'!
otraPata

	^ transfer fromAccount.! !

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 21:57:41'!
printValue

	^ 'Entrada por transferencia de ', self value asString.! !

!DepositTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 21:36:06'!
value

	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositTransfer class' category: #'Portfolio-Solucion'!
DepositTransfer class
	instanceVariableNames: ''!

!DepositTransfer class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 21:17:19'!
withTransfer: aTransfer and: anAccount
	
	^ self new initializeWithTransfer: aTransfer and: anAccount.! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'a 10/22/2019 21:57:48'!
printValue

	^ 'Extraccion por ', value asString.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'car 10/21/2019 21:01:03'!
affectTransferBalance: aBalance

	^ aBalance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawTransfer category: #'Portfolio-Solucion'!
AccountTransaction subclass: #WithdrawTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:18:02'!
affectBalance: aBalance

	^aBalance - (transfer value).! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:59:59'!
affectTransferBalance: aBalance

	^ aBalance - transfer value.! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:16:57'!
initializeWithTransfer: aTransfer and: anAccount
	
	transfer := aTransfer.
	anAccount register: self.! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:10:25'!
otraPata

	^ transfer toAccount.! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 21:57:53'!
printValue

	^ 'Salida por transferencia de ', self value asString.! !

!WithdrawTransfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 21:36:10'!
value

	^ transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawTransfer class' category: #'Portfolio-Solucion'!
WithdrawTransfer class
	instanceVariableNames: ''!

!WithdrawTransfer class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 21:17:25'!
withTransfer: aTransfer and: anAccount
	
	^ self new initializeWithTransfer: aTransfer and: anAccount.! !


!classDefinition: #Report category: #'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:43:10'!
printReport

	self subclassResponsibility ! !


!classDefinition: #AccountSummaryReport category: #'Portfolio-Solucion'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:45:33'!
initializeWith: anAccount
	
	account := anAccount.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 21:51:26'!
printBalance
	
	^ 'Balance = ', account balance asString.! !

!AccountSummaryReport methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:01:19'!
printReport
	
	| transactionsHistory |
	

	transactionsHistory := account transactions 
		inject: ''
		into: [ :transactionsReport :currentTransaction | transactionsReport, (currentTransaction printValue), '. ' ].
		
	^ (transactionsHistory, self printBalance).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: #'Portfolio-Solucion'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:49:27'!
with: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #TransferNetReport category: #'Portfolio-Solucion'!
Report subclass: #TransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:45:58'!
initializeWith: anAccount
	
	account := anAccount.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:58:55'!
printReport
	
	^ account transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectTransferBalance: currentBalance ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: #'Portfolio-Solucion'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:49:35'!
with: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value fromAccount fromTransaction toTransaction toAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:08:15'!
fromAccount
	
	^ fromAccount! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:08:59'!
fromTransaction
	
	^ fromTransaction! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'car 10/24/2019 17:14:27'!
initializeFrom: anAccount to: anotherAccount withValue: aValue
	
	(anAccount balance < aValue ) ifTrue: [^ Transfer error: Transfer errorInsufficientBalance ].
	(anAccount = anotherAccount ) ifTrue: [^ Transfer error: Transfer errorSameAccountTransfer ].
	fromTransaction := WithdrawTransfer withTransfer: self and: anAccount.
	toTransaction := DepositTransfer withTransfer: self and: anotherAccount.
	fromAccount := anAccount.
	toAccount := anotherAccount.
	value := aValue.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:09:05'!
toAccount
	
	^ toAccount! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:09:09'!
toTransaction
	
	^ toTransaction! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:18:13'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 20:26:39'!
errorInsufficientBalance

	^'Insufficient balance'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'car 10/21/2019 21:18:47'!
errorSameAccountTransfer

	^ 'Cannot transfer to same account'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'a 10/22/2019 22:03:17'!
from: anAccount to: anotherAccount withValue: aValue 
	
	
	^ self new initializeFrom: anAccount to: anotherAccount withValue: aValue.! !
