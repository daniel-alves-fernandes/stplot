# stplot
*stplot* specifies the overall look of graphs in Stata.

*stplot* is not a theme. It is a command that writes the graph style instructions to .scheme file. This approach offers three distinct advantages
over conventional graph scheme packages:

- it includes more control over the base theme to be used in graphs.
- it makes it possible to specify several tweaked versions of a theme to use in different plots.
- it facilitates the visual reproduction of graphs. The .scheme file contains all the instructions necessary to replicate the look of graphs with no
installs required (including the stplot package itself). Just share this file with your peers!

## Install

This package requires three packages to work: 

- [grstyle](http://repec.sowi.unibe.ch/stata/grstyle/index.html): stplot uses grstyle settings to create the graph styles.
- [palettes](http://repec.sowi.unibe.ch/stata/palettes/index.html): program to manage colors, symbol and linestyles within Stata.
- [colrspace](https://github.com/benjann/colrspace): program to manage of color-spaces within Mata. Palettes requires this package to run.

To install them, just type this into Stata:

```
ssc install grstyle
ssc install colrspace
ssc install palettes
```

You can download these packages manually. After installing these packages, put `stplot.ado` and `stplot.sthlp` in your working directory or your personal Stata directory.

If these packages are not on your system in the first run, `stplot` will prompt you to install them. In this case, the installation process will be handled automatically by the program.

## Syntax

```
stplot scheme, [colors(colorpalette) symbols(symbolstyle) lines(linestyle) legend(position) nogrid noticks altcontrast background(color) name(name)]
```

Type `help stplot` in Stata to have a detailed description of all the options.

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

```stata
stplot mesh, background("234 234 241")
twoway scatter price mpg
```

![nogrid](https://raw.githubusercontent.com/daniel-alves-fernandes/stplot/main/examples/mesh.png)
