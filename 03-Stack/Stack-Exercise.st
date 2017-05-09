!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:16:49'!
initialize
	container := OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:17:22'!
isEmpty
	^container isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:17:56'!
pop
	^(OOStackState stateFor: self) pop: self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:21:01'!
push: anObject
	container add: anObject .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:21:17'!
safePop
	^container removeLast! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:21:25'!
safeTop
	^container first ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:21:33'!
size
	^container size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:21:41'!
top
	^(OOStackState stateFor: self) top: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:18:34'!
stateFor: aStack
	^(self allSubclasses detect: [ :state | state canHandle: aStack ]) new! !


!classDefinition: #OOEmptyStackState category: #'Stack-Exercise'!
OOStackState subclass: #OOEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStackState methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:19:40'!
pop: aStack
	self error: aStack class stackEmptyErrorDescription ! !

!OOEmptyStackState methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:19:51'!
top: aStack
	self error: aStack class stackEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyStackState class' category: #'Stack-Exercise'!
OOEmptyStackState class
	instanceVariableNames: ''!

!OOEmptyStackState class methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:19:23'!
canHandle: aStack
	^aStack isEmpty ! !


!classDefinition: #OOLoadedStackState category: #'Stack-Exercise'!
OOStackState subclass: #OOLoadedStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLoadedStackState methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:20:10'!
pop: aStack
	^aStack safePop.! !

!OOLoadedStackState methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:20:28'!
top: aStack
	^aStack safeTop.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLoadedStackState class' category: #'Stack-Exercise'!
OOLoadedStackState class
	instanceVariableNames: ''!

!OOLoadedStackState class methodsFor: 'as yet unclassified' stamp: 'PR 5/8/2017 21:19:16'!
canHandle: aStack
	^aStack isEmpty not! !
