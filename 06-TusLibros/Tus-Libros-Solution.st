!classDefinition: #TusLibrosTest category: #'Tus-Libros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosTest methodsFor: 'cart' stamp: 'Mirko 6/26/2017 10:46:05'!
test01ANewCartContainsNothing

	self assert: factory cart isEmpty .! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/13/2017 15:58:53'!
test02AddingABookToACartThenCartContainsThatBook
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	
	self deny: aCart isEmpty .
	self assert: (aCart includes: aBook).
	self assert: aCart size = 1.! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/13/2017 15:59:09'!
test03AddingSameBookToACartThenCartContainsAllTheCopiesAdded
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	aCart add: aBook.
	aCart add: aBook.
	
	self assert: (aCart occurrencesOf: aBook) = 3.
	self assert: aCart size = 3.! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/13/2017 18:35:20'!
test04CanAddMultipleCopiesToCartAtOnce
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook withOccurrences: 4.
	aCart add: aBook withOccurrences: 3.

	self assert: (aCart occurrencesOf: aBook) = 7.
	self assert: aCart size = 7.! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/13/2017 18:36:02'!
test05ACartCanHoldDifferentItems
	
	|aBook aCart anotherBook |
	
	aBook := factory bookOne.
	anotherBook := factory bookTwo.
	aCart := factory cart.
	
	aCart add: aBook withOccurrences: 4.
	aCart add: anotherBook withOccurrences: 3.

	self assert: (aCart occurrencesOf: aBook) = 4.
	self assert: (aCart occurrencesOf: anotherBook) = 3.
	self assert: aCart size = 7.! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/14/2017 22:48:45'!
test07AddingBookFromOutsideCatalogToCartShouldThrowError
	
	| aCart anInvalidBook |
	
	anInvalidBook := factory invalidBookOne.
	aCart := factory cart.
	
	self
		should: [ aCart add: anInvalidBook ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidBookError ]
	
	
	! !

!TusLibrosTest methodsFor: 'cart' stamp: 'PR 6/15/2017 19:14:24'!
test08AddingNonPositiveAmountOfBooksToCartShouldThrowError
	
	| aCart aBook |
	
	aCart := factory cart.
	aBook := factory bookOne.
	
	self
		should: [ aCart add: aBook withOccurrences: -3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidAmount.
			self assert: aCart isEmpty
		]
	
	
	! !


!TusLibrosTest methodsFor: 'cashier' stamp: 'PR 6/22/2017 22:39:17'!
test09WhenACashierCheckoutsAnEmptyCartAnErrorIsThrown
	
	| anEmptyCart aCashier aCard |
	
	anEmptyCart := factory cart.
	aCashier := factory cashier.
	aCard := factory card.
	
	self
		should: [ aCashier checkout: anEmptyCart with: aCard. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutEmptyCartError.
			self assert: aCashier sales isEmpty.
			]
	
	
	! !

!TusLibrosTest methodsFor: 'cashier' stamp: 'PR 6/22/2017 22:40:08'!
test10CheckoutWithExpiredCardShouldThrowError
	
	| aCashier expiredCard aBook aCart |
	
	aCart := factory cart.
	aBook := factory bookOne.
	aCart add: aBook.
	
	aCashier := factory cashier.
	expiredCard := factory expiredCard.
	
	self
		should: [ aCashier checkout: aCart with: expiredCard. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutWithExpiredCardError.
			self assert: aCashier sales isEmpty.]
	
	
	! !

!TusLibrosTest methodsFor: 'cashier' stamp: 'PR 6/22/2017 22:43:08'!
test11successfullCheckoutLogsSaleInSalesBookAndGivesTicketWithCorrectAmount
	
	| aCashier aCart ticket aCard |
	
	aCart := factory cart.
	aCart add: factory bookOne withOccurrences: 3.
	aCart add: factory bookTwo withOccurrences: 4.
	aCashier := factory cashier.
	aCard := factory card.
	
	ticket :=  aCashier checkout: aCart with: aCard. 
	
	self assert: ticket = 10.
	self assert: aCashier sales size = 1.
	self assert: aCashier sales last  = 10.
	
	
	! !


!TusLibrosTest methodsFor: 'card' stamp: 'PR 6/25/2017 19:59:41'!
test13cannotCreateCardWithEmptyOwner
	
	self
		should: [ Card number: 1234123412341234 expirationDate: Date today owner: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card emptyOwnerError]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'card' stamp: 'PR 6/25/2017 20:01:52'!
test14cannotCreateCardWithInvalidNumberSize
	
	self
		should: [ Card number: 1234 expirationDate: Date today owner: 'Roberto']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Card invalidNumberForCardError]
	
	
	
	
	! !


