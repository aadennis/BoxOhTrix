# TransposeDates.ps1

Given a text file, pass in a) the From locale, b) the To locale, c) array of the column indexes which contain the dates to be transposed.
An example file is _
"Record 1,Not much here,01/07/2010,Just here,03/08/2012,And a vowel please Rachel"
"Record    2,Quite a lot here         ,01/06/2011,Over there,22/12/2015, Just the consonant please Rache"_

Given a call of
$datesIndexArray = 3,5
TransposeDates -fromLocale "en-GB", "US-US", $record
the expected result is:
"Record 1,Not much here,07/01/2010,Just here,08/03/2012,And a vowel please Rachel"
"Record    2,Quite a lot here         ,06/01/2011,Over there,12/22/2015, Just the consonant please Rache"

That is, the 2 dates in eaach record have been transposed, with all other stuff left as-is

