Closures
========


What closures add is the ability to give a subroutine attributes (or rather, add attributes to a reference to a subroutine). So you can write a subroutine that takes arguments and returns a subroutine that has those arguments as parameters.

```elixir
closures = (0..2)
  |> Enum.map &( fn () -> IO.puts(&1) end)

  closures
    |> Enum.each &(&1.())
```


* https://stackoverflow.com/questions/1305570/closures-why-are-they-so-useful
* https://reprog.wordpress.com/2010/02/27/closures-finally-explained/
* http://www.perlmonks.org/?node=Why%20Closures%3F
* https://www.electricmonk.nl/log/2011/05/20/closures-and-when-theyre-useful/  -> use case
* https://www.quora.com/Why-are-closures-important-in-JavaScript
* https://www.amberbit.com/blog/2015/6/14/closures-elixir-vs-ruby-vs-javascript/

*
