# stplot
*stplot* specifies the overall look of graphs in Stata.

*stplot* is not a theme. It is a command that writes the graph style instructions to .scheme file. This approach offers three distinct advantages
over conventional graph scheme packages:

- it includes more control over the base theme to be used in graphs.
- it makes it possible to specify several tweaked versions of a theme to use in different plots.
- it facilitates the visual reproduction of graphs. The .scheme file contains all the instructions necessary to replicate the look of graphs with no
installs required (including the stplot package itself). Just share this file with your peers!


## Syntax

```
stplot scheme, [colors(colorpalette) symbols(symbolstyle) lines(linestyle) legend(position) nogrid noticks altcontrast name(name)]
```

## Basic usage

``` stata
sysuse auto 
twoway scatter price mpg
```

![s2color](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/s2color.png)

``` stata
stplot axes
twoway scatter price mpg
```

![axes](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/axes.png)

``` stata
stplot noaxes
twoway scatter price mpg
```

![noaxes](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/noaxes.png)

``` stata
stplot box
twoway scatter price mpg
```

![box](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/box.png)

``` stata
stplot axes, nogrid
twoway scatter price mpg
```

![nogrid](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/nogrid.png)
