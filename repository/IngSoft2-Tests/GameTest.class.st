Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aBlock raise: anError withMessage: anErrorMessage [

	| tmp2 tmp3 |
	aBlock
		on: anError
		do: [ :error | 
			tmp2 := true.
			tmp3 := error messageText ].
	self
		assert: tmp2;
		assert: tmp3 equals: anErrorMessage
]

{ #category : #tests }
GameTest >> testAGameHasAWinner [

	| aBoard dieOne dieTwo dieThree aDiceCup game |
	aBoard := Board with: 60.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCup.
	[game hasFinished] whileFalse:  [game playATurn].
	self assert: (game winner) equals: 'Valen'.
	self deny: (game winner) equals: 'Pablito'.
	

]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipWins [

	| aBoard dieOne dieTwo dieThree aDiceCup game |
	aBoard := Board with: 6.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCup.
	self assert: (game hasFinished) equals:false.
	game playATurn.
	self assert: (game hasFinished) equals:true.

]

{ #category : #tests }
GameTest >> testAGameIsCreatedWithLessThanTwoShips [

	| aBoard dieOne dieTwo dieThree aDiceCup |
	aBoard := Board with: 6.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	self
		should: [ 
		Game with: { 'Valen' } a: aBoard and: aDiceCup ]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testAGameRetrunsPositionOfShipAfterItMoves [

	| aBoard dieOne dieTwo dieThree aDiceCup game |
	aBoard := Board with: 15.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCup.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game boxNumberOf: 'Valen') equals: 12.
	self assert: (game boxNumberOf: 'Pablo') equals: 6.
]

{ #category : #tests }
GameTest >> testAGameRetrunsRanking [

	| aBoard dieOne dieTwo dieThree aDiceCup game |
	aBoard := Board with: 15.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'AA' }
		        a: aBoard
		        and: aDiceCup.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Valen') equals: 1.
	self assert: (game rankingOf: 'Pablo') equals: 3.
	self assert: (game rankingOf: 'AA') equals: 2.
]

{ #category : #tests }
GameTest >> testAGameStartsWithShipsAtPosition0 [

	| aBoard dieOne dieTwo dieThree aDiceCup game |
	aBoard := Board with: 6.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCup.
	self assert: (game boxNumberOf: 'Valen') equals: 0
]
