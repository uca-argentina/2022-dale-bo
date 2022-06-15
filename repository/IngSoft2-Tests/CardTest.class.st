Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
CardTest >> testADeckCannotBeCreatedWithNoCards [

	 self
		should: [Deck with: {} ]
		raise: Error
		withMessage: 'A deck must have at least one card'
	


]

{ #category : #tests }
CardTest >> testPabloPlaysARedoCardAfterPabloPlaysAOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForCardGiver overloadCard redoCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	game playATurn.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 7.
	overloadCard
		playedUsing: game
		by: 'Pablo'
		to: 'Seba'
		for: overloadCard.
	redoCard
		playedUsing: game
		by: 'Pablo'
		to: ''
		for: redoCard.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Seba') boxNumber equals: 9
]

{ #category : #tests }
CardTest >> testPabloPlaysARepeatCardAfterValenLandsInACardGiver [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck repeatCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	repeatCard := RepeatCard new.
	deck := Deck with: { repeatCard }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { (CardGiverEffect with: deck) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	"repeatCard
		playedUsing: game
		by: 'Pablo'
		to: ''
		for: repeatCard.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') hand size equals: 3"
]

{ #category : #tests }
CardTest >> testPabloPlaysARepeatCardAfterValenLandsInASpeedUpEffect [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { RepeatCard new }.
	boxSequence := (BoxesGenerator
		                generate: 16
		                for: { SpeedUpEffect new. }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 11.
	game playRepeatCardBy: 'Pablo' to: 'Pablo'.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 15.
]

{ #category : #tests }
CardTest >> testPabloTriesToPlaysARedoCardNotInHisTurnAfterPabloPlaysAOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForCardGiver overloadCard redoCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard := OverloadCard new.
	deckForGame := Deck with: { overloadCard }.
	redoCard := RedoCard new.
	deckForCardGiver := Deck with: { redoCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForCardGiver) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 7.
	overloadCard
		playedUsing: game
		by: 'Pablo'
		to: 'Valen'
		for: overloadCard.
	game playATurn.
	self
		should: [ redoCard
		playedUsing: game
		by: 'Pablo'
		to: ''
		for: redoCard. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesACard [

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
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.

	self assert: (game positionOfShip: 'Valen') numberOfCards equals: 3
]

{ #category : #tests }
CardTest >> testValenPlaysASpeedCardToPablo [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	speedCard:= SpeedCard new.
	deck := Deck with: {speedCard}.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect with:deck }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	
	speedCard playedUsing:game by:'Valen' to:'Pablo' for:speedCard.
	game playATurn.
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 8
]

{ #category : #tests }
CardTest >> testValenPlaysAnAccelerationCardAndPabloUseCancelationCardToValenInValensTurn [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deckForGame deckForBoxes accelerationCard cancellationCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	accelerationCard:=AccelerationCard new.
	cancellationCard:=CancellationCard new.
	deckForGame := Deck with: {accelerationCard }.
	deckForBoxes := Deck with: { cancellationCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deckForBoxes) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deckForGame.
	accelerationCard playedUsing:game by:'Valen' to:'' for:accelerationCard.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 8.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 8.
	cancellationCard playedUsing:game by:'Pablo' to:'Valen' for:accelerationCard.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Valen') lapNumber equals: 2.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 2.
	self assert: (game positionOfShip: 'Pablo') lapNumber equals: 2
]

{ #category : #tests }
CardTest >> testValenPlaysAnAccelerationCardToAllPlayers [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck accelerationCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	accelerationCard:=AccelerationCard new.
	deck := Deck with: {accelerationCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deck) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	accelerationCard playedUsing:game by:'Valen' to:'' for:accelerationCard.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 8.
	game playATurn.
	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 8.
	game playATurn.
	game playATurn.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 2
]

{ #category : #tests }
CardTest >> testValenPlaysAnOverloadCardToPablo [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck overloadCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard:= OverloadCard new.
	deck := Deck with: { overloadCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { (CardGiverEffect with: deck) }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	overloadCard playedUsing:game by:'Valen' to:'Pablo' for:overloadCard.
	game playATurn.
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 5
]

{ #category : #tests }
CardTest >> testValenTriesToPlayACardInPablosTurnAndHeCantsBecauseItAPermanentCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	speedCard:= SpeedCard new.
	deck := Deck with: { speedCard }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect with:deck }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self
		should: [ 
			speedCard playedUsing:game by:'Valen' to:'Pablo' for:speedCard. ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]

{ #category : #tests }
CardTest >> testValenTriesToPlayACardThatIsNotInHisHand [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck speedCard overloadCard |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	overloadCard:=OverloadCard new.
	speedCard:= SpeedCard new.
	deck := Deck with: {speedCard}.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with:200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	self
		should: [ 
			overloadCard playedUsing:game by:'Valen' to:'Pablo' for:overloadCard. ]
		raise: Error
		withMessage: 'The spaceship does not have this card'
]
