Class {
	#name : #OtherCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OtherCardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
OtherCardTest >> testADeckCannotBeCreatedWithNoCards [

	 self
		should: [Deck with: {} ]
		raise: Error
		withMessage: 'A deck must have at least one card'
	


]

{ #category : #tests }
OtherCardTest >> testPabloTriesToCancelWhenThereWasNoCardPlayedPreviously [

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
				playedUsing: game
				by: 'Valen'
				to: 'Valen'
				for: cancelationCard ]
		raise: Error
		withMessage: 'There is no cards played to be canceled'
]

{ #category : #tests }
OtherCardTest >> testPlayerLandsInABoxAndReceivesACard [

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

	self assert: (game spaceshipOf: 'Valen') numberOfCards equals: 3
]

{ #category : #tests }
OtherCardTest >> testValenPlaysASpeedCardToPablo [

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

	speedCard
		playedUsing: game
		by: 'Valen'
		to: 'Pablo'
		for: speedCard.
	game playATurn.
	game playATurn.

	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 8
]

{ #category : #tests }
OtherCardTest >> testValenPlaysAnAccelerationCardAndPabloUseCancelationCardToValenInValensTurn [

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
		playedUsing: game
		by: 'Valen'
		to: ''
		for: accelerationCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 8.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 8.
	cancellationCard
		playedUsing: game
		by: 'Pablo'
		to: 'Valen'
		for: accelerationCard.
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1.
	self assert: (game spaceshipOf: 'Valen') lapNumber equals: 2.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 2.
	self assert: (game spaceshipOf: 'Pablo') lapNumber equals: 2
]

{ #category : #tests }
OtherCardTest >> testValenPlaysAnAccelerationCardToAllPlayers [

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
		                for: { (CardGiverEffect with: deck) }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	accelerationCard
		playedUsing: game
		by: 'Valen'
		to: ''
		for: accelerationCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 1.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 8.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 8.
	game playATurn.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 2
]

{ #category : #tests }
OtherCardTest >> testValenPlaysAnOverloadCardToPablo [

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
		playedUsing: game
		by: 'Valen'
		to: 'Pablo'
		for: overloadCard.
	game playATurn.
	game playATurn.

	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 5
]

{ #category : #tests }
OtherCardTest >> testValenTriesToPlayACardInPablosTurnAndHeCantsBecauseItAPermanentCard [

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
				playedUsing: game
				by: 'Valen'
				to: 'Pablo'
				for: speedCard ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]

{ #category : #tests }
OtherCardTest >> testValenTriesToPlayACardThatIsNotInHisHand [

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
				playedUsing: game
				by: 'Valen'
				to: 'Pablo'
				for: overloadCard ]
		raise: Error
		withMessage: 'The spaceship does not have this card'
]
