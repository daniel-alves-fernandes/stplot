{smcl}
{* *! version 4.0  12jul2023}{...}

{title:Stata Plot}

{pstd}
{hi:stplot} {hline 2} specifies the overall look of graphs.

{marker syntax}{...}
{title:Syntax}

{pstd}
  {cmd:stplot} {it:scheme},
  [{bf:{ul:c}olors(}{help colorpalette:colors}{bf:)}
  {bf:{ul:s}ymbols(}{help symbolstyle:symbols}{bf:)}
  {bf:{ul:l}ines(}{help linepatternstyle:lines}{bf:)}
  {bf:{ul:leg}end(}{it:position}{bf:)}
  {bf:{ul:t}icks(}{it:option}{bf:)}
  {bf:{ul:b}ackground(}color{bf:)}
  {bf:size(}{it:ysize} {it:xsize}{bf:)}
  {bf:{ul:n}ame(}{it:name}{bf:)]}


{title:Description}

{pstd}
{it:stplot} specifies the overall look of graphs.
Three base schemes are available with this command:

{pstd}
1. {it:noaxes} draws plots without axes lines{break}
2. {it:axes} draws lines along the x-axis and the y-axis{break}
3. {it:box} draws a frame around all the sides of the plot region{break}
4. {it:mesh} draws white axes lines on a coloured background

{pstd}
{it:stplot} is not a theme.
{it:stplot} is a command that writes the graph style instructions to .scheme file.
This approach offers three distinct advantages over conventional graph scheme packages:

{pstd}
- it includes more control over the base theme to be used in graphs.{break}
- it makes it possible to specify several tweaked versions of a theme to use in different plots.{break}
- it facilitates the visual reproduction of graphs. The .scheme file contains all the instructions necessary to replicate the look of graphs with no installs required (including the {it:stplot} package).

{title:Options}

{pstd}
{bf:{ul:c}olors(}{help colorpalette:colors}{bf:)}: specifies the color scheme to be used in graphs. This option is a wrap of the {help colorpalette} command. It accepts color schemes (e.g. s2color) and lists of color names or their RGB codes (e.g. navy "123 146 168" maroon), or any color palette generated by {help colorpalette}.

{pstd}
{bf:{ul:s}ymbols(}{help symbolstyle:symbols}{bf:)}: specifies the symbols to be used in marker elements.

{pstd}
{bf:{ul:l}ines(}{help linepatternstyle:lines}{bf:)}: specifies the line patterns to be used in line elements.

{pstd}
{bf:{ul:leg}end(}{it:position}{bf:)}: four alternatives available:{break}
1. {it:off} turns off the legend{break}
2. {it:inside} draws the legend inside the plot region{break}
3. {it:side} draws the legend outside of the plot region on its right side{break}
4. {it:bottom} draws the legend outside of the plot region on the bottom.

{pstd}
{bf:nogrid}: turns all the gridlines off.

{pstd}
{bf:{ul:t}icks(}{it:option}{bf:)}: specify style of major and minor ticks. Four alternative available:{break}
1. {it:outside}: draws ticks ouside of the axis line. {it:Default option if this option is not specified.}{break}
2. {it:inside}: draws ticks inside of the axis line.{break}
3. {it:transparent}: hides ticks but keeps the space between axes and labels {break}
4. {it:off}: turns ticks off. {it:stplot noaxes} uses this option by default.

{pstd}
{bf:{ul:b}ackground}: specifies the background colour of the plot region. {it:Only allowed in scheme mesh.}

{pstd}
{bf:size(}{it:ysize} {it:xsize}{bf:)}: specify the size of the graph. {it:ysize} and {it:xsize} are numeric values followed by units {it:in}, {it:pt}, or {it:cm}. When units are not specified, {it:in} is assumed.
By default, {it:stplot} defines 112.5mm by 150mm. The graph area has a 4:3 aspect ratio. The horizontal size fills the text width of a A4 paper with a 3cm margin on each side.


{pstd}
{bf:{ul:n}ame(}{it:name}{bf:)}: saves a .scheme file with the specified name. If this option is not specified, the command saves the scheme instructions on file with the name {it:stataplot-scheme.scheme}.

{title:Author}

{pstd}
{it:Daniel Alves Fernandes}{break}
European University Institute

{pstd}
daniel.fernandes@eui.eu

{pstd}
{it: A special thanks to Ben Jann, the creator of the {help grstyle} and the {help colorpalette} packages.}
