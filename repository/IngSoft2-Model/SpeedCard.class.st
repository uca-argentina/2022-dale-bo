Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpeedCard >> applyTo: target over:aCardEffect [

	target isAffectedBy: self.
]

{ #category : #accesing }
SpeedCard >> effect [
	^ 1.
]

{ #category : #accessing }
SpeedCard >> family [
^ 'Permanent'
]

{ #category : #accessing }
SpeedCard >> type [

	^ 'SpeedCard'
]
