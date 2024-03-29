"if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" ===================================================================
" HTML - HTML - HTML - HTML - HTML - HTML - HTML - HTML
" ===================================================================
"
" File:      $HOME/vim/src/html.vim
" This file: <URL:http://www.math.fu-berlin.de/~guckes/vim/src/html.vim>
" Purpose:      Setup file for the editor Vim for Webpage/HTML editing
" Author:       Sven Guckes guckes@vim.org (guckes@math.fu-berlin.de)
"               <URL:http://www.math.fu-berlin.de/~guckes/>
" Comments:     See also:  <URL:http://www.vim.org/howto/html.html>
"               Please send comments to me - email preferred!
" See also:     http://www.math.fu-berlin.de/~guckes/www/html.html
"               HTML Mini Guide
" Last update:  Tue Mar 20 15:00:00 MET 2001
"
" HTML = HyperText Markup Language - the language of the World Wide Web
"
" ===================================================================
" HTML - useful abbreviations
" ===================================================================
"
"     YWWW  The start of a typical Web address:
  iab YWWW  http://www.
"
" ===================================================================
" HTML - working on files
" ===================================================================
"
"  Whenever I edit a web page I use ",e" to start the edit command.
"  And I use ",rn" to read in a web page template:
"       ,e  = edit www file
" The Webpages are on the web server which is mounted on /import/Mweb
" nmap  ,e :e /import/Mweb/guckes/
" nmap  ,e :e ~/.P/
" The directory ~/.P is a link to the directory with my webpages.
" the name is short so it will be short for the output of ":ls".
"
"   I used ",e" for the command here before, but this was part of the
"   default string for "highlight", so while entering the default
"   string the ",e" it got expanded.  Darn!
"
"       ,rm = read mailto (standard html file for a mailto link to my address)
" map   ,rm :r ~/.P/txt/mailto.html
"
"       ,rn = read new-page (standard html file for a new web page)
"       see http://www.math.fu-berlin.de/~guckes/txt/New.page.form.html
" map   ,rn :0r ~/.P/txt/New.page.form.html
"
"       ,mp = "make public"  - set permissions of file to "rw-r--r--"
" nmap  ,mp :!chmod 644 %<CR>
"       ,MP = "make private" - set permissions of file to "rw-------"
" nmap  ,MP :!chmod 600 %<CR>
"
" ===================================================================
"      wb - white body
"      include a body tage with white background
  iab Ywb  <body bgcolor="#ffffff">
" ===================================================================
"
" ===================================================================
" HTML - Inserting "single" tags
" ===================================================================
"
  iab Ybr <br></br><ESC>T<i
  iab Yhr <hr>
  iab Yp  <p>
  iab Ypp  <p></p><ESC>T>i
  vmap ,pp "zdi<p><C-R>z<CR></p>
"
" ===================================================================
" HTML - making environments
" ===================================================================
"
" HTML ,me = "make environment"
" make current word an HTML environment
 nmap ,me viwyi<<ESC>ea></<C-R>"><ESC>
 vmap ,me    yi<<ESC>ea></<C-R>"><ESC>
"
" Example:  "foo" -> "<foo></foo>"
"
" ===================================================================
" HTML - inserting environments
" ===================================================================
"
" Comment:
  iab  Ycom  <!--X--><ESC>FXs
" vmap ,com <esc>`<i<!--<ESC>`>i--><ESC>
" always comment *whole* lines blocks):
  vmap ,com <esc>`<O<!--<ESC>`>o--><ESC>
"
" Make paragraph
  vmap ,P   <esc>`<O<p><ESC>`>o</p><ESC>
"
" ===================================================================
" HTML - changing the appearance/font of text
" ===================================================================
"
" BlockQuoted Text:
  iab  Ybl  <blockquote></blockquote><ESC>T>i
" vmap ,bl  "zdi<blockquote><C-R>z</blockquote><ESC>2F>
"
" Bold text:
  iab  Yb   <b></b><ESC>T>i
  vmap ,b   "zdi<b><C-R>z</b><ESC>F>
  nmap ,b   viw,b
"
" Center Inline Text:
  iab  Ycenter <center></center><ESC>T>i
  iab  Ycen    <center></center><ESC>T>i
  vmap ,cen "zdi<center><C-M><C-R>z<C-M></center><ESC>?><CR>
"
" Center Text Blocks:
  iab  YCen <center><CR></center><ESC>O
  vmap ,Cen <ESC>'<O<center><ESC>'>o</center><ESC>
"
" Code in Text:
  iab  Ycod <code></code><ESC>T>i
  vmap ,cod "zdi<code><C-M><C-R>z<C-M></code><C-M><ESC>T>i
