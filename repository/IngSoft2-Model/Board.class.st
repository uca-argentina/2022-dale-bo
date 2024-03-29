Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'laps',
		'distanceOfBoard',
		'distancePerBox',
		'allSpaceshipsPositions',
		'lastBoxEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
Board class >> ships: aCollectionOfSpacships with: aBoxSequence distance: aDistance laps: laps [ 
	^ self new
		  initializeWithShips: aCollectionOfSpacships 
		  with: aBoxSequence
		  distance: aDistance
		  laps: laps
]

{ #category : #accessing }
Board >> boxAt: aPosition [ 
	^boxes at: aPosition.
]

{ #category : #accessing }
Board >> calculate: aSpaceship newpositionUsing: aSum [

	| spaceshipNewBoxNumber spaceshipNewLapNumber auxNewBoxNumber spaceshipAuxLapNumber oldSpaceshipPosition |
	oldSpaceshipPosition := self positionOf: aSpaceship.
	auxNewBoxNumber := self
		                   newBoxNumberFor: oldSpaceshipPosition
		                   with: aSum.
	spaceshipNewBoxNumber := auxNewBoxNumber % distanceOfBoard.
	spaceshipAuxLapNumber := auxNewBoxNumber - 1 // distanceOfBoard + 1.
	spaceshipNewLapNumber := spaceshipAuxLapNumber min: laps.
	(spaceshipAuxLapNumber > laps or: spaceshipNewBoxNumber = 0) ifTrue: [ 
		spaceshipNewBoxNumber := distanceOfBoard ].

	self
		updateSpaceshipPositionOf: oldSpaceshipPosition
		to: (SpaceshipPosition
				 for: oldSpaceshipPosition name
				 at: spaceshipNewBoxNumber
				 distance: oldSpaceshipPosition distanceInBox
				 laps: spaceshipNewLapNumber)
]

{ #category : #accessing }
Board >> createPositionsFor: aCollectionOfSpaceships [

	| position |
	allSpaceshipsPositions := aCollectionOfSpaceships collect: [ :ship | 
		                          position := SpaceshipPosition
															for:ship
			                                      at: 1
			                                      distance: 0
			                                      laps: 1 ]
]

{ #category : #accesing }
Board >> effectAt:aSpaceshipPosition [

	| positionOfSpaceship |
	positionOfSpaceship:= self positionOf: aSpaceshipPosition.
	^boxes at:(positionOfSpaceship boxNumber).
]

{ #category : #'class initialization' }
Board >> initializeWithShips: aCollectionOfSpaceships with: aBoxSequence distance: aDistance laps: numberOfLaps [
	self createPositionsFor:aCollectionOfSpaceships.
	boxes := aBoxSequence.
	distanceOfBoard :=boxes size.
	distancePerBox := Parsecs with:((aDistance amountInParsecs) / distanceOfBoard).
	laps := numberOfLaps.
	lastBoxEffect := InvalidEffect new.
]

{ #category : #accessing }
Board >> lastBoxEffect [

	^ lastBoxEffect
]

{ #category : #actions }
Board >> move: aSpaceship to: aBox using: aGame [

	self calculate: aSpaceship newpositionUsing: aBox.
	lastBoxEffect:= self effectAt:(aSpaceship).
	lastBoxEffect triggeredBy: (self positionOf: aSpaceship) name with: aGame. 
	self sortPositionsByRanking.
]

{ #category : #actions }
Board >> move: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox |
	oldSpaceshipPosition := allSpaceshipsPositions detect: [ :each | each name = aSpaceship ].
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distanceInBox + aDistanceNumber amountInParsecs.

	self updateSpaceshipPositionOf: oldSpaceshipPosition
		to: (SpaceshipPosition
				for:aSpaceship
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % (distancePerBox amountInParsecs) 
				 laps: oldSpaceshipPosition lapNumber).
	self
		calculate: aSpaceship
		newpositionUsing: spaceshipNewDistanceInBox // (distancePerBox amountInParsecs).
]

{ #category : #actions }
Board >> moveBackwards: aNumberOfBoxes allSpaceshipsExcept: aSpaceship [

	allSpaceshipsPositions do: [ :each | 
		each name ~= aSpaceship ifTrue: [ 
			self calculate: each name newpositionUsing: aNumberOfBoxes ] ].
]

{ #category : #actions }
Board >> moveBackwards: aSpaceship by: numberOfBoxes [ 

	self calculate: aSpaceship newpositionUsing: (numberOfBoxes negated).
	self sortPositionsByRanking.
]

{ #category : #actions }
Board >> moveBackwards: aSpaceship toFinalDistance: aDistanceNumber [ 
	| oldSpaceshipPosition  spaceshipNewDistanceInBox |
	oldSpaceshipPosition := allSpaceshipsPositions detect: [ :each | each name = aSpaceship ].
	spaceshipNewDistanceInBox :=oldSpaceshipPosition  distanceInBox + (aDistanceNumber amountInParsecs) negated.

	self updateSpaceshipPositionOf: oldSpaceshipPosition
		to: (SpaceshipPosition
				for:aSpaceship
				 at: oldSpaceshipPosition boxNumber
				 distance: spaceshipNewDistanceInBox % (distancePerBox amountInParsecs) 
				 laps: oldSpaceshipPosition lapNumber).
	self
		calculate: aSpaceship
		newpositionUsing: spaceshipNewDistanceInBox // (distancePerBox amountInParsecs).
]

{ #category : #action }
Board >> moveSpaceshipsToTheFirstBox [

	allSpaceshipsPositions do: [ :each | 
		self
			updateSpaceshipPositionOf: each
			to:
			(SpaceshipPosition for:each name at: 1 distance: 0 laps: each lapNumber) ]
]

{ #category : #private }
Board >> newBoxNumberFor: oldSpaceshipPosition with: aBox [

	| newBoxNumber |
	newBoxNumber := ((oldSpaceshipPosition lapNumber - 1) * distanceOfBoard)
	                + aBox + oldSpaceshipPosition boxNumber.
	newBoxNumber <= 0 ifTrue: [ ^ 1 ].
	^newBoxNumber.
]

{ #category : #accesing }
Board >> positionOf: aSpacehipsName [

	^ allSpaceshipsPositions detect: [ :each | (each name) = aSpacehipsName ]
]

{ #category : #accesing }
Board >> rankingOf: aSpaceship [

	allSpaceshipsPositions do: [ :spaceship | 
		spaceship name = aSpaceship ifTrue: [ 
			^ allSpaceshipsPositions indexOf: spaceship ] ]

]

{ #category : #private }
Board >> sortPositionsByRanking [

	allSpaceshipsPositions sort: [ :spaceship1 :spaceship2 | 
		spaceship1  > spaceship2  ]
]

{ #category : #accessing }
Board >> thereIsAWinner [

	| possibleWinnerPosition |
	possibleWinnerPosition := (allSpaceshipsPositions first).
	^((possibleWinnerPosition boxNumber = distanceOfBoard and:
		 possibleWinnerPosition lapNumber = laps))
]

{ #category : #private }
Board >> updateSpaceshipPositionOf: oldSpaceshipPosition to: newSpaceshipPosition [


	allSpaceshipsPositions replaceAll: oldSpaceshipPosition with: newSpaceshipPosition.
]

{ #category : #accesing }
Board >> winner [

	self thereIsAWinner
		ifTrue: [ ^ (allSpaceshipsPositions first) name ]
		ifFalse: [ 
			Error signal:
				'Game does not have a winner beacause is not finished yet' ]
]
