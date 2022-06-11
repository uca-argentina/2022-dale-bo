Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AccelerationCard >> applyTo: target [

	target do:[:each | each isAffectedBy: self].
]

{ #category : #action }
AccelerationCard >> effect [

	^ 1
]

{ #category : #accessing }
AccelerationCard >> family [
^'Permanent'.
]

{ #category : #accessing }
AccelerationCard >> type [

	^ 'AccelerationCard'
]
