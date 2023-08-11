Class {
	#name : #Board2,
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

{ #category : #instanceCreation }
Board2 class >> with: aBoxSequence distance: aDistance laps: laps [ 
	^ self new
		  initializeWith: aBoxSequence
		  distance: aDistance
		  laps: laps
]

{ #category : #accessing }
Board2 >> allSpaceships [
	^allSpaceshipsStatuses.
]

{ #category : #action }
Board2 >> createStatusFor: aCollectionOfShips [

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
Board2 >> effectAt: aBoxNumber appliedBy: aSpacehip [

	(boxes at: aBoxNumber) triggeredBy: aSpacehip with: self.
	lastBoxEffect := boxes at: aBoxNumber
]

{ #category : #accessing }
Board2 >> effectAt: aBoxNumber for: ships appliedBy: aSpacehip [

	(boxes at: aBoxNumber) triggeredBy: aSpacehip with: self.
	lastBoxEffect := boxes at: aBoxNumber
]

{ #category : #actions }
Board2 >> giveTo: aSpaceship card: aCard [

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

{ #category : #'class initialization' }
Board2 >> initializeWith: aBoxSequence distance: aDistance laps: numberOfLaps [ 
	boxes := aBoxSequence.
	distanceOfBoard :=boxes size.
	distancePerBox := Parsecs with:((aDistance amountInParsecs) / distanceOfBoard).
	laps := numberOfLaps.
	lastBoxEffect := NoEffect new.
]

{ #category : #accessing }
Board2 >> lastBoxEffect [
	^lastBoxEffect .
]

{ #category : #accessing }
Board2 >> move: oldSpaceshipPosition to: aBox [

	|spaceshipNewBoxNumber spaceshipNewLapNumber auxNewBoxNumber spaceshipAuxLapNumber |
	
	auxNewBoxNumber := self newBoxNumberFor:oldSpaceshipPosition with:aBox.
	spaceshipNewBoxNumber := auxNewBoxNumber % distanceOfBoard.
	spaceshipAuxLapNumber:= (auxNewBoxNumber - 1 // distanceOfBoard + 1).
	spaceshipNewLapNumber:=spaceshipAuxLapNumber min:laps.
	((spaceshipAuxLapNumber > laps) or:spaceshipNewBoxNumber = 0) ifTrue:[spaceshipNewBoxNumber:=distanceOfBoard].

	^ SpaceshipPosition at: spaceshipNewBoxNumber distance: (oldSpaceshipPosition distanceInBox) laps: spaceshipNewLapNumber.
]

{ #category : #actions }
Board2 >> move: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox oldSpaceshipStatus |
	oldSpaceshipStatus := allSpaceshipsStatuses detect: [ :each | each name = aSpaceship ].
	oldSpaceshipPosition:= oldSpaceshipStatus position.
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distanceInBox + aDistanceNumber amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipStatus
		to: (SpaceshipPosition
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % (distancePerBox amountInParsecs) 
				 laps: oldSpaceshipPosition lapNumber).
	self
		move: aSpaceship
		to: spaceshipNewDistanceInBox // (distancePerBox amountInParsecs).
]

{ #category : #actions }
Board2 >> move: oldSpaceshipPosition with: aDiceResult [

	self move: oldSpaceshipPosition to: aDiceResult.
	self
		effectAt: oldSpaceshipPosition boxNumber
		appliedBy: oldSpaceshipPosition.
]

{ #category : #actions }
Board2 >> moveBackwards: aNumberOfBoxes allSpaceshipsExcept: aSpaceship [

	allSpaceshipsStatuses do: [ :each | 
		each name ~= aSpaceship ifTrue: [ 
			self move: each name to: aNumberOfBoxes ] ].
]

{ #category : #action }
Board2 >> moveSpaceshipsToTheFirstBox [

	allSpaceshipsStatuses do: [ :each | 
		self
			updateSpaceshipPositionOf: each
			to:
			(SpaceshipPosition at: 1 distance: 0 laps: each position lapNumber) ]
]

{ #category : #private }
Board2 >> newBoxNumberFor: oldSpaceshipPosition with: aBox [

	| newBoxNumber |
	newBoxNumber := ((oldSpaceshipPosition lapNumber - 1) * distanceOfBoard)
	                + aBox + oldSpaceshipPosition boxNumber.
	newBoxNumber <= 0 ifTrue: [ ^ 1 ].
	^newBoxNumber.
]

{ #category : #accesing }
Board2 >> rankingOf: aSpaceship [

	allSpaceshipsStatuses do: [ :spaceship | 
		spaceship name = aSpaceship ifTrue: [ 
			^ allSpaceshipsStatuses indexOf: spaceship ] ]

]

{ #category : #accessing }
Board2 >> remove:aCard from:aSpaceship [

	| spaceshipOldStatus spaceshipNewHand spaceshipHand |
	spaceshipOldStatus := self spaceshipOf:aSpaceship.
	spaceshipHand := spaceshipOldStatus hand cards.
	spaceshipHand remove: aCard.
	spaceshipNewHand := SpaceshipHand with: spaceshipHand.
	self
		updateSpaceshipHandOf: spaceshipOldStatus
		with: spaceshipNewHand
]

{ #category : #private }
Board2 >> sortPositionsByRanking [

	allSpaceshipsStatuses sort: [ :spaceship1 :spaceship2 | 
		spaceship1 position > spaceship2 position ]
]

{ #category : #accesing }
Board2 >> spaceshipOf: aSpacehipsName [

	^ allSpaceshipsStatuses detect: [ :each | each name = aSpacehipsName ]
]

{ #category : #accessing }
Board2 >> thereIsAWinner [

	| possibleWinnerPosition |
	possibleWinnerPosition := (allSpaceshipsStatuses first) position.
	^((possibleWinnerPosition boxNumber = distanceOfBoard and:
		 possibleWinnerPosition lapNumber = laps))
]

{ #category : #accessing }
Board2 >> thereIsAWinnerWith: aCollectionOfPositions [ 
	| possibleWinnerPosition |
	possibleWinnerPosition := aCollectionOfPositions first.
	^((possibleWinnerPosition boxNumber = distanceOfBoard and:
		 possibleWinnerPosition lapNumber = laps))
]

{ #category : #actions }
Board2 >> updateSpaceshipEffectsOf: aSpaceshipOldStatus to: spaceshipNewEffects [

	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: aSpaceshipOldStatus hand
			 effects: spaceshipNewEffects)
]

{ #category : #private }
Board2 >> updateSpaceshipHandOf: aSpaceshipOldStatus with: spaceshipNewHand [

	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: aSpaceshipOldStatus position
			 cards: spaceshipNewHand
			 effects: aSpaceshipOldStatus effectsOnSpaceship)
]

{ #category : #private }
Board2 >> updateSpaceshipPositionOf: aSpaceshipOldStatus to: spaceshipNewPosition [


	allSpaceshipsStatuses replaceAll: aSpaceshipOldStatus with: (SpaceshipStatus
			 of: aSpaceshipOldStatus name
			 position: spaceshipNewPosition
			 cards: aSpaceshipOldStatus hand
			 effects: aSpaceshipOldStatus effectsOnSpaceship).
]

{ #category : #accesing }
Board2 >> winner [

	self thereIsAWinner
		ifTrue: [ ^ (allSpaceshipsStatuses first) name ]
		ifFalse: [ 
			Error signal:
				'Game does not have a winner beacause is not finished yet' ]
]
