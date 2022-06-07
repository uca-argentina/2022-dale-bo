Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesACard [

	| dieOne dieTwo dieThree aDiceCup game newPosition |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (CardGiverEffect new)  
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	self assert: ((game positionOfShip: 'Valen') numberOfCards) equals: 1
	


]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesASpeedCard [

	| dieOne dieTwo dieThree aDiceCup game newPosition |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (CardGiverEffect new)  
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	(game positionOfShip: 'Valen') playACard: SpeedCard to: (game positionOfShip: 'Pablo').
	game playATurn.

	self assert: ((game positionOfShip: 'Pablo') boxNumber)  equals: 8

]

{ #category : #tests }
CardTest >> testPlayerLandsInABoxAndReceivesAnOverloadCard [

	| dieOne dieTwo dieThree aDiceCup game newPosition |
	dieOne := LoadedDie with: 3.
	dieTwo := LoadedDie with: 2.
	dieThree := LoadedDie with: 1.
	aDiceCup := DiceCup withAll: { 
			                    dieOne.
			                    dieTwo.
			                    dieThree }.
	game := Game ships: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWithOnly: (CardGiverEffect new)  
		        at: 6
		        of: 10
		        distance: 200
		        laps: 2
		        and: aDiceCup.
	game playATurn.
	(game positionOfShip: 'Valen') playACard: OverloadCard to: (game positionOfShip: 'Pablo').
	game playATurn.

	self assert: ((game positionOfShip: 'Pablo') boxNumber)  equals: 5

]
