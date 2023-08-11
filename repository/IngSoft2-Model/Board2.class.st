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
		'allSpaceshipsPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board2 class >> ships: aCollectionOfSpacships with: aBoxSequence distance: aDistance laps: laps [ 
	^ self new
		  initializeWithShips: aCollectionOfSpacships 
		  with: aBoxSequence
		  distance: aDistance
		  laps: laps
]

{ #category : #accessing }
Board2 >> createPositionsFor: aCollectionOfSpaceships [

	| position |
	allSpaceshipsPositions := aCollectionOfSpaceships collect: [ :ship | 
		                          position := SpaceshipPosition2
															for:ship
			                                      at: 1
			                                      distance: 0
			                                      laps: 1 ]
]

{ #category : #'class initialization' }
Board2 >> initializeWithShips: aCollectionOfSpaceships with: aBoxSequence distance: aDistance laps: numberOfLaps [
	self createPositionsFor:aCollectionOfSpaceships.
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
Board2 >> move: aSpaceship to: aBox [

	| spaceshipNewBoxNumber spaceshipNewLapNumber auxNewBoxNumber spaceshipAuxLapNumber oldSpaceshipPosition |
	oldSpaceshipPosition := self positionOf:aSpaceship.
	auxNewBoxNumber := self
		                   newBoxNumberFor: oldSpaceshipPosition
		                   with: aBox.
	spaceshipNewBoxNumber := auxNewBoxNumber % distanceOfBoard.
	spaceshipAuxLapNumber := auxNewBoxNumber - 1 // distanceOfBoard + 1.
	spaceshipNewLapNumber := spaceshipAuxLapNumber min: laps.
	(spaceshipAuxLapNumber > laps or: spaceshipNewBoxNumber = 0) ifTrue: [ 
		spaceshipNewBoxNumber := distanceOfBoard ].
	lastBoxEffect := boxes at: spaceshipNewBoxNumber.
	self
		updateSpaceshipPositionOf: oldSpaceshipPosition
		to: (SpaceshipPosition2
				 for: oldSpaceshipPosition name
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distanceInBox
				 laps: spaceshipNewLapNumber)
	
]

{ #category : #actions }
Board2 >> move: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox |
	oldSpaceshipPosition := allSpaceshipsPositions detect: [ :each | each name = aSpaceship ].
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distanceInBox + aDistanceNumber amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipPosition
		to: (SpaceshipPosition2
				for:aSpaceship
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % (distancePerBox amountInParsecs) 
				 laps: oldSpaceshipPosition lapNumber).
	self
		move: aSpaceship
		to: spaceshipNewDistanceInBox // (distancePerBox amountInParsecs).
]

{ #category : #actions }
Board2 >> moveBackwards: aNumberOfBoxes allSpaceshipsExcept: aSpaceship [

	allSpaceshipsPositions do: [ :each | 
		each name ~= aSpaceship ifTrue: [ 
			self move: each name to: aNumberOfBoxes ] ].
]

{ #category : #action }
Board2 >> moveSpaceshipsToTheFirstBox [

	allSpaceshipsPositions do: [ :each | 
		self
			updateSpaceshipPositionOf: each
			to:
			(SpaceshipPosition2 for:each name at: 1 distance: 0 laps: each lapNumber) ]
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
Board2 >> positionOf: aSpacehipsName [

	^ allSpaceshipsPositions detect: [ :each | (each name) = aSpacehipsName ]
]

{ #category : #accesing }
Board2 >> rankingOf: aSpaceship [

	allSpaceshipsPositions do: [ :spaceship | 
		spaceship name = aSpaceship ifTrue: [ 
			^ allSpaceshipsPositions indexOf: spaceship ] ]

]

{ #category : #private }
Board2 >> sortPositionsByRanking [

	allSpaceshipsPositions sort: [ :spaceship1 :spaceship2 | 
		spaceship1  > spaceship2  ]
]

{ #category : #accessing }
Board2 >> thereIsAWinner [

	| possibleWinnerPosition |
	possibleWinnerPosition := (allSpaceshipsPositions first).
	^((possibleWinnerPosition boxNumber = distanceOfBoard and:
		 possibleWinnerPosition lapNumber = laps))
]

{ #category : #private }
Board2 >> updateSpaceshipPositionOf: oldSpaceshipPosition to: newSpaceshipPosition [


	allSpaceshipsPositions replaceAll: oldSpaceshipPosition with: newSpaceshipPosition.
]

{ #category : #accesing }
Board2 >> winner [

	self thereIsAWinner
		ifTrue: [ ^ (allSpaceshipsPositions first) name ]
		ifFalse: [ 
			Error signal:
				'Game does not have a winner beacause is not finished yet' ]
]
