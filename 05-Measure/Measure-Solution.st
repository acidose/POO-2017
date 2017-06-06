!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:40:29'!
* aSmallInteger 
	^self class createWithAmount: amount*aSmallInteger withUnit: self unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:10:50'!
+ aMeasure 
	^self class createWithAmount: ((amount*unit ratio) + (aMeasure amount*aMeasure unit ratio))/ unit ratio withUnit: self unit. ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:40:20'!
- aDistance 
	^self + (aDistance * (-1)).! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:41:16'!
/ aSmallInteger 
	^self * (1/aSmallInteger). ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:41:45'!
< aMeasure
	^ (amount * unit ratio) < (aMeasure amount * aMeasure unit ratio).! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:31:09'!
= aMeasure
	^(aMeasure isKindOf: self class) and: [(amount*unit ratio) = (aMeasure amount * aMeasure unit ratio)].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:42:33'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:40'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 01:59:11'!
convertTo: anUnit
	^self class createWithAmount: (amount * unit ratio) / anUnit ratio withUnit: anUnit. ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:59:27'!
initializeWithAmount: aNumber withUnit: anUnit 
	amount := aNumber.
	unit := anUnit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 01:51:27'!
negated
	^ self class createWithAmount: (amount * (-1)) withUnit: unit .! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:47'!
unit
	^unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:12:08'!
createWithAmount: aSmallInteger withUnit: anUnit 
	^self new initializeWithAmount: aSmallInteger withUnit: anUnit ! !


!classDefinition: #Distance category: #'Measure-Solution'!
Measure subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 17:47:25'!
to: aDistance 
	^DistanceInterval from: self to: aDistance.! !

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 18:17:01'!
to: aDistance by: aDistance2 
	^DistanceInterval from: self to: aDistance by: aDistance2.! !



!Distance methodsFor: 'converting' stamp: 'Mirko 6/6/2017 01:58:40'!
convertTo: anUnit
	^self class createWithAmount: (amount * unit ratio) / anUnit ratio withUnit: anUnit. ! !


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


!Distance methodsFor: 'inspecting' stamp: 'PR 6/3/2017 20:46:55'!
lesserUnit: aDistance 
(self unit ratio < aDistance unit ratio)ifTrue: [^self unit ] ifFalse: [^aDistance unit ]. ! !


!Distance methodsFor: 'as yet unclassified' stamp: 'Mirko 6/3/2017 22:50:58'!
hash
	|hasher|
	hasher := self convertTo: Unit createMeter.
	^  hasher amount hash .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Measure-Solution'!
Distance class
	instanceVariableNames: 'unit value'!

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:38:54'!
createCentimeterWithAmount: anAmount 
	^self new initializeWithAmount: anAmount withUnit: Unit createCentimeter.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:40:38'!
createDecameterWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createDecameter .! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:40:27'!
createDecimeterWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createDecimeter .! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:40:51'!
createHectometerWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createHectometer .! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:39:50'!
createKilometerWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createKilometer.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:36:18'!
createMeterWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createMeter.! !

!Distance class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/5/2017 23:58:31'!
createMillimeterWithAmount: anAmount
	^self new initializeWithAmount: anAmount withUnit: Unit createMillimeter .! !


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

!Temperature methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:22:16'!
+ aTemperature
	|convertCelsius aTemperatureconvertCelsius|
	
	(self unit = aTemperature unit)ifFalse:[
	convertCelsius:= self convertToCelsius.
	aTemperatureconvertCelsius := aTemperature convertToCelsius .
	^Temperature createCelsiusWithAmount: ( convertCelsius amount + aTemperatureconvertCelsius amount)]
	 ifTrue: [^Temperature createWithAmount:  amount + aTemperature amount withUnit: unit ]
	
	
	"aca es donde no veo sentido a los createCelsius... etc..."! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:59:13'!
- aTemperature
	|convertCelsius aTemperatureconvertCelsius amountCelsius |
	convertCelsius:= self convertToCelsius.
	aTemperatureconvertCelsius := aTemperature convertToCelsius .
	amountCelsius:= convertCelsius amount - aTemperatureconvertCelsius  amount .
	 ^Temperature createCelsiusWithAmount: amountCelsius.
	
	
	"aca es donde no veo sentido a los createCelsius... etc..."! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:08:27'!
= aTemperature
	^(aTemperature isKindOf: self class) and: [ self convertToCelsius amount = aTemperature convertToCelsius amount].! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:32:56'!
convertToCelsius

	(unit = Unit createCelsius)ifTrue: [^Temperature createCelsiusWithAmount: amount]ifFalse: 
	[(unit = Unit createKelvin )ifTrue:[^Temperature createCelsiusWithAmount: amount -273.15]ifFalse: [^Temperature createCelsiusWithAmount: (amount -32)*(5/9)]].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Temperature class' category: #'Measure-Solution'!
