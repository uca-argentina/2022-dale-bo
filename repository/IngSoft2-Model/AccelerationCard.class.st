Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AccelerationCard >> effect [

	^ 1
]

{ #category : #operations }
AccelerationCard >> isPermanent [

	^true.
]

{ #category : #'as yet unclassified' }
AccelerationCard >> playedOn: aGame by: aSpaceship [

	| aCardPlay |
	aCardPlay := CardPlay
		             by: aSpaceship
		             type: self
		             to: 'all'
		             for: nil.
	aGame applyCardPlay: aCardPlay
]
