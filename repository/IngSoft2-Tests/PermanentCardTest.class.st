Class {
	#name : #PermanentCardTest,
	#superclass : #TestCase,
	#instVars : [
		'die'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PermanentCardTest >> assert: aSpaceship handHas: aNumberOfCards in: aGame [ 
	self assert: ((aGame spaceshipOf: aSpaceship) hand ) numberOfCards equals: aNumberOfCards.

]

{ #category : #tests }
PermanentCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.


]

{ #category : #running }
PermanentCardTest >> setUp [
	die:= LoadedDie with:6.
]

{ #category : #tests }
PermanentCardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
PermanentCardTest >> testADeckCannotBeCreatedWithNoCards [

	 self
		should: [Deck with: {} ]
		raise: Error
		withMessage: 'A deck must have at least one card'
	


]

{ #category : #tests }
PermanentCardTest >> testPabloCantPlayCancellationBecauseThereWasnACardPlayedBefore [

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
		should: [ 
			cancelationCard
				playedOn: game
				by: 'Valen'
				to: 'Valen'
				for: (SpeedCard new).]
		raise: Error
		withMessage: 'The spaceship does not have this effect applied on'
]

{ #category : #tests }
PermanentCardTest >> testPlayerLandsInABoxAndReceivesACard [

	| game boxSequence deck cardGiverBox |
	deck := Deck with: { 
			        SpeedCard new.
			        OverloadCard new }.
	cardGiverBox := DiscreteProbabilityEvent for: (CardGiverEffect with:deck) with: 100.
	boxSequence := (BoxesGenerator generate: 16 for: { cardGiverBox })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self assert:'Valen' handHas:3 in:game.
]

{ #category : #tests }
PermanentCardTest >> testValenCantPlayACardThatIsNotInHisHand [

	| game boxSequence deck speedCard overloadCard cardGiverBox |
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	cardGiverBox := DiscreteProbabilityEvent for: (CardGiverEffect with:deck) with: 100.
	boxSequence := (BoxesGenerator generate: 13 for: { cardGiverBox })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	self
		should: [ 
			overloadCard
				playedOn: game
				by: 'Valen'
				to: 'Pablo']
		raise: Error
		withMessage: 'The spaceship does not have this card'
]

{ #category : #tests }
PermanentCardTest >> testValenPlaysASpeedCardToPabloAndAddsOneToPablosRoll [

	| game boxSequence deck speedCard noEffect |
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.

	speedCard
		playedOn: game
		by: 'Valen'
		to: 'Pablo'.
	game playATurn.
	game playATurn.
	self assert:'Pablo' isAt:8 with:1 in:game.
]

{ #category : #tests }
PermanentCardTest >> testValenPlaysAnAccelerationCardAndPabloUseCancelationCardToValenInValensTurn [

	| game boxSequence deckForGame deckForBoxes accelerationCard cancellationCard cardGiverBox |
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	deckForGame := Deck with: { accelerationCard }.
	deckForBoxes := Deck with: { cancellationCard }.
	cardGiverBox:=DiscreteProbabilityEvent for:(CardGiverEffect with: deckForBoxes) with:100.
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
	accelerationCard
		playedOn: game
		by: 'Valen'.
	game playATurn.
	self assert:'Valen' isAt:8 with:1 in:game.
	game playATurn.
	self assert:'Valen' isAt:8 with:1 in:game.
	cancellationCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'
		for: accelerationCard.
	game playATurn.
	game playATurn.
	self assert:'Valen' isAt:1 with:2 in:game.
	game playATurn.
	self assert:'Pablo' isAt:2 with:2 in:game.
]

{ #category : #tests }
PermanentCardTest >> testValenPlaysAnAccelerationCardToAllPlayersAndTheyAddOneToTheirRoll [

	| game boxSequence deck accelerationCard noEffect |
	accelerationCard := AccelerationCard new.
	deck := Deck with: { accelerationCard }.
	noEffect:=DiscreteProbabilityEvent for:(NoEffect new) with:100.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { noEffect }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	accelerationCard
		playedOn: game
		by: 'Valen'.
	game playATurn.
	self assert:'Pablo' isAt:1 with:1 in:game.
	self assert:'Valen' isAt:8 with:1 in:game.
	game playATurn.
	self assert:'Pablo' isAt:8 with:1 in:game.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert:'Pablo' isAt:2 with:2 in:game.
]

{ #category : #tests }
PermanentCardTest >> testValenPlaysAnOverloadCardToPabloAndReduceItsDieRollByOne [

	|  game boxSequence deck overloadCard cardGiverBox |
	overloadCard := OverloadCard new.
	deck := Deck with: { overloadCard }.
	cardGiverBox := DiscreteProbabilityEvent for: (CardGiverEffect with:deck) with: 100.
	boxSequence := (BoxesGenerator generate: 13 for: { cardGiverBox })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	overloadCard
		playedOn: game
		by: 'Valen'
		to: 'Pablo'.
	game playATurn.
	game playATurn.
	self assert: 'Pablo' isAt:5 with:1 in:game.
]

{ #category : #tests }
PermanentCardTest >> testValenTriesToPlayACardInPablosTurnAndHeCantsBecauseItAPermanentCard [

	| game boxSequence deck speedCard cardGiverBox |
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	cardGiverBox := DiscreteProbabilityEvent for: (CardGiverEffect with:deck) with: 100.
	boxSequence := (BoxesGenerator generate: 13 for: { cardGiverBox })
		               boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: die
		        and: deck.
	game playATurn.
	self
		should: [ 
			speedCard
		playedOn: game
		by: 'Valen'
		to: 'Pablo'. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]
