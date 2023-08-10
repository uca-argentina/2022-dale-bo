Class {
	#name : #HyperjumpTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
HyperjumpTest >> assert: aSpaceshipName isAtPostion: aPositionNumber with: aLapNumber atDistance: aDistance in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
	self assert: spaceshipPosition distanceInBox equals: aDistance.
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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAtPostion: 7
		with: 1
		atDistance: 0
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Gamma'
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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Lightyear with: 60)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self
		assert: 'Spaceship Alpha'
		isAtPostion: 8
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Beta'
		isAtPostion: 7
		with: 1
		atDistance: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Gamma'
		isAtPostion: 8
		with: 1
		atDistance: 1
		in: game.
]

{ #category : #tests }
HyperjumpTest >> testPrueba [
| die game boxSequence noEffect spaceship |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	spaceship:= (game boardFalopa) spaceshipOf: 'Spaceship Alpha'.
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 5.
	self assert:'Spaceship Alpha'  isAtPostion:6  with:1  atDistance:0 in: game. 
]

{ #category : #tests }
HyperjumpTest >> testPrueba2 [
| die game boxSequence noEffect |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 5.
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 5.
	self assert:'Spaceship Alpha'  isAtPostion:1  with:2  atDistance:0 in: game. 
]

{ #category : #tests }
HyperjumpTest >> testPrueba3 [
| die game boxSequence noEffect |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 5.
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: -3.
	self assert:'Spaceship Alpha'  isAtPostion:3  with:1  atDistance:0 in: game. 
]

{ #category : #tests }
HyperjumpTest >> testPrueba4 [
| die game boxSequence noEffect |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 15.
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: -8.
	self assert:'Spaceship Alpha'  isAtPostion:8  with:1  atDistance:0 in: game. 
]

{ #category : #tests }
HyperjumpTest >> testPrueba5 [
| die game boxSequence noEffect |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 1
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 11.
	self assert:'Spaceship Alpha'  isAtPostion:10  with:1  atDistance:0 in: game. 
]

{ #category : #tests }
HyperjumpTest >> testPrueba6 [
| die game boxSequence noEffect |
	die := Die with: 5.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesEffectsGenerator
		                generate: 10
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 1
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	(game boardFalopa ) moveDef:'Spaceship Alpha'  to: 9.
	self assert:'Spaceship Alpha'  isAtPostion:10  with:1  atDistance:0 in: game. 
]
