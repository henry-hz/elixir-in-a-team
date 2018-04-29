Why Elixir
==========

We have been in San Francisco, and it's amazing how people there are moving from
Rails to Elixir! Yeah!. See
[how](https://medium.com/@elviovicosa/5-reasons-you-should-use-phoenix-instead-of-rails-in-your-next-project-504b4d83c48e)
people are talking about it.




## Declarative, instead of Imperative

Elixir is better for declarative programming, but you should pay attention to
make your code declarative anyway.

*Imperative programming*: telling the “machine” how to do something, and as a result what you want to happen will happen.

*Declarative programming*: telling the “machine” what you would like to happen, and letting the computer figure out how to do it.



```javascript
'use strict'

const sumAllMultiples = limit => {
    let sum = 0

    for(let i = 0; i < limit; i++) {
        if(i % 3 == 0 || i % 5 == 0) {
            sum += i;
        }
    }

    return sum;
}

console.log(sumAllMultiples(1000));
```


The same solution in Elixir
```elixir
1..999 |> Enum.to_list
       |> Enum.filter(&(rem(&1, 3) == 0 or rem(&1, 5) == 0))
       |> Enum.sum
       |> IO.puts
```



## Actor based concurrency model

Instead of mutex, semaphores, and much more complexity, actor based model is
language native and light, very light. Many
[libs](http://berb.github.io/diploma-thesis/original/054_actors.html) today are
adding actor based concurrency model, but really farway from the Beam Machine,
behind the Elixir/Erlang binary files, where garbage collector is per process,
etc... that build a soft real time system. 


## Real time scalability
2 million users connectect in the same server, using web-sockets, with near zero
CPU usage, as described
[here](http://phoenixframework.org/blog/the-road-to-2-million-websocket-connections).


## Code clarity and size

"We’ve also seen an improvement in code clarity. We’re converting our
notifications system from Java to Elixir. The Java version used an Actor system
and weighed in at around 10,000 lines of code. The new Elixir system has shrunk
this to around 1000 lines." . See
[here](https://pragtob.wordpress.com/2017/07/26/choosing-elixir-for-the-code-not-the-performance/)
for more details.

## Web framework

You can use phoenix, that is an amazing framework for web and database. Because
functional programming is so powerfull, you will get a simple code with a lot of
power. See [here](https://www.slant.co/topics/362/~best-backend-web-frameworks)
the comparison.


## Future oriented

Joe Armstrong, creator of Erlang, said something along the lines of: "In OO, if you ask a banana, you might receive a banana with the gorilla and the jungle". When we encapsulate data and behaviour in an object, we have no idea about what is going on there. Of course, one might argue that good OO design might solve this problem. I agree to a certain degree since normally you don't have control over third-party libraries. See [here](https://janjiss.com/the-way-of-modern-web/) for more details.






## Big and successful companies use Elixir
See
[here](https://codesync.global/media/successful-companies-using-elixir-and-erlang/)
and [here](https://www.netguru.co/blog/10-companies-use-elixir)

