!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'GOLFactory' stamp: 'PR 5/14/2017 21:45:22'!
createGOL: aListOfAliveCells withBoardSize: aPoint
	^GameOfLife withLiveCells: aListOfAliveCells withWidth: aPoint x withHeight: aPoint y.! !


!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:45:33'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := self createGOL: { 1@1 } withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:45:45'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := self createGOL: { 1@1. 2@0. 1@0. } withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:45:52'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := self createGOL: { 1@1. 2@0. 1@0. 1@2. } withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:46:01'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := self createGOL: { 1@1. 2@0. 1@0. 1@2. 0@1. } withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:46:08'!
test05DeadCellWithThreeAliveNeighResurrects
	| gameOfLife |
	
	gameOfLife := self createGOL: { 2@0. 1@0. 0@0.} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny:  (gameOfLife isDeadAt: 1@1).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:48:45'!
test06CreateCellOutsideBoundsXPositive
	self assertOutsideBoundsRaisesOn: [self createGOL: {2@0. 1@0. 4@2.} withBoardSize: 3@3. ].! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:49:11'!
test07CreateCellOutsideBoundsXNegative
	self assertOutsideBoundsRaisesOn: [self createGOL: {2@0. 1@0. -1@2.} withBoardSize: 3@3. ].! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:49:30'!
test08CreateCellOutsideBoundsYPositive
	self assertOutsideBoundsRaisesOn: [self createGOL: {2@0. 1@0. -1@2.} withBoardSize: 3@3. ].! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:49:42'!
test09CreateCellOutsideBoundsYNegative
	self assertOutsideBoundsRaisesOn: [self createGOL: {2@0. 1@0. 1@-4.} withBoardSize: 3@3. ].! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:38:19'!
test10EveryoneDeadEveryoneStaysDead
	| gameOfLife |
	
	gameOfLife := self createGOL: {} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert:  (gameOfLife aliveCells isEmpty).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:40:20'!
test11AllAliveThenCornersSurvive
	| gameOfLife |
	
	gameOfLife := self createGOL: { 0@0. 0@1. 0@2. 1@0. 1@1. 1@2. 1@2. 2@0. 2@1. 2@2.} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert:  (gameOfLife isAliveAt: 0@0).
	self assert:  (gameOfLife isAliveAt: 2@2).
	self assert:  (gameOfLife isAliveAt: 0@2).
	self assert:  (gameOfLife isAliveAt: 2@0).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:39:12'!
test12DeadCellsWithOneAliveNeighStaysDead
	| gameOfLife |
	
	gameOfLife := self createGOL: { 0@0.} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert:  (gameOfLife aliveCells isEmpty).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:39:29'!
test13DeadCellsWithTwoAliveNeighStaysDead
	| gameOfLife |
	
	gameOfLife := self createGOL: { 0@0. 0@1.} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert:  (gameOfLife aliveCells isEmpty).! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'PR 5/16/2017 18:40:03'!
test14DeadCellWithMoreThanThreeAliveNeighStaysDead
	| gameOfLife |
	
	gameOfLife := self createGOL: { 0@0. 2@2. 0@2. 2@0.} withBoardSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert:  (gameOfLife isDeadAt: 1@1).! !


!GOLTest methodsFor: 'asserting' stamp: 'PR 5/16/2017 18:46:37'!
assertOutsideBoundsRaisesOn: aBlock

	self should: aBlock
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: anError messageText equals: GameOfLife cellOutOfBoardBoundsException]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'initialization' stamp: 'PR 5/14/2017 18:59:28'!
initializeWith: aCollectionOfAliveCells withBoard: aBoard 
	aliveCells := aCollectionOfAliveCells.
	board := aBoard.! !


!GameOfLife methodsFor: 'stepping' stamp: 'PR 5/15/2017 02:08:56'!
nextGeneration
	aliveCells := (aliveCells select: [ :anAliveCell | self hasToSurvive: anAliveCell]) union: 
		(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell])! !


!GameOfLife methodsFor: 'evaluating' stamp: 'PR 5/14/2017 21:06:14'!
isAliveAt: aCell

	^aliveCells includes: aCell! !

!GameOfLife methodsFor: 'evaluating' stamp: 'PR 5/14/2017 21:06:42'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not! !

!GameOfLife methodsFor: 'evaluating' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'predicting' stamp: 'PR 5/11/2017 21:18:15'!
hasToResurrect: aCell 
	^(self numberOfAliveNeighboursOf: aCell) = 3.! !

!GameOfLife methodsFor: 'predicting' stamp: 'PR 5/11/2017 19:57:52'!
hasToSurvive: aCell
	| aliveNeighbours |
	
	aliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^aliveNeighbours = 2 or: [aliveNeighbours = 3].! !


!GameOfLife methodsFor: 'accessing' stamp: 'PR 5/14/2017 21:25:28'!
aliveCells
	^aliveCells.! !

!GameOfLife methodsFor: 'accessing' stamp: 'PR 5/14/2017 21:08:58'!
deadCells
	| deadCells |
	
	deadCells := OrderedCollection new.	

	(board left) to: (board right) 
		do: [ :x | (board top) to: (board bottom) 
			do: [ :y | (self isAliveAt: x@y) ifFalse: [deadCells add: x@y] ]
		].

	^deadCells.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'PR 5/11/2017 20:40:20'!
cellOutOfBoardBoundsException
	^'celda fuera del tablero'! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 19:33:06'!
withLiveCells: aCollectionOfAliveCells withBoardSize: aPoint 

	| board |
	
	board := 0@0 rect: aPoint.
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | board containsPoint: aCell]) 
		ifFalse: [ ^self error: GameOfLife cellOutOfBoardBoundsException ].
	
	^self new initializeWith: aCollectionOfAliveCells asSet withBoard: board.! !

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'PR 5/14/2017 21:46:57'!
withLiveCells: aCollectionOfAliveCells withWidth: aWidth withHeight: aHeight 

	| board |
	
	board := 0@0 rect: aWidth@aHeight.
	
	(aCollectionOfAliveCells allSatisfy: [:aCell | board containsPoint: aCell]) 
		ifFalse: [ ^self error: GameOfLife cellOutOfBoardBoundsException ].
	
	^self new initializeWith: aCollectionOfAliveCells asSet withBoard: board.! !
