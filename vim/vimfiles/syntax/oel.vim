" Vim syntax file
" Language:	OEL
" Maintainer:	Bernd Franke <frankbrn@ina.de>
" Last change:	1998 Sep 1

" Please check :help oel.vim for comments on some of the options available.

" Remove any old syntax stuff hanging around
syn clear

" some characters that cannot be in a oel program (outside a string)
syn match oelError "<<<\|\.\.\|=>\|<>\|||=\|&&=\|->"

" keyword definitions
syn keyword oelExternal        	Require 
syn keyword oelError            const
syn keyword oelError            byvalue operator
syn keyword oelBranch           break continue
syn keyword oelLabel            let global
syn keyword oelConditional      if else switch when unless
syn keyword oelRepeat           while for do foreach
syn keyword oelBoolean          Yes No
syn keyword oelConstant         Nil
syn keyword oelTypedef          self Super
syn keyword oelOperator         IsA IsSubclass
syn keyword oelType             CString Integer Real Number Symbol Dictionary Set Object Boolean List
syn keyword oelType             Sequence
syn keyword oelStatement        return
syn keyword oelStorageClass     static dynamic synchronized
syn keyword oelExceptions       throw try catch
syn keyword oelMethodDecl       class method function constructor
syn keyword oelClassDecl        abstract extends implements interface
" to differentiate the keyword  class from MyClass.class we use a match here
" syn match   oelClassDecl        "^class\>"
" syn match   oelClassDecl        "[^.]\<class\>"ms=s+1
syn keyword oelScopeDecl        public protected private

" Comments
syn match  oelCommentSkip	contained "^\s*\*\($\|\s\+\)"
syn region oelCommentString	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
syn region oelComment2String	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
syn region oelComment	start="/\*" end="\*/" contains=cTodo,cCommentString,cCharacter,cNumber,cFloat,cSpaceError
syn match  oelComment	"//.*" contains=cTodo,cComment2String,cCharacter,cNumber,cSpaceError
syn region oelCommentString    contained start=+"+  skip=+\\\\\|\\"+  end=+"+ end=+\*/+me=s-1,he=s-1 contains=oelSpecial,oelCommentStar
syn region  oelComment2String   contained start=+"+  skip=+\\\\\|\\"+  end=+$\|"+  contains=oelSpecial
syn region  oelComment          start="/\*"  end="\*/" contains=oelCommentString,oelCharacter,oelNumber
syn match   oelCommentStar contained "^\s*\*[^/]"me=e-1
syn match   oelCommentStar contained "^\s*\*$"
hi link oelCommentString oelString
hi link oelComment2String oelString
syn match   oelLineComment      "//.*" contains=oelComment2String,oelCharacter,oelNumber
syn match   oelLineDescription  "\".*$" contains=oelComment2String,oelCharacter,oelNumber