"
" div in Text:
  iab  Ych <div class="check"></div><ESC>T>i
  vmap ,ch "zdi<div class="check"><C-M><C-R>z<C-M></div><C-M><ESC>T>i
"
" Italic Text:
  iab  Yi   <i></i><ESC>T>i
  vmap ,i   "zdi<i><C-R>z</i><ESC>T>
  nmap ,i   viw,i
"
" Typewriter Type:
  iab  Ytt   <tt></tt><ESC>T>i
  vmap ,tt   "zdi<tt><C-R>z</tt><ESC>T>
  nmap ,tt   viw,tt
"
"
" emphasized:
  iab  Yem   <em></em><ESC>T>i
  vmap ,em   "zdi<em><C-R>z</em><ESC>T>
  nmap ,em   viw,em
"
" ===================================================================
" HTML - Preserving Text Structure
" ===================================================================
"
" Preserve Text Formatting *with*  interpretation of HTML:
  iab  Ypre <pre></pre><ESC>T>i
" vmap ,pre "zdi<pre><C-M><C-R>z</pre><C-M><ESC>T>
  vmap ,pre mz:<ESC>'<O<pre><ESC>'>o</pre><ESC>`z
"
" Preserve Text Formatting without interpretation of HTML:
"           Insert environment <xmp></xmp>
  iab  Yxmp <xmp></xmp><ESC>T>i
" vmap ,xmp "zdi<xmp><C-M><C-R>z<C-M></xmp><C-M><ESC>T>i
  vmap ,xmp mz:<ESC>'<O<xmp><ESC>'>o</xmp><ESC>`z
"
" ===================================================================
" HTML - Making Tables
" ===================================================================
"
" Table Environment
  iab  Ytable <table><cr></table>
" Table Header
  iab  Yth  <th></th><ESC>T>i
  vmap ,th  "zdi<th><C-R>z</th><ESC>T>
  nmap ,th  viw,th
" Table Data
  iab  Ytd  <td></td><ESC>T>i
  vmap ,td  "zdi<td><C-R>z</td><ESC>T>
  nmap ,td  viw,td
" Table Row
  iab  Ytr  <tr><CR></tr><ESC>T>i
  vmap ,tr  "zdi<tr><C-R>z</tr><ESC>T>i
"
"
" ===================================================================
" HTML - Making Header Lines (h1 to h6)
" ===================================================================
"
  iab  Yh1 <h1></h1><ESC>T>i
  vmap ,h1 "zdi<h1><C-R>z</h1><ESC>2F>
  iab  Yh2 <h2></h2><ESC>T>i
  vmap ,h2 "zdi<h2><C-R>z</h2><ESC>2F>
  iab  Yh3 <h3></h3><ESC>T>i
  vmap ,h3 "zdi<h3><C-R>z</h3><ESC>2F>
  iab  Yh4 <h4></h4><ESC>T>i
  vmap ,h4 "zdi<h4><C-R>z</h4><ESC>2F>
  iab  Yh5 <h5></h5><ESC>T>i
  vmap ,h5 "zdi<h5><C-R>z</h5><ESC>2F>
  iab  Yh6 <h6></h6><ESC>T>i
  vmap ,h6 "zdi<h6><C-R>z</h6><ESC>2F>
"
" ===================================================================
" HTML - Making Lists and List Items
" ===================================================================
"
"           Insert "ordered list" with one list element
  iab Yol <ol><CR><li><CR></ol><ESC>k
"           Insert "unordered list" with one list element
  iab Yul <ul><CR><li></li><CR></ul><ESC>k
  vmap ,ul di<ul><CR></ul><CR><ESC>kmaP>'a'a<< 
  vmap ,ol di<ol><CR></ol><CR><ESC>kmaP>'a'a<< 
"           Insert "decsription list" with one list element
" iab Ydl <dl><CR><dt><CR><dd><CR><p><CR></dl><CR><ESC>4kA
  iab Ydl <dl><CR><CR><dt><CR><dd><CR><p><CR><CR></dl><CR><ESC>5kA
"
" Insert "list" item (for both ordered and unordered list)
  iab Yli <li></li><ESC>T>i
  vmap ,li "zdi<li><C-R>z</li>
  nmap ,li viw,li
  nmap ,lli ^v$h,li
" Insert "description list" item
  iab Ydt <dt><CR><dd><CR><p><CR><ESC>kA
  iab Ydp <dt><CR><dd><C-M><p><C-M><ESC>kkkA
"
" ===================================================================
" HTML - Making Links
" ===================================================================
"
"
"     A HREF (HTML 2.0)
" insert "generic link"
  iab  Yhref <a href=""></a><ESC>?""<CR>a
  vmap ,href "zdi<a href="#"><C-R>z</a><ESC>F"i
  nmap ,href viw,href
  nmap ,HREF viw,href
  vmap ,HREF ,href
