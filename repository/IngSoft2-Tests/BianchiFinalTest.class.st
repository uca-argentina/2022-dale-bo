Class {
	#name : #BianchiFinalTest,
	#superclass : #TestCase,
	#instVars : [
		'die',
		'repeatCard'
	],
	#category : #'IngSoft2-Tests'
}

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
BianchiFinalTest >> testSpaceshipAlphaLandsInJailAndGetsOutByThrowingMaxDiceSum2 [
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
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:true.
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Beta') equals:true.
	game playATurn.
	self assert:((game spaceshipsInPrison) includes:'Spaceship Alpha') equals:false.
	
]
