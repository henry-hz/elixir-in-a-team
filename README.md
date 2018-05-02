Elixir in a Team
================

> "Any fool can write code that a computer can understand. Good programmers write code that humans can understand." — Martin Fowler

Well, you just arrived in a company to work with Elixir, but wait, there are a
lot of resources needed, behind coding! And the most important of all, is to
learn to code for your team. People will need to read your code, typing is
essential to leave your brain CPU resources focus on coding, instead of hunting
letters, code-style, architecture, HTTP, git, linux, and much more.

But the most important issue: you take some vacations, and your co-workers will
open and read/mantain your code... oho... what happens now ? can they understand
something ? can they compile ? can they change some part of the code with safety,
or they become afraid of touching it ? It's all about coding for
others, and once you understand that well, for sure your approach in coding will be
the correct one, and your code will be a real aggregated value for your company.

An excelent reference for Elixir is in [Elixir
School](https://elixirschool.com/en/). I added in this repo a lot of info on how
to write code for you team, enjoy.



## Introduction

  * [introduction](introduction/INTRODUCTION.md) - some theory to start
  * [why-elixir](introduction/WHY_ELIXIR.md) - good reasons to adopt
  * [working-in-a-team](introduction/TEAM.md) - what is the approach on learning
      how to code for people
  * [functional-programming](introduction/FUNCTIONAL_PROGRAMMING.md) -
      introduction and basic principles for functional programming


## References


### Elixir
  * [quick-reference](references/elixir/ELIXIR.md) - amazing quick reference.
  * [specs](references/elixir/SPECS.md) - type specifications for your functions.
  * [error-handling](references/elixir/ERROR_HANDLING.md) - many good strategies
  * [with](references/elixir/WITH.md) - pipelines using {:ok, res} and {:error, message} pattern matchings
  * [pipes](references/elixir/PIPES.md) - many options on how to use them
  * [debugging](references/DEBUGGING.md) - local and remote debugging techniques 
  * [documentation](references/elixir/DOCUMENTATION.md) - writing documentation
  * TODO: [boilerplate](references/BOILERPLATE.md) - essential dependencies: ex_doc, dialyzer, sentry, docker, etc... 

### Phoenix

  * [conn](references/phoenix/CONN.md) - http data structure
  * [controllers](references/phoenix/CONTROLLERS.md) - design patterns in
      controllers
  * [plug](references/phoenix/PLUG.md) - building components to http calls

### GIT
  * [git](references/git/GIT.md) - code repository to share code with a team


### Typing

  * [typing](references/typing/TYPING.md) - finger positions and links


### Linux
  * [linux](references/linux/LINUX.md) - linux
  * [regex](references/linux/REGEX.md) - regex tutorial and references
  * [vi](references/linux/VIM.md) - vi, the super hero editor

### HTTP
  * [http](references/http/HTTP.md) - hyper text transfer protocol introduction
  * [curl](references/http/CURL.md) - making http requests from the command line
  * [rest](references/http/REST.md) - basic and advanced concepts on building a
      REST API

### Deploy
  * TODO: [docker](references/docker/DOCKER.md) - building containers
  * TODO: [kubernetes](references/kubernetes/KUBERNETES.md) - sending your app to the
      cloud


## Labs

  * [calc](labs/calc) - simple calculations, using a datastructure to store every
      step
  * [ninety-nine](labs/ninety_nine) - different solutions for the
      [99-functional-problems](http://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/) 