if !exists("oel_ignore_oeldoc")
  syn region  oelComment       start="/\*\*"  end="\*/" contains=oelCommentTitle,oelHtmlError,oelHtmlTag,oelHtmlEndTag,oelHtmlSpecialChar,oelHtmlComment,oelDocTags
  syn region  oelCommentTitle  contained matchgroup=oelComment start="/\*\*"   matchgroup=oelCommentTitle end="\.$" end="\.[ \t\r<&]"me=e-1 end="@"me=s-1,he=s-1 end="\*/"me=s-1,he=s-1 contains=oelHtmlError,oelHtmlTag,oelHtmlEndTag,oelHtmlSpecialChar,oelHtmlComment,oelCommentStar

  " syntax coloring for oeldoc comments (HTML)
  syntax case ignore

  syn match oelDocTags contained "comment \(DESCRIPTION\|VERSION\|CATEGORY\|AUTHOR\)"

  syn match oelHtmlError contained "[<>&]"

  " tags
  syn match   oelHtmlSpecial  contained "\\[0-9][0-9][0-9]\|\\."
  syn region  oelHtmlString   contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=oelHtmlSpecial,oelScriptExpression
  syn region  oelHtmlString   contained start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=oelHtmlSpecial,oelScriptExpression
  syn match   oelHtmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1   contains=oelScriptExpression
  syn region  oelHtmlEndTag   contained start=+</+    end=+>+              contains=oelHtmlTagName,oelHtmlTagError
  syn region  oelHtmlTag      contained start=+<[a-zA-Z]+ end=+>+ end=+\*/+me=s-1,he=s-1 contains=oelHtmlString,oelHtmlTagName,oelHtmlArg,oelHtmlValue,oelHtmlTagError,oelHtmlEvent
  syn match   oelHtmlTagError contained "[^>]<"ms=s+1

  " tag names
  syn keyword oelHtmlTagName contained address applet area a base basefont
  syn keyword oelHtmlTagName contained big blockquote body br b caption center
  syn keyword oelHtmlTagName contained cite code dd dfn dir div dl dt em font
  syn keyword oelHtmlTagName contained form h1 h2 h3 h4 h5 h6 head hr html img
  syn keyword oelHtmlTagName contained input isindex i kbd link li link map menu
  syn keyword oelHtmlTagName contained meta ol option param pre p samp
  syn keyword oelHtmlTagName contained select small strike strong style sub sup
  syn keyword oelHtmlTagName contained table td textarea th title tr tt ul u var

  " legal arg names
  syn keyword oelHtmlArg contained action
  syn keyword oelHtmlArg contained align alink alt archive background bgcolor
  syn keyword oelHtmlArg contained border bordercolor cellpadding
  syn keyword oelHtmlArg contained cellspacing checked clear code codebase color
  syn keyword oelHtmlArg contained cols colspan content coords enctype face
  syn keyword oelHtmlArg contained gutter height href hspace
  syn keyword oelHtmlArg contained link lowsrc marginheight
  syn keyword oelHtmlArg contained marginwidth maxlength method name prompt
  syn keyword oelHtmlArg contained rel rev rows rowspan scrolling selected shape
  syn keyword oelHtmlArg contained size src start target text type url
  syn keyword oelHtmlArg contained usemap ismap valign value vlink vspace width wrap
  syn match oelHtmlArg contained "http-equiv"
  " Netscape extensions
  syn keyword oelHtmlTagName contained frame frameset nobr span
  syn keyword oelHtmlTagName contained layer ilayer nolayer spacer
  syn keyword oelHtmlArg     contained frameborder noresize pagex pagey above below
  syn keyword oelHtmlArg     contained left top visibility clip id noshade
  syn match   oelHtmlArg     contained "z-index"

  " special characters
  syn match oelHtmlSpecialChar contained "&[^;]*;"

  " The real html comments (this implements the comments as defined by html,
  " but not all html pages actually conform to it. Errors are flagged.
  syn region oelHtmlComment      contained          start=+<!+        end=+>+ contains=oelHtmlCommentPart,oelHtmlCommentError
  syn region oelHtmlComment      contained          start=+<!DOCTYPE+ end=+>+
  syn match  oelHtmlCommentError contained "[^><!]"
  syn region oelHtmlCommentPart  contained start=+--+        end=+--+

  syntax case match
endif

" match the special comment /**/
syn match   oelComment          "/\*\*/"

" Strings and constants
syn match   oelSpecialError     contained "\\."
syn match   oelSpecialCharError contained "[^']"
syn match   oelSpecialChar      contained "\\\([0-9]\{1,2\}\|[0-3][0-9][0-9]\|[\"\\'ntbrf]\|u[0-9a-fA-F]\{4\}\)"
syn region  oelString           start=+"+  skip=+\\\\\|\\"+  end=+"+ end=+$+  contains=oelSpecialChar,oelSpecialError
syn match   oelCharacter        "'[^']*'" contains=oelSpecialChar,oelSpecialCharError
syn match   oelCharacter        "'\\''" contains=oelSpecialChar
syn match   oelCharacter        "'[^\\]'"
syn match   oelNumber           "-\=\<[0-9]\+L\=\>\|0[xX][0-9a-fA-F]\+\>"

" unicode characters
syn match   oelSpecial "\\u[0-9]\{4\}"

" catch errors caused by wrong parenthesis
syn region  oelParen            transparent start="(" end=")" contains=ALLBUT,oelCommentStar,oelSpecial,oelParenError,oelDebugString,oelDebugNumber,oelDebugType,oelDebug,oelDebugBoolean,oelDebugSpecial,oelDebugSpecialCharacter,oelDebugCharacter,oelSpecialError,oelSpecialCharError,oelHtml.*
syn match   oelParenError       ")"
hi link     oelParenError       oelError