!TusLibrosTest methodsFor: 'interactionWithMerchantProcessor' stamp: 'PR 6/25/2017 19:22:28'!
test12checkoutFromAStolenCardThrowsException
	
	| aCashier aCart aStolenCard aMerchantProcessor |
	
	aCart := factory cart.
	aCart add: factory bookOne.
	aMerchantProcessor := factory merchantProcessorWithStolenCard.
	aCashier := factory cashierWithMerchantProcessor: aMerchantProcessor.
	aStolenCard := factory stolenCard.
	
	self
		should: [ aCashier checkout: aCart with: aStolenCard. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor stolenCardError .
			self assert: aCashier sales isEmpty.]
	
	
	
	
	! !

!TusLibrosTest methodsFor: 'interactionWithMerchantProcessor' stamp: 'Mirko 6/26/2017 14:08:59'!
test15checkoutFromACardWithInsuffientFoundsCardThrowsException
	
	| aCashier aCart aMerchantProcessor aInsufficientFoundsCard |
	
	aCart := factory cart.
	aCart add: factory bookOne.
	aMerchantProcessor := factory merchantProcessorWithInsufficientFounds.
	aCashier := factory cashierWithMerchantProcessor: aMerchantProcessor.
	aInsufficientFoundsCard := factory insufficientFoundsCard.
	
	self
		should: [ aCashier checkout: aCart with: aInsufficientFoundsCard.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor insufficientFoundsCardError .
			self assert: aCashier sales isEmpty.]
	
	
	
	
	! !


!TusLibrosTest methodsFor: 'setup' stamp: 'PR 6/13/2017 15:23:15'!
setUp
	factory := TusLibrosFactory new.! !


!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 18:43:33'!
test16createCartWithInvalidUserShouldRaiseInvalidUserError
	
	| interface |
	interface := factory interfaceWithNoUsers.
		
	self
		should: [ interface createCartWithUser: 'Michael Jackson' pass: 718929.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidUserError .
			self assert: (interface carts size = 0).]! !

!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 18:43:20'!
test17createCartWithWrongPasswordShouldRaiseError
	
	| interface |
	interface := factory interfaceWithUsers.
		
	self
		should: [ interface createCartWithUser: 'Michael Jackson' pass: 718929.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface invalidPasswordError .
			self assert: (interface carts size = 0).]! !

!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 19:55:27'!
test18createCartWithValidUserAndPasswordShouldCreateAnEmptyCart
	
	| interface cartId |
	
	interface := factory interfaceWithUsers.
		
	cartId := interface createCartWithUser: 'Michael Jackson' pass: 12355.
	self assert: (interface carts size = 1).
	self assert: (interface cartWithId: cartId) isEmpty.! !

!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 20:21:06'!
test19cartShouldBeAlwaysTheSameForSameId
	
	| interface cartId cart |
	
	interface := factory interfaceWithUsers.
	cartId := interface createCartWithUser: 'Michael Jackson' pass: 12355.
	
	cart := interface cartWithId: cartId.
	
	self assert: (interface idForCart: cart) = cartId.! !

!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 21:22:28'!
test20addBooksToCartWithIdShouldAddOnlyThoseBooksToTheCart
	
	| interface cartId abook |
	
	abook := factory bookOne.
	interface := factory interfaceWithUsersAndCatalog.
	
	cartId := interface createCartWithUser: 'Michael Jackson' pass: 12355.
	interface addToCartWithId: cartId book: abook occurences: 2.
	
	self assert: (((interface listCartWithId: cartId) occurrencesOf: abook) = 2). 
	self assert: (interface listCartWithId: cartId) size = 2.! !

!TusLibrosTest methodsFor: 'interactionWithRestInterface' stamp: 'PR 6/26/2017 21:56:07'!
test21

	| interface cartId aBook otherBook  aCard|
	
	aBook := factory bookOne.
	otherBook := factory bookTwo. 
	interface := factory interfaceWithUsersAndCatalog.
	aCard := factory card .
	
	cartId := interface createCartWithUser: 'Michael Jackson' pass: 12355.
	interface addToCartWithId: cartId book: aBook occurences: 2 .
	interface addToCartWithId: cartId book: otherBook  occurences: 1. 
	
	interface checkOutWithId: cartId card: aCard .
	
	self assert: (interface listPurcharsesWithIdUser: 'Michael Jackson' password: 12355 ) = (interface listCartWithId: cartId ).
	
	
	
	

	! !


