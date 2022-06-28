Class {
	#name : #RedoCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
RedoCardTest >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: ((aGame spaceshipOf: aSpaceship) hand ) numberOfCards equals: aNumberOfCards.
]

{ #category : #tests }
RedoCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #running }
RedoCardTest >> setUp [
	die:= LoadedDie with:6.
]

{ #category : #tests }
RedoCardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
RedoCardTest >> testPabloPlaysARedoAfterACancelation [

	| game boxSequence deckForGame cancelationCard redoCard deckForCardGiver accelerationCard deckForAccelerationCardGiver cardGiverBox |
	
	cancelationCard := CancellationCard new.
	redoCard := RedoCard new.
	accelerationCard := AccelerationCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForAccelerationCardGiver := Deck with: { accelerationCard }.
	deckForGame := Deck with: { cancelationCard }.
	cardGiverBox := DiscreteProbabilityEvent
		                for:
		                (CardGiverEffect with: deckForAccelerationCardGiver)
		                with: 100.
	boxSequence := (BoxesGenerator generate: 16 for: { cardGiverBox })
		               boxSequence.
	boxSequence
		add: (CardGiverEffect with: deckForCardGiver)
		afterIndex: 12.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	accelerationCard playedOn: game by: 'Valen'.
	game playATurn.
	cancelationCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'
		for: accelerationCard.
	game playATurn.
	redoCard playedOn: game by: 'Pablo' to: 'Seba'.
	self
		assert: 'Pablo'
		isAt: 13
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Seba'
		isAt: 13
		with: 1
		in: game
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoAfterValenPlaysARepeat [

	|  game boxSequence deckForGame repeatCard redoCard deckForCardGiver cardGiverBox |
	repeatCard := RepeatCard new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { repeatCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	repeatCard
		playedOn: game
		by: 'Valen'
		to: 'Valen'.
	game playATurn.
	redoCard playedOn: game by:'Pablo'  to:'Pablo'.
	self assert:'Valen' handHas:3 in:game.
	self assert:'Pablo' handHas:3 in:game.
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoAfterValenPlaysAnAccellerationCard [

	|  game boxSequence deckForGame accellerationCard redoCard deckForCardGiver cardGiverBox |
	accellerationCard := AccelerationCard  new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { accellerationCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	
	accellerationCard
		playedOn: game
		by: 'Valen'.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	redoCard playedOn: game by:'Pablo'  to:'Valen'.
	game playATurn.
	game playATurn.
	self assert: 'Seba' isAt:16 with:1 in:game.
	
	
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoCardAfterPabloPlaysAOverloadCard [

	| game boxSequence deckForGame deckForCardGiver overloadCard redoCard cardGiverBox |
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert:'Seba' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Pablo'
		to: 'Seba'.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Seba'.
	game playATurn.
	game playATurn.
	self assert:'Seba' isAt:9 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysARedoWhenNoCardWasPlayedPreviously [

	| game boxSequence deckForGame cancelationCard redoCard deckForCardGiver cardGiverBox |
	cancelationCard := CancellationCard new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { cancelationCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	self
		should: [ redoCard 
		playedOn: game
		by: 'Valen'
		to: 'Valen' ]
		raise: Error
		withMessage:
		'There are no cards played'.
	
]

{ #category : #tests }
RedoCardTest >> testPabloPlaysTwoRedoCardsAfterPlaysASpeedCard [

	| game boxSequence deckForGame redoCard deckForCardGiver aSpeedCard cardGiverBox |
	redoCard := RedoCard new.
	aSpeedCard := SpeedCard new.
	deckForCardGiver := Deck with: { aSpeedCard }.
	deckForGame := Deck with: { redoCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	aSpeedCard
		playedOn: game
		by: 'Valen'
		to: 'Valen'.
	game playATurn.
	self assert:'Valen' isAt:14 with:1 in:game.
	self assert:'Pablo' isAt:7 with:1 in:game.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:15 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testPabloTriesToPlaysARedoCardNotInHisTurnAfterPabloPlaysAOverloadCard [

	|game boxSequence deckForGame deckForCardGiver overloadCard redoCard cardGiverBox |
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForCardGiver) with:100.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { cardGiverBox }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'.
	game playATurn.
	self
		should: [ redoCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]
