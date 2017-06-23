!classDefinition: #TusLibrosTest category: #'Tus-Libros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 15:23:15'!
setUp
	factory := TusLibrosFactory new.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 15:58:21'!
test01ANewCartContainsNothing

	self assert: factory cart isEmpty .! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 15:58:53'!
test02AddingABookToACartThenCartContainsThatBook
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	
	self deny: aCart isEmpty .
	self assert: (aCart includes: aBook).
	self assert: aCart size = 1.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 15:59:09'!
test03AddingSameBookToACartThenCartContainsAllTheCopiesAdded
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	aCart add: aBook.
	aCart add: aBook.
	
	self assert: (aCart occurrencesOf: aBook) = 3.
	self assert: aCart size = 3.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:35:20'!
test04CanAddMultipleCopiesToCartAtOnce
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook withOccurrences: 4.
	aCart add: aBook withOccurrences: 3.

	self assert: (aCart occurrencesOf: aBook) = 7.
	self assert: aCart size = 7.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:36:02'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:48:45'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/15/2017 19:14:24'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:39:17'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:40:08'!
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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:43:08'!
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


!classDefinition: #Cart category: #'Tus-Libros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/15/2017 19:11:55'!
add: aBook
	self add: aBook withOccurrences: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/18/2017 21:30:46'!
add: anItem withOccurrences: anAmount 
	anAmount <= 0 ifTrue: [^self error: Cart invalidAmount ].
	(catalog includesKey: anItem) 
		ifTrue: [contents add: anItem withOccurrences: anAmount.]
	ifFalse:
		[^self error: Cart invalidBookError]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/15/2017 19:47:09'!
contents
	^contents copy.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:45:30'!
includes: anItem
	^contents includes: anItem.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:45:08'!
initializeWithCatalog: aCatalog
	catalog := aCatalog.
	contents := Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:43:58'!
isEmpty
	^contents isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:46:22'!
occurrencesOf: anItem
	^contents occurrencesOf: anItem.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:45:53'!
size
	^contents size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:50:11'!
invalidAmount
	^'Invalid amount'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:52:24'!
invalidBookError
	^'Invalid Book'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:43:28'!
newWithCatalog: aCatalog
	^Cart new initializeWithCatalog: aCatalog.! !


!classDefinition: #Cashier category: #'Tus-Libros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList today salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:43:38'!
checkout: aCart with: aCard
	| ticket |
	
	aCart isEmpty ifTrue:[self error: Cashier cannotCheckoutEmptyCartError.].
	
	(aCard < Date today) ifTrue: [self error: Cashier cannotCheckoutWithExpiredCardError].
	
	ticket := 0.
	aCart contents do: [ :aBook | ticket := ticket + (self price: aBook).].
	
	salesBook add: ticket.
	^ticket.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:53:19'!
initializeWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection
	priceList := aPriceList.
	today := aDate.
	salesBook := anOrderedCollection.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PR 6/15/2017 19:45:57'!
price: aBook
	^priceList at: aBook.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:37:11'!
sales
	^salesBook copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'Tus-Libros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'PR 6/15/2017 19:28:24'!
cannotCheckoutEmptyCartError
	^'Empty Cart, cannot checkout'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 19:21:10'!
cannotCheckoutWithExpiredCardError
	^'Cannot checkout with expired card'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:53:39'!
newWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection.
	^self new initializeWithPriceList: aPriceList withToday: aDate withSalesBook: anOrderedCollection.! !


!classDefinition: #TusLibrosFactory category: #'Tus-Libros-Solution'!
Object subclass: #TusLibrosFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/18/2017 21:26:56'!
bookOne
	^self catalog keys at: 1.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/18/2017 21:27:20'!
bookTwo
	^self catalog keys at: 2.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 18:48:49'!
card
	^Date today + (Duration days: 30).! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/14/2017 22:43:15'!
cart
	^Cart newWithCatalog: self catalog.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:30:14'!
cashier
	^Cashier newWithPriceList: self catalog withToday: Date today withSalesBook: self salesBook.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/18/2017 21:32:46'!
catalog
	| books |
	
	books := Dictionary new.
	
	books at: 1111 put: 1.
	books at: 1234 put: 2.
	
	^books.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 18:33:19'!
expiredCard
	^Date newDay: 31 month: 'March' year: 2017.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:44:05'!
invalidBookOne
	^9999.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/22/2017 22:54:08'!
salesBook
	^OrderedCollection new.! !
