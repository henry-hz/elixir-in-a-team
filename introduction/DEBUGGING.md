Debugging
=========

## Local


#### IO.inspect

From elixir 1.4, you can use IO.inspect even during a pipe :)

```elixir
[1, 2, 3]
|> IO.inspect(label: "before")
|> Enum.map(&(&1 * 2))
|> IO.inspect(label: "after")
|> Enum.sum
```

#### Pry


```elixir
require IEx
IEx.pry()  # <- add this where you want to stop
```

to restart:

```
respawn
```



#### Observer

An insight tool for all kinds of metrics for a running BEAM node.



```
:observer.start()
```


* [pry-inspect](http://blog.plataformatec.com.br/2016/04/debugging-techniques-in-elixir-lang/) - debugging techniques in elixir
* [observer](http://www.akitaonrails.com/2015/11/22/observing-processes-in-elixir-the-little-elixir-otp-guidebook)
- observing processes in elixir - The Little Elixir & OTP Guidebook
* [debuggin-phoenix](https://medium.com/@diamondgfx/debugging-phoenix-with-iex-pry-5417256e1d11) - debugging views, controllers, etc...
* [tracing](https://zorbash.com/post/debugging-elixir-applications/) - tracing,
EPMD, etc...




## Production

#### Observer remotely

```
iex --name sally -S mix s
epmd -names
iex --name bob
Node.connect(:"sally@Gregs-MacBook-Pro-2.wework.com")
:observer.start()
```

* [recon](https://github.com/ferd/recon) - collection of functions and scripts to debug Erlang in production
* [observer-cli](https://github.com/zhongwencool/observer_cli) - like the
    observer, but in a CLI environment
*
[observer-remotely](https://sgeos.github.io/elixir/erlang/observer/2016/09/16/elixir_erlang_running_otp_observer_remotely.html)
- use the graphical observer connected to a remote node
