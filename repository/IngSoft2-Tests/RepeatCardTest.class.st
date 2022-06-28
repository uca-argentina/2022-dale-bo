Class {
	#name : #RepeatCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RepeatCardTest >> assert: aSpaceshipName isAt: aPositionNumber with: aLapNumber in: aGame [

	| spaceshipPosition |
	spaceshipPosition := (aGame spaceshipOf: aSpaceshipName) position.
	
	self assert: spaceshipPosition boxNumber equals: aPositionNumber.
	self assert: spaceshipPosition lapNumber equals: aLapNumber.
]

{ #category : #tests }
RepeatCardTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize-1 timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced-1.
	^ boxSequence
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInAAtomicBombEffect [

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

	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: AtomicBombEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:1 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'.
	self assert:'Pablo' isAt:1 with:1 in:game.
	self assert:'Valen' isAt:1 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInACardGiver [

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
	boxSequence := self
		               sequenceOfNoEffectsOf: 16
		               with: (CardGiverEffect with: deck)
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert: ((game spaceshipOf: 'Pablo') hand) cards size equals: 3.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInAHyperJumpEffect [

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
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 20)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:9 with:1 in:game.
	self assert: (game spaceshipOf: 'Valen') position distance equals: 1.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:9 with:1 in:game.
	self assert: (game spaceshipOf: 'Valen') position distance equals: 1.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInAMoonwalkEffect [

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
	boxSequence := self
		               sequenceOfNoEffectsOf: 10
		               with: (MoonwalkEffect with: 2)
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:7 with:1 in:game.
	self assert:'Valen' isAt:3 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInANoEffect [

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
		                for: { NoEffect new }
		                with: { 100 }) boxSequence.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:7 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:7 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInASpeedUpEffect [

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
	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: SpeedUpEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:11 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Pablo'.
	game playATurn.
	self assert:'Pablo' isAt:11 with:1 in:game.
]

{ #category : #tests }
RepeatCardTest >> testPabloPlaysARepeatCardAfterValenLandsInAWormholeEffect [

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

	boxSequence := self
		               sequenceOfNoEffectsOf: 15
		               with: WormHoleEffect new
		               at: 7.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert:'Valen' isAt:3 with:1 in:game.
	repeatCard
		playedOn: game
		by: 'Pablo'
		to: 'Valen'.
	self assert:'Valen' isAt:1 with:1 in:game.
]
