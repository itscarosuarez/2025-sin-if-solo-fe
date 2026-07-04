"
RedoCard
"
Class {
	#name : 'CardRedo',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardRedo >> playedBy: aSpaceship targeting: aTarget in: aGame [

	aGame playsRedoCard: aSpaceship targeting: aTarget
]
