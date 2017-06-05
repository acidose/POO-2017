!classDefinition: #Distance category: #'Measure-Solution'!
Magnitude subclass: #Distance
	instanceVariableNames: 'unit amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 17:47:25'!
to: aDistance 
	^DistanceInterval from: self to: aDistance.! !

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 18:17:01'!
to: aDistance by: aDistance2 
	^DistanceInterval from: self to: aDistance by: aDistance2.! !


!Distance methodsFor: 'arithmetic' stamp: 'PR 6/3/2017 20:27:15'!
* aSmallInteger 
	^Distance createWithValue: amount*aSmallInteger withUnit: self unit.! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:05'!
+ aDistance 
	^Distance createWithValue: ((amount*unit ratio) + (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/1/2017 21:14:11'!
- aDistance 
	^Distance createWithValue: ((amount*unit ratio) - (aDistance amount*aDistance unit ratio))/ unit ratio withUnit: self unit. ! !

!Distance methodsFor: 'arithmetic' stamp: 'PR 6/3/2017 20:27:21'!
/ aSmallInteger 
	^Distance createWithValue: amount/aSmallInteger withUnit: unit. ! !


!Distance methodsFor: 'comparing' stamp: 'PR 6/1/2017 21:14:16'!
< aDistance 
	^ (amount * unit ratio) < (aDistance amount * aDistance unit ratio).! !


!Distance methodsFor: 'converting' stamp: 'PR 5/30/2017 17:04:10'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !

!Distance methodsFor: 'converting' stamp: 'PR 6/3/2017 20:42:47'!
convertTo: anUnit
	^Distance createWithValue:  (amount * unit ratio) / anUnit ratio withUnit: anUnit. ! !


!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 23:01:27'!
printString
	| distanceAsString |
	distanceAsString := amount printString, ' ',unit printString.
	
	(amount > 1) ifTrue: [distanceAsString := distanceAsString, 's'].
	
	^distanceAsString.! !

!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 21:20:53'!
withAmount: anAmount withUnit: aUnit
	amount := anAmount.
	unit := aUnit.! !


!Distance methodsFor: 'inspecting' stamp: 'PR 6/1/2017 21:12:13'!
amount
	^amount.! !

!Distance methodsFor: 'inspecting' stamp: 'PR 6/3/2017 20:46:55'!
lesserUnit: aDistance 
(self unit ratio < aDistance unit ratio)ifTrue: [^self unit ] ifFalse: [^aDistance unit ]. ! !

!Distance methodsFor: 'inspecting' stamp: 'PR 5/29/2017 21:03:25'!
unit
	^unit.! !


!Distance methodsFor: 'as yet unclassified' stamp: 'Mirko 6/3/2017 22:50:58'!
hash
	|hasher|
	hasher := self convertTo: Unit createMeter.
	^  hasher amount hash .! !

!Distance methodsFor: 'as yet unclassified' stamp: 'Mirko 6/3/2017 22:53:11'!
negated
	^ Distance createWithValue: (amount * (-1)) withUnit: unit .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Measure-Solution'!
Distance class
	instanceVariableNames: 'unit value'!

!Distance class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/5/2017 17:18:48'!
createWithValue: anAmount withUnit: aUnit
	^self new withAmount: anAmount withUnit: aUnit.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:29:51'!
< aMeasure
	self subclassResponsibility ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:31:09'!
= aMeasure
	^(aMeasure isKindOf: self class) and: [(amount*unit ratio) = (aMeasure amount * aMeasure unit ratio)].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:40'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:59:27'!
initializeWithAmount: aNumber withUnit: anUnit 
	amount := aNumber.
	unit := anUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:47'!
unit
	^unit.! !


!classDefinition: #Mass category: #'Measure-Solution'!
Measure subclass: #Mass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mass class' category: #'Measure-Solution'!
Mass class
	instanceVariableNames: ''!

!Mass class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:55:06'!
createGramWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createGram.! !

!Mass class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:56:19'!
createKilogramWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createKilogram.
	! !


!classDefinition: #Temperature category: #'Measure-Solution'!
Measure subclass: #Temperature
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Temperature methodsFor: 'as yet unclassified' stamp: 'Mirko 6/5/2017 02:19:03'!
= aTemperature
	^(aTemperature isKindOf: self class) and: [ self convertToDegreeCelsius amount = aTemperature convertToDegreeCelsius amount].! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:15:41'!
convertToDegreeCelsius 
	
	(unit = Unit createCelsius) ifFalse: [amount := amount - 273.15].		
	^Temperature createCelsiusWithAmount: amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Temperature class' category: #'Measure-Solution'!
Temperature class
	instanceVariableNames: ''!

!Temperature class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:10:02'!
createCelsiusWithAmount: aNumber
	^self new initializeWithAmount: aNumber withUnit: Unit createCelsius. ! !

!Temperature class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:25:42'!
createFahrenheitWithAmount: anAmount 
	^self new initializeWithAmount: anAmount withUnit: Unit createFahrenheit.! !

!Temperature class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:10:28'!
createKelvinWithAmount: aNumber
	^self new initializeWithAmount: aNumber withUnit: Unit createKelvin ! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:34:24'!
setUp
	factory := MeasureFactory new.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:50:13'!
test01MassRepresentingSameMassShouldBeEqual

	self assert: factory oneKilogram = factory oneKilogram.
	self assert: factory fiveHundredGrams = factory fiveHundredGrams.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:51:38'!
test02DifferentMassesShouldntBeEqual

	self deny: factory oneKilogram = factory twoKilograms.
	self deny: factory fiveHundredGrams = factory oneThousandGrams.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:19:44'!
test101TemperatureRepresentingSameTemperatureShoudBeEqual

	self assert: factory oneCelsius = factory oneCelsius.
	self assert: factory zeroKelvin = factory zeroKelvin.
	self assert: factory thirtyTwoFahrenheits = factory thirtyTwoFahrenheits.! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:14:12'!
celsius
	^Unit createCelsius.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:13'!
centimeter
	^Unit createCentimeter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:31'!
decameter
	^Unit createDecameter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:24'!
decimeter
	^Unit createDecimeter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:48:35'!
fiveHundredGrams
	^Mass createGramWithAmount: 500.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:45'!
hectometer
	^Unit createHectometer .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:12:49'!
kelvin
	^Unit createKelvin.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:51'!
kilometer
	^Unit createKilometer .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:38'!
meter
	^Unit createMeter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:03:05'!
millimeter
	^Unit createMillimeter.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:04:26'!
minusOneMeter! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:20:14'!
oneCelsius
	^Temperature createCelsiusWithAmount: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:58:45'!
oneThousandGrams
	^Mass createGramWithAmount: 1000.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:24:45'!
thirtyTwoFahrenheits
	^Temperature createFahrenheitWithAmount: 32.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:52:03'!
twoKilograms
	^Mass createKilogramWithAmount: 2.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:24:09'!
zeroKelvin
	^Temperature createKelvinWithAmount: 0.! !


!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/5/2017 18:45:35'!
oneKilogram
	^Mass createKilogramWithAmount: 1.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'rate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 23:08:46'!
= anObject
	(anObject isKindOf: self class) ifFalse: [^False].
	
	^(self ratio = anObject ratio) and: [self name = anObject name].! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:53'!
printString
	^name.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:48'!
ratio
	^rate.! !


!Unit methodsFor: 'initialization' stamp: 'PR 6/1/2017 20:40:33'!
initializeWithConvertionRate: aConvertionRate withName: aName.
	rate := aConvertionRate.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: 'ratio'!

!Unit class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:23:24'!
createCelsius
	^self new initializeWithConvertionRate: 1 withName: 'celsius'.! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:28:54'!
createFahrenheit
	"TODO: hay que ver el tema del rate"
	
	^self newConvertionRate: 273.15 named: 'fahrenheit' ! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/4/2017 23:15:33'!
createGram
	^self newConvertionRate: 1 named: 'gram'.! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:23:35'!
createKelvin
	^self newConvertionRate: 273.15 named: 'kelvin' ! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/4/2017 23:16:43'!
createKilogram
	^self newConvertionRate: 1000 named: 'kilogram'. ! !

!Unit class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 17:50:14'!
createMillimeter
	^self newConvertionRate: 1/1000 named: 'millimeter'.! !


!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 21:07:27'!
createCentimeter
	^self newConvertionRate:1/100 named: 'centimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:41:41'!
createDecameter
	^self newConvertionRate:10 named: 'decameter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:41:50'!
createDecimeter
	^self newConvertionRate:1/10 named: 'decimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:01'!
createHectometer
	^self newConvertionRate:100 named: 'hectometer'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:10'!
createKilometer
	^self newConvertionRate:1000 named: 'kilometer'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:20'!
createMeter
	^self newConvertionRate:1 named: 'meter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:42:33'!
createMilimeter
	^self newConvertionRate:1/1000 named: 'milimeter'.! !

!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:39:52'!
newConvertionRate: aConvertionRate named: aName.

	^self new initializeWithConvertionRate: aConvertionRate withName: aName.! !
