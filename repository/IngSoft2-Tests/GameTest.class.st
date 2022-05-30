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
GameTest >> testAGameCannotBePlayedAfterItHasFinished [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
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
				          noEffect }
		          and: 2.
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
	self
		should: [ game playATurn ]
		raise: Error
		withMessage: 'Turn cannot be played, games has finished'
]

{ #category : #tests }
GameTest >> testAGameHasABoardWithAAtomicBombInPositionThreeAndTheEffectDoenstChangeLaps [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect atomicBomb|
	noEffect := Box parsecs: 2.
	atomicBomb := AtomicBomb with:2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          atomicBomb.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.				          
							 noEffect.
							 noEffect.
							 noEffect. }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 3.
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
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 7.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Valen') lapNumber equals: 2.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 1.
]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipInTheLastPositionOfTheLastLap [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
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
				          noEffect }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game with: { 'Valen'. 'Pablo' } a: aBoard and: aDiceCup.
	self deny: game hasFinished.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game hasFinished.
	self assert: (game positionOfShip:(game winner) ) boxNumber equals:13.
	self assert: (game positionOfShip:(game winner) ) lapNumber equals:2.
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInLapTwo [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect }
		          and: 2.
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
	self assert: (game positionOfShip: 'Valen') lapNumber equals:2.
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInPositionOneAndTheOthersInTheSecondPosition [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect  |
	noEffect  := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
				          noEffect .
				          noEffect .
				          noEffect .
				          noEffect .
				          noEffect .
				          noEffect .
				          noEffect  }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game with: { 'Valen'. 'Pablo'. 'AA' } a: aBoard and: aDiceCup.
	game playATurn .
	game playATurn .
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Valen') equals: 1.
	self assert: (game rankingOf: 'Pablo') equals: 2.
	self assert: (game rankingOf: 'AA') equals: 2
]

{ #category : #tests }
GameTest >> testAGameReturnsPositionOfShipAfterItMoves [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
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
				          noEffect }
		          and: 2.
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
	self assert: (game positionOfShip: 'Valen') boxNumber  equals: 13.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 12.
]

{ #category : #tests }
GameTest >> testAGameStartsWithShipsAtPositionOne [

	| aBoard dieOne dieTwo dieThree aDiceCup game noEffect |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect }
		          and: 2.
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
	self assert: (game positionOfShip: 'Valen') boxNumber  equals: 1
]

{ #category : #tests }
GameTest >> testAllPlayersLandInHyperJumpAtBoxFiveAndTheyMoveFirstFiveParsecsAndThenFourAndTheSequenceRestarts [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect hyperJump|
	noEffect := Box parsecs: 2.
	hyperJump := HyperJump with: {5. 4.} parsecs: 2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.				        
				          noEffect.
				          noEffect.
							 hyperJump.
				          noEffect.
				          noEffect.				          
							 noEffect.
							 noEffect.
							 noEffect. }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
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
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Valen') parsecNumber equals: 1.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Pablo') parsecNumber equals: 0.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Seba') parsecNumber equals: 1.
	
	
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithLessThanTwoShips [

	| noEffect aBoard dieOne dieTwo dieThree aDiceCup game |
	noEffect := Box parsecs: 2.
	aBoard := Board
		          withAll: { 
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
				          noEffect }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.

self
		should: [ Game
		        with: { 'Valen' }
		        a: aBoard
		        and: aDiceCup.]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testValenLandsInAMoonwalkAtBoxSixAndMakeTheOthersGoBackTwoPositions [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect moonwalk |
	noEffect := Box parsecs: 2.
	moonwalk := Moonwalk with: 2 and:2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          moonwalk.
				          noEffect.
				          noEffect.
				          noEffect }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCupForValen := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        a: aBoard
		        and: aDiceCupForValen.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 4.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 2.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 2.
]

{ #category : #tests }
GameTest >> testValenLandsInASpeedupBoxInPositionFiveAndMovesToPositionNine [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect speedUp newPosition |
	noEffect := Box parsecs: 2.
	speedUp := SpeedUp with:2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          speedUp.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect }
		          and: 2.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCupForValen := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game
		        with: {'Valen'.'Pablo'.'Seba'}
		        a: aBoard
		        and: aDiceCupForValen.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 9.
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxSevenAndGoesBackFourBoxesToEndAtBoxNumberThree [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect newPosition wormhole |
	noEffect := Box parsecs: 2.
	wormhole := WormHole with: 2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          wormhole.
				          noEffect.
				          noEffect.
				          noEffect }
		          and: 2.
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
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
	self assert: newPosition boxNumber equals: 3.
	self assert: newPosition lapNumber equals: 1
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxThreeOfLapTwoAndStepBackFourBoxesToEndAtBoxNumberNineAndLapOne [

	| aBoard dieOne dieTwo dieThree aDiceCupForValen game noEffect newPosition wormhole |
	noEffect := Box parsecs: 2.
	wormhole := WormHole with:2.
	aBoard := Board
		          withAll: { 
				          noEffect.
				          noEffect.
				          wormhole.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          noEffect.
				          }
		          and: 2.
	dieOne := LoadedDie with: 9.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
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
	self assert: newPosition boxNumber equals: 9.
	self assert: newPosition lapNumber equals:1.
]
