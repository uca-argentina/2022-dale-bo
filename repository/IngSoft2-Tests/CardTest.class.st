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
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.

	self assert: (game positionOfShip: 'Valen') numberOfCards equals: 3
]

{ #category : #tests }
CardTest >> testValenPlaysASpeedCardToPablo [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	
	game
		playSpeedCardBy:'Valen'
		to: (game positionOfShip: 'Pablo').
	game playATurn.
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 8
]

{ #category : #tests }
CardTest >> testValenPlaysAnAccelerationCardToAllPlayers [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { AccelerationCard new }.
boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game
		playAccelerationCardBy: 'Valen'
		.
	game playATurn.
	self assert:(game positionOfShip: 'Pablo') boxNumber equals: 1.
	self assert: (game positionOfShip: 'Valen') boxNumber equals: 8.
	game playATurn.
	self assert:(game positionOfShip: 'Pablo') boxNumber equals: 8.
	
]

{ #category : #tests }
CardTest >> testValenPlaysAnOverloadCardToPablo [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { OverloadCard new }.
boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game
		playOverloadCardBy:'Valen'
		to: (game positionOfShip: 'Pablo').
	game playATurn.
	game playATurn.

	self assert: (game positionOfShip: 'Pablo') boxNumber equals: 5
]

{ #category : #tests }
CardTest >> testValenTriesToPlayACardInPablosTurnAndHeCantsBecauseItAPermanentCard [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self
		should: [ 
			game
				playSpeedCardBy:'Valen'
		to: (game positionOfShip: 'Pablo'). ]
		raise: Error
		withMessage:
		'A permanent card cannot be played on another spaceship turn'
]

{ #category : #tests }
CardTest >> testValenTriesToPlayACardThatIsNotInHisHand [

	| dieOne dieTwo dieThree aDiceCup game boxSequence deck |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			            dieOne.
			            dieTwo.
			            dieThree }.
	deck := Deck with: { SpeedCard new }.
	boxSequence := (BoxesGenerator
		                generate: 13
		                for: { CardGiverEffect new }
		                with: { 1 }) boxSequence.
	game := Game
		        spaceships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: 200
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	self
		should: [ 
			game
				playOverloadCardBy:'Valen'
		to: (game positionOfShip: 'Pablo'). ]
		raise: Error
		withMessage: 'The spaceship does not have this card'
]
