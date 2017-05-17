Water Reservoir API
================================================================================
[![Codeship Status for fredw/senac-tcs-api](https://app.codeship.com/projects/21999170-f31e-0134-1a26-0a07c77144fa/status?branch=master)](https://app.codeship.com/projects/209878)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/34f4e5be07944695b8319d09e481faf1)](https://www.codacy.com/app/fredw/senac-tcs-api)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/34f4e5be07944695b8319d09e481faf1)](https://www.codacy.com/app/fredw/senac-tcs-api)
[![Run in Postman](https://img.shields.io/badge/postman-ok-orange.svg)](https://app.getpostman.com/run-collection/eb9c2fad329aaf3e792b)

RESTful API for water reservoir control developed for the **Semester Completion Work** for the **Systems Analysis and Development** course at the **SENAC Blumenau**.  
The proposal is to develop a prototype for water control of a reservoirs (cisterns, water tanks, etc.) in condominiums.  
This repository contains only the business layer of the solution, in which it is consumed through the [interface layer](https://github.com/fredw/senac-tcs-web).


Commands
------------------------------------------------------------
``` bash
# Install dependencies
bundle

# Launch web server
rails s

# Console
rails c

# Generate ...
rails g ...

# Tests
rspec
```


TODO and Improvements
------------------------------------------------------------
- [ ] Notify users by email when reservoir reaches a certain level
- [ ] Separate this solution in multiple services (following concepts of micro services)
- [ ] Improve data structure to prevent problems with reservoirs and sensors settings update (considering data already sent)


Credits
------------------------------------------------------------
* Frederico Wuerges Becker <fred.wuerges@gmail.com>
