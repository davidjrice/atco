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


require 'rubygems'
require 'atco'

result = Atco.parse("filename.cif")
# example data files in the repo
result = Atco.parse("spec/fixtures/translink/SVRTMAO009A-20091005.cif")
result = Atco.parse("spec/fixtures/ulsterbus/Y18_Antrim_1_Sept_2023.cif")

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
