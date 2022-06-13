Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
OverloadCard >> applyTo: target over:aCardEffect [

	target isAffectedBy: self.
]

{ #category : #action }
OverloadCard >> effect [
	^-2.
]

{ #category : #accessing }
OverloadCard >> family [

	^ 'Permanent'
]

{ #category : #accessing }
OverloadCard >> type [

	^ 'OverloadCard'
]
