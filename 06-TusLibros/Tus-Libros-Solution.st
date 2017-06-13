!classDefinition: #Cart category: #'Tus-Libros-Solution'!
Bag subclass: #Cart
	instanceVariableNames: 'editorialBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:11:53'!
add: aBook
	(editorialBooks includes: aBook) 
	ifTrue: 
		[ super add: aBook]
	ifFalse:
		[^self error: Cart invalidBookError]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:10:29'!
initializeWithEditorialBooks: aSet
	editorialBooks := aSet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Tus-Libros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:52:24'!
invalidBookError
	^'Invalid Book'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:14:45'!
newWithEditorialBooks: anOrderedCollection
	^Cart new initializeWithEditorialBooks: anOrderedCollection.! !


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

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:39:45'!
test06CanRemoveItemsFromACart
	
	|aBook aCart anotherBook |
	
	aBook := factory bookOne.
	anotherBook := factory bookTwo.
	aCart := factory cart.
	aCart add: aBook withOccurrences: 4.
	aCart add: anotherBook withOccurrences: 3.
	
	aCart remove: aBook.
	aCart remove: anotherBook.

	self assert: (aCart occurrencesOf: aBook) = 3.
	self assert: (aCart occurrencesOf: anotherBook) = 2.
	self assert: aCart size = 5.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 18:52:15'!
test07CannotAddBooksFromOtherEditorsToACart
	
	| aCart anInvalidBook |
	
	anInvalidBook := factory invalidBookOne.
	aCart := factory cart.
	
	self
		should: [ aCart add: anInvalidBook ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidBookError ]
	
	
	! !


!classDefinition: #TusLibrosFactory category: #'Tus-Libros-Solution'!
Object subclass: #TusLibrosFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:15:18'!
bookOne
	^self editorialBooks at: 1.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:15:22'!
bookTwo
	^self editorialBooks at: 2.! !

!TusLibrosFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/13/2017 19:10:49'!
cart
	^Cart newWithEditorialBooks: self editorialBooks.! !

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