if exists("oel_highlight_functions")
  " WARNING: the following definitions work only if you use one tab or two spaces
  " to indent function. If you use something different, change the leading
  " white space in all definitions.
  syn match  oelFuncDef "^\t[a-zA-Z][a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=oelScopeDecl,oelType,oelStorageClass
  syn region oelFuncDef start=+^\t[a-zA-Z][a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=oelScopeDecl,oelType,oelStorageClass
  syn match  oelFuncDef "^  [a-zA-Z][a-zA-Z0-9_. \[\]]*([^-+*/()]*)" contains=oelScopeDecl,oelType,oelStorageClass
  syn region oelFuncDef start=+^  [a-zA-Z][a-zA-Z0-9_. \[\]]*([^-+*/()]*,\s*+ end=+)+ contains=oelScopeDecl,oelType,oelStorageClass
  syn match  oelBraces  "[{}]"
endif

if exists("oel_mark_braces_in_parens_as_errors")
  syn match oelInParen          contained "[{}]"
  hi link   oelInParen          oelError
endif

if exists("oel_highlight_debug")
  " to make this work you must define the highlighting for these groups
  syn region oelDebug start="System\.\(out\|err\)\.print\(ln\)*\s*" end=";" contains=oelDebug.*
  syn region oelDebug  start="trace[ \t]*(" end=";" contains=oelDebug.*

  " Strings and constants
  syn match   oelDebugSpecial          contained "\\[0-9][0-9][0-9]\|\\."
  syn region  oelDebugString           contained start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=oelDebugSpecial
  syn match   oelDebugCharacter        contained "'[^\\]'"
  syn match   oelDebugSpecialCharacter contained "'\\.'"
  syn match   oelDebugSpecialCharacter contained "'\\''"
  syn match   oelDebugNumber           contained "-\=\<[0-9]\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
  syn keyword oelDebugBoolean          contained Yes Nil
  syn keyword oelDebugType             contained Nil self Super

  hi link oelDebug    Debug
  hi link oelDebugString DebugString
  hi link oelDebugType DebugType
  hi link oelDebugBoolean DebugBoolean
  hi link oelDebugNumber Debug
  hi link oelDebugSpecial DebugSpecial
  hi link oelDebugSpecialCharacter DebugSpecial
  hi link oelDebugCharacter DebugString

  hi link DebugString String
  hi link DebugSpecial Special
  hi link DebugBoolean Boolean
  hi link DebugType Type
endif

if !exists("oel_minlines")
  let oel_minlines = 10
endif
exec "syn sync ccomment oelComment minlines=" . oel_minlines

if !exists("did_oel_syntax_inits")
  let did_oel_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link oelFuncDef                       Function
  hi link oelBraces                        Function
  hi link oelBranch                        Conditional
  hi link oelLabel                         Label
  hi link oelConditional                   Conditional
  hi link oelRepeat                        Repeat
  hi link oelExceptions                    Exception
  hi link oelStorageClass                  StorageClass
  hi link oelMethodDecl                    oelStorageClass
  hi link oelClassDecl                     oelStorageClass
  hi link oelScopeDecl                     oelStorageClass
  hi link oelBoolean                       Boolean
  hi link oelSpecial                       Special
  hi link oelSpecialError                  Error
  hi link oelSpecialCharError              Error
  hi link oelString                        String
  hi link oelCharacter                     Character
  hi link oelSpecialChar		           SpecialChar
  hi link oelNumber                        oelValue
  hi link oelError                         Error
  hi link oelStatement                     Statement
  hi link oelOperator                      Operator
  hi link oelComment                       Comment
  hi link oelLineDescription               Comment
  hi link oelLineComment                   Comment
  hi link oelConstant			           Constant
  hi link oelTypedef			           Typedef

  hi link oelCommentTitle                  SpecialComment
  hi link oelDocTags			           Special
  hi link oelCommentStar                   oelComment

  hi link oelType                          Type
  hi link oelValue                         Number
  hi link oelExternal                      Include

  hi link oelHtmlTag                       Function
  hi link oelHtmlEndTag                    Identifier
  hi link oelHtmlArg                       Type
  hi link oelHtmlTagName                   oelHtmlStatement
  hi link oelHtmlSpecialChar               SpecialChar
  hi link oelHtmlSpecial                   Special
  hi link oelHtmlString                    String
  hi link oelHtmlStatement                 Statement
  hi link oelHtmlComment                   Special
  hi link oelHtmlCommentPart               Special
  hi link oelHtmlPreProc                   PreProc
  hi link oelHtmlValue                     String
  hi link oelHtmlCommentError              oelHtmlError
  hi link oelHtmlTagError                  oelHtmlError
  hi link oelHtmlEvent                     oelScript
  hi link oelHtmlError			    Error
endif

let b:current_syntax = "oel"

" vim: ts=4
