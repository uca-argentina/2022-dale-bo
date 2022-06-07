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

	| dieOne dieTwo dieThree aDiceCup game|
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	[ game hasFinished ] whileFalse: [ game playATurn].
	self
		should: [ game playATurn ]
		raise: Error
		withMessage: 'Turn cannot be played, games has finished'
]

{ #category : #tests }
GameTest >> testAGameHasABoardWithAAtomicBombInPositionThreeAndTheEffectDoenstChangeLaps [

	| dieOne dieTwo dieThree aDiceCup game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 3.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (AtomicBombEffect new )  
		        at: 2
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn .
	game playATurn .
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 7.
	game playATurn .
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Valen') lapNumber equals: 2.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 1.
]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipInTheLastPositionOfTheLastLap [

	|dieOne dieTwo dieThree aDiceCup game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	self deny: game hasFinished.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: game hasFinished.
	self assert: (game positionOfShip:(game winner) ) boxNumber equals:13.
	self assert: (game positionOfShip:(game winner) ) lapNumber equals:2.
]

{ #category : #tests }
GameTest >> testAGameHasNoWinnerBeforeItsFinished [

	| dieOne dieTwo dieThree aDiceCup game  |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	 game playATurn .
	self assert: game winner equals: 'No one'
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInLapTwo [

	| dieOne dieTwo dieThree aDiceCup game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game positionOfShip: 'Valen') lapNumber equals:2.
]

{ #category : #tests }
GameTest >> testAGameIsPlayedAndValenEndsInPositionOneAndTheOthersInTheSecondPosition [

	| dieOne dieTwo dieThree aDiceCup game  |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn .
	game playATurn .
	game playATurn.
	game playATurn.
	self assert: (game rankingOf: 'Valen') equals: 1.
	self assert: (game rankingOf: 'Pablo') equals: 2.
	self assert: (game rankingOf: 'Seba') equals: 2
]

{ #category : #tests }
GameTest >> testAGameReturnsPositionOfShipAfterItMoves [

	| dieOne dieTwo dieThree aDiceCup game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	[ game hasFinished ] whileFalse: [ game playATurn ].
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 13.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 12
]

{ #category : #tests }
GameTest >> testAGameStartsWithShipsAtPositionOne [

	| dieOne dieTwo dieThree aDiceCup game |

	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	self assert: (game positionOfShip: 'Valen') boxNumber  equals: 1
]

{ #category : #tests }
GameTest >> testAllPlayersLandInHyperJumpAtBoxFiveAndTheyMoveFirstFiveParsecsAndThenFourAndTheSequenceRestarts [

	| dieOne dieTwo dieThree aDiceCup game |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (HyperJumpEffect with:{5. 4})
		        at: 4
		        of: 10
		        distance: 20
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Valen') parsecNumber equals: 1.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Pablo') parsecNumber equals: 0.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Seba') parsecNumber equals: 1
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithLessThanTwoShips [

	|dieOne dieTwo dieThree aDiceCup|
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.

self
		should: [ Game
		        ships: { 'Valen'. } 
		        boardWithNoEffectsOf: 13 
		        distance: 200
		        laps: 2
		        and: aDiceCup.]
		raise: Error
		withMessage: 'Game must have more than one Ship'
]

{ #category : #tests }
GameTest >> testValenLandsInAMoonwalkAtBoxSevenAndMakeTheOthersGoBackTwoPositions [

	| dieOne dieTwo dieThree game aDiceCup |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (MoonwalkEffect with:2)
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 4.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 2.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 2
]

{ #category : #tests }
GameTest >> testValenLandsInAMoonwalkAtBoxSixAndMakeTheOthersGoBackTwoPositions [

	| dieOne dieTwo dieThree game aDiceCup |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (MoonwalkEffect with:2)
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 4.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 2.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 2
]

{ #category : #tests }
GameTest >> testValenLandsInASpeedupBoxInPositionFiveAndMovesToPositionNine [

	| dieOne dieTwo dieThree aDiceCup game newPosition |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	game := Game
		        ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (SpeedUpEffect new)  
		        at: 4
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 9
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxSevenAndGoesBackFourBoxesToEndAtBoxNumberThree [

	| dieOne dieTwo dieThree aDiceCup game newPosition |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (WormHoleEffect new)  
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 3.
	self assert: newPosition lapNumber equals: 1
]

{ #category : #tests }
GameTest >> testValenLandsInWormholeAtBoxThreeOfLapTwoAndStepBackFourBoxesToEndAtBoxNumberNineAndLapOne [

	| dieOne dieTwo dieThree aDiceCup game newPosition wormhole |
	wormhole := WormHoleEffect with:2.
	dieOne := LoadedDie with: 9.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (WormHoleEffect new)  
		        at: 2
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	newPosition := game positionOfShip: 'Valen'.
	self assert: newPosition boxNumber equals: 9.
	self assert: newPosition lapNumber equals:1.
]
