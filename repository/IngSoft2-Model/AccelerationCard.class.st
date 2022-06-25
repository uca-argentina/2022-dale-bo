Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
AccelerationCard >> applyUsing: aCardEffectApplicator basedOn: aCardPlay [ 
	aCardEffectApplicator applyAccelerationBasedOn:aCardPlay.
]

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
		             card: self
		             to: aGame allSpaceships
		             itsRedo: false.
	aGame applyCardPlay: aCardPlay
]