!classDefinition: #Card category: #'Tus-Libros-Solution'!
Object subclass: #Card
	instanceVariableNames: 'number expirationDate owner today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Card methodsFor: 'initialization' stamp: 'PR 6/25/2017 18:32:48'!
initializeWithNumber: anInteger expirationDate: aDate owner: aString
	number := anInteger.
	expirationDate := aDate.
	owner := aString.! !


!Card methodsFor: 'inspecting' stamp: 'PR 6/26/2017 18:33:15'!
hasValidNumber
	^number printString size = 16.! !

!Card methodsFor: 'inspecting' stamp: 'PR 6/25/2017 18:31:40'!
isExpired: aDateToday
	^expirationDate < aDateToday. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #'Tus-Libros-Solution'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'error' stamp: 'PR 6/25/2017 20:00:07'!
emptyOwnerError
	^'Cannot create card with empty owner'.! !

!Card class methodsFor: 'error' stamp: 'PR 6/25/2017 20:02:18'!
invalidNumberForCardError
	^'Cannot create card with invalid number size'.! !


!Card class methodsFor: 'class initialization' stamp: 'PR 6/25/2017 19:57:28'!
number: anInteger expirationDate: aDate owner: aString
	(anInteger printString size = 16) ifFalse: [ self error: Card invalidNumberForCardError ].
	(aString size > 0) ifFalse: [ self error: Card emptyOwnerError ].

	^self new initializeWithNumber: anInteger expirationDate: aDate owner: aString.! !


!classDefinition: #Cart category: #'Tus-Libros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cart methodsFor: 'adding' stamp: 'PR 6/15/2017 19:11:55'!
add: aBook
	self add: aBook withOccurrences: 1.! !

!Cart methodsFor: 'adding' stamp: 'PR 6/18/2017 21:30:46'!
add: anItem withOccurrences: anAmount 
	anAmount <= 0 ifTrue: [^self error: Cart invalidAmount ].
	(catalog includesKey: anItem) 
		ifTrue: [contents add: anItem withOccurrences: anAmount.]
	ifFalse:
		[^self error: Cart invalidBookError]! !


!Cart methodsFor: 'accessing' stamp: 'PR 6/14/2017 22:45:53'!
size
	^contents size.! !


!Cart methodsFor: 'initialization' stamp: 'PR 6/14/2017 22:45:08'!
initializeWithCatalog: aCatalog
	catalog := aCatalog.
	contents := Bag new.! !


!Cart methodsFor: 'testing' stamp: 'PR 6/14/2017 22:45:30'!
includes: anItem
	^contents includes: anItem.! !

!Cart methodsFor: 'testing' stamp: 'PR 6/14/2017 22:43:58'!
isEmpty
	^contents isEmpty.! !

!Cart methodsFor: 'testing' stamp: 'PR 6/14/2017 22:46:22'!
occurrencesOf: anItem
	^contents occurrencesOf: anItem.! !


!Cart methodsFor: 'private' stamp: 'PR 6/15/2017 19:47:09'!
contents
	^contents copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'class initialization' stamp: 'PR 6/14/2017 22:43:28'!
newWithCatalog: aCatalog
	^Cart new initializeWithCatalog: aCatalog.! !


!Cart class methodsFor: 'error' stamp: 'PR 6/14/2017 22:50:11'!
invalidAmount
	^'Invalid amount'.! !

!Cart class methodsFor: 'error' stamp: 'PR 6/13/2017 18:52:24'!
invalidBookError
	^'Invalid Book'.! !


!classDefinition: #Cashier category: #'Tus-Libros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList today salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cashier methodsFor: 'initialization' stamp: 'PR 6/23/2017 21:12:05'!
initializeWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection withMerchantProcessor: aMerchantProcessor
	priceList := aPriceList.
	today := aDate.
	salesBook := anOrderedCollection.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'private' stamp: 'PR 6/22/2017 22:37:11'!
sales
	^salesBook copy! !


!Cashier methodsFor: 'evaluating' stamp: 'PR 6/26/2017 21:36:43'!
checkout: aCart with: aCard
	| ticket |
	
	aCart isEmpty ifTrue:[self error: Cashier cannotCheckoutEmptyCartError.].
	
	(aCard isExpired: today) ifTrue: [self error: Cashier cannotCheckoutWithExpiredCardError].
	
	ticket := 0.
	aCart contents do: [ :aBook | ticket := ticket + (self price: aBook).].
	
	merchantProcessor debit: ticket from: aCard.
	
	salesBook add: ticket.
	
	^ticket.! !


