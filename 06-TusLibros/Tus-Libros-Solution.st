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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:16:37'!
test02AddingABookToACartThenCartContainsThatBook
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	
	self deny: aCart isEmpty .
	self assert: (aCart includes: aBook).
	self assert: aCart numberOfBook = 1.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:19:01'!
test03AddingSameBookToACartThenCartContainsAllTheCopiesAdded
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook.
	aCart add: aBook.
	aCart add: aBook.
	
	self assert: (aCart occurrencesOfBook: aBook) = 3.
	self assert: aCart numberOfBook = 3.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:20:07'!
test04CanAddMultipleCopiesToCartAtOnce
	
	|aBook aCart |
	
	aBook := factory bookOne.
	aCart := factory cart.
	
	aCart add: aBook withOccurrences: 4.
	aCart add: aBook withOccurrences: 3.

	self assert: (aCart occurrencesOfBook: aBook) = 7.
	self assert: aCart numberOfBook = 7.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:20:49'!
test05ACartCanHoldDifferentItems
	
	|aBook aCart anotherBook |
	
	aBook := factory bookOne.
	anotherBook := factory bookTwo.
	aCart := factory cart.
	
	aCart add: aBook withOccurrences: 4.
	aCart add: anotherBook withOccurrences: 3.

	self assert: (aCart occurrencesOfBook: aBook) = 4.
	self assert: (aCart occurrencesOfBook: anotherBook) = 3.
	self assert: aCart numberOfBook = 7.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:21:13'!
test06CanRemoveItemsFromACart
	
	"|aBook aCart anotherBook |
	
	aBook := factory bookOne.
	anotherBook := factory bookTwo.
	aCart := factory cart.
	aCart add: aBook withOccurrences: 4.
	aCart add: anotherBook withOccurrences: 3.
	
	aCart remove: aBook.
	aCart remove: anotherBook.

	self assert: (aCart occurrencesOf: aBook) = 3.
	self assert: (aCart occurrencesOf: anotherBook) = 2.
	self assert: aCart size = 5."! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:15:35'!
test07CannotAddBooksFromOtherEditorsToACart
	
	| aCart anInvalidBook |
	
	anInvalidBook := factory invalidBookOne.
	aCart := factory cart.
	
	self
		should: [ aCart add: anInvalidBook ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidBookError ].
			self assert: aCart isEmpty .
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:25:32'!
test08YouCanNotGoToTheCashierWithAnEmptyCart
	
	| aCart aCashier |
	
	aCart := factory cart.
	aCashier := factory cashier.
	self
		should: [ aCashier  makeAPurchase: aCart ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier invalidCartError ].
	
	
	! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:35:26'!
test09
	
	| aCart aCashier |
	
	aCart := factory cart.
	aCashier := factory cashier.
	aCart add: factory bookOne.
	
	self assert: (aCashier makeAPurchase: aCart  ) = 5.! !


!classDefinition: #Cart category: #'Tus-Libros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'editorialBooks contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/13/2017 21:21:49'!
add: aBook
	(editorialBooks includes: aBook) 
	ifTrue: 
		[ contents add: aBook]
	ifFalse:
		[^self error: Cart invalidBookError]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:19:46'!
add: aSmallInteger withOccurrences: aSmallInteger2 
	contents add: aSmallInteger withOccurrences: aSmallInteger2 .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:40:13'!
contents
	^contents .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/13/2017 21:28:41'!
includes: aBook
	^editorialBooks includes: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/13/2017 21:21:32'!
initializeWithEditorialBooks: aSet
	contents := Bag new.
	editorialBooks := aSet.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:18:26'!
isEmpty
	
	^contents isEmpty .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:17:33'!
numberOfBook
	^ contents size! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:18:47'!
occurrencesOfBook: aBook
	^ contents occurrencesOf: aBook .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:52:24'!
invalidBookError
	^'Invalid Book'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/13/2017 21:21:05'!
newWithEditorialBooks: anOrderedCollection

	^Cart new initializeWithEditorialBooks: anOrderedCollection.! !


!classDefinition: #Cashier category: #'Tus-Libros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:30:08'!
initializeWithListPrice: aDictionary 
	priceList := aDictionary .! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:42:02'!
makeAPurchase: aCart 
	|ticket|
	ticket := 0.
	(aCart isEmpty )ifTrue: [^ self error: Cashier invalidCartError]
		ifFalse: [ aCart contents do: [:aBook| ticket := ticket + (( aCart occurrencesOfBook: aBook ) * priceList at: aBook )] ].
		^ticket .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'Tus-Libros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:32:09'!
invalidCartError
	^ 'Invalid Cart, this is empty'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:29:17'!
newWithPriceList: aDictionary 
	^Cashier new initializeWithListPrice: aDictionary .! !


!classDefinition: #TusLibrosFactory category: #'Tus-Libros-Solution'!
Object subclass: #TusLibrosFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:15:18'!
bookOne
	^self editorialBooks at: 1.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:35:12'!
bookTwo
	^self editorialBooks at: 2.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:10:49'!
cart
	^Cart newWithEditorialBooks: self editorialBooks.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:26:48'!
cashier
	^Cashier newWithPriceList: self listPrice.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:14:59'!
editorialBooks
	| books |
	
	books := OrderedCollection new.
	
	books add: 1111.
	books add: 1234.
	
	^books.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:44:05'!
invalidBookOne
	^9999.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/15/2017 14:28:22'!
listPrice
	|prices|
	
	prices := Dictionary new.
	
	prices  at: 1111 put: 5.
	prices at: 1234 put: 10.
	
	^prices .! !