"
" make current URL a link:
  vmap ,link "zdi<a href="<C-R>z"<C-M><C-I>><C-R>z</a><ESC>F"i
"
" add link to current text:
  vmap ,text "zdi<a href=""><C-R>z</a><ESC>F"i
"
"     A NAME (HTML-2.0)
  iab  Yname <a name=""></a><ESC>?""<CR>a
  vmap ,name di<a name="<C-R>""><C-R>"</a><ESC>2T"
  nmap ,name viw,name

"
"            Insert/make link to image
  iab  Yimg  <img alt="[]"<C-M>   align=<C-M>     src=""></a><ESC>?""<CR>a
"
" 000811
"            Insert a link to an image with a thumbnail
  iab YIMG   <a  href="PIC"><cr><img alt=""<cr>   align=right<cr>     src=""><cr></a><cr>
"
"            Insert/make mailto link
  iab  Ymail <a href="mailto:"></a><ESC>?:<CR>a
  vmap ,mail "zdi<a href="mailto:<C-R>z"<C-M><C-I><C-I>><C-R>z</a><ESC>2F>
  vmap ,Mail "zdi<a href="mailto:<C-R>z"><C-R>z</a><ESC>2F>
"
"            Insert/make link to newsgroup
  iab  Ynews <a href="news:"></a><ESC>?:<CR>a
  vmap ,news "zdi<a href="news:<C-R>z"><C-R>z</a><ESC>2F>
"
"      Ypage Insert page description with a possible link and text
  iab  Ypage   <C-M>page:<C-I><C-M>link:<C-I><C-M>text:<C-I><ESC>kkA
"
"
" For adding descriptions and keywords to important pages:
" <META Name="description" Content="Write your description here">
" <META Name="keywords"    Content="Write your keywords here">
"
" Colorizing Text
"
"      ,Cblu = colorize the selection with color "blue"
  vmap ,Cblu "zdi<FONT COLOR="#0000FF"><C-R>z</FONT>
"      ,Cgre = colorize the selection with color "green"
  vmap ,Cgre "zdi<FONT COLOR="#00FF00"><C-R>z</FONT>
"      ,Cred = colorize the selection with color "red"
  vmap ,Cred "zdi<FONT COLOR="#FF0000"><C-R>z</FONT>
"
" ===================================================================
" HTML - handling special text
" ===================================================================
"
" HTML - inserting special characters
  imap ;& &amp;
  imap ;K &copy;
  imap ;" &quot;
  imap ;< &lt;
  imap ;> &gt;
"
" HTML - inserting umlauts  [981110]
  imap \Ae &Auml;
  imap \Oe &Ouml;
  imap \Ue &Uuml;
  imap \ae &auml;
  imap \oe &ouml;
  imap \ue &uuml;
  imap \ss &szlig;
"
" HTML - Converting umlauts to digraphs [960430]
"
" cnoremap ,ae %s/ae/<C-V>228/gc
" cnoremap ,ae %s/ae/\&auml;/gc
" cnoremap ,oe %s/oe/<C-V>246/gc
" cnoremap ,ue %s/ue/<C-V>252/gc
" cnoremap ,Ae %s/Ae/<C-V>196/gc
" cnoremap ,Oe %s/Oe/<C-V>124/gc
" cnoremap ,Ue %s/Ue/<C-V>220/gc
" cnoremap ,ss %s/ss/<C-V>223/gc
"
"       ,= = turn "===" into headline of size 1
  nmap  ,= :%s/^===\(.*\)$/<h1>\1<\/h1>/c<CR>
" Example:
" before:  === New section
" after:   <h1>New section</h1>
"
" ===================================================================
" HTML 3.0
" ===================================================================
" environments:
" ABBREV ACRONYM AU BANNER BIG BQ CAPTION CREDIT DEL DFN DIR DIV FN
" HTML INS NOTE OL P Q S SMALL SUB SUP TAB V
" other:
" FIG LANG OVERLAY RANGE SPOT STYLE
"
" ===================================================================
" HTML - Misc
" ===================================================================
"
" HTML - Add closing tags to name tag
" (which I forgot when I started HTML):
" map ,,,, :g/^<a name="[a-z_]*">$/s/$/<\/a>/
" Example:
" before:  <a name="close_tag">
" after:   <a name="close_tag"></a>
"
" Insert/make reference link to overview list (short"cut")
  iab  Ycut  \| <a href="#"<C-I>></a><ESC>F#a
  vmap ,cut  "zdi<a href="#<C-R>z"<C-I>><C-R>z</a><ESC>2F>
"
" end of file vim: tw=999
