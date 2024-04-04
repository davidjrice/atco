## ATCO-CIF

ATCO-CIF is the format of choice for UK public transport authorities. This is a ruby library that reads **.cif** files and gives you JSON back.

* ATCO (Association of Transport Coordinating Officers)
* CIF (Common Interface File)

* **Official spec:** [http://www.pti.org.uk/CIF/atco-cif-spec.pdf](http://www.pti.org.uk/CIF/atco-cif-spec.pdf)

### USAGE

Currently this library is under-development and has several things left to do before it is perfect (see the [todo.md](http://github.com/davidjrice/atco/blob/master/TODO.md) list ).

* clone this library
* start an irb session
* put the cif file in ./data (needs to change from being hardcoded)

Code example, for more detailed internal api usage see the spec files.


```ruby
gem install atco
irb


require 'rubygems
require 'atco'

result = Atco.parse('filename.cif')
result = Atco.parse('SVRTMAO009A-20091005.cif) # an example data file in the repo

=> {
  header: {…},
  locations: […],
  journies: {…}
}
```