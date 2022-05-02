Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aBlock raise: anError withMessage: anErrorMessage [

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
GameTest >> testAGameHasAWinner [

	| ship1 ships aBoard sequenceController dieOne dieTwo dieThree aDiceCup game ship2 |
	aBoard := Board with: 60.
	ship1 := Ship withName: 'Valen'.
	ship2:= Ship withName:'Pablito'.
	ships := { ship1.ship2.}.
	sequenceController := SequenceController withShips: ships.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { dieOne. dieTwo. dieThree }.
	game:=Game withShips: ships aBoard: aBoard shipsSequenceController: sequenceController 
	andDiceCup: 	aDiceCup.
	[game hasFinished] whileFalse:  [game playATurn].
	self assert: (game winner) equals: 'Valen'.
	self deny: (game winner) equals: 'Pablito'.
	

]

{ #category : #tests }
GameTest >> testAGameHasFinishedWhenAShipWins [

	| ship1 ships aBoard sequenceController dieOne dieTwo dieThree aDiceCup game ship2 |
	aBoard := Board with: 6.
	ship1 := Ship withName: 'Valen'.
	ship2:= Ship withName:'Pablito'.
	ships := { ship1.ship2.}.
	sequenceController := SequenceController withShips: ships.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { dieOne. dieTwo. dieThree }.
	game:=Game withShips: ships aBoard: aBoard shipsSequenceController: sequenceController 
	andDiceCup: 	aDiceCup.
	self assert: (game hasFinished) equals:false.
	game playATurn.
	self assert: (game hasFinished) equals:true.

]

{ #category : #tests }
GameTest >> testAGameIsCreatedWithLessThanTwoShips [

	| ship1 ships aBoard sequenceController dieOne dieTwo dieThree aDiceCup |
	aBoard := Board with: 10.
	ship1 := Ship withName: 'Valen'.
	ships := { ship1 }.
	sequenceController := SequenceController withShips: ships.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { dieOne. dieTwo. dieThree }.
	self should:[Game
		        withShips: ships
		        aBoard: aBoard
		        shipsSequenceController: sequenceController
		        andDiceCup: aDiceCup.]
	 		raise: Error
			withMessage: 'Game must have more than one Ship'.
	
]

{ #category : #tests }
GameTest >> testAGameReturnsThePositionsOfAllShips [

	| ship1 ships aBoard sequenceController dieOne dieTwo dieThree aDiceCup game ship2 |
	aBoard := Board with: 10.
	ship1 := Ship withName: 'Valen'.
	ship2:= Ship withName:'Pablito'.
	ships := { ship1.ship2.}.
	sequenceController := SequenceController withShips: ships.
	dieOne := LoadedDie with: 1.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 3.
	aDiceCup := DiceCup withAll: { dieOne. dieTwo. dieThree }.
	game:=Game withShips: ships aBoard: aBoard shipsSequenceController: sequenceController 
	andDiceCup: 	aDiceCup.
	game playATurn.
	self assert: (game positionOf: 'Valen') equals:6.
	game playATurn.
	self assert: (game positionOf: 'Pablito') equals:6.

]