!Cashier methodsFor: 'inspecting' stamp: 'PR 6/15/2017 19:45:57'!
price: aBook
	^priceList at: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'Tus-Libros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error' stamp: 'PR 6/15/2017 19:28:24'!
cannotCheckoutEmptyCartError
	^'Empty Cart, cannot checkout'.! !

!Cashier class methodsFor: 'error' stamp: 'PR 6/25/2017 18:22:13'!
cannotCheckoutFromStolenCardError
	^'The card is stolen, cannot checkout'.! !

!Cashier class methodsFor: 'error' stamp: 'PR 6/22/2017 19:21:10'!
cannotCheckoutWithExpiredCardError
	^'Cannot checkout with expired card'.! !


!Cashier class methodsFor: 'class initialization' stamp: 'PR 6/23/2017 21:10:43'!
newWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection withMerchantProcessor: aMerchantProcessor.
	^self new initializeWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection withMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #MerchantProcessor category: #'Tus-Libros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!MerchantProcessor methodsFor: 'evaluating' stamp: 'PR 6/25/2017 17:30:30'!
debit: anAmount from: aCard
	self shouldBeImplemented.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #'Tus-Libros-Solution'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error' stamp: 'Mirko 6/26/2017 14:08:30'!
insufficientFoundsCardError
	^'Cannot debit from a card with insufficient founds'.! !

!MerchantProcessor class methodsFor: 'error' stamp: 'PR 6/25/2017 19:01:33'!
stolenCardError
	^'Cannot debit from a stolen card'.! !


!classDefinition: #MerchantProcessorStub category: #'Tus-Libros-Solution'!
MerchantProcessor subclass: #MerchantProcessorStub
	instanceVariableNames: 'block'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!MerchantProcessorStub methodsFor: 'evaluating' stamp: 'PR 6/25/2017 18:36:22'!
debit: anAmount from: aCard
	block value: anAmount value: aCard.! !


!MerchantProcessorStub methodsFor: 'initialization' stamp: 'PR 6/25/2017 17:27:00'!
initializeWithExecution: aBlockClosure 

	block := aBlockClosure! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStub class' category: #'Tus-Libros-Solution'!
MerchantProcessorStub class
	instanceVariableNames: ''!

!MerchantProcessorStub class methodsFor: 'class initialization' stamp: 'PR 6/25/2017 18:58:49'!
executeOnDebitFrom: aBlockClosure 
	^self new initializeWithExecution: aBlockClosure.! !


!classDefinition: #TusLibrosFactory category: #'Tus-Libros-Solution'!
Object subclass: #TusLibrosFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/18/2017 21:32:46'!
catalog
	| books |
	
	books := Dictionary new.
	
	books at: 1111 put: 1.
	books at: 1234 put: 2.
	
	^books.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 19:40:58'!
interfaceWithUsersAndCatalog
 ^TusLibrosRestInterface newWithUsers: self users catalog: self catalog .! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:54:08'!
salesBook
	^OrderedCollection new.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 18:36:06'!
users
	| users |
	users := Dictionary new.
	users at: 'Michael Jackson' put: 12355.
	
	^users.
	! !


!TusLibrosFactory methodsFor: 'books' stamp: 'Mirko 6/26/2017 14:21:22'!
bookOne
	^self catalog keys at: 1.! !

!TusLibrosFactory methodsFor: 'books' stamp: 'PR 6/18/2017 21:27:20'!
bookTwo
	^self catalog keys at: 2.! !

!TusLibrosFactory methodsFor: 'books' stamp: 'PR 6/13/2017 18:44:05'!
invalidBookOne
	^9999.! !


!TusLibrosFactory methodsFor: 'card' stamp: 'PR 6/25/2017 18:32:18'!
card
	^Card number: 1234123412341234 expirationDate: Date today + (Duration days: 30) owner: 'Robertito Fulanito'.! !

!TusLibrosFactory methodsFor: 'card' stamp: 'PR 6/25/2017 19:35:35'!
cardWithInvalidNumber
	^Card number: 1234 expirationDate: Date today owner: 'Jose'.! !

!TusLibrosFactory methodsFor: 'card' stamp: 'PR 6/25/2017 18:32:26'!
expiredCard
	^Card number: 1234123412341234 expirationDate: Date today - (Duration days: 30) owner: 'Gerardo Expirado'.! !

!TusLibrosFactory methodsFor: 'card' stamp: 'Mirko 6/26/2017 14:07:19'!
insufficientFoundsCard
	^Card number: 9879871233217893 expirationDate: Date today +(Duration days: 30)  owner: 'Juan Sinplata' ! !

