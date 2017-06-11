!classDefinition: #TusLibrosTest category: #'Tus-Libros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:30:04'!
test01ANewCartContainsNothing

	self assert: Cart new isEmpty .! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:42:09'!
test02IfIAddABookToACartThisIsNotEmpty
	|aBook|
	aBook := Book new.
	self deny: (Cart new addBook:aBook) isEmpty .! !


!classDefinition: #Book category: #'Tus-Libros-Solution'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!


!classDefinition: #Cart category: #'Tus-Libros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:40:14'!
addBook: aBook
	content add: aBook .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:21:39'!
contents
	^ content .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:40:53'!
initialize
	content := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Mirko 6/9/2017 00:43:54'!
isEmpty
	^content isEmpty.! !
