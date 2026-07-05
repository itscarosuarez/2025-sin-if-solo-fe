"
card
"
Class {
	#name : 'CardSkip',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardSkip >> applyInstantaneousEffectIn: aGame [ 

	aGame skipTurnDueToCard 


]

{ #category : 'action' }
CardSkip >> playedBy: aSpaceship targeting: aTarget in: aGame [

	aGame playsInstantaneousCard: self
]