!TusLibrosFactory methodsFor: 'card' stamp: 'PR 6/25/2017 18:32:34'!
stolenCard
	^Card number: 8888888888888888 expirationDate: Date today + (Duration days: 30) owner: 'Roberto Fraudulento'.! !


!TusLibrosFactory methodsFor: 'cart' stamp: 'PR 6/14/2017 22:43:15'!
cart
	^Cart newWithCatalog: self catalog.! !


!TusLibrosFactory methodsFor: 'cashier' stamp: 'PR 6/25/2017 18:16:43'!
cashier
	^Cashier newWithPriceList: self catalog withToday: Date today withSalesBook: self salesBook withMerchantProcessor: self emptyMerchantProcessor.! !

!TusLibrosFactory methodsFor: 'cashier' stamp: 'PR 6/25/2017 18:39:26'!
cashierWithMerchantProcessor: aMerchantProcessor 
	^Cashier newWithPriceList: self catalog withToday: Date today withSalesBook: self salesBook withMerchantProcessor: aMerchantProcessor.! !


!TusLibrosFactory methodsFor: 'merchantProcessor' stamp: 'PR 6/25/2017 19:00:55'!
emptyMerchantProcessor
	^MerchantProcessorStub executeOnDebitFrom: [ :anAmount :aCard ].! !

!TusLibrosFactory methodsFor: 'merchantProcessor' stamp: 'PR 6/25/2017 18:15:12'!
merchantProcessor
	self shouldBeImplemented! !

!TusLibrosFactory methodsFor: 'merchantProcessor' stamp: 'Mirko 6/26/2017 14:04:13'!
merchantProcessorWithInsufficientFounds
	^MerchantProcessorStub  executeOnDebitFrom: [:anAmount :aCard | self error: MerchantProcessor insufficientFoundsCardError.]! !

!TusLibrosFactory methodsFor: 'merchantProcessor' stamp: 'PR 6/25/2017 19:00:08'!
merchantProcessorWithStolenCard
	^MerchantProcessorStub executeOnDebitFrom: [ :anAmount :aCard | self error: MerchantProcessor stolenCardError ]! !


!TusLibrosFactory methodsFor: 'user interface' stamp: 'PR 6/26/2017 20:26:41'!
interfaceWithNoUsers

^TusLibrosRestInterface newWithUsers: Dictionary new catalog: self catalog.! !

!TusLibrosFactory methodsFor: 'user interface' stamp: 'PR 6/26/2017 20:27:03'!
interfaceWithUsers
	^TusLibrosRestInterface newWithUsers: self users catalog: self catalog.! !


!classDefinition: #TusLibrosRestInterface category: #'Tus-Libros-Solution'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'users carts catalog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosRestInterface methodsFor: 'inspecting' stamp: 'PR 6/26/2017 19:07:52'!
cartWithId: cartId

	^carts at: cartId.! !

!TusLibrosRestInterface methodsFor: 'inspecting' stamp: 'PR 6/26/2017 19:06:38'!
carts
	^carts copy.! !


!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'PR 6/26/2017 21:54:54'!
initializeWithUsers: anUsersDictionary catalog: anCatalog
	users := anUsersDictionary.
	catalog := anCatalog .
	carts := Dictionary new.
	! !


!TusLibrosRestInterface methodsFor: 'interface' stamp: 'PR 6/26/2017 19:34:30'!
createCartWithUser: anUserString pass: aPasswordNumber 


	(users includesKey: anUserString )
		ifFalse: [self error: TusLibrosRestInterface invalidUserError.].
	
	(users at: anUserString) = aPasswordNumber
		ifFalse: [self error: TusLibrosRestInterface invalidPasswordError. ].
		
	 carts at: carts size + 1 put: (Cart newWithCatalog: catalog).	
	
	^ carts size
! !


!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 20:31:39'!
addToCartWithId: cartId book: aBook occurences: aNumber
	(self carts at: cartId) add: aBook withOccurrences: aNumber.

 	! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 21:46:43'!
checkOutWithId: aSmallInteger card: aCard 
	self shouldBeImplemented! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 20:19:16'!
idForCart: aCart 
	^carts keyAtValue: aCart.! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 20:57:36'!
listCartWithId: aCartId
	^(self carts at: aCartId ) contents.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #'Tus-Libros-Solution'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 18:39:33'!
invalidPasswordError
	^'Invalid password for user'.! !

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 18:09:55'!
invalidUserError
	^'User not registered, out of bounds'! !

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'PR 6/26/2017 21:55:34'!
newWithUsers: anUsersDictionary catalog: aCatalog
	^self new initializeWithUsers: anUsersDictionary catalog: aCatalog.! !
