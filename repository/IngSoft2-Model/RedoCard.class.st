Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
RedoCard >> applyTo: target over:aCardEffect [

	target isAffectedBy: self..
]

{ #category : #accessing }
RedoCard >> family [
^nil.
]

{ #category : #accessing }
RedoCard >> type [
^'RedoCard'
]
