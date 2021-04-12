*******************************************************************************
* stplot
* version 3.2

* author: Daniel Fernandes
* contact: daniel.fernandes@eui.eu
*******************************************************************************

capture: program drop stplot
program define stplot

  syntax name(name=scheme),                                     ///
  [Colors(string asis) Symbols(string asis) Lines(string asis)] ///
  [legend(string) nogrid noticks altcontrast]                   ///
  [Name(string)]

  version 16

  * Required packages
  foreach package in grstyle colorpalette{
    capture: which `package'
    if (_rc == 111) noisily display as error  ///
    "Packages required: grstyle, colorpalette, and colorspace"
  }

  * Initialize style
  grstyle clear
  set scheme s2color
  if ("`name'" != "") grstyle init `name'   , replace
  else                grstyle init stataplot, replace

  * Background and coordinate system
  if !inlist("`scheme'","noaxes","axes","box"){
    noisily: display as error "available schemes: noaxes, axes, box"
    exit 197
  }

  if ("`grid'" == "nogrid") local grid nogrid
  else local grid grid
  if ("`scheme'" == "noaxes"){
    grstyle set plain, horizontal `grid'
    grstyle set linewidth 0 : axisline
    grstyle set size 0: tick minortick
    grstyle color major_grid black%05
    if ("`altcontrast'" == "") grstyle color tick_label black%10
    else                       grstyle color tick_label black
  }
  if ("`scheme'" == "axes"){
    grstyle set plain, horizontal `grid'
    grstyle color major_grid black%05
  }
  if ("`scheme'" == "box"){
    grstyle set plain, box horizontal `grid'
    grstyle color major_grid black%05
    grstyle set linewidth 0 : axisline
  }
  if ("`ticks'" == "noticks") grstyle set size 0: tick minortick

  * Legend
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

  * Colour scheme
  grstyle set color `colors'
  local color "`r(p1)'"
  if ("`altcontrast'" == "") local base white
  else                       local base black

  local options:   display strpos("`colors'",",")
  if (`options' == 0) colorpalette `colors', nograph
  else                colorpalette `colors'  nograph

  colorpalette "`r(p1)'", nograph forcergb
  local pcolor :   display `r(p)'
  local opacity:   display strpos("`pcolor'","%")
  if (`opacity' != 0){
    if(regexm("`pcolor'","%[0-9]*")) local opacity = regexs(0)
    local opacity: display subinstr("`opacity'","%","",.)
    local pcolor:  display regexr("`pcolor'","%[0-9]*","")
  }
  else local opacity 100

  tokenize `pcolor', parse(" ")
  local pbright = (0.21 * `1') + (0.72 * `2') + (0.07 * `3')
  local m1      = (0.1 + (255-`pbright')/1000) + (`pbright' / 255)
  local m2      = 1.2 * `m1'
  local m3      = 3 * `m1'

  * Sunflower plots
  colorpalette "`pcolor'", intensify(`m1' `m2' `m3') opacity(`opacity') nograph
  forvalues i = 1/3{
    local r`i': display "`r(p`i')'"
  }
  grstyle symbol sunflower smdiamond_hollow
  grstyle set color "`base'": sunflowerlf sunflowerdf
  grstyle set color "`r1'": sunflower
  grstyle set color "`r2'": sunflowerlb
  grstyle set color "`r3'": sunflowerdb

  * Histograms
  grstyle color histogram "`pcolor'", opacity(`opacity')
  grstyle color histogram_line `base'
  grstyle linewidth histogram thin

  * Matrices
  grstyle seriesstyle matrix p1

  * Confidence intervals
  local ci1 = floor((0.2 + (255-`pbright') * 0.4/255) * (`opacity'/100) * 100)
  local ci2 = floor((0.1 + (255-`pbright') * 0.4/255) * (`opacity'/100) * 100)
  grstyle set color "`pcolor'", opacity(`ci1'): ci_area
  grstyle set color "`pcolor'", opacity(`ci2'): ci2_area

  * Reference lines
  grstyle set color black: refline refmarker refmarkline xyline

  * Outline thickness of markers and areas
  grstyle set linewidth thin: refline refmarker refmarkline xyline
  grstyle set linewidth vthin: pmark pboxmark pdotmark matrixmark histogram
  grstyle set linewidth none: parea pbar ci_area ci2_area

  * Symbols and lines scheme
  if ("`symbols'" != "") grstyle set symbol `symbols'
  if ("`lines'" != "")   grstyle set lpattern `lines'

  * Other options
  grstyle yesno title_span yes
  grstyle yesno subtitle_span no
  grstyle yesno caption_span yes
  grstyle yesno note_span yes
end
