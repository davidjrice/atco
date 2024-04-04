## TODO

### Version (future)

* Remove data from the repo / gem **(DONE)**
* If nil or blank data found. Remove from output
* Specs should not test the internal methods, should retrieve the objects to test from Atco.parse !!
* Parse all objects into more native ruby objects
* Header attributes should just be root attrs
* "Models" are getting quite repetitive/declarative, declarative is good to allow for easy (understandable) mapping to better domain... however, use active model?
* Handle translink atco-cif extensions during parsing
* handle bank holiday parsing

### Version (1.0.0)

* Update to Ruby 3.x.x compatibility
* Remove deprecated code
* Update docs

### Version (0.0.2)

* Place the entirety of atco code within a Module for namespacing. **(DONE)**
* Journey data, combine into one object. **(DONE)**

### Version (0.0.1)

* 0. File Header **(DONE)**
* 1a. Journey Header **(DONE)**
* 1d. Origin Record **(DONE)**
* 1e. Intermediate Record **(DONE)**
* 1f. Destination Record **(DONE)**
* 2a. Location record **(DONE)**
* 2b. Additional Location Information Record **(DONE)**
* 4a. Operator Record 1 **(DONE)**
* 8. Bank Holiday Dates **(DONE)**
* Iterate lines and parse each into an object from methods extracted above **(DONE)**
* Collate data in a procedural form **(DONE)**
* Output data **(DONE)**
* Journey header not integrated into output **(DONE)**
* Location data should be combined **(DONE)**
* Gemify the library **(DONE)**
