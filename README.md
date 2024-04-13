## ATCO-CIF

ATCO-CIF is the format of choice for UK public transport authorities. This is a ruby library that reads **.cif** files and gives you JSON back.

* ATCO (Association of Transport Coordinating Officers)
* CIF (Common Interface File)

* **Official spec:** ~~[http://www.pti.org.uk/CIF/atco-cif-spec.pdf](http://www.pti.org.uk/CIF/atco-cif-spec.pdf)~~
* **NOTE**: official spec is no-longer available from the above URL but can be found on archive.org
* A copy of the [atco-cif-spec.pdf](http://github.com/davidjrice/atco/blob/master/docs/atco-cif-spec.pdf) is included in the `docs` folder in this repo

### USAGE

Currently this library is under-development and has several things left to do before it is perfect (see the [TODO.md](http://github.com/davidjrice/atco/blob/master/TODO.md) list ).

* clone this library `git clone git@github.com:davidjrice/atco.git`
* or install the gem `gem install atco`
* start an irb session (with the helper console command) `bin/console`

Code example, for more detailed internal api usage see the spec files.


```ruby
require "rubygems"
require "atco"

result = Atco.parse("filename.cif")
result = Atco.parse("data/SVRTMAO009A-20091005.cif")

=> {
  header: {…}, # Atco::Header
  locations: […], # Atco::Location
  journeys: {
    "journey_identifier": {…} # Atco::Journey
  },
  unparsed: [
    {line: "unparsed line", line_number:1234}
  ]
}
```

### Author & Contributors

The `ATCO-CIF` Ruby library was originally authored by David Rice [@davidjrice](https://github.com/davidjrice) in response to an FOI request to [Translink](https://www.translink.co.uk) for there timetable data as part of an [OpenDataNI](https://admin.opendatani.gov.uk) initiative.

See [CONTRIBUTORS.md](http://github.com/davidjrice/atco/blob/master/CONTRIBUTORS.md)
