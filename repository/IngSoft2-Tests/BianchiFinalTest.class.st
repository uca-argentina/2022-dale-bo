Class {
	#name : #BianchiFinalTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'repeatCard',
		'freedomCard',
		'reverseCard',
		'skipCard',
		'doubleCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
BianchiFinalTest >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: (aGame handOf: aSpaceship) numberOfCards equals: aNumberOfCards.

]

{ #category : #initialization }
BianchiFinalTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := aGame positionOf: aSpaceshipName.
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #initialization }
BianchiFinalTest >> setUp [
	super setUp.
	die:= LoadedDie with:6.
	freedomCard:= FreedomCard new.
	reverseCard:= ReverseCard new.
	skipCard:= SkipCard new.
	doubleCard:= DoubleCard new.
]

{ #category : #initialization }
BianchiFinalTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
BianchiFinalTest >> testRedoDouble [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { doubleCard }).
	"Juega Alpha"
	game playATurn.
	"Juega Beta"
	game playATurn.
	"Tira carta y repite turno"
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	doubleCard playedOn:game  by:'Spaceship Alpha'.
	"Juega Alpha"
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 6  with:2  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testRedoReverse [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { doubleCard }).
	"Juega Alpha"
	game playATurn.
	"Juega Beta"
	game playATurn.
	"Tira carta y repite turno"
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	doubleCard playedOn:game  by:'Spaceship Alpha'.
	"Juega Alpha"
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 6  with:2  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testRedoSkip [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { doubleCard }).
	"Juega Alpha"
	game playATurn.
	"Juega Beta"
	game playATurn.
	"Tira carta y repite turno"
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	doubleCard playedOn:game  by:'Spaceship Alpha'.
	"Juega Alpha"
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 6  with:2  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testRepeatJail [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { doubleCard }).
	"Juega Alpha"
	game playATurn.
	"Juega Beta"
	game playATurn.
	"Tira carta y repite turno"
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	doubleCard playedOn:game  by:'Spaceship Alpha'.
	"Juega Alpha"
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 6  with:2  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaLandsInJailAndGetsImprisoned [
	| jailEffect boxSequence game |
	jailEffect := DiscreteProbabilityEvent for: JailEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { jailEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:true.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Beta') equals:false.
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaLandsInJailAndGetsOutByThrowingMaxDiceSum [
	| jailEffect boxSequence game dieOne dieTwo aDiceCup |
	dieOne := LoadedDie  with: 6.
	dieTwo := LoadedDie with: 6.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo. }.
	jailEffect := DiscreteProbabilityEvent for: JailEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { jailEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	self assert: 'Spaceship Alpha' isAt:13  with:1  in: game.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:true.
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Beta') equals:true.
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:false.
	game playATurn.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt:12  with:2 in: game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaLandsInJailAndPlaysFreedomCard [
	| jailEffect boxSequence game |
	jailEffect := DiscreteProbabilityEvent for: JailEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { jailEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { freedomCard }).
	game playATurn.
	self assert: 'Spaceship Alpha' isAt:7  with:1  in:game.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:true.
	freedomCard playedOn: game by: 'Spaceship Alpha'. 
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:false.
	game playATurn.
	game playATurn.
	self assert: 'Spaceship Alpha' isAt:13  with:1  in:game.
	self assert:'Spaceship Alpha' handHas: 1  in: game.
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaLandsInJailGetsMaxSumAndKeepMovingOn [
"Ver Nombre Tests"
	| jailEffect boxSequence game |
	jailEffect := DiscreteProbabilityEvent for: JailEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { jailEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { SpeedCard new }).
	game playATurn.
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha'  isAt: 7  with:1  in: game.
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha'  isAt: 13  with:1  in: game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaPlays2ReverseCard [
	| noEffect boxSequence game |
	"Revisar abajo cosas"
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reverseCard }).
	"Juega A"
	game playATurn.
	"Juega B"
	game playATurn.
	self assert:'Spaceship Beta' isAt: 7  with:1  in:game.
	reverseCard playedOn:game  by:'Spaceship Alpha'.
	"Juega C"
	game playATurn.
	reverseCard playedOn:game  by:'Spaceship Gamma'.
	"Juega A"
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 13  with:1  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaPlaysDoubleCard [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { doubleCard }).
	"Juega Alpha"
	game playATurn.
	"Juega Beta"
	game playATurn.
	"Tira carta y repite turno"
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	doubleCard playedOn:game  by:'Spaceship Alpha'.
	"Juega Alpha"
	game playATurn.
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 6  with:2  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaPlaysFreedomCardWhileNotInJailAndGetsError [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: {  freedomCard }).
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:false.
	game playATurn.
	self should:[freedomCard playedOn: game by: 'Spaceship Alpha'] raise:Error  withMessage:'You cant free a spaceship thats not in prison'. 
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaPlaysReverseCard [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { reverseCard }).
	"Juega A"
	game playATurn.
	"Juega B"
	game playATurn.
	self assert:'Spaceship Beta' isAt: 7  with:1  in:game.
	reverseCard playedOn:game  by:'Spaceship Alpha'.
	"Juega C"
	game playATurn.
	"Juega B"
	game playATurn.
	self assert:'Spaceship Beta' isAt: 13  with:1  in:game.
	
]

{ #category : #tests }
BianchiFinalTest >> testSpaceshipAlphaPlaysSkipCardOnBetasTurnAndSkipsTurn [
	| noEffect boxSequence game |
	noEffect := DiscreteProbabilityEvent for: NoEffect new with: 100.
	boxSequence := (BoxesEffectsGenerator generate: 13 for: { noEffect })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: (Deck with: { skipCard }).
	"Juega A"
	game playATurn.
	self assert:'Spaceship Alpha' isAt: 7  with:1  in:game.
	skipCard playedOn:game  by:'Spaceship Alpha'.
	"Juega A"
	game playATurn.
	self assert:'Spaceship Beta' isAt: 1  with:1  in:game.
	self assert:'Spaceship Alpha' isAt: 13  with:1  in:game.
	
]