Temperature class
	instanceVariableNames: ''!

!Temperature class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:59:41'!
createCelsiusWithAmount: aNumber
(aNumber < -273.15)ifTrue: [^Error ] ifFalse:[ 
	^self new initializeWithAmount: aNumber withUnit: Unit createCelsius]. ! !

!Temperature class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 17:04:41'!
createFahrenheitWithAmount: anAmount 
	(anAmount < -459.67)ifTrue: [^Error ]
	ifFalse: [^self new initializeWithAmount: anAmount withUnit: Unit createFahrenheit].! !

!Temperature class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 17:00:17'!
createKelvinWithAmount: aNumber
(aNumber < 0)ifTrue:[^Error ]ifFalse: 
	[^self new initializeWithAmount: aNumber withUnit: Unit createKelvin]. ! !


!classDefinition: #Tiempo category: #'Measure-Solution'!
Measure subclass: #Tiempo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:34:24'!
setUp
	factory := MeasureFactory new.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:03:23'!
test001MassRepresentingSameMassShouldBeEqual

	self assert: factory oneKilogram = factory oneKilogram.
	self assert: factory fiveHundredGrams = factory fiveHundredGrams.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:03:34'!
test002DifferentMassesShouldntBeEqual

	self deny: factory oneKilogram = factory twoKilograms.
	self deny: factory fiveHundredGrams = factory oneThousandGrams.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:17:53'!
test003AddingMassOfSameUnitCorrectlyAndClassIsMass

	self assert: factory oneKilogram  + factory  oneKilogram = factory twoKilograms .
	self assert: (factory oneKilogram  + factory  oneKilogram) class = Mass.
	self assert: factory oneGram + factory oneGram = factory twoGrams.
	self assert:  (factory oneGram + factory oneGram) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:22:13'!
test004AddingMassOfDifferentUnitCorrectlyAndClassIsMass

	self assert: factory oneKilogram  +  factory oneThousandGrams = factory twoKilograms .
	self assert: (factory oneKilogram  + factory  oneThousandGrams ) class = Mass.
! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:27:31'!
test005SubstractingMassOfSameUnitCorrectlyAndClassIsMass

	self assert: factory twoKilograms  - factory  oneKilogram = factory oneKilogram .
	self assert: (factory twoKilograms  - factory  oneKilogram) class = Mass.
	self assert: factory twoGrams - factory oneGram = factory oneGram.
	self assert:  (factory twoGrams - factory oneGram) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:30:26'!
test006SubstractingMassOfDifferentUnitCorrectlyAndClassIsMass

	self assert: factory twoKilograms  -  factory oneThousandGrams = factory oneKilogram .
	self assert: (factory twoKilograms  -  factory oneThousandGrams) class = Mass.
! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:38:19'!
test007MultiplyMassWithNumberAndClassIsMass

	self assert: factory oneKilogram  * 2 = factory twoKilograms .
	self assert: (factory  oneKilogram * 2) class = Mass.
	self assert: factory twoGrams *(1/2) = factory oneGram.
	self assert:  (factory twoGrams *(1/2)) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:58:29'!
test008MultiplyNumberWithMassAndClassIsMass

	self assert:  2 * factory oneKilogram   = factory twoKilograms .
	self assert: (2 *factory  oneKilogram ) class = Mass.
	self assert: (1/2) * factory twoGrams  = factory oneGram.
	self assert:  ((1/2) * factory twoGrams ) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 01:14:04'!
test009DividedMassWithNumberAndClassIsMass

	self assert: factory twoKilograms  / 2 = factory oneKilogram .
	self assert: (factory  oneKilogram / 2) class = Mass.
	self assert: factory twoGrams /2 = factory oneGram.
	self assert:  (factory twoGrams /2) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 01:50:50'!
test010NegatingAMassNegateItsAmountAndClassIsMass

	self assert: factory oneKilogram  negated = factory minusOneKilogram .
	self assert: (factory  oneKilogram negated ) class = Mass.
	self assert: factory oneKilogram negated negated = factory oneKilogram .
	self assert:  (factory twoGrams negated negated) class = Mass! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:19:44'!
test101TemperatureRepresentingSameTemperatureShoudBeEqual

	self assert: factory oneCelsius = factory oneCelsius.
	self assert: factory zeroKelvin = factory zeroKelvin.
	self assert: factory thirtyTwoFahrenheits = factory thirtyTwoFahrenheits.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:23:48'!
test102DifferentTemperatureShouldntBeEqual

	self deny: factory oneCelsius = factory twoCelsius.
	self deny: factory threeKelvin = factory zeroKelvin.
	self deny: factory thirtyTwoFahrenheits = factory tenFahrenheits.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:39:17'!
