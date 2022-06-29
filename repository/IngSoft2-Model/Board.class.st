Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'distancePerBox',
		'deck',
		'lastBoxEffect',
		'allSpaceshipsStatuses'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertCollectionOfSpaceshipsIsValid:aCollectionOfShips [

	(aCollectionOfShips size  > 1) ifFalse: [ 
		Error signal: 'Game must have more than one Ship']
]

{ #category : #asserting }
Board class >> assertValidDistance: distance [
	distance < 1 ifTrue: [ Error signal: 'A board must have a distance greater than zero' ].
]

{ #category : #asserting }
Board class >> assertValidLaps:laps [
	laps > 0 ifFalse: [ Error signal: 'A board must have at least one lap' ].
]

{ #category : #'instance creation' }
Board class >> ships: spaceships with: aBoxSequence distance: aDistance laps: laps and: aDeck [


	^ self new
		  initializeWithShips: spaceships
		  with: aBoxSequence
		  distance: aDistance
		  laps: laps
		  and: aDeck
]

{ #category : #accessing }
Board >> allSpaceships [
	^allSpaceshipsStatuses.
]

{ #category : #accessing }
Board >> assertHasAWinner [

	| possibleWinnerPosition |
	possibleWinnerPosition := (allSpaceshipsStatuses at:1) position.
	^((possibleWinnerPosition boxNumber = distanceOfBoard and:
		 possibleWinnerPosition lapNumber = laps))
]

{ #category : #action }
Board >> createStatusFor: aCollectionOfShips [

	| hand position spaceshipEffects cards |
	allSpaceshipsStatuses := aCollectionOfShips collect: [ :ship | 
		              cards := OrderedCollection new.
		              cards add: deck giveCard.
		              cards add: deck giveCard.
		              hand := SpaceshipHand with: cards.
		              position := SpaceshipPosition
			                          at: 1
			                          distance: 0
			                          laps: 1.
		              spaceshipEffects := SpaceshipEffects with:
			                                  OrderedCollection new.
		              SpaceshipStatus
			              of: ship
			              position: position
			              cards: hand
			              effects: spaceshipEffects ]
]

{ #category : #accessing }
Board >> effectAt: aBoxNumber for: ships appliedBy: aSpacehip [

	(boxes at: aBoxNumber) triggeredBy: aSpacehip with: self.
	lastBoxEffect := boxes at: aBoxNumber
]

{ #category : #actions }
Board >> giveTo: aSpaceship card: aCard [

	| aSpaceshipOldStatus  aSpaceshipHand |
	aSpaceshipOldStatus:= self spaceshipOf: aSpaceship.
	aSpaceshipHand:=  (aSpaceshipOldStatus hand) cards.
	aSpaceshipHand add:aCard.
	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: (SpaceshipHand with:aSpaceshipHand)
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #initialization }
Board >> initializeWithShips: aCollectionOfSpaceships with: aBoxSequence distance: aDistance laps: numberOfLaps and: aDeck [
	boxes := aBoxSequence.
	distanceOfBoard :=boxes size.
	distancePerBox := Parsecs with:((aDistance amountInParsecs) / distanceOfBoard).
	laps := numberOfLaps.
	deck:= aDeck.
	self createStatusFor:aCollectionOfSpaceships.
	lastBoxEffect := NoEffect new.
]

{ #category : #accessing }
Board >> lastBoxEffect [
	^lastBoxEffect .
]

{ #category : #actions }
Board >> move: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox oldSpaceshipStatus |
	oldSpaceshipStatus := allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ].
	oldSpaceshipPosition:= oldSpaceshipStatus position.
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distance + aDistanceNumber amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % (distancePerBox amountInParsecs) 
				 laps: oldSpaceshipPosition lapNumber).
	self
		moveForward: aSpaceship
		to: spaceshipNewDistanceInBox // (distancePerBox amountInParsecs).
]

{ #category : #actions }
Board >> move: aSpaceship with: aDiceResult [

	| oldSpaceshipStatus spaceshipStatusWithoutEffectsApplied |
	oldSpaceshipStatus := self spaceshipOf: aSpaceship.
	self moveForward: oldSpaceshipStatus name to: aDiceResult.
	spaceshipStatusWithoutEffectsApplied := (self spaceshipOf: aSpaceship) position.
	self
		effectAt: spaceshipStatusWithoutEffectsApplied boxNumber
		for: allSpaceshipsStatuses
		appliedBy: oldSpaceshipStatus name.
	self sortPositionsByRanking.
]

{ #category : #actions }
Board >> moveBackwards: aNumberOfBoxes AllSpaceshipsExcept: aSpaceship [

	allSpaceshipsStatuses do: [ :each | 
		each name ~= aSpaceship ifTrue: [ 
			self moveBackwards: each name to: aNumberOfBoxes ] ].
]

{ #category : #accessing }
Board >> moveBackwards: aSpaceship to: aBox [

	| oldSpaceshipPosition spaceshipNewBoxNumber spaceshipNewLapNumber oldSpaceshipStatus|
	oldSpaceshipStatus := allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ].
	oldSpaceshipPosition := oldSpaceshipStatus position.
	spaceshipNewBoxNumber := oldSpaceshipPosition boxNumber - aBox.
	spaceshipNewLapNumber := oldSpaceshipPosition lapNumber.
	
	(spaceshipNewBoxNumber < 1 and: oldSpaceshipPosition lapNumber > 1) ifTrue: [ 
        spaceshipNewBoxNumber := distanceOfBoard + spaceshipNewBoxNumber.
        spaceshipNewLapNumber := oldSpaceshipPosition lapNumber - 1 ].
    (spaceshipNewBoxNumber < 1 and: oldSpaceshipPosition lapNumber = 1) ifTrue: [ 
        spaceshipNewBoxNumber := 1 ].
	self
		updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distance
				 laps: spaceshipNewLapNumber).
]

{ #category : #accessing }
Board >> moveForward: aSpaceship to: aBox [

	| oldSpaceshipPosition spaceshipNewBoxNumber spaceshipNewLapNumber oldSpaceshipStatus |
	oldSpaceshipStatus := allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ].
	oldSpaceshipPosition := oldSpaceshipStatus position.
	spaceshipNewBoxNumber := oldSpaceshipPosition boxNumber + aBox.
	
	(spaceshipNewBoxNumber > distanceOfBoard and:
		 oldSpaceshipPosition lapNumber = laps) ifTrue: [ 
		spaceshipNewBoxNumber := distanceOfBoard ].
	(spaceshipNewBoxNumber > distanceOfBoard and:
		 oldSpaceshipPosition lapNumber < laps)
		ifTrue: [ 
			spaceshipNewLapNumber := (oldSpaceshipPosition lapNumber + (spaceshipNewBoxNumber // distanceOfBoard)) min:laps.
			spaceshipNewBoxNumber := spaceshipNewBoxNumber - distanceOfBoard min:distanceOfBoard ] 
		ifFalse: [ spaceshipNewLapNumber := oldSpaceshipPosition lapNumber ].
		
	self
		updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distance
				 laps: spaceshipNewLapNumber).
]

{ #category : #action }
Board >> moveSpaceshipsToTheFirstBox [

	allSpaceshipsStatuses do: [ :each | 
		self
			updateSpaceshipPositionOf: each
			to:
			(SpaceshipPosition at: 1 distance: 0 laps: each position lapNumber) ]
]

{ #category : #accesing }
Board >> rankingOf: aSpaceship [

	allSpaceshipsStatuses do: [ :spaceship | 
		spaceship name = aSpaceship ifTrue: [ 
			^ allSpaceshipsStatuses indexOf: spaceship ] ]
]

{ #category : #accessing }
Board >> sortPositionsByRanking [

	allSpaceshipsStatuses sort: [ :spaceship1 :spaceship2 | 
		spaceship1 position > spaceship2 position ]
]

{ #category : #accesing }
Board >> spaceshipOf: aSpacehipsName [

	^ allSpaceshipsStatuses detect: [ :each | each name = aSpacehipsName ]
]

{ #category : #actions }
Board >> updateSpaceshipEffectsOf: aSpaceshipOldStatus to: spaceshipNewEffects [

	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: aSpaceshipOldStatus hand
			 effects: spaceshipNewEffects)
]

{ #category : #actions }
Board >> updateSpaceshipHandOf: aSpaceshipOldStatus with: spaceshipNewHand [

	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: spaceshipNewHand
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #actions }
Board >> updateSpaceshipPositionOf: aSpaceshipOldStatus to: spaceshipNewPosition [


	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: spaceshipNewPosition
			 cards: aSpaceshipOldStatus hand
			 effects: aSpaceshipOldStatus effectsOnSpaceship).
]

{ #category : #accesing }
Board >> winner [

	self assertHasAWinner
		ifTrue: [ ^ (allSpaceshipsStatuses at: 1) name ]
		ifFalse: [ 
			Error signal:
				'Game does not have a winner beacause is not finished yet' ]
]
