Class {
	#name : #RepeatCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RepeatCardTest >> sequenceOfNoEffectsOf: boardSize with: effectToBePlaced at: positionOfEffectToBePlaced [

	| boxSequence |
	boxSequence := OrderedCollection new.
	boardSize timesRepeat: [ boxSequence add: NoEffect new ].
	boxSequence
		add: effectToBePlaced
		afterIndex: positionOfEffectToBePlaced.
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
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Valen'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 1.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1
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
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') hand size equals: 3
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
		               sequenceOfNoEffectsOf: 9
		               with: (HyperJumpEffect with: { 
					                (Parsecs with: 5).
					                (Lightyear with: 12) })
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 20)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 9.
	self assert: (game spaceshipOf: 'Valen') distanceInBox equals: 1.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 9.
	self assert: (game spaceshipOf: 'Valen') distanceInBox equals: 1
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
		               sequenceOfNoEffectsOf: 9
		               with: (MoonwalkEffect with: 2)
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 7.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 3
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
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 7.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 7
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
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 11.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Pablo'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 11
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
		               at: 6.
	game := SpaceRaceGame
		        with: { 'Valen'. 'Pablo'. 'Seba' }
		        boardWith: boxSequence
		        distance: (Parsecs with: 200)
		        laps: 2
		        diceCup: aDiceCup
		        and: deck.
	game playATurn.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 3.
	repeatCard
		playedUsing: game
		by: 'Pablo'
		to: 'Valen'
		for: repeatCard.
	game playATurn.
	self assert: (game spaceshipOf: 'Pablo') boxNumber equals: 3.
	self assert: (game spaceshipOf: 'Valen') boxNumber equals: 1
]
