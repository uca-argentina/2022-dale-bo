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
GameTest >> testAGameHasABoardWithAWormHoleInFivePositionAndValentinEndsUpInPositionOne [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect newPosition wormHole |
	noEffect := Box new.
	wormHole := WormHole new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          wormHole.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 2.
	aDiceCupForValen := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCupForValen.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 6
]

{ #category : #tests }
GameTest >> testAGameHasABoardWithNoEffectsAndValenWinsTheGame [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
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
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game winner equals: 'Valen'.
	self deny: game winner equals: 'Pablito'
]

{ #category : #tests }
GameTest >> testAGameHasABoardWithSpeedUpInFivePositionAndValentinEndsUpInNinePositon [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect speedUp newPosition |
	noEffect := Box new.
	speedUp := SpeedUp new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          speedUp.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 2.
	aDiceCupForValen := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCupForValen.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 6
]

{ #category : #tests }
GameTest >> testAGameHasAWinner [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
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
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game winner equals: 'Valen'.
	self deny: game winner equals: 'Pablito'
]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipWins [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game with: { 'Valen'. 'Pablo' } a: aBoard and: aDiceCup.
	self assert: game hasFinished equals: false.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game hasFinished equals: true
]

{ #category : #tests }
GameTest >> testAGameIsCreatedWithLessThanTwoShips [

	| aBoard dieOne dieTwo dieThree aDiceCup noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	self
		should: [ Game with: { 'Valen' } a: aBoard and: aDiceCup ]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testAGameRetrunsPositionOfShipAfterItMoves [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
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
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game boxNumberOf: 'Valen') equals: 12.
	self assert: (game boxNumberOf: 'Pablo') equals: 7
]

{ #category : #tests }
GameTest >> testAGameRetrunsRanking [

	| aBoard dieOne dieTwo dieThree aDiceCup game box |
	box := Box new.
	aBoard := Board withAll: { 
			          box.
			          box.
			          box.
			          box.
			          box.
			          box.
			          box }.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game with: { 'Valen'. 'Pablo'. 'AA' } a: aBoard and: aDiceCup.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Valen') equals: 1.
	self assert: (game rankingOf: 'Pablo') equals: 2.
	self assert: (game rankingOf: 'AA') equals: 2
]

{ #category : #tests }
GameTest >> testAGameStartsWithShipsAtPosition0 [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box new.
	aBoard := Board withAll: { 
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect.
			          noEffect }.
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
	self assert: (game boxNumberOf: 'Valen') equals: 1
]
