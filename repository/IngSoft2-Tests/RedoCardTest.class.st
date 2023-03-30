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
	super setUp.
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
RedoCardTest >> testSpaceshipBetaPlaysARedoAfterACancelation [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	accelerationCard playedOn: game by: 'Spaceship Alpha'.
	game playATurn.
	cancelationCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'
		for: accelerationCard.
	game playATurn.
	redoCard playedOn: game by: 'Spaceship Beta' to: 'Spaceship Gamma'.
	self
		assert: 'Spaceship Beta'
		isAt: 13
		with: 1
		in: game.
	game playATurn.
	self
		assert: 'Spaceship Gamma'
		isAt: 13
		with: 1
		in: game
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaPlaysARedoAfterSpaceshipAlphaPlaysAnAccellerationCard [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	
	accellerationCard
		playedOn: game
		by: 'Spaceship Alpha'.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	redoCard playedOn: game by:'Spaceship Beta'  to:'Spaceship Alpha'.
	game playATurn.
	game playATurn.
	self assert: 'Spaceship Gamma' isAt:16 with:1 in:game.
	
	
	
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaPlaysARedoAfterValenPlaysARepeat [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	repeatCard
		playedOn: game
		by: 'Spaceship Alpha'
		to: 'Spaceship Alpha'.
	game playATurn.
	redoCard playedOn: game by:'Spaceship Beta'  to:'Spaceship Beta'.
	self assert:'Spaceship Alpha' handHas:3 in:game.
	self assert:'Spaceship Beta' handHas:3 in:game.
	
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaPlaysARedoCardAfterHePlaysAOverloadCard [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert:'Spaceship Gamma' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Gamma'.
	redoCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Gamma'.
	game playATurn.
	game playATurn.
	self assert:'Spaceship Gamma' isAt:9 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaPlaysARedoWhenNoCardWasPlayedPreviously [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	self
		should: [ redoCard 
		playedOn: game
		by: 'Spaceship Alpha'
		to: 'Spaceship Alpha' ]
		raise: Error
		withMessage:
		'There are no cards played'.
	
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaPlaysTwoRedoCardsAfterPlaysASpeedCard [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
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
		by: 'Spaceship Alpha'
		to: 'Spaceship Alpha'.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:14 with:1 in:game.
	self assert:'Spaceship Beta' isAt:7 with:1 in:game.
	redoCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	redoCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Beta'.
	game playATurn.
	self assert:'Spaceship Beta' isAt:15 with:1 in:game.
]

{ #category : #tests }
RedoCardTest >> testSpaceshipBetaTriesToPlaysARedoCardNotInHisTurnAfterBetaPlaysAOverloadCard [

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
		        with: { 'Spaceship Alpha'. 'Spaceship Beta'. 'Spaceship Gamma' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deckForGame.
	game playATurn.
	self assert:'Spaceship Alpha' isAt:7 with:1 in:game.
	overloadCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Alpha'.
	game playATurn.
	self
		should: [ redoCard
		playedOn: game
		by: 'Spaceship Beta'
		to: 'Spaceship Alpha'. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]
