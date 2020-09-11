# Editing Snippets for UltiSnips

<!-- TOC MARKED -->

* [Include Other Snippet Files](#include-other-snippet-files)
* [Keywords](#keywords)
* [Snippets' Format](#snippets-format)
* [Snippet Options](#snippet-options)
* [Character Escaping](#character-escaping)
* [Plaintext Snippets](#plaintext-snippets)
* [Tabstop and Placeholders](#tabstop-and-placeholders)
* [Visual Placeholder](#visual-placeholder)
* [Mirrors](#mirrors)
* [Interpolation](#interpolation)
  - [Shellcode](#shellcode)
  - [Vimscript](#vimscript)
  - [Python](#python)
* [Global Snippets](#global-snippets)
* [Transformations](#transformations)
  - [Regular Expression](#regular-expression)
  - [Replacement](#replacement)
  - [Options](#options)
* [Clear(Disable) Snippets](#cleardisable-snippets)
* [Context](#context)
* [Snippet Actions](#snippet-actions)
  - [Pre-expand and Post-expand Actions](#pre-expand-and-post-expand-actions)
  - [Post-jump Actions](#post-jump-actions)

<!-- /TOC -->


## Include Other Snippet Files

Add c snippets for cpp files for example.

1. `UltiSnipsAddFiletypes`
    ```vim
    au FileType cpp UltiSnipsAddFiletypes cpp.c
    ```
2. `extends`: For example, in 'cpp.snippets', add:
    ```
    extends c
    ```


## Keywords

1. `extends`: See above.
2. `priority`: Set priority for all snippet defined in the current file.
3. `snippets` `endsnippet`: Define a snippet.
4. `global` `endglobal`: Define a [global snippet](#global-snippets)(only supports python currently).
5. `pre_expand` `post_expand` `post_jump`: Declare snippet actions.


## Snippets' Format


    snippet trigger_word [ "description" [ options ] ]

- `trigger_word`: The word to trigger the snippet. It can include spaces via wrap it in quotes or any other characters.
  ```
  snippet "tab trigger" [ "description" [ options ] ]
  snippet ltab triggerl [ "description" [ options ] ]
  ```
  Quotes can be included as part of the trigger by wrapping the trigger in
another character.
  ```
  snippet !"tab trigger"! [ "description" [ options ] ]
  ```
- `description`: A string describing the trigger.
- `options`: See below.

## Snippet Options

- `b`: Beginning of line - A snippet with this option is expanded only if the tab trigger is the first word on the line. In other words, if only whitespace precedes the tab trigger, expand. The default is to expand snippets at any position regardless of the preceding non-whitespace characters.

- `i`: In-word expansion - By default a snippet is expanded only if the tab trigger is the first word on the line or is preceded by one or more whitespace characters. A snippet with this option is expanded regardless of the preceding character. In other words, the snippet can be triggered in the middle of a word.

- `w`: Word boundary - With this option, the snippet is expanded if the tab trigger start matches a word boundary and the tab trigger end matches a word boundary. In other words the tab trigger must be preceded and followed by non-word characters. Word characters are defined by the 'iskeyword' setting. Use this option, for example, to permit expansion where the tab trigger follows punctuation without expanding suffixes of larger words.

- `r`: Regular expression - With this option, the tab trigger is expected to be a python regular expression. The snippet is expanded if the recently typed characters match the regular expression. Note: The regular expression MUST be quoted (or surrounded with another character) like a multi-word tab trigger (see above) whether it has spaces or not. A resulting match is passed to any python code blocks in the snippet definition as the local variable "match".

- `t`: Do not expand tabs - If a snippet definition includes leading tab characters, by default UltiSnips expands the tab characters honoring the Vim 'shiftwidth', 'softtabstop', 'expandtab' and 'tabstop' indentation settings. (For example, if 'expandtab' is set, the tab is replaced with spaces.) If this option is set, UltiSnips will ignore the Vim settings and insert the tab characters as is. This option is useful for snippets involved with tab delimited formats.

- `s`: Remove whitespace immediately before the cursor at the end of a line before jumping to the next tabstop.  This is useful if there is a tabstop with optional text at the end of a line.

- `m`: Trim all whitespaces from right side of snippet lines. Useful when snippet contains empty lines which should remain empty after expanding. Without this option empty lines in snippets definition will have indentation too.

- `e`: Custom context snippet - With this option expansion of snippet can be controlled not only by previous characters in line, but by any given python expression. This option can be specified along with other options, like 'b'. See UltiSnips-custom-context-snippets for more info.

- `A`: Snippet will be triggered automatically, when condition matches. See UltiSnips-autotrigger for more info.


## Character Escaping

>In snippet definitions, the characters '`', '{', '$' and '\' have special
>meaning. If you want to insert one of these characters literally, escape them
>with a backslash, '\'.


## Plaintext Snippets

For example:
```
snippet bye "My mail signature"
Good bye, Sir. Hope to talk to you soon.
- Arthur, King of Britain
endsnippet
```


## Tabstop and Placeholders

A simplest tabstop looks like `$no`, `no` is a number starting from 1. `$0` is a special tabstop that is always the last tabstop no matter how many tabstops are defined.

    snippet letter
    Dear $1,
    $0
    Yours sincerely,
    $2
    endsnippet

Default text:

    snippet case
    case ${1:word} in
        ${2:pattern} ) $0;;
    esac
    endsnippet

Have a tabstop within another tabstop:

    snippet a
    <a href="${1:http://www.${2:example.com}}"
        $0
    </a>
    endsnippet

> Typing any text at the first tabstop replaces the default
> value, including the second tabstop, with the typed text. So the second
> tabstop is essentially deleted.


## Visual Placeholder

Format:
```
${VISUAL:default/search/replace/option}
```
Usage:
1. Select some text in visual mode and press the trigger key, the text well be deleted.
2. Enter the `trigger_word` and press the trigger key again, the text deleted will replace the `${VISUAL}` placeholder.

Details:
1. Snippets containing Visual Placeholder can be used in insert mod. In the way, the `default` will be used as default text.
2. With `/search/replace/option`, you can process the text like using `:s` command. See [Transformations](#transformations).


## Mirrors

Mirrors repeat the content of a tabstop.To mirror a tabstop simply insert the tabstop again using the "dollar sign followed by a number" syntax, e.g., `\$1`.

    snippet ifndef
    #ifndef ${1:SOME_DEFINE}
    #define $1
    $0
    #endif /* $1 */
    endsnippet


## Interpolation


### Shellcode

An example may be the most helpful.
```
snippet today
Today is the `date +%d.%m.%y`.
endsnippet
```
The output of command `date +%d.%m%y` will replace the text wrapped by backticks. You'll get something like "Today is the 19.08.20."


### Vimscript

Similar to shellcode, but begins with \`v.
```
snippet indent
Indent is: `!v indent(".")`.
endsnippet
```
```
(note the 4 spaces in front): indent<trigger_key> ->
(note the 4 spaces in front): Indent is: 4.
```


### Python

There are two choices:
1. **\`#!/usr/bin/python ...\`**: Normal python code.
2. **\`!p ...\`**: Use python with some predefined objects and variables. The variables automatically defined in python code are:


| variable | description                                                                                                                                                                        |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| fn       | The current filename                                                                                                                                                               |
| path     | The complete path to the current file                                                                                                                                              |
| t        | The values of the placeholders, t\[1\] is the text of `${1},` etc.                                                                                                                  |
| snip     | UltiSnips.TextObjects.SnippetUtil object instance. Has methods that simplify indentation handling and owns the string that should be inserted for the snippet.                   |
| context  | Result of context condition. See UltiSnips-custom-context-snippets.                                                                                                                |
| match    | Only in regular expression triggered snippets.<br> This is the return value of the match of the regular expression.<br> See http://docs.python.org/library/re.html#match-objects |

**`snip` object**

The 'snip' object provides the following methods:

- `snip.mkline(line="", indent=None)`:
        Returns a line ready to be appended to the result. If indent
        is None, then mkline prepends spaces and/or tabs appropriate to the
        current 'tabstop' and 'expandtab' variables.
- `snip.shift(amount=1)`:
        Shifts the default indentation level used by mkline right by the
        number of spaces defined by 'shiftwidth', 'amount' times.
- `snip.unshift(amount=1)`:
        Shifts the default indentation level used by mkline left by the
        number of spaces defined by 'shiftwidth', 'amount' times.
- `snip.reset_indent()`:
        Resets the indentation level to its initial value.
- `snip.opt(var, default)`:
        Checks if the Vim variable 'var' has been set. If so, it returns the
        variable's value; otherwise, it returns the value of 'default'.

The 'snip' object provides some properties as well:

- `snip.rv`:
        'rv' is the return value, the text that will replace the python block
        in the snippet definition. It is initialized to the empty string. This
        deprecates the 'res' variable.

- `snip.c`:
        The text currently in the python block's position within the snippet.
        It is set to empty string as soon as interpolation is completed. Thus
        you can check `if snip.c is != ""` to make sure that the interpolation
        is only done once. This deprecates the "cur" variable.

- `snip.v`:
         Data related to the `${VISUAL}` placeholder. This has two attributes:
             snip.v.mode   ('v', 'V', '^V', see |visual-mode| )
             snip.v.text   The text that was selected.

- `snip.fn`:
        The current filename.

- `snip.basename`:
        The current filename with the extension removed.

- `snip.ft`:
        The current filetype.

- `snip.p`:
        Last selected placeholder. Will contain placeholder object with
        following properties:
  - '`current_text`' - text in the placeholder on the moment of selection;
  - '`start`' - placeholder start on the moment of selection;
  - '`end`' - placeholder end on the moment of selection;

For your convenience, the 'snip' object also provides the following
operators:

- `snip >> amount`:
        Equivalent to `snip.shift(amount)`
- `snip << amount`:
        Equivalent to `snip.unshift(amount)`
- `snip += line`:
        Equivalent to "`snip.rv += '\n' + snip.mkline(line)`"

>Any variables defined in a python block can be used in other python blocks
>that follow within the same snippet. Also, the python modules 'vim', 're',
>'os', 'string' and 'random' are pre-imported within the scope of snippet code.
>Other modules can be imported using the python 'import' command.

>Python code allows for very flexible snippets. For example, the following
>snippet mirrors the first tabstop value on the same line but right aligned and
>in uppercase.


## Global Snippets

Use `global` and `endglobal` to define Global snippets.

You can define functions or use import command inside.
```
global !p
def upper_right(inp):
    return (75 - 2 * len(inp))*' ' + inp.upper()
endglobal
```
```
global !p
from my_snippet_helpers import *
endglobal
```


## Transformations

> Transformations are like mirrors but instead of just copying text from the
> original tabstop verbatim, a regular expression is matched to the content of
> the referenced tabstop and a transformation is then applied to the matched
> pattern.

    ${<tab_stop_no/regular_expression/replacement/options}

The <font color='green'>components</font> are defined as follows:

- `tab_stop_no`: The number of the tabstop to reference
- `regular_expression`: The regular expression the value of the referenced tabstop is matched on
- `replacement`: The replacement string, explained in detail below
- `options`: Options for the regular expression


### Regular Expression

See http://docs.python.org/library/re.html.


### Replacement

The <font color='green'>**replacement string**</font> can contain `$no` variables, e.g., `$1,` which reference matched groups in the regular expression. The `$0` variable is special and yields the whole match. The replacement string can also contain special escape sequences:

- `\u`: Uppercase next letter
- `\l`: Lowercase next letter
- `\U`: Uppercase everything till the next \E
- `\L`: Lowercase everything till the next \E
- `\E`: End upper or lowercase started with \L or \U
- `\n`: A newline
- `\t`: A literal tab

Finally, the **replacement string** can contain conditional replacements using the syntax (**?no:text:other text**). This reads as follows: if the group `$no` has
matched, insert "text", otherwise insert "other text". "other text" is
optional and if not provided defaults to the empty string, "". This feature
is very powerful. It allows you to add optional text into snippets.


### Options

The <font color='green'>**options**</font> can be any combination of

- `g`: **global replace**

  By default, only the first match of the regular expression is
  replaced. With this option all matches are replaced.

- `i`: **case insensitive**

  By default, regular expression matching is case sensitive. With this
  option, matching is done without regard to case.

- `m`: **multiline**

  By default, the '\^' and '\$' special characters only apply to the
  start and end of the entire string; so if you select multiple lines,
  transformations are made on them entirely as a whole single line
  string. With this option, '^' and '\$' special characters match the
  start or end of any line within a string ( separated by newline
  character - '\n' ).

- `a`: **ascii conversion**

  By default, transformation are made on the raw utf-8 string. With
  this option, matching is done on the corresponding ASCII string
  instead, for example 'à' will become 'a'.
  This option required the python package 'unidecode'.


## Clear(Disable) Snippets

Add `clearsnippets` to snippet files to disable some specified snippets.

1. Disable by priority.
    ```
    priority 6
    clearsnippets
    ```
    Disable all snippets have priority not bigger than 6.

2. Disable by trigger.
    ```
    clearsnippets printf title box
    ```
    Disable snippets whose trigger word is `printf`, `title` or `box`. To do this, the priority of `clearsnippets` must not be smaller than other snippets'.


## Context

Custom context snippets can be enabled by using the 'e' option in the snippet
definition.

In that case snippet should be defined using this syntax:

    snippet trigger_word "description" "expression" options

The context can be defined using a special header:

    context "python_expression"
    snippet trigger_word "description" options

The 'expression' can be any python expression. If 'expression' evaluates to
'True', then this snippet will be eligible for expansion. The 'expression'
must be wrapped with **double-quotes**.

The following **python modules** are automatically imported into the scope before
'expression' is evaluated: **'re', 'os', 'vim', 'string', 'random'**.

Global variable `snip` will be available with following properties:
- `snip.window`: alias for `vim.current.window`
- `snip.buffer`: alias for `vim.current.window.buffer`

    > Note: special variable called 'snip.buffer' should be used for all buffer
    > modifications. Not 'vim.current.buffer' and not 'vim.command("...")', because
    > in that case UltiSnips will not be able to track changes to the buffer correctly.
    >
    > 'snip.buffer' has the same interface as 'vim.current.window.buffer'.

- `snip.cursor`: cursor object, which behaves like `vim.current.window.cursor`, but zero-indexed and with following additional methods:
    - `preserve()`: special method for executing pre/post/jump actions;
    - `set(line, column)`: sets cursor to specified line and column;
    - `to_vim_cursor()`: returns 1-indexed cursor, suitable for assigning to `vim.current.window.cursor`;
- `snip.contex`: evaluated value of the expression in **context**;
- `snip.line` and `snip.column`: aliases for cursor position (zero-indexed);
- `snip.visual_mode`: ('v', 'V', '^V', see visual-mode);
- `snip.visual_text`: last visually-selected text;
- `snip.last_placeholder`: last active placeholder from previous snippet with following properties:
    - `current_text`: text in the placeholder on the moment of selection;
    - `start`: placeholder start on the moment of selection;
    - `end`: placeholder end on the moment of selection;

```
snippet i "if err != nil" "re.match('^\s+[^=]*err\s*:?=', snip.buffer[snip.line-1])" be
if err != nil {
    $1
}
endsnippet
```

```
global !p
import my_utils
endglobal

snippet , "return ..., nil/err" "my_utils.is_return_argument(snip)" ie
, `!p if my_utils.is_in_err_condition():
    snip.rv = "err"
else:
    snip.rv = "nil"`
endsnippet
```


## Snippet Actions

* Pre-expand: invoked just after trigger condition was matched, but before snippet actually expanded;
* Post-expand: invoked after snippet was expanded and interpolations were applied for the first time, but before jump on the first placeholder.
* Jump: invoked just after a jump to the next/prev placeholder.

> Specified code will be evaluated at stages defined above and same global
> variables and modules will be available that are stated in
> the UltiSnips-custom-context-snippets section.

`snip.visual_content` will be also declared and will contain text that was selected before snippet expansion (similar to `$VISUAL` placeholder).

    pre_expand "snip.buffer[snip.line] = ''; snip.cursor.set(snip.line, len(snip.visual_content))"
    snippet "nothing done here"
    ${VISUAL}
    endsnippet


### Pre-expand and Post-expand Actions

Buffer can be modified in pre-expand action code through variable called
'snip.buffer', snippet expansion position will be automatically adjusted.

    pre_expand "snip.buffer[snip.line] = ' '*4; snip.cursor.set(snip.line, 4)"
    snippet d
    def $1():
        $0
    endsnippet

    post_expand "snip.buffer[snip.snippet_end[0]+1:snip.snippet_end[0]+1] = ['']"
    snippet d "Description" b
    def $1():
        $2
    endsnippet


### Post-jump Actions

Post-jump actions can be used to trigger some code based on user input into the placeholders.

Notable use **cases**:

- Expand another snippet after jump or anonymous snippet after last jump (e.g. perform move method refactoring and
then insert new method invokation);
- Insert heading into TOC after last jump.

**Variables** and **methods** below will be also defined in the action code scope:

* `snip.tabstop`: zero-indexed number of tabstop jumped onto;
    + `start`: (line, column) of the starting position of the tabstop (also accessible as `tabstop.line` and `tabstop.col`).
    + `end`: (line, column) of the ending position;
    + `current_text`: text inside the tabstop.
* `snip.jump_direction`: `1` if jumped forward and `-1` otherwise;
* `snip.tabstops`: list with tabstop objects, see above;
* `snip.snippet_start`: (line, column) of start of the expanded snippet;
* `snip.snippet_end`: (line, column) of end of the expanded snippet;
* `snip.expand_anon()`: alias for `UltiSnips_Manager.expand_anon()`;

> Also note that you should use `snip.buffer`, rather than than any other way, to edit buffer content.

Following snippet will insert section in the Table of Contents in the vim-help file:

```
post_jump "if snip.tabstop == 0: insert_toc_item(snip.tabstops[1], snip.buffer)"
snippet s "section" b
`!p insert_delimiter_0(snip, t)`$1`!p insert_section_title(snip, t)`
`!p insert_delimiter_1(snip, t)`
$0
endsnippet
```

> The functions called in this snippet are not defined by Ultisnips.

Following example will insert method call at the end of file after user jump out of method declaration snippet.

```
global !p
def insert_method_call(name):
	vim.command('normal G')
	snip.expand_anon(name + '($1)\n')
endglobal

post_jump "if snip.tabstop == 0: insert_method_call(snip.tabstops[1].current_text)"
snippet d "method declaration" b
def $1():
	$2
endsnippet
```
