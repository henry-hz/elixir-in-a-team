Errors
======


Use LOGs only to detect software malfunction, all the business exceptions should be part of the main system, and audited.

If {error, reason} is something you need to handle in your business logic you deal with it with pattern matching and you should only deal with the errors you care about. Because it is part of business logic you have to deal with is so the "complexity" is unavoidable.

Don't catch errors and log anywhere except the top level of your code. It is better to bubble up. Error messages should ideally be tuples of atoms with as much information as possible so that you clearly know which sort of errors to handle and which to ignore.



* actionable errors - i.e. expected errors. When those happen we need to handle them gracefully, so that our application can continue working correctly. A good example of this is invalid data provided by the user or data not present in the database. In general we want to handle this kind of errors by using tuple return values ({:ok, value} | {:error, reason}) - the consumer can match on the value and act on the result.

* fatal errors - errors that place our application in undefined state - violate some system invariant, or make us reach a point of no return in some other way. A good example of this is a required config file not present or a network failing in the middle of transmitting a packet. With that kind of errors we usually want to crash and lean on the supervision system to recover - we handle all errors of this kind in a unified way. That’s exactly what the let it crash philosophy is about - it’s not about letting our application burn in case of any errors, but avoiding excessive code for handling errors that can’t be handled gracefully. You can read more about what the “let it crash” means in the excellent article by Fred Hebert of the “Learn You Some Erlang for Great Good” fame - “The Zen of Erlang”.

