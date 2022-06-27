Class {
	#name : #HyperjumpTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
HyperjumpTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
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

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
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
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Valen') position) distance equals: 1.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Pablo') position) distance equals: 0.
	game playATurn.
	self assert:'Seba' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Seba')position) distance equals: 1
]

{ #category : #tests }
HyperjumpTest >> testHyperjumpDistanceSequenceIsAlwaysInDecreasingOrder [

	| dieOne dieTwo dieThree aDiceCup game boxSequence |
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 1.
	dieThree := LoadedDie with: 2.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
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
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:'Valen' isAt:8 with:1 in: game.
	self assert: ((game spaceshipOf: 'Valen') position) distance equals: 1.
	game playATurn.
	self assert:'Pablo' isAt:7 with:1 in: game.
	self assert: ((game spaceshipOf: 'Pablo') position) distance equals: 1.
	game playATurn.
	self assert:'Seba' isAt:8 with:1 in: game.
	self assert: ((game spaceshipOf: 'Seba')position) distance equals: 1
]
