# stplot
*stplot* specifies the overall look of graphs in Stata.

*stplot* is not a theme. It is a command that writes the graph style instructions to .scheme file. This approach offers three distinct advantages
over conventional graph scheme packages:

- it includes more control over the base theme to be used in graphs.
- it makes it possible to specify several tweaked versions of a theme to use in different plots.
- it facilitates the visual reproduction of graphs. The .scheme file contains all the instructions necessary to replicate the look of graphs with no
installs required (including the stplot package itself).


```
sysuse auto 
```