test103AddingTemperatureOfSameUnitCorrectlyAndClassIsTemperature

	self assert: factory oneCelsius  + factory  oneCelsius = factory twoCelsius.
	self assert: (factory oneCelsius  + factory  oneCelsius ) class = Temperature .
	self assert: factory threeKelvin + factory threeKelvin = factory sixKelvin.
	self assert:  (factory threeKelvin + factory threeKelvin) class = Temperature ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:39:28'!
test104AddingTemperatureOfDifferentUnitCorrectlyAndClassIsTemperature

	self assert: factory oneCelsius  + factory  threeKelvin = factory minusTwoHundredSixtyNine.
	self assert: (factory oneCelsius  + factory  threeKelvin ) class = Temperature .
	self assert: factory oneCelsius + factory thirtyTwoFahrenheits = factory oneCelsius.
	self assert:  (factory oneCelsius + factory thirtyTwoFahrenheits) class = Temperature. 
	self assert: factory threeKelvin + factory thirtyTwoFahrenheits = factory threeKelvin .
	self assert:  (factory threeKelvin + factory thirtyTwoFahrenheits) class = Temperature ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 18:13:02'!
test105SubstractingTemperatureOfSameUnitCorrectly

	self assert: factory twoCelsius  - factory  oneCelsius = factory oneCelsius .

	self assert: factory thirtyTwoFahrenheits - factory twentyFahrenheits = factory twelveFahrenheits .	
	
	"preguntar, no es lo mismo sumar los Fahrenheits y luego aplicar convertToCelsius que aplicar convertToCelcius y luego sumarlos"! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:33:41'!
test106SubstractingTemperatureOfDifferentUnitCorrectlyAndClassIsMass

	self assert: factory twoCelsius  -  factory thirtyTwoFahrenheits = factory twoCelsius .
	self assert: (factory twoCelsius  -  factory thirtyTwoFahrenheits) class = Temperature .
	self assert: factory threeKelvin  -  factory thirtyTwoFahrenheits = factory threeKelvin .
	self assert: (factory threeKelvin  -  factory thirtyTwoFahrenheits) class= Temperature.
	self assert: factory thirtyCelcius - factory  threeHundredKelvin = factory threepointEightyFiveCelcius.
	self assert: (factory thirtyCelcius - factory  threeHundredKelvin) class = Temperature ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:42:33'!
test107CanNotCreateKelvinNegative

	self assert: factory threeKelvin  -  factory threeHundredKelvin = Error .! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:34:55'!
test201DistanceRepresentingSameDistanceShoudBeEqual

	self assert: factory oneMeter = factory oneMeter.
	self assert: factory oneHundredCentimeters = factory oneHundredCentimeters.
	self assert: factory oneKilometer = factory oneKilometer.! !


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

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 01:52:23'!
minusOneKilogram
	^Mass createKilogramWithAmount: -1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:04:26'!
minusOneMeter! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 02:48:25'!
minusTwoHundredSixtyNine
	^Temperature createCelsiusWithAmount: -269.15.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:20:14'!
oneCelsius
	^Temperature createCelsiusWithAmount: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:14:10'!
oneGram
	^Mass createGramWithAmount: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:38:19'!
oneHundredCentimeters
	^Distance createCentimeterWithAmount: 100.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:42:18'!
oneKilometer
	^Distance createKilometerWithAmount: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:37:04'!
oneMeter
	^Distance createMeterWithAmount: 1.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:58:45'!
oneThousandGrams
	^Mass createGramWithAmount: 1000.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 02:35:01'!
sixKelvin
	^Temperature createKelvinWithAmount: 6.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:24:24'!
tenFahrenheits
	^Temperature createFahrenheitWithAmount: 10.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:14:53'!
thirtyCelcius
	^Temperature createCelsiusWithAmount: 30.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:24:45'!
thirtyTwoFahrenheits
	^Temperature createFahrenheitWithAmount: 32.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:15:14'!
threeHundredKelvin
	^Temperature createKelvinWithAmount: 300.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:24:06'!
threeKelvin
	^Temperature createKelvinWithAmount: 3.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 16:25:20'!
threepointEightyFiveCelcius
	^Temperature createCelsiusWithAmount: 30- (300-273.15).! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 15:57:14'!
twelveFahrenheits
	^Temperature createFahrenheitWithAmount: 12.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 15:56:48'!
twentyFahrenheits
	^Temperature createFahrenheitWithAmount: 20.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:23:22'!
twoCelsius
	^Temperature createCelsiusWithAmount: 2.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:14:29'!
twoGrams
	^Mass createGramWithAmount: 2.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:52:03'!
twoKilograms
	^Mass createKilogramWithAmount: 2.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:05:21'!
twoKilometers
	^Distance createWithAmount: 2 withUnit: Unit createKilometer.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:07:28'!
twoMeters
	^Distance createWithAmount: 2 withUnit: Unit createMeter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:12:12'!
zeroCelsius
	^Temperature createCelsiusWithAmount: 0.! !

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
