*******************************************************************************
* stplot
* version 5.0.1
* Requires Stata 18

* author: Daniel Fernandes
* contact: d.alves.fernandes@law.leidenuniv.nl
*******************************************************************************

capture: program drop stplot
program define stplot

  * Syntax
  syntax name(name=scheme),                                     ///
  [Colors(string asis) Symbols(string asis) Lines(string asis)] ///
  [LEGend(string) nogrid Ticks(string) size(string)]           ///
  [Background(string)] [Name(string)]

  **** Programmer options ****
  * Required version
  version 18

  * Required packages
  foreach package in grstyle colorpalette{
    capture: which `package'
    if (_rc == 111){
      noisily display as text  ///
      "Packages required: grstyle, colorpalette, and colorspace. " ///
      "Type {it:install} to install" _request(_query)
      if ("`query'" == "install"){
        ssc install grstyle, replace
        ssc install colrspace, replace
        ssc install palettes, replace
      }
      else exit
    }
  }

  * Error checking
  if !inlist("`scheme'","noaxes","axes","box","mesh"){
    noisily: display as error "available schemes: noaxes, axes, box, mesh"
    exit 197
  }

  if ("`scheme'" != "mesh") & ("`background'" != ""){
    noisily: display as error ///
    "option {bf:background} cannot be combined with scheme `scheme'"
    exit 197
  }

  if ("`grid'" == "nogrid") local grid nogrid
  if ("`size'" != ""){
    local anchor = strpos("`size'"," ")
    local ysize = strtrim(substr("`size'",1,`anchor'))
    local xsize = strtrim(substr("`size'",`anchor',.))
  }
  else{
    * These measurements fit in a A4 paper with 3cm margins on each side
    local ysize 112.5mm
    local xsize 150mm
  }

  **** Graph settings ****
  * Initialize style
  grstyle clear
  set scheme stcolor
  if ("`name'" != "") grstyle init `name', replace
  else grstyle init stataplot, replace

  * Graph size
  grstyle set graphsize `ysize' `xsize'

  * Base scheme
  if ("`scheme'" == "noaxes"){
    grstyle set plain, horizontal `grid'
    grstyle linepattern major_grid solid
    grstyle linepattern xyline solid
    grstyle color major_grid black%5

    grstyle set linewidth 0 : axisline
    grstyle color tick_label black
  }
  if ("`scheme'" == "axes"){
    grstyle set plain, horizontal `grid'
    grstyle linepattern major_grid solid
    grstyle linepattern xyline solid
    grstyle color major_grid black%5
  }
  if ("`scheme'" == "box"){
    grstyle set plain, box horizontal `grid'
    grstyle linepattern major_grid solid
    grstyle linepattern xyline solid
    grstyle color major_grid black%5

    grstyle set linewidth 0: axisline
  }
  if ("`scheme'" == "mesh"){
    grstyle set plain, horizontal `grid'
    grstyle linepattern major_grid solid
    grstyle linepattern xyline solid
    grstyle set color white: major_grid

    grstyle set linewidth 0: axisline
    if ("`background'" == "") local background "234 234 241"
    grstyle color plotregion "`background'"
  }

  ** Global settings
  * Transparent confidence intervals
  grstyle set ci, opacity(20 20)

  * Line width
  grstyle set linewidth thin: refline refmarker refmarkline xyline major_grid
  grstyle set linewidth vthin: pmark pboxmark pdotmark matrixmark histogram
  grstyle set linewidth none: parea pbar ci_area ci2_area

  * Colours, symbols, and lines
  if ("`colors'" != "")  grstyle set color `colors'
  if ("`symbols'" != "") grstyle set symbol `symbols'
  if ("`lines'" != "")   grstyle set lpattern `lines'

  * Spanning
  grstyle yesno title_span yes
  grstyle yesno subtitle_span no
  grstyle yesno caption_span no
  grstyle yesno note_span no

  ** Other options
  * Legends
  if !inlist("`legend'","","off","inside","bottom","side"){
    noisily{
      display as error "available legend options: off, inside, bottom, side"
    }
    error 197
  }
  if ("`legend'" == "off"){
    grstyle yesno legend_force_nodraw yes
  }
  if ("`legend'" == "inside"){
    grstyle set legend, inside
    grstyle clockdir legend_position 2
    grstyle numstyle legend_cols 1
    grstyle gsize legend_key_xsize vsmall
    grstyle gsize legend_key_ysize vsmall
    if ("`scheme'" == "mesh") grstyle linewidth legend vvthin
    else                      grstyle linewidth legend vthin
  }
  if ("`legend'" == "side"){
    grstyle set legend, nobox
    grstyle clockdir legend_position 3
    grstyle numstyle legend_cols 1
    grstyle gsize legend_key_xsize vsmall
    grstyle gsize legend_key_ysize vsmall
  }
  if inlist("`legend'","bottom",""){
    grstyle set legend, nobox
    grstyle clockdir legend_position 6
    grstyle numstyle legend_rows 1
    grstyle gsize legend_key_xsize vsmall
    grstyle gsize legend_key_ysize vsmall
  }

  * Ticks
  if inlist("`ticks'","","off","inside","outside","transparent"){
    if ("`ticks'" == "off") grstyle set size 0: tick minortick
    else{
        grstyle set size 1.2: tick
        grstyle set size 0.5: minortick
      }
    if ("`ticks'" == "inside") grstyle tickposition axis_tick inside
    if ("`ticks'" == "transparent"){
      grstyle color tick black%0
      grstyle color minortick black%0
    }
  }
  else{
    noisily: display as error "option {bf:ticks} incorrectly specified"
    error 198
  }

end
