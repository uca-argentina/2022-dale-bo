Class {
	#name : #HyperjumpTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
HyperjumpTest >> assert: aSpaceshipName isAtPostion: aPositionNumber with: aLapNumber atDistance: aDistance in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	self assert: spaceshipPosition distance equals: aDistance.
]

{ #category : #tests }
HyperjumpTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	(boardSize-1) timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced -1.
	^ boxSequence
]

{ #category : #asserting }
HyperjumpTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
HyperjumpTest >> testAllPlayersLandInHyperJumpAtBoxFiveAndTheyMoveFirstFiveParsecsAndThenFourAndTheSequenceRestarts [

	| die game boxSequence |
	die:= LoadedDie with: 4.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Valen'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Pablo'
		isAtPostion: 7
		with: 1
		atDistance: 0
		in: game.
	game playATurn.
	self
		assert: 'Seba'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
]

{ #category : #tests }
HyperjumpTest >> testHyperjumpCannotBeCreatedWithNegativeDistances [

	self
		should: [ HyperJumpEffect with: { Parsecs with:-1. } ]
		raise: Error
		withMessage: 'Distances must be greater than zero'
]

{ #category : #tests }
HyperjumpTest >> testHyperjumpCannotBeCreatedWithoutDistances [

	self
		should: [ HyperJumpEffect with: {  } ]
		raise: Error
		withMessage: 'There are no posible moves'
]

{ #category : #tests }
HyperjumpTest >> testHyperjumpDistanceSequenceIsAlwaysInDecreasingOrder [

	| die game boxSequence |
	die := LoadedDie with: 4.
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 21) })
		               at: 5.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Valen'
		isAtPostion: 8
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Pablo'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Seba'
		isAtPostion: 8
		with: 1
		atDistance: 1
		in: game.
]
