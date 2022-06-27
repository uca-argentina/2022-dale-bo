Class {
	#name : #SpeedAccellerationOverloadAndCancellationTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SpeedAccellerationOverloadAndCancellationTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.


]

{ #category : #tests }
SpeedAccellerationOverloadAndCancellationTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
SpeedAccellerationOverloadAndCancellationTest >> testADeckCannotBeCreatedWithNoCards [

	 self
		should: [Deck with: {} ]
		raise: Error
		withMessage: 'A deck must have at least one card'
	


]

{ #category : #tests }
SpeedAccellerationOverloadAndCancellationTest >> testPabloCantPlayCancellationBecauseThereWasnACardPlayedBefore [

	| die game boxSequence deckForGame cancelationCard redoCard deckForCardGiver |
	die := LoadedDie with: 6.
	cancelationCard := CancellationCard new.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	deckForGame := Deck with: { cancelationCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 100 }) boxSequence.
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
SpeedAccellerationOverloadAndCancellationTest >> testPlayerLandsInABoxAndReceivesACard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { 
			        SpeedCard new.
			        OverloadCard new }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deck) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.

	self assert: ((game spaceshipOf: 'Valen') hand) numberOfCards equals: 3
]

{ #category : #tests }
SpeedAccellerationOverloadAndCancellationTest >> testValenPlaysASpeedCardToPablo [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (NoEffect new) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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
SpeedAccellerationOverloadAndCancellationTest >> testValenPlaysAnAccelerationCardAndPabloUseCancelationCardToValenInValensTurn [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForBoxes accelerationCard cancellationCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	deckForGame := Deck with: { accelerationCard }.
	deckForBoxes := Deck with: { cancellationCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForBoxes) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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
SpeedAccellerationOverloadAndCancellationTest >> testValenPlaysAnAccelerationCardToAllPlayers [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck accelerationCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	accelerationCard := AccelerationCard new.
	deck := Deck with: { accelerationCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (NoEffect new) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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
SpeedAccellerationOverloadAndCancellationTest >> testValenPlaysAnOverloadCardToPabloAndReduceItsDieRollByOne [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck overloadCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	deck := Deck with: { overloadCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deck) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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
SpeedAccellerationOverloadAndCancellationTest >> testValenTriesToPlayACardInPablosTurnAndHeCantsBecauseItAPermanentCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deck) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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

{ #category : #tests }
SpeedAccellerationOverloadAndCancellationTest >> testValenTriesToPlayACardThatIsNotInHisHand [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard overloadCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	deck := Deck with: { speedCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
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
