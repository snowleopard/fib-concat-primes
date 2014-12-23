Fibonacci concat primes
=======================

A _Fibonacci concat prime_ is a prime number obtained by concatenating several first elements of the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number) (1, 1, 2, 3, 5, 8, 13, ...). These numbers showed up in [Evelyn Lamb's tweet](https://twitter.com/evelynjlamb/status/546943925357785089) and got me interested, especially since I wanted to play with primality testing of big numbers in Haskell. ('Fibonacci concat prime' is a completely made up name; shout if you know the right one!)

Known trivial examples: 
 * 11 = 1 ○ 1
 * 1123 = 1 ○ 1 ○ 2 ○ 3 

I got curious if there were any other Fibonacci concat primes and wrote a generator in Haskell using [this implementation of Miller-Rabin primality test](https://github.com/pernas/Primes).

[My generator](fibConcatPrimes.hs) seems to work fine, but unfortunately it reported that there were no other Fibonacci concat primes less than 10<sup>35000</sup>! It took just a couple of hours for the generator to do the work, which I thought was pretty impressive since I made no effort to optimise the code.

Being a bit disappointed by my wasted efforts, I decided to try my luck by _reversing_ the numbers. And it worked!

The following four _reversed Fibonacci concat primes_ were found below 10<sup>20000</sup>:
 * 11 = reverse (1 ○ 1)
 * 211 = reverse (1 ○ 1 ○ 2)
 * 853211 = reverse (1 ○ 1 ○ 2 ○ 3 ○ 5 ○ 8)
 * 8807636183460050617945574903584919919511612709750316609341373260988735867648438276143212267642043327441464197323493449875748800793972557076092264546143508797705841112756829445969403139394033551560846297811045489492107112516080353190709429309149906403096671114184206432727358212075549448825300987777256577108676171327758902016012489130747556188735937250416918703740522955780084511406202276599789276821952616925345637173341585225442683859312721757626837119261335990082159234701105630252096268521940247877767962570843705121792309113638171309431133780410773449433469241976214108556155143320168954236961880937187514225303941564722978820758754253903871296264314023892241511871381469139312152057863647568211771649015676181448527951789167733324419855431231853211 = reverse (1 ○ ... ○ 160500643816367088)

So, now if you need a big (754 digits) prime number, just concatenate Fibonacci numbers from F<sub>1</sub> to F<sub>84</sub> and then reverse the result!

Related work
------------

A comment on [this OEIS sequence](http://oeis.org/A019523) says that no other non-reversed Fibonacci concat primes are currently known.

There is another related sequence at OEIS: [A134069](http://oeis.org/A134069). Note that it is different from what I call reversed Fibonacci concat primes: the sequence of Fibonacci numbers is reversed, but the numbers themselves are not, e.g., it contains 13853211 instead of 31853211. To distinguish the sequences, I will refer to A134069 as _semireversed Fibonacci concat primes_. I have implemented their generation as well (try the `-semireversed` option); the only semireversed Fibonacci concat primes below 10<sup>20000</sup> are 11, 211 and 853211.

Instructions
------------

To clone this repository, run the following command:
```
git clone --recursive https://github.com/snowleopard/fib-concat-primes.git
```
Note that `--recursive` is important, as otherwise submodule `Primes` will not be cloned.

To build the sources, run the `build.bat` script (should be cross-platform).
