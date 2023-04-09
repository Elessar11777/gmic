#@gmic
#
#  File        : gmic_stdlib.gmic
#                ( G'MIC command file )
#
#  Description : GREYC's Magic for Image Computing - Standard library
#                ( https://gmic.eu )
#
#  Copyright   : David Tschumperlé
#                ( https://tschumperle.users.greyc.fr/ )
#
#  Licenses    : This file is 'dual-licensed', you have to choose one
#                of the two licenses below to apply.
#
#                CeCILL-C
#                The CeCILL-C license is close to the GNU LGPL.
#                ( http://cecill.info/licences/Licence_CeCILL-C_V1-en.html )
#
#            or  CeCILL v2.1
#                The CeCILL license is compatible with the GNU GPL.
#                ( http://cecill.info/licences/Licence_CeCILL_V2.1-en.html )
#
#  This software is governed either by the CeCILL or the CeCILL-C license
#  under French law and abiding by the rules of distribution of free software.
#  You can  use, modify and or redistribute the software under the terms of
#  the CeCILL or CeCILL-C licenses as circulated by CEA, CNRS and INRIA
#  at the following URL: "http://cecill.info".
#
#  As a counterpart to the access to the source code and  rights to copy,
#  modify and redistribute granted by the license, users are provided only
#  with a limited warranty  and the software's author,  the holder of the
#  economic rights,  and the successive licensors  have only  limited
#  liability.
#
#  In this respect, the user's attention is drawn to the risks associated
#  with loading,  using,  modifying and/or developing or reproducing the
#  software by the user in light of its specific status of free software,
#  that may mean  that it is complicated to manipulate,  and  that  also
#  therefore means  that it is reserved for developers  and  experienced
#  professionals having in-depth computer knowledge. Users are therefore
#  encouraged to load and test the software's suitability as regards their
#  requirements in conditions enabling the security of their systems and/or
#  data to be ensured and,  more generally, to use and operate it in the
#  same conditions as regards security.
#
#  The fact that you are presently reading this means that you have had
#  knowledge of the CeCILL and CeCILL-C licenses and that you accept its terms.
#

#------ Syntax rules for a G'MIC command file :#

#*** General syntax :
#
# - Each line starting with 'command_name :' starts a new definition of the G'MIC custom command 'command_name'.
# - Each line starting with '#' is a comment line.
# - Any other line is considered as the continuation of a previously started G'MIC custom command.
#
#*** Specific rules for the command-line interface 'gmic':
#
# - A comment line starting with '#@cli' will be parsed by 'gmic' to print help for
#    G'MIC custom commands (when invoked with option 'h'). More precisely :
#
#      _ '#@cli :: subsection' defines a new command subsection in the displayed help.
#      _ '#@cli command_name : arguments_format1 : arguments_format2 : ... : (qualifier)'
#        starts a new command description.
#      _ '#@cli : description' add a new description line to the current command description.
#      _ '#@cli : $ command_line' defines a new example of use of the current command.
#      _ '#@cli : $$ _pagename' tells the command has a dedicated page in the web tutorial.
#
#*** Specific rules for the universal plug-in 'gmic-qt':
#
# - A comment line starting with '#@gui' will be parsed by the plug-in to define the filters tree.
# - A comment line starting with '#@gui_xx' will define a filter only for a specific language 'xx'
#    (e.g. 'en','fr'...).
# - A comment line starting with '#@gui_xx hide(/Filter or folder name)' will hide the existing
#    filter of folder for the locale 'xx'.
# - More precisely, the syntax of a '#@gui' comment line is :
#
#    '#@gui Folder name'
#
# or
#
#    '#@gui Command name : command, preview_command (zoom_factor)[*|+] [: default_input_mode]
#    '#@gui : parameter1 = typedef(arguments1...), parameter2 = typedef(arguments2...)'
#    '#@gui : parameter3 = typedef(arguments3...),
#
#   where :
#
#      'command' is the G'MIC command name called to process the image.
#
#      'preview_command' is the G'MIC command name called to process the preview.
#
#           Note that you can optionally specify a float-valued factor>=0 between parentheses at the end of
#           the 'preview_command' to force the default zoom factor used by the preview for this filter.
#           Use (0) for a 1:1 preview, (1) for previewing the whole image, (2) for 1/2 image and so on...
#           You can put an additional '+' sign after the parenthesis to specify the rendered preview
#           is still accurate for different zoom factors. Use '*' instead to tell the plug-in that the preview filter
#           must get the entire image rather than a thumbnail.
#
#
#      'default_input_mode' set the default input mode for that filter. It can be
#        { x=none | .=active (default) | *=all | +=active & below | -=active & above | v=all visible | i=all invisible }
#
#      'parameter = typedef' tells about the names, types and default values of the filter parameters.
#
#           'typedef' can be :
#
#      _ 'bool(default_value={ 0 | 1 | false | true })':
#          Add a boolean parameter (0 or 1) (as a checkbutton).
#
#      _ 'button(_alignment)':
#          Add a boolean parameter (0 or 1) (as a button).
#
#      _ 'choice(_default_index,Choice0,..,ChoiceN)':
#          Add a integer parameter (as a combobox).
#
#      _ 'color(R,_G,_B,_A)':
#          Add R,G,B[,A] parameters (as a colorchooser).
#
#      _ 'point(_X,_Y,_removable={ -1 | 0 | 1 },_burst={ 0 | 1 },_R,_G,_B,_[-]A,_radius[%])':
#          Add X,Y parameters (as a moveable point over the preview).
#
#      _ 'file[_in,_out](_default_filename)':
#          Add a filename parameter (as a filechooser).
#
#      _ 'float(default_value,min_value,max_value)':
#          Add a float-valued parameter (as a float slider).
#
#      _ 'folder(_default_foldername)':
#          Add a foldername parameter (as a folderchooser).
#
#      _ 'int(default_value,min_value,max_value)':
#          Add a integer parameter (as an integer slider).
#
#      _ 'link(_alignment,_label,URL)':
#          Display a URL (do not add a parameter).
#
#      _ 'note(_label)':
#          Display a label (do not add a parameter).
#
#      _ 'text(_is_multiline={ 0 | 1 },_default text)':
#          Add a single or multi-line text parameter (as a text entry).
#
#      _ 'separator()':
#          Display an horizontal separator (do not add a parameter).
#
#      _ 'value(value)':
#          Add a pre-defined value parameter (not displayed).
#
#   Type separators '()' can be replaced by '[]' or '{}' if necessary (for instance if parentheses are required in
#   an argument of the typedef, e.g in a text). You can also replace 'typedef' by '_typedef' to tell the plug-in not
#   being responsive, i.e not to update the image preview when the corresponding parameter is modified.
#   After the closing separator, you may specify a 'visibility state' character for the parameter, which can be
#   { _0=Hidden | _1=Grayed-out | _2=Visible (default) }, opt. followed by a propagation character that tells
#   if this visibility state must be propagated to neighboring non-valued interface widgets
#   (s.a. separator(), link() or note()).
#   This propagation character can be:
#   { '+'=propagate forward | '-'=propagate backward | '*'=propagate in both directions }.
#
#   Use '_none_' as a special command or preview_command to tell the plug-in that the entry requires no G'MIC call.
#
#   A G'MIC command can set new values for each filter parameter, through the status (see command ''status'').
#   To do so, the returned status must follow the syntax :
#   '{params1}{params2}{..}{paramsN}' where N must be exactly equal to the number of parameters
#   for the current filter. Optionally, you can append to each {param} its visibility state suffix ( e.g: {param}_1 ).
#
#   A G'MIC command can also specify the output blending mode, the opacity and the position of each of the output image
#   (i.e. layer in the plug-in). To do so, set the image name to something like:
#   'mode(grainmerge),opacity(50),pos(30,50),name(name)'.
#
#     - Blending mode name should be the same as the argument of the 'blend' command.
#     - Opacity is a float number in [0,100].
#     - X and Y positions are integers.
#     - 'name' is the layer name.
#
#   Pre-defined plug-in variables:
#
#   - _preview_width: Width of the preview image.
#   - _preview_height: Height of the preview image.
#   - _preview_area_width: Width of the preview widget area.
#   - _preview_area_height: Height of the preview widget area.
#   - _preview_x0: X-coordinate of the upper-left corner of the preview (expressed in the image space).
#   - _preview_y0: Y-coordinate of the upper-left corner of the preview (exressed in the image space).
#   - _preview_x1: X-coordinate of the lower-right corner of the preview (expressed in the image space).
#   - _preview_y1: Y-coordinate of the lower-right corner of the preview (expressed in the image space).
#   - _persistent : Variable that is shared between successive calls to the G'MIC interpreter, for a single filter.
#
#   Values of variables $_preview[x/y][0/1] vary only when preview mode is set to * (full preview).
#
#-----------------------------------------------------------------------------------------------------------------------

#---------------------------------
#
#@cli :: Global Options
#
#---------------------------------

# This command is run when the cli tool 'gmic' is invoked without arguments on the command line.
cli_noarg :
  v 0 use_vt100 g=$_vt100_g c=$_vt100_c n=$_vt100_n r=$_vt100_r _cli_noarg=1 version
  +e "\n[gmic] No commands, options or data provided."
  gmic_help="gmic help"
  if !${-is_macos}" && "!${-is_windows} gmic_help.=" | less" if $_vt100 gmic_help.=" -r" fi fi
  if {*,u}>0
    +e "[gmic] (type "${c}"'"$gmic_help"'"$n" to print help, "${c}"'gmic demos'"$n" to launch demos)."
  else
    +e "[gmic] (type "${c}"'"$gmic_help"'"$n" to print help)."
  fi
  file_update=${_path_rc}update$_version.gmic
  if "isfile(['"{/$file_update}"'])"
    update_old={"Y = date(0); M = date(1); D = date(2); date_current = Y*365 + M*31 + D;
                 Y = date(0,'"{/$file_update}"'); M = date(1,'"{/$file_update}"');
                 D = date(2,'"{/$file_update}"'); date_file = Y*365 + M*31 + D;
                 date_current - date_file"}
    if $update_old>=14
      +e "[gmic] Command update file is "$update_old" days old, type "$g"'gmic up'"$n" to update it."
    fi
  else
    +e "[gmic] Command update file not found, type "$g"'gmic up'"$n" to get it."
  fi
  +e "\n"

# cli_start
# This command is called each time the cli interface 'gmic' starts.
# Overload it in your local user command file if necessary.
cli_start :

#@cli debug : (+)
#@cli : Activate debug mode.
#@cli : When activated, the G'MIC interpreter becomes very verbose and outputs additional log
#@cli : messages about its internal state on the standard output (stdout).
#@cli : This option is useful for developers or to report possible bugs of the interpreter.

#@cli h : eq. to 'help'.
h :
  help $"*"

#@cli help : command : (no arg)
#@cli : Display help (optionally for specified command only) and exit.
#@cli : (eq. to 'h').
help : skip ${1=""}
  use_vt100
  if $!!=1" || w!=1 || d!=1 || s!=1" rm fi
  if ['$1']==0

    # Display global help.
    _no_examples,_no_default_values,_no_tutorial_link=1
    reference ascii

  else

    # Display help for a single command.
    if narg("$1")" && "isfile(['{/$_path_user}'])
      l[] { it[] $_path_user onfail }
    fi
    if narg("$1")" && "narg($_path_commands) l[] {
      $_path_commands foreach { l { it[] {n} onfail 0 } k. }
      onfail
    } fi
    if isfile(['{/$_path_rc/update$_version.gmic}'])
      l[] {
        i cimgz:$_path_rc/update$_version.gmic
        onfail l[] { it[] $_path_rc/update$_version.gmic onfail }
      }
    fi
    if !$! return fi
    a y

    # Check that requested command exist.
    command={`"
      s = ['$1']; len = size(s); z = 0;
      (p = find(s,_'['))>0?(s[p] = 0; len = p);
      isin(s[0],_'-',_'+') && len>1 && !(s[z + 1]=='3' && s[z + 2]=='d')?(copy(s,s[z + 1],len - 1); s[len - 1] = 0);
      s"`}

    s +,{'"#@cli "$command" :"'} s +,{'"#@cli "$command":"'} s +,{'"#@cli "$command"\n"'}
    if $!==1
      l[] {
        m "foo : "$command # Detect command misspelling.
        repeat 16 { um $command } # Be sure the specified command does not exist anymore !
        foo um foo
        onfail ('${}') s -,{'"; did you mean "'} if $!>1 s[1] -,39 k[1] misspelling={t} fi rm
      }
      if narg($misspelling) misspelling="; did you mean '"$_vt100_g$misspelling$_vt100_n"' ?" fi
      +e "\n[gmic] No help available for command '"$_vt100_r$command$_vt100_n"'"$misspelling". "\
         "\n       Try '"${_vt100_c}"gmic help"$_vt100_n"' for global help."
    else
      a y
      _no_categories=1
      +parse_cli ascii,$command
      if narg(${}) parse_cli ascii,${} fi # In case of shortcut, display also help for shortcut command.
    fi
  fi
  +e "\n" rm q

# Command to write reference documentation with various output modes.
# $1 = output mode, can be { ascii | html | man | pdf }.
# $2 = name of the folder containing additional .gmd pages (optional).
# Reference and command documentation is written using the G'MIC-markdown syntax.
reference : skip "${2=}"
  m "_section : reference_section_$1 \"$""*\""
  m "_text : reference_text_$1 \"$""*\""
  l { reference_begin_$1 reference_header_$1 onfail }
  _section "Usage"
  _text \
"~~~\ngmic [command1 [arg1_1,arg1_2,..]] .. [commandN [argN_1,argN_2,..]]\n~~~"\n\n\
"`gmic` is the open-source interpreter of the \\\G'MIC language, a script-based programming "\
"language dedicated to the design of possibly complex image processing pipelines and operators."\n\
"It can be used to convert, manipulate, filter and visualize image datasets made of one or "\
"several 1D/2D or 3D multi-spectral images."\n\
\n\
"This reference documentation describes all the technical aspects of the G'MIC framework, "\
"in its current version ___"${-strver}"___."\n\
\n\
"As a starting point, you may want to visit our detailed tutorial pages, at: <https://gmic.eu/tutorial/>"

  _section "Overall Context"
  _text \
"* At any time, \\G'MIC manages one list of numbered (and optionally named) pixel-based images, "\
"entirely stored in computer memory (uncompressed)."\n\
"* The first image of the list has index '0' and is denoted by '[0]'. The second image of the "\
"list is denoted by '[1]', the third by '[2]' and so on."\n\
"* Negative indices are treated in a periodic way: '[-1]' refers to the last image of the list, '[-2]' to the "\
"penultimate one, etc. Thus, if the list has 4 images, '[1]' and '[-3]' both designate the second image of the list."\n\
"* A named image may be also indicated by '[name]', if 'name' uses the character set `[a-zA-Z0-9_]` and does not "\
"start with a number. Image names can be set or reassigned at any moment during the processing pipeline "\
"(see command ''name'' for this purpose)."\n\
"* G'MIC defines a set of various commands and substitution mechanisms to allow the design of complex "\
"pipelines and operators managing this list of images, in a very flexible way: You can insert or remove images "\
"in the list, rearrange image order, process images (individually or grouped), merge image data together, "\
"display and output image files, etc."\n\
"* Such a pipeline can define a new custom G'MIC command (stored in a user command file), and re-used "\
"afterwards as a regular command, in a larger pipeline if necessary."

  _section "Image Definition and Terminology"
  _text \
"* In \\G'MIC, each image is modeled as a 1D, 2D, 3D or 4D array of scalar values, uniformly "\
"discretized on a rectangular/parallelepipedic domain."\n\
"* The four dimensions of this array are respectively denoted by:"\n\
"  - `width`, the number of image columns (size along the `x-axis`)."\n\
"  - `height`, the number of image rows (size along the `y-axis`)."\n\
"  - `depth`, the number of image slices (size along the `z-axis`). "\
"The depth is equal to '1' for usual color or grayscale 2D images."\n\
"  - `spectrum`, the number of image channels (size along the `c-axis`). "\
"The spectrum is respectively equal to '3' and '4' for usual `RGB` and `RGBA` color images."\n\
\n\
"* There are no hard limitations on the size of the image along each dimension. For instance, the number of image "\
"slices or channels can be of arbitrary size within the limits of the available memory."\n\
"* The `width`, `height` and `depth` of an image are considered as spatial dimensions, while the `spectrum` has a "\
"multi-spectral meaning. Thus, a 4D image in G'MIC should be most often regarded as a 3D dataset of multi-spectral "\
"voxels. Most of the G'MIC commands will stick with this idea (e.g. command ''blur'' blurs images only along the "\
"spatial `xyz`-axes)."\n\
"* G'MIC stores all the image data as buffers of `float` values (32 bits, value range '[-3.4E38,+3.4E38]'. "\
"It performs all its image processing operations with floating point numbers. Each image pixel takes "\
"then 32bits/channel (except if double-precision buffers have been enabled during the compilation of the software, "\
"in which case 64bits/channel can be the default)."\n\
"* Considering `float`-valued pixels ensure to keep the numerical precision when executing image processing "\
"pipelines. For image input/output operations, you may want to prescribe the image datatype to be different than "\
"`float` (like `bool`, `char`, `int`, etc.). This is possible by specifying it as a file option when using "\
"I/O commands. (see section ''Input/Output Properties'' to learn more about file options)."

  _section "Items of a Processing Pipeline"
  _text \
"* In \\G'MIC, an image processing pipeline is described as a sequence of items separated by the "\
"space character. Such items are interpreted and executed from the left to the right. For instance, the expression:"\n\
"~~~\nfilename.jpg blur 3,0 sharpen 10 resize 200%,200% output file_out.jpg\n~~~\n"\
"defines a valid pipeline composed of nine G'MIC items."\n\n\
"* Each G'MIC item is a string that is either a __command__, a list of command __arguments__, "\
"a __filename__ or a special __input string__."\n\
"* Escape characters '\\' and double quotes '\"' can be used to define items containing spaces or "\
"other special characters. For instance, the two strings `single\\ item` and `\"single item\"` "\
"both define the same single item, with a space in it."

  _section "Input Data Items"
  _text \
"* If a specified \\G'MIC item appears to be an existing filename, the corresponding image data "\
"are loaded and inserted at the end of the image list (which is equivalent to the use of `input filename`). "\n\
"* Special filenames `-` and `-.ext` stand for the standard input/output streams, optionally "\
"forced to be in a specific 'ext' file format (e.g. `-.jpg` or `-.png`). "\n\
"* The following special input strings may be used as G'MIC items to create and insert new "\
"images with prescribed values, at the end of the image list:"\n\
"  - '[selection]' or '[selection]xN': Insert 1 or N copies of already existing images. "\
"'selection' may represent one or several images (see section ''Command Items and Selections'' to learn more "\
"about selections)."\n\
"  - 'width[%],_height[%],_depth[%],_spectrum[%],_values[xN]': Insert one or N images with specified "\
"size and values (adding '%' to a dimension means __\"percentage of the size along the same axis\"__, "\
"taken from the last image '[-1]'). Any specified dimension can be also written as "\
"'[image]', and is then set to the size (along the same axis) of the existing specified image "\
"'[image]'. 'values' can be either a sequence of numbers separated by commas ',', "\
"or a mathematical expression, as e.g. in input item '256,256,1,3,[x,y,128]' which "\
"creates a `256x256` RGB color image with a spatial shading on the red and green channels. "\
"(see section ''Mathematical Expressions'' to learn more about mathematical expressions). "\n\
"  - '(v1,v2,..)[xN]': Insert one or `N` new images from specified prescribed values. Value separator "\
"inside parentheses can be ',' (column separator), ';' (row separator), '/' (slice separator) or "\
"'^' (channel separator). For instance, expression '(1,2,3;4,5,6;7,8,9)' creates a 3x3 matrix (scalar image), "\
"with values running from 1 to 9. "\n\
"  - '(\\'string\\'[:delimiter])[xN]': Insert one or N new images from specified string, by filling "\
"the images with the character codes composing the string. When specified, 'delimiter' tells about "\
"the main orientation of the image. Delimiter can be 'x' (eq. to ',' which is the default), "\
"'y' (eq. to ';'), 'z' (eq. to '/') or 'c' (eq. to '^'). "\
"When specified delimiter is ',', ';', '/' or '^', the expression is actually equivalent to "\
"'({\\'string\\'[:delimiter]})[xN]' (see section ''Substitution Rules'' for more information on the syntax)."\n\
"  - '0[xN]': Insert one or N new `empty` images, containing no pixel data. "\
"Empty images are used only in rare occasions."\n\
\n\
"* Input item 'name=value' declares a new variable 'name', or assign a new string value to an existing variable. "\
"Variable names must use the character set `[a-zA-Z0-9_]` and cannot start with a number. "\n\
"* A variable definition is always local to the current command except when it starts by the underscore "\
"character '_'. In that case, it becomes also accessible by any command invoked outside the current command "\
"scope (global variable)."\n\
"* If a variable name starts with two underscores `__`, the global variable is also shared among different threads "\
"and can be read/set by commands running in parallel (see command ''parallel'' for this purpose). "\
"Otherwise, it remains local to the thread that defined it."\n\
"* Numerical variables can be updated with the use of these special operators: "\
"'+=' (addition), '-=' (subtraction), '*=' (multiplication), '/=' (division), '%=' (modulo), '&=' (bitwise and), "\
"'|=' (bitwise or), '^=' (power), '<<=' and '>>' (bitwise left and right shifts). For instance, 'foo=1' 'foo+=3'."\n\
"* Input item 'name.=string' appends specified `string` at the end of variable 'name'."\n\
"* Input item 'name..=string' prepends specified `string` at the beginning of variable 'name'."\n\
"* Multiple variable assignments and updates are allowed, with expressions: 'name1,name2,...,nameN=value' or "\
"'name1,name2,...,nameN=value1,value2,...,valueN' where assignment operator '=' can be replaced by one of the "\
"allowed operators (e.g. '+=')."\n\
"* Variables usually store numbers or strings. Use command ''store'' to assign variables from image data "\
"(and syntax `input $variable` to bring them back on the image list afterwards)."

  _section "Command Items and Selections"
  _text \
"* A \\G'MIC item that is not a filename nor a special input string designates a 'command' "\
"most of the time. Generally, commands perform image processing operations on one or several available images "\
"of the list."\n\
"* Reccurent commands have two equivalent names ('regular' and 'short'). For instance, command names "\
"'resize' and 'r' refer to the same image resizing action."\n\
"* A G'MIC command may have mandatory or optional __arguments__. Command arguments must be specified "\
"in the next item on the command line. Commas ',' are used to separate multiple arguments of a single command, "\
"when required."\n\
"* The execution of a G'MIC command may be restricted only to a __subset__ of the image list, by "\
"appending '[selection]' to the command name. Examples of valid syntaxes for 'selection' are: "\n\
"  - 'command[-2]': Apply command only on the penultimate image '[-2]' of the list."\n\
"  - 'command[0,1,3]': Apply command only on images '[0]', '[1]' and '[3]'."\n\
"  - 'command[3-6]': Apply command only on images '[3]' to '[6]' (i.e, '[3]', '[4]', '[5]' and '[6]')."\n\
"  - 'command[50%-100%]': Apply command only on the second half of the image list."\n\
"  - 'command[0,-4--1]': Apply command only on the first image and the last four images."\n\
"  - 'command[0-9:3]': Apply command only on images '[0]' to '[9]', with a step of 3 "\
"(i.e. on images '[0]', '[3]', '[6]' and '[9]')."\n\
"  - 'command[0--1:2]': Apply command only on images of the list with even indices. "\n\
"  - 'command[0,2-4,50%--1]': Apply command on images '[0]', '[2]', '[3]', '[4]' and on the second half of "\
"the image list."\n\
"  - 'command[^0,1]': Apply command on all images except the first two."\n\
"  - 'command[name1,name2]': Apply command on named images 'name1' and 'name2'."\n\
\n\
"* Indices in selections are always sorted in increasing order, and duplicate indices are "\
"discarded. For instance, selections '[3-1,1-3]' and '[1,1,1,3,2]' are both equivalent to "\
"'[1-3]'. If you want to repeat a single command multiple times on an image, use a "\
"'repeat..done' loop instead. Inverting the order of images for a command is achieved by "\
"explicitly inverting the order of the images in the list, with command 'reverse[selection]'."\n\
"* Command selections '[-1]', '[-2]' and '[-3]' are so often used they have their own shortcuts, respectively "\
"'.', '..' and '...'. For instance, command 'blur..' is equivalent to 'blur[-2]'. "\
"These shortcuts work also when specifying command arguments."\n\
"* G'MIC commands invoked without '[selection]' are applied on all images of the list, i.e. the "\
"default selection is '[0--1]' (except for command ''input'' whose default selection is '[-1]'')."\n\
"* Prepending a single hyphen '-' to a G'MIC command is allowed. This may be useful to recognize "\
"command items more easily in a one-liner pipeline (typically invoked from a shell). "\n\
"* A G'MIC command prepended with a plus sign '+' does not act __in-place__ but inserts its result as one or "\
"several new images at the end of the image list."\n\
"* There are two different types of commands that can be run by the G'MIC interpreter:"\n\
"  - __Built-in commands__ are the hard-coded functionalities in the interpreter core. They are thus compiled as "\
"binary code and run fast, most of the time. Omitting an argument when invoking a built-in command is not permitted, "\
"except if all following arguments are also omitted. "\
"For instance, invoking 'plasma 10,,5' is invalid but 'plasma 10' is correct. "\n\
"  - __Custom commands__, are defined as G'MIC pipelines of built-in or other custom commands. "\
"They are parsed by the G'MIC interpreter, and thus run a bit slower than built-in commands. "\
"Omitting arguments when invoking a custom command is permitted. For instance, expressions "\
"`flower ,,,100,,2` or `flower ,` are correct. "\n\
\n\
"* Most of the existing commands in G'MIC are actually defined as __custom commands__. "\n\
"* A user can easily add its own custom commands to the G'MIC interpreter (see section "\
" ''Adding Custom Commands'' for more details). New built-in commands cannot be added (unless you modify the "\
"G'MIC interpreter source code and recompile it)."

  _section "Input/Output Properties"
  _text \
"* \\G'MIC is able to read/write most of the classical image file formats, including:"\n\
"  - 2D grayscale/color files: `.png`, `.jpeg`, `.gif`, `.pnm`, `.tif`, `.bmp`, ..."\n\
"  - 3D volumetric files: `.dcm`, `.hdr`, `.nii`, `.cube`, `.pan`, `.inr`, `.pnk`, ..."\n\
"  - Video files: `.mpeg`, `.avi`, `.mp4`, `.mov`, `.ogg`, `.flv`, ..."\n\
"  - Generic text or binary data files: `.gmz`, `.cimg`, `.cimgz`, `flo`, `ggr`, `gpl`, `.dlm`, `.asc`, "\
"`.pfm`, `.raw`, `.txt`, `.h`."\n\
"  - 3D mesh files: `.off`, `.obj`."\n\
\n\
"* When dealing with color images, G'MIC generally reads, writes and displays data using the usual "\
"sRGB color space."\n\
"* When loading a `.png` and `.tiff` file, the bit-depth of the input image(s) is returned to the status."\n\
"* G'MIC is able to manage __3D objects__ that may be read from files or generated by G'MIC commands. "\
"A 3D object is stored as a one-column scalar image containing the object data, in the "\
"following order: { magic_number; sizes; vertices; primitives; colors; opacities }. "\
"These 3D representations can be then processed as regular images (see command ''split3d'' for accessing "\
"each of these 3D object data separately)."\n\
"* Be aware that usual file formats may be sometimes not adapted to store all the available image "\
"data, since G'MIC uses float-valued image buffers. For instance, saving an image that was "\
"initially loaded as a 16bits/channel image, as a `.jpg` file will result in a loss of "\
"information. Use the G'MIC-specific file extension `.gmz` to ensure that all data "\
"precision is preserved when saving images."\n\
"* Sometimes, file options may/must be set for file formats:"\n\
"  - __Video files:__ Only sub-frames of an image sequence may be loaded, using the input expression "\
"'filename.ext,[first_frame[,last_frame[,step]]]'. Set 'last_frame==-1' to tell it must be "\
"the last frame of the video. Set 'step' to '0' to force an opened video file to be "\
"opened/closed. Output framerate and codec can be also set by using the output expression "\
"'filename.avi,_fps,_codec,_keep_open' where 'keep_open' can be { 0 | 1 }. 'codec' is a 4-char string "\
"(see <http://www.fourcc.org/codecs.php> ) or '0' for the default codec. 'keep_open' "\
"tells if the output video file must be kept open for appending new frames afterwards."\n\
"  - `.cimg[z]` __files:__ Only crops and sub-images of .cimg files can be loaded, using the input "\
"expressions 'filename.cimg,N0,N1', 'filename.cimg,N0,N1,x0,x1', "\
"'filename.cimg,N0,N1,x0,y0,x1,y1', 'filename.cimg,N0,N1,x0,y0,z0,x1,y1,z1' or "\
"'filename.cimg,N0,N1,x0,y0,z0,c0,x1,y1,z1,c1'. "\
"Specifying '-1' for one coordinates stands for the maximum possible value. Output expression "\
"'filename.cimg[z][,datatype]' can be used to force the output pixel type. 'datatype' can be "\
"{ auto | bool | uint8 | int8 | uint16 | int16 | uint32 | int32 | uint64 | int64 | float32 | float64 }. "\n\
"  - `.raw` __binary files:__ Image dimensions and input pixel type may be specified when loading `.raw` "\
"files with input expression 'filename.raw[,datatype][,width][,height[,depth[,dim[,offset]]]]]'. If no dimensions are "\
"specified, the resulting image is a one-column vector with maximum possible height. Pixel "\
"type can also be specified with the output expression 'filename.raw[,datatype]'. "\
"'datatype' can be the same as for `.cimg[z]` files. "\n\
"  - `.yuv` __files:__ Image dimensions must be specified when loading, and only sub-frames of an image "\
"sequence may be loaded, using the input expression "\
"'filename.yuv,width,height[,chroma_subsampling[,first_frame[,last_frame[,step]]]'. "\
"'chroma_subsampling' can be { 420 | 422 | 444 }. "\
"When saving, chroma subsampling mode can be specified with output expression "\
"'filename.yuv[,chroma_subsampling]'. "\n\
"  - `.tiff` __files:__ Only sub-images of multi-pages tiff files can be loaded, using the input "\
"expression 'filename.tif,_first_frame,_last_frame,_step'. "\
"Output expression 'filename.tiff,_datatype,_compression,_force_multipage,_use_bigtiff' can be used "\
"to specify the output pixel type, as well as the compression method. "\
"'datatype' can be the same as for `.cimg[z]` files. 'compression' can be "\
" { none (default) | lzw | jpeg }. 'force_multipage' can be { 0=no (default) | 1=yes }. "\
"'use_bigtiff' can be { 0=no | 1=yes (default) }."\n\
"  - `.pdf` __files:__ When loading a file, the rendering resolution can be specified using the input expression "\
"'filename.pdf,resolution', where 'resolution' is an unsigned integer value."\n\
"  - `.gif` __files:__ Animated gif files can be saved, using the input expression "\
"'filename.gif,fps>0,nb_loops'. Specify 'nb_loops=0' to get an infinite number of animation "\
"loops (this is the default behavior)."\n\
"  - `.jpeg` __files:__ The output quality may be specified (in %), using the output expression "\
"'filename.jpg,30' (here, to get a 30% quality output). '100' is the default."\n\
"  - `.mnc` __files:__ The output header can set from another file, using the output expression "\
"'filename.mnc,header_template.mnc'. "\n\
"  - `.pan`, `.cpp`, `.hpp`, `.c` and `.h` __files:__ The output datatype can be selected with output expression "\
"'filename[,datatype]'. 'datatype' can be the same as for `.cimg[z]` files."\n\
"  - `.gmic` __files:__ These filenames are assumed to be G'MIC custom commands files. Loading such a "\
"file will add the commands it defines to the interpreter. Debug information can be "\
"enabled/disabled by the input expression 'filename.gmic[,add_debug_info]' where 'debug_info' can be "\
"{ 0=false | 1=true }. "\n\
"  - Inserting 'ext:' on the beginning of a filename (e.g. 'jpg:filename') forces G'MIC to "\
"read/write the file as it would have been done if it had the specified extension `.ext`."\n\
\n\
"* Some input/output formats and options may not be supported, depending on the configuration "\
"flags that have been set during the build of the G'MIC software."

  _section "Substitution Rules"
  _text \
"* \\G'MIC items containing '$' or '{}' are substituted before being interpreted. Use these "\
"substituting expressions to access various data from the interpreter environment."\n\
"* '$name' and '${name}' are both substituted by the value of the specified named variable "\
"(set previously by the item 'name=value'). If this variable has not been already set, the "\
"expression is substituted by the highest positive index of the named image '[name]'. If no "\
"image has this name, the expression is substituted by the value of the OS environment variable "\
"with same name (it may be thus an empty string if it is not defined). "\n\
"* The following reserved variables are predefined by the G'MIC interpreter: "\n\
"  - '$!': The current number of images in the list."\n\
"  - '$>' and '$<': The increasing/decreasing index of the latest (currently running) "\
"'repeat...done' loop. '$>' goes from `0` (first loop iteration) to `nb_iterations - 1` (last iteration). "\
"'$<' does the opposite. "\n\
"  - '$/': The current call stack. Stack items are separated by slashes '/'."\n\
"  - '$|': The current value (expressed in seconds) of a millisecond precision timer."\n\
"  - '$^': The current verbosity level."\n\
"  - '$_cpus': The number of computation cores available on your machine."\n\
"  - '$_flags': The list of enabled flags when G'MIC interpreter has been compiled."\n\
"  - '$_host': A string telling about the host running the G'MIC interpreter (e.g. `cli` or `gimp`)."\n\
"  - '$_os': A string describing the running operating system."\n\
"  - '$_path_rc': The path to the G'MIC folder used to store configuration files (its value is OS-dependent)."\n\
"  - '$_path_user': The path to the G'MIC user file `.gmic` or `user.gmic` (its value is OS-dependent)."\n\
"  - '$_path_commands': A list of all imported command files (stored as an image list)."\n\
"  - '$_pid': The current process identifier, as an integer."\n\
"  - '$_pixeltype': The type of image pixels (default: 'float32')."\n\
"  - '$_prerelease': For pre-releases, the date of the pre-release as `yymmdd`. "\
"For stable releases, this variable is set to `0`."\n\
"  - '$_version': A 3-digits number telling about the current version of the G'MIC interpreter "\
" (e.g. '"$_version"'). "\n\
"  - '$_vt100': Set to `1` if colored text output is allowed on the console. Otherwise, set to `0`."\n\
\n\
"* '$$name' and '$${name}' are both substituted by the G'MIC script code of the specified named "\
"`custom command`, or by an empty string if no custom command with specified name exists. "\n\
"* '${\"-pipeline\"}' is substituted by the __status value__ after the execution of the specified "\
"G'MIC pipeline (see command ''status''). Expression '${}' thus stands for the current status value."\n\
"* '{``string}' (starting with two backquotes) is substituted by a double-quoted version of the specified string."\n\
"* '{/string}' is substituted by the escaped version of the specified string."\n\
"* '{\\'string\\'[:delimiter]}' (between single quotes) is substituted by the sequence of character codes "\
"that composes the specified string, separated by specified delimiter. Possible delimiters are "\
"',' (default), ';', '/', '^' or ' '. For instance, item '{'foo'}' is substituted by '102,111,111' and "\
"'{'foo':;}' by '102;111;111'."\n\
"* '{image,feature[:delimiter]}' is substituted by a specific feature of the image '[image]'. "\
"'image' can be either an image number or an image name. It can be also eluded, in which case, "\
"the last image '[-1]' of the list is considered for the requested feature. "\
"Specified 'feature' can be one of:"\n\
"  - 'b': The image basename (i.e. filename without the folder path nor extension)."\n\
"  - 'f': The image folder name."\n\
"  - 'n': The image name or filename (if the image has been read from a file)."\n\
"  - 't': The text string from the image values regarded as character codes."\n\
"  - 'x': The image extension (i.e the characters after the last `.` in the image name)."\n\
"  - '^': The sequence of all image values, separated by commas `,`."\n\
"  - '@subset': The sequence of image values corresponding to the specified subset, and separated by commas `,`. "\n\
"  - Any other 'feature' is considered as a __mathematical expression__ associated to the image '[image]' and is "\
"substituted by the result of its evaluation (float value). For instance, expression '{0,w+h}' is substituted by "\
"the sum of the width and height of the first image (see section ''Mathematical Expressions'' for more details). "\
"If a mathematical expression starts with an underscore `_`, the resulting value is truncated to a readable format. "\
"For instance, item '{_pi}' is substituted by '3.14159' (while '{pi}' is substituted by '3.141592653589793')."\n\
"  - A 'feature' delimited by backquotes is replaced by a string whose character codes correspond to the list of "\
"values resulting from the evaluation of the specified mathematical expression. For instance, item "\
"'{`[102,111,111]`}' is substituted by 'foo' and item '{`vector8(65)`}' by 'AAAAAAAA'."\n\
\n\
"* '{*}' is substituted by the visibility state of the instant display window '#0' "\
"(can be { 0=closed | 1=visible }."\n\
"* '{*[index],feature1,...,featureN[:delimiter]}' is substituted by a specific set of features of the instant display "\
"window '#0' (or '#index', if specified). Requested 'features' can be:"\n\
"  - 'u': screen width (actually independent on the window size)."\n\
"  - 'v': screen height (actually independent on the window size)."\n\
"  - 'uv': screen width x screen height."\n\
"  - 'd': window width (i.e. width of the window widget)."\n\
"  - 'e': window height (i.e. height of the window widget)."\n\
"  - 'de': window width x window height."\n\
"  - 'w': display width (i.e. width of the display area managed by the window)."\n\
"  - 'h': display height (i.e. height of the display area managed by the window)."\n\
"  - 'wh': display width x display height."\n\
"  - 'i': X-coordinate of the display window."\n\
"  - 'j': Y-coordinate of the display window."\n\
"  - 'n': current normalization type of the instant display."\n\
"  - 't': window title of the instant display."\n\
"  - 'x': X-coordinate of the mouse position (or -1, if outside the display area)."\n\
"  - 'y': Y-coordinate of the mouse position (or -1, if outside the display area)."\n\
"  - 'b': state of the mouse buttons { 1=left-but. | 2=right-but. | 4=middle-but. }."\n\
"  - 'o': state of the mouse wheel."\n\
"  - 'k': decimal code of the pressed key if any, 0 otherwise."\n\
"  - 'c': boolean (0 or 1) telling if the instant display has been closed recently."\n\
"  - 'r': boolean telling if the instant display has been resized recently."\n\
"  - 'm': boolean telling if the instant display has been moved recently."\n\
"  - Any other 'feature' stands for a keycode name (in capital letters), and is substituted "\
"by a boolean describing the current key state { 0=pressed | 1=released }."\n\
"  - You can also prepend a hyphen '-' to a 'feature' (that supports it) to flush the "\
"corresponding event immediately after reading its state (works for keys, mouse and window events)."\n\
\n\
"* Item substitution is __never__ performed in items between double quotes. One must break the quotes "\
"to enable substitution if needed, as in '\"3+8 kg = \"{3+8}\" kg\"'. Using double quotes is then "\
"a convenient way to disable the substitutions mechanism in items, when necessary."\n\
"* One can also disable the substitution mechanism on items outside double quotes, by escaping the "\
"`{`, `}` or `$` characters, as in `\\{3+4\\}\\ doesn\47t\\ evaluate`."

  _section "Mathematical Expressions"
  _text \
"* \\G'MIC has an embedded __mathematical parser__, used to evaluate (possibly complex) math expressions "\
"specified inside braces '{}', or formulas in commands that may take one as an argument (e.g. ''fill'' or ''eval'')."\n\
"* When the context allows it, a formula is evaluated __for each pixel__ of the selected images "\
"(e.g. ''fill'' or ''eval'')."\n\
"* A math expression may return a __scalar__ or a __vector-valued__ result (with a fixed number of components)."\n\
"The mathematical parser understands the following set of functions, operators and variables:"\n\
"## Usual math operators:"\n\
"'||' (logical or), '&&' (logical and), '|' (bitwise or), '&' (bitwise and), "\
"'!=', '==', '<=', '>=', '<', '>', '<<' (left bitwise shift), '>>' (right bitwise shift), '-', '+', '*', '/', "\
"'%' (modulo), '^' (power), '!' (logical not), '~' (bitwise not), '++', '--', '+=', '-=', '*=', '/=', '%=', "\
"'&=', '|=', '^=', '>>', '<<=' (in-place operators)."\n\
"## Usual math functions:"\n\
"'abs()', 'acos()', 'acosh()', 'arg()', 'arg0()', 'argkth()', 'argmax()', 'argmaxabs()', "\
"'argmin()', 'argminabs()', 'asin()', 'asinh()', 'atan()', 'atan2()', 'atanh()', 'avg()', 'bool()', 'cbrt()', "\
"'ceil()', 'cos()', 'cosh()', 'cut()', 'deg2rad()', 'erf()', 'erfinv()', 'exp()', 'fact()', 'fibo()', 'floor()', "\
"'gauss()', 'gcd()', 'int()', 'isnan()', 'isnum()', 'isinf()', 'isint()', 'isbool()', 'isexpr()', 'isfile()', "\
"'isdir()', 'isin()', 'kth()', 'log()', 'log2()', 'log10()', 'max()', 'maxabs()', 'med()', 'min()', 'minabs()', "\
"'narg()', 'prod()', 'rad2deg()', 'rol()' (left bit rotation), 'ror()' (right bit rotation), 'round()', 'sign()', "\
"'sin()', 'sinc()', 'sinh()', 'sqrt()', 'std()', 'srand(_seed)', 'sum()', 'tan()', 'tanh()', 'var()', 'xor()'."\n\
\n\
"* 'cov(A,B,_avgA,_avgB)' estimates the covariance between vectors 'A' and 'B' (estimated averages of these vectors "\
"may be specified as arguments)."\n\
"* 'mse(A,B)' returns the mean-squared error between vectors 'A' and 'B'."\n\
"* 'atan2(y,x)' is the version of 'atan()' with two arguments 'y' and 'x' (as in C/C++)."\n\
"* 'permut(k,n,with_order)' computes the number of permutations of 'k' objects from a set of 'n' objects."\n\
"* 'gauss(x,_sigma,_is_normalized)' returns `exp(-x^2/(2*s^2))/(is_normalized?sqrt(2*pi*sigma^2):1)`."\n\
"* 'cut(value,min,max)' returns 'value' if it is in range '[min,max]', or 'min' or 'max' otherwise."\n\
"* 'narg(a_1,...,a_N)' returns the number of specified arguments (here, 'N')."\n\
"* 'arg(i,a_1,..,a_N)' returns the `i`-th argument 'a_i'."\n\
"* 'isnum()', 'isnan()', 'isinf()', 'isint()', 'isbool()' test the type of the given number or expression, "\
"and return '0' (false) or '1' (true)."\n\
"* 'isfile(\\'path\\')' (resp. 'isdir('path')') returns '0' (false) or '1' (true) whether its string argument is a "\
"path to an existing file (resp. to a directory) or not."\n\
"* 'isvarname(\\'str\\')' returns '0' (false) or '1' (true) whether its string argument would be a valid to name "\
"a variable or not."\n\
"* 'isin(v,a_1,...,a_n)' returns '0' (false) or '1' (true) whether the first argument 'v' appears in the set of other "\
"argument 'a_i'."\n\
"* 'inrange(value,m,M,include_m,include_M)' returns '0' (false) or '1' (true) whether the specified value lies in "\
"range '[m,M]' or not ('include_m' and 'includeM' tells how boundaries 'm' and 'M' are considered)."\n\
"* 'argkth()', 'argmin()', 'argmax()', 'argminabs()', 'argmaxabs()'', 'avg()', 'kth()', 'min()', 'max()', 'minabs()', "\
"'maxabs()', 'med()', 'prod()', 'std()', 'sum()' and 'var()' can be called with an arbitrary number of scalar/vector "\
"arguments."\n\
"* 'vargkth()', 'vargmin()', 'vargmax()', 'vargminabs()', 'vargmaxabs()', 'vavg()', 'vkth()', 'vmin()', "\
"'vmax()', 'vminabs()', 'vmaxabs()', 'vmed()', 'vprod()', 'vstd()', 'vsum()' and 'vvar()' are the versions of the "\
"previous function with vector-valued arguments."\n\
"* 'round(value,rounding_value,direction)' returns a rounded value. 'direction' can be "\
"{ -1=to-lowest | 0=to-nearest | 1=to-highest }."\n\
"* 'lerp(a,b,t)' returns 'a*(1-t)+b*t'."\n\
"* 'swap(a,b)' swaps the values of the given arguments."\n\
"## Variable names:"\n\
"Variable names below are pre-defined. They can be overridden."\n\
"* 'l': length of the associated list of images."\n\
"* 'k': index of the associated image, in '[0,l-1]'."\n\
"* 'w': width of the associated image, if any ('0' otherwise)."\n\
"* 'h': height of the associated image, if any ('0' otherwise)."\n\
"* 'd': depth of the associated image, if any ('0' otherwise)."\n\
"* 's': spectrum of the associated image, if any ('0' otherwise)."\n\
"* 'r': shared state of the associated image, if any ('0' otherwise)."\n\
"* 'wh': shortcut for width x height."\n\
"* 'whd': shortcut for width x height x depth."\n\
"* 'whds': shortcut for width x height x depth x spectrum (i.e. number of image values)."\n\
"* 'im', 'iM', 'ia', 'iv', 'id', 'is', 'ip', 'ic', 'in': Respectively the minimum, maximum, average, variance, "\
"standard deviation, sum, product, median value and L2-norm of the associated image, if any ('0' otherwise)."\n\
"* 'xm', 'ym', 'zm', 'cm': The pixel coordinates of the minimum value in the associated image, "\
"if any ('0' otherwise)."\n\
"* 'xM', 'yM', 'zM', 'cM': The pixel coordinates of the maximum value in the associated image, "\
"if any ('0' otherwise)."\n\
"* All these variables are considered as __constant values__ by the math parser (for optimization purposes) "\
"which is indeed the case most of the time. Anyway, this might not be the case, if function 'resize(#ind,..)' "\
"is used in the math expression. If so, it is safer to invoke functions 'l()', 'w(_#ind)', 'h(_#ind)', ... 's(_#ind)' "\
"and 'in(_#ind)' instead of the corresponding named variables."\n\
"* 'i': current processed pixel value (i.e. value located at `(x,y,z,c)`) in the associated image, "\
"if any ('0' otherwise)."\n\
"* 'iN': N-th channel value of current processed pixel (i.e. value located at `(x,y,z,N)` in the associated image, "\
"if any ('0' otherwise). 'N' must be an integer in range '[0,9]'."\n\
"* 'R', 'G', 'B' and 'A' are equivalent to 'i0', 'i1', 'i2' and 'i3' respectively."\n\
"* 'I': current vector-valued processed pixel in the associated image, if any ('0' otherwise). "\
"The number of vector components is equal to the number of image channels (e.g. 'I' = `[ R,G,B ]` for a "\
"`RGB` image)."\n\
"* You may add '#ind' to any of the variable name above to retrieve the information for any "\
"numbered image '[ind]' of the list (when this makes sense). For instance 'ia#0' denotes the average value of the "\
"first image of the list)."\n\
"* 'x': current processed column of the associated image, if any ('0' otherwise)."\n\
"* 'y': current processed row of the associated image, if any ('0' otherwise)."\n\
"* 'z': current processed slice of the associated image, if any ('0' otherwise)."\n\
"* 'c': current processed channel of the associated image, if any ('0' otherwise)."\n\
"* 't': thread id when an expression is evaluated with multiple threads ('0' means __master thread__)."\n\
"* 'n': maximum number of threads when expression is evaluated in parallel (so that 't' goes from '0' to 'n-1')."\n\
"* 'e': value of e, i.e. `2.71828...`."\n\
"* 'pi': value of pi, i.e. `3.1415926...`."\n\
"* 'u': a random value between '[0,1]', following a uniform distribution."\n\
"* 'v': a random value between '[-1,1]', following a uniform distribution."\n\
"* 'g': a random value, following a gaussian distribution of variance 1 (roughly in '[-6,6]')."\n\
"* 'interpolation': value of the default interpolation mode used when reading pixel values with the pixel access "\
"operators (i.e. when the interpolation argument is not explicitly specified, see below for more details on pixel "\
"access operators). Its initial default value is '0'."\n\
"* 'boundary': value of the default boundary conditions used when reading pixel values with the pixel access "\
"operators (i.e. when the boundary condition argument is not explicitly specified, see below for more details "\
"on pixel access operators). Its initial default value is '0'."\n\
"* The last image of the list is always associated to the evaluations of 'expressions', e.g. G'MIC sequence "\
"\n~~~\n256,128 fill {w}\n~~~\n will create a 256x128 image filled with value 256."\n\
"## Vector calculus:"\n\
"Most operators are also able to work with vector-valued elements."\n\
"* '[a0,a1,...,aN-1]' defines a 'N'-dimensional vector with scalar coefficients 'ak'."\n\
"* 'vectorN(a0,a1,,...,aN-1)' does the same, with the 'ak' being repeated periodically if only a few are specified."\n\
"* 'vector(#N,a0,a1,,...,aN-1)' does the same, and can be used for any constant expression 'N'."\n\
"* In previous expressions, the 'ak' can be vectors themselves, to be concatenated into a single vector."\n\
"* The scalar element 'ak' of a vector 'X' is retrieved by 'X[k]'."\n\
"* The sub-vector '[X[p],X[p+s]...X[p+s*(q-1)]]' (of size 'q') of a vector 'X' is retrieved by 'X[p,q,s]'."\n\
"* 'expr(formula,_w,_h,_d,_s)' outputs a vector of size 'w*h*d*s' with values generated from "\
"the specified formula, as if one were filling an image with dimensions '(w,h,d,s)'."\n\
"* Equality/inequality comparisons between two vectors is done with operators '==' and '!='."\n\
"* Some vector-specific functions can be used on vector values: "\
"'cross(X,Y)' (cross product), 'dot(X,Y)' (dot product), 'size(X)' (vector dimension), "\
"'sort(X,_is_increasing,_nb_elts,_size_elt)' (sorted values), 'reverse(A)' (reverse order of components), "\
"'map(X,P,_nb_channelsX,_nb_channelsP,_boundary_conditions)', "\
"'shift(A,_length,_boundary_conditions)' and 'same(A,B,_nb_vals,_is_case_sensitive)' (vector equality test)."\n\
"* Function 'normP(u1,...,un)' computes the LP-norm of the specified vector ('P' being an `unsigned integer` constant "\
"or 'inf'). If 'P' is omitted, the L2 norm is calculated."\n\
"* Function 'resize(A,size,_interpolation,_boundary_conditions)' returns a resized version of a vector 'A' with "\
"specified interpolation mode. 'interpolation' can be "\
"{ -1=none (memory content) | 0=none | 1=nearest | 2=average | 3=linear | 4=grid | 5=bicubic | 6=lanczos }, and "\
"'boundary_conditions' can be { 0=dirichlet | 1=neumann | 2=periodic | 3=mirror }."\n\
"* Function 'resize(A,ow,oh,od,os,nw,_nh,_nd,_ns,_interpolation,_boundary_conditions,_ax,_ay,_az,_ac)' is an "\
"extended version of the previous function. It allows to resize the vector 'A', seen as an image of size "\
"'ow x oh x od x os' as a new image of size 'nw x nh x nd x ns', with specified resizing options."\n\
"* Function 'find(A,B,_starting_index,_search_step)' returns the index where sub-vector 'B' appears in vector 'A', "\
"(or '-1' if 'B' is not contained in 'A'). Argument 'A' can be also replaced by an image index '#ind'."\n\
"* A `2`-dimensional vector may be seen as a complex number and used in those particular functions/operators: "\
"'**' (complex multiplication), '//' (complex division), '^^' (complex exponentiation), "\
"'**=' (complex self-multiplication), '//=' (complex self-division), '^^=' (complex self-exponentiation), "\
"'cabs()' (complex modulus), 'carg()' (complex argument), 'cconj()' (complex conjugate), "\
"'cexp()' (complex exponential), 'clog()' (complex logarithm),  'ccos()' (complex cosine), "\
"'csin()' (complex sine), 'csqrt()' (complex square root), 'ctan()' (complex tangent), 'ccosh()' "\
"(complex hyperpolic cosine), 'csinh()' (complex hyperbolic sine) and 'ctanh()' (complex hyperbolic tangent)."\n\
"* A `MN`-dimensional vector may be seen as a `M` x `N` matrix and used in those particular functions/operators: "\
"'*' (matrix-vector multiplication), 'det(A)' (determinant), 'diag(V)' (diagonal matrix from a vector), "\
"'eig(A)' (eigenvalues/eigenvectors), 'eye(n)' (n x n identity matrix), 'invert(A,_nb_colsA,_use_LU,_lambda)' "\
"(matrix inverse), 'mul(A,B,_nb_colsB)' (matrix-matrix multiplication), "\
"'rot(u,v,w,angle)' (3D rotation matrix), 'rot(angle)' (2D rotation matrix), "\
"'solve(A,B,_nb_colsB,_use_LU)' (solver of linear system A.X = B), 'svd(A,_nb_colsA)' (singular value decomposition), "\
"'trace(A)' (matrix trace) and 'transpose(A,nb_colsA)' (matrix transpose). Argument 'nb_colsB' may be omitted if "\
"it is equal to `1`".\n\
"* 'mproj(S,nb_colsS,D,nb_colsD,method,max_iter,max_residual)' projects a matrix 'S' onto a dictionary (matrix) "\
"'D'. Equivalent to command ''mproj'' but inside the math evaluator."\n\
"* Specifying a vector-valued math expression as an argument of a command that operates on image values "\
"(e.g. 'fill') modifies the whole spectrum range of the processed image(s), for each spatial coordinates `(x,y,z)`. "\
"The command does not loop over the `c`-axis in this case."\n\
"## String manipulation:"\n\
"Character strings are defined and managed as vectors objects. "\
"Dedicated functions and initializers to manage strings are:"\n\
"* `['string']` and `'string'` define a vector whose values are the character codes of the "\
"specified `character string` (e.g. `'foo'` is equal to `[ 102,111,111 ]`)."\n\
"* `_'character'` returns the (scalar) byte code of the specified character (e.g. `_'A'` is equal to '65')."\n\
"* A special case happens for __empty__ strings: Values of both expressions `['']` and `''` are '0'."\n\
"* Functions 'lowercase()' and 'uppercase()' return string with all string characters lowercased or uppercased."\n\
"* Function 's2v(str,_starting_index,_is_strict)' parses specified string 'str' and returns the value contained "\
"in it."\n\
"* Function 'v2s(expr,_nb_digits,_siz)' returns a vector of size 'siz' which contains the character representation "\
"of values described by expression 'expr'. "\
"'nb_digits' can be { <-1=0-padding of integers | -1=auto-reduced | 0=all | >0=max number of digits }."\n\
"* Function 'echo(str1,str2,...,strN)' prints the concatenation of given string arguments on the console."\n\
"* Function 'string(_#siz,str1,str2,...,strN)' generates a vector corresponding to the concatenation of given "\
"string/number arguments."\n\
"## Dynamic arrays:"\n\
"A dynamic array is defined as a one-column (or empty) image '[ind]' in the image list. "\
"It allows elements to be added or removed, each element having the same dimension "\
"(which is actually the number of channels of image '[ind]'). "\
"Dynamic arrays adapt their size to the number of elements they contain."\n\n\
"A dynamic array can be manipulated in a math expression, with the following functions:"\n\
"* 'da_size(_#ind)': Return the number of elements in dynamic array '[ind]'."\n\
"* 'da_back(_#ind)': Return the last element of the dynamic array '[ind]'."\n\
"* 'da_insert(_#ind,pos,elt_1,_elt_2,...,_elt_N)': Insert 'N' new elements 'elt_k' starting from index 'pos' "\
"in dynamic array '[ind]'."\n\
"* 'da_push(_#ind,elt1,_elt2,...,_eltN)': Insert 'N' new elements 'elt_k' at the end of dynamic array '[ind]'."\n\
"* 'da_pop(_#ind)': Same as 'da_back()' but also remove last element from the dynamic array '[ind]'."\n\
"* 'da_remove(_#ind,_start,_end)': Remove elements located between indices 'start' and 'end' (included) "\
"in dynamic array '[ind]'."\n\
"* 'da_freeze(_#ind)': Convert a dynamic array into a 1-column image with height 'da_size(#ind)'."\n\
"* The value of the k-th element of dynamic array '[ind]' is retrieved with 'i[_#ind,k]' (if the element is a "\
"scalar value), or 'I[_#ind,k]' (if the element is a vector)."\n\n\
"In the functions above, argument '#ind' may be omitted in which case it is assumed to be '#-1'."\n\
"## Special operators:"\n\
"* ';': expression separator. The returned value is always the last encountered expression. "\
"For instance expression '1;2;pi' is evaluated as 'pi'."\n\
"* '=': variable assignment. Variables in mathematical parser can only refer to numerical "\
"values (vectors or scalars). Variable names are case-sensitive. Use this operator in conjunction with ';' to define "\
"more complex evaluable expressions, such as \n~~~\nt = cos(x); 3*t^2 + 2*t + 1\n~~~\n"\
"These variables remain __local__ to the mathematical parser and cannot be accessed outside the evaluated "\
"expression."\n\
"* Variables defined in math parser may have a __constant__ property, by specifying keyword 'const' before the "\
"variable name (e.g. 'const foo = pi/4;'). The value set to such a variable must be indeed a __constant scalar__. "\
"Constant variables allows certain types of optimizations in the math JIT compiler."\n\
\
"## Specific functions:"\n\
"* 'addr(expr)': return the pointer address to the specified expression 'expr'. "\n\
"* 'fill(target,expr)' or 'fill(target,index_name,expr)' fill the content of the specified target "\
"(often vector-valued) using a given expression, e.g. `V = vector16(); fill(V,k,k^2 + k + 1);`. "\
"For a vector-valued target, it is basically equivalent to: "\
"`for (index_name = 0, index_name<size(target), ++index_name, target[index_name] = expr);`."\n\
"* 'u(max)' or 'u(min,max,_include_min,_include_max)': return a random value in range '0...max' or 'min...max', "\
"following a uniform distribution. Each range extremum can be included (default) in the distribution or not."\n\
"* 'f2ui(value)' and 'ui2f(value)': Convert a large unsigned integer as a negative floating point value "\
"(and vice-versa), so that 32bits floats can be used to store large integers while keeping a unitary precision."\n\
"* 'i(_a,_b,_c,_d,_interpolation_type,_boundary_conditions)': return the value of the pixel located at position "\
"`(a,b,c,d)` in the associated image, if any ('0' otherwise). "\
"'interpolation_type' can be { 0=nearest neighbor | 1=linear | 2=cubic }. "\
"'boundary_conditions' can be { 0=dirichlet | 1=neumann | 2=periodic | 3=mirror }. "\
"Omitted coordinates are replaced by their default values which are respectively 'x', 'y', 'z', 'c', 'interpolation' "\
"and 'boundary'. For instance command \n~~~\nfill 0.5*(i(x+1)-i(x-1))\n~~~\n will estimate the X-derivative of an "\
"image with a classical finite difference scheme."\n\
"* 'j(_dx,_dy,_dz,_dc,_interpolation_type,_boundary_conditions)' does the same for the pixel located at position "\
"`(x+dx,y+dy,z+dz,c+dc)` (pixel access relative to the current coordinates)."\n\
"* 'i[offset,_boundary_conditions]' returns the value of the pixel located at specified 'offset' in the associated "\
"image buffer (or '0' if offset is out-of-bounds)."\n\
"* 'j[offset,_boundary_conditions]' does the same for an offset relative to the current pixel coordinates "\
"`(x,y,z,c)`."\n\
"* 'i(#ind,_x,_y,_z,_c,_interpolation,_boundary_conditions)', "\
"'j(#ind,_dx,_dy,_dz,_dc,_interpolation,_boundary_conditions)', 'i[#ind,offset,_boundary_conditions]' and "\
"'i[offset,_boundary_conditions]' are similar expressions used to access pixel values for any numbered image '[ind]' "\
"of the list."\n\
"* 'I/J[_#ind,offset,_boundary_conditions]' and 'I/J(_#ind,_x,_y,_z,_interpolation,_boundary_conditions)' do the same "\
"as 'i/j[_#ind,offset,_boundary_conditions]' and 'i/j(_#ind,_x,_y,_z,_c,_interpolation,_boundary_conditions)' but "\
"return a vector instead of a scalar (e.g. a vector `[ R,G,B ]` for a pixel at `(a,b,c)` in a color image)."\n\
"* 'crop(_#ind,_x,_y,_z,_c,_dx,_dy,_dz,_dc,_boundary_conditions)' returns a vector whose values come from the "\
"cropped region of image '[ind]' (or from default image selected if 'ind' is not specified). Cropped region starts "\
"from point `(x,y,z,c)` and has a size of `dx x dy x dz x dc`. Arguments for coordinates and sizes can be omitted "\
"if they are not ambiguous (e.g. 'crop(#ind,x,y,dx,dy)' is a valid invocation of this function)."\n\
" * 'crop(S,w,h,d,s,_x,_y,_z,_c,_dx,_dy,_dz,_dc,_boundary_conditions)' does the same but extracts the cropped data "\
"from a vector 'S', viewed as an image of size `w x h x d x s`."\n\
"* 'draw(_#ind,S,_x,_y,_z,_c,_dx,_dy,_dz,_dc,_opacity,_M,_max_M)' draws a sprite 'S' in image '[ind]' "\
"(or in default image selected if 'ind' is not specified) at coordinates `(x,y,z,c)`."\n\
"* 'draw(D,w,h,s,d,S,_x,_y,_z,_c,_dx,_dy,_dz,_dc,_opacity,_M,_max_M)' does the same but draw the sprite 'S' in "\
"the vector 'D', viewed as an image of size `w x h x d x s`."\n\
"* 'polygon(_#ind,nb_vertices,coords,_opacity,_color)' draws a filled polygon in image '[ind]' (or in default image "\
"selected if 'ind' is not specified) at specified coordinates. It draws a single line if 'nb_vertices' is set to 2."\n\
"* 'polygon(_#ind,-nb_vertices,coords,_opacity,_pattern,_color)' draws a outlined polygon in image '[ind]' (or in "\
"default image selected if 'ind' is not specified) at specified coordinates and with specified line pattern. "\
"It draws a single line if 'nb_vertices' is set to 2."\n\
"* 'ellipse(_#ind,xc,yc,radius1,_radius2,_angle,_opacity,_color)' draws a filled ellipse in image '[ind]' "\
"(or in default image selected if 'ind' is not specified) with specified coordinates."\n\
"* 'ellipse(_#ind,xc,yc,-radius1,-_radius2,_angle,_opacity,_pattern,_color)' draws an outlined ellipse in image "\
"'[ind]' (or in default image selected if 'ind' is not specified)."\n\
"* 'resize(#ind,w,_h,_d,_s,_interp,_boundary_conditions,_cx,_cy,_cz,_cc)' resizes an image of the associated list "\
"with specified dimension and interpolation method. When using this function, you should consider retrieving the "\
"(non-constant) image dimensions using the dynamic functions 'w(_#ind)', 'h(_#ind)', 'd(_#ind)', 's(_#ind)', "\
"'wh(_#ind)', 'whd(_#ind)' and 'whds(_#ind)' instead of the corresponding constant variables."\n\
"* 'if(condition,expr_then,_expr_else)': return value of 'expr_then' or 'expr_else', depending on the value of "\
"'condition' { 0=false | other=true }. 'expr_else' can be omitted in which case '0' is returned if the condition "\
"does not hold. Using the ternary operator 'condition?expr_then[:expr_else]' gives an equivalent expression. "\
"For instance, G'MIC commands \n~~~\nfill if(x%10==0,255,i)\n~~~\n and \n~~~\nfill x%10?i:255\n~~~\n both draw blank "\
"vertical lines on every 10th column of an image."\n\
"* 'do(expression,_condition)' repeats the evaluation of 'expression' until 'condition' vanishes "\
"(or until 'expression' vanishes if no 'condition' is specified). For instance, the expression: "\
"\n~~~\nif(N<2,N,n=N-1;F0=0;F1=1;do(F2=F0+F1;F0=F1;F1=F2,n=n-1))\n~~~\n returns the N-th value of the Fibonacci "\
"sequence, for 'N>=0' (e.g., '46368' for 'N=24'). 'do(expression,condition)' always evaluates the specified "\
"expression at least once, then check for the loop condition. When done, it returns the last value of 'expression'."\n\
"* 'for(init,condition,_procedure,body)' first evaluates the expression 'init', then iteratively evaluates 'body' "\
"(followed by 'procedure' if specified) while 'condition' holds (i.e. not zero). It may happen that no iterations are "\
"done, in which case the function returns 'nan'. Otherwise, it returns the last value of 'body'. "\
"For instance, the expression: \n~~~\nif(N<2,N,for(n=N;F0=0;F1=1,n=n-1,F2=F0+F1;F0=F1;F1=F2))\n~~~\n "\
"returns the 'N'-th value of the Fibonacci sequence, for 'N>=0' (e.g., '46368' for 'N=24')."\n\
"* 'while(condition,expression)' is exactly the same as 'for(init,condition,expression)' without the specification of "\
"an initializing expression."\n\
"* 'repeat(nb_iters,expr)' or 'fill(nb_iters,iter_name,expr)' run 'nb_iters' iterations of the specified expression "\
"'expr', e.g. `V = vector16(); repeat(16,k,V[k] = k^2 + k + 1);`. "\
"It is basically equivalent to: "\
"`for (iter_name = 0, iter_name<nb_iters, ++iter_name, expr);`."\n\
"* 'break()' and 'continue()' respectively breaks and continues the current running block."\n\
"* 'fsize('filename')' returns the size of the specified 'filename' (or '-1' if file does not exist)."\n\
"* 'date(attr,'path')' returns the date attribute for the given 'path' (file or directory), "\
"with 'attr' being { 0=year | 1=month | 2=day | 3=day of week | 4=hour | 5=minute | 6=second }, or a vector "\
"of those values."\n\
"* 'date(_attr)' returns the specified attribute for the current (locale) date (attributes being "\
"{ 0...6=same meaning as above | 7=milliseconds })."\n\
"* 'print(expr1,expr2,...)' or 'print(#ind)' prints the value of the specified expressions (or image information) "\
"on the console, and returns the value of the last expression (or 'nan' in case of an image). "\
"Function 'prints(expr)' also prints the string composed of the character codes defined by the vector-valued "\
"expression (e.g. 'prints('Hello')')."\n\
"* 'debug(expression)' prints detailed debug info about the sequence of operations done by the math parser to "\
"evaluate the expression (and returns its value)."\n\
"* 'display(_X,_w,_h,_d,_s)' or 'display(#ind)' display the contents of the vector 'X' (or specified image) and "\
"wait for user events. if no arguments are provided, a memory snapshot of the math parser environment is displayed "\
"instead."\n\
"* 'begin(expression)' and 'end(expression)' evaluates the specified expressions only once, respectively at the "\
"beginning and end of the evaluation procedure, and this, even when multiple evaluations are required "\
"(e.g. in 'fill \">begin(foo = 0); ++foo\"')."\n\
"* 'copy(dest,src,_nb_elts,_inc_d,_inc_s,_opacity)' copies an entire memory block of 'nb_elts' elements starting "\
"from a source value 'src' to a specified destination 'dest', with increments defined by 'inc_d' and 'inc_s' "\
"respectively for the destination and source pointers."\n\
"* 'stats(_#ind)' returns the statistics vector of the running image '[ind]', i.e the vector "\
"`[ im,iM,ia,iv,xm,ym,zm,cm,xM,yM,zM,cM,is,ip ]` (14 values)."\n\
"* 'ref(expr,a)' references specified expression 'expr' as variable name 'a'."\n\
"* 'unref(a,b,...)' destroys references to the named variable given as arguments."\n\
"* 'breakpoint()' inserts a possible computation breakpoint (useless with the cli interface)."\n\
"* '_(comment) expr' just returns expression 'expr' (useful for inserting inline comments in math expressions)."\n\
"* 'run('pipeline')' executes the specified G'MIC pipeline as if it was called outside the currently evaluated "\
"expression."\n\
"* 'set(\\'variable_name\\',A)' set the G'MIC variable '$variable_name' with the value of expression 'A'. If 'A' is"\
" a vector-valued variable, it is assumed to encode a string."\n\
"* 'store(\\'variable_name\\',A,_w,_h,_d,_s,_is_compressed)' transfers the data of vector 'A' as a "\
"`w x h x d x s` image to the G'MIC variable '$variable_name'. Thus, the data becomes available outside the math "\
"expression (that is equivalent to using the regular command ''store'', but directly in the math expression)."\n\
"* 'get(\\'variable_name\\',_size,_return_as_string)' returns the value of the specified variable, as a vector of "\
"'size' values, or as a scalar (if 'size' is zero or not specified)."\n\
"* 'name(_#ind,size)' returns a vector of size 'size', whose values are the characters codes of the name of image "\
"'[ind]' (or default image selected if 'ind' is not specified)."\n\
"* 'correlate(I,wI,hI,dI,sI,K,wK,hK,dK,sK,_boundary_conditions,_is_normalized,_channel_mode,_xcenter,_ycenter,"\
"_zcenter,_xstart,_ystart,_zstart,_xend,_yend,_zend,_xstride,_ystride,_zstride,_xdilation,_ydilation,_zdilation,"\
"_interpolation_type)' returns the correlation, unrolled as a vector, of the `wI x hI x dI x sI`-sized image 'I' "\
"with the `wK x hK x dK x sK`-sized kernel 'K' (the meaning of the other arguments are the same as in command "\
"'correlate'). Similar function 'convolve(...)' is also defined for computing the convolution between 'I' and 'K'."\n\
\
"## User-defined macros:"\n\
"* Custom macro functions can be defined in a math expression, using the assignment operator "\
"'=', e.g. \n~~~\nfoo(x,y) = cos(x + y); result = foo(1,2) + foo(2,3)\n~~~\n"\n\
"* Trying to override a built-in function (e.g. 'abs()') has no effect."\n\
"* Overloading macros with different number of arguments is possible. Re-defining a previously defined macro with "\
"the same number of arguments discards its previous definition."\n\
"* Macro functions are indeed processed as __macros__ by the mathematical evaluator. You should avoid invoking them "\
"with arguments that are themselves results of assignments or self-operations. "\
"For instance, \n~~~\nfoo(x) = x + x; z = 0; foo(++z)\n~~~\n returns '4' rather than expected value '2'."\n\
"* When substituted, macro arguments are placed inside parentheses, except if a number sign "\
"'#' is located just before or after the argument name. For instance, expression \n"\
"~~~\nfoo(x,y) = x*y; foo(1+2,3)\n~~~\n "\
"returns '9' (being substituted as '(1+2)*(3)'), while expression \n~~~\nfoo(x,y) = x#*y#; foo(1+2,3)\n~~~\n "\
"returns '7' (being substituted as '1+2*3')."\n\
"* Number signs appearing between macro arguments function actually count for __empty__ separators. They may be used "\
"to force the substitution of macro arguments in unusual places, e.g. as in \n~~~\nstr(N) = ['I like N#'];\n~~~\n"\
"* Macros with variadic arguments can be defined, by specifying a single argument name followed by `...`. "\
"For instance,\n~~~\nfoo(args...) = sum([ args ]^2);\n~~~\n "\
"defines a macro that returns the sum of its squared arguments, so `foo(1,2,3)` returns `14` and "\
"`foo(4,5)` returns `41`.\n"\
\
"## Multi-threaded and in-place evaluation:"\n\
"* If your image data are large enough and you have several CPUs available, it is likely that the math expression "\
"passed to a 'fill', 'eval' or 'input' commands is evaluated in parallel, using multiple computation threads."\n\
"* Starting an expression with ':' or '*' forces the evaluations required for an image to be run in parallel, "\
"even if the amount of data to process is small (beware, it may be slower to evaluate in this case!). "\
"Specify ':' (rather than '*') to avoid possible image copy done before evaluating the expression "\
"(this saves memory, but do this only if you are sure this step is not required!)"\n\
"* If the specified expression starts with '>' or '<', the pixel access operators 'i()', 'i[]', 'j()' and 'j[]' "\
"return values of the image being currently modified, in forward ('>') or backward ('<') order. "\
"The multi-threading evaluation of the expression is disabled in this case."\n\
"* Function 'critical(expr)' forces the execution of the given expression in a single thread at a time."\n\
"* 'begin_t(expr)' and 'end_t(expr)' evaluates the specified expression once for each running thread "\
"(so possibly several times) at the beginning and the end of the evaluation procedure."\n\
"* 'merge(variable,operator)' tells to merge the local variable value computed by threads, with the specified "\
"operator, when all threads have finished computing."\n\
"* Expressions 'i(_#ind,x,_y,_z,_c)=value', 'j(_#ind,x,_y,_z,_c)=value', 'i[_#ind,offset]=value' and "\
"'j[_#ind,offset]=value' set a pixel value at a different location than the running one in the image '[ind]' "\
"(or in the associated image if argument '#ind' is omitted), either with global coordinates/offsets "\
"(with 'i(...)' and 'i[...]'), or relatively to the current position `(x,y,z,c)` (with 'j(...)' and 'j[...]'). "\
"These expressions always return 'value'."

  _section "Image and Data Viewers"
  _text \
"* \\G'MIC has some very handy embedded __visualization modules__, for 1D signals (command ''plot''), "\
"1D/2D/3D images (command ''display'') and 3D vector objects (command ''display3d''). It manages interactive views "\
"of the selected image data."\n\
"* The following actions are available in the interactive viewers:"\n\
"  - `(mousewheel)`: Zoom in/out."\n\
"  - `ESC`: Close window."\n\
"  - `CTRL+D`: Increase window size."\n\
"  - `CTRL+C`: Decrease window size."\n\
"  - `CTRL+R`: Reset window size."\n\
"  - `CTRL+F`: Toggle fullscreen mode."\n\
"  - `CTRL+S`: Save current view as a numbered file 'gmic_xxxx.ext'."\n\
"  - `CTRL+O`: Save copy of the viewed data, as a numbered file 'gmic_xxxx.ext'."\n\
\n\
"* Actions specific to the __1D/2D image viewer__ (command ''display'') are:"\n\
"  - `Left mouse button`: Create an image selection and zoom into it."\n\
"  - `Middle mouse button`, or `CTRL+left mouse button`: Move image."\n\
"  - `Mouse wheel` or `PADD+/-`: Zoom in/out."\n\
"  - `Arrow keys`: Move image left/right/up/down."\n\
"  - `CTRL+A`: Enable/disable transparency (show alpha channel)."\n\
"  - `CTRL+N`: Change normalization mode (can be { none | normal | channel-by-channel })."\n\
"  - `CTRL+SPACE`: Reset view."\n\
"  - `CTRL+X`: Show/hide axes."\n\
"  - `CTRL+Z`: Hold/release aspect ratio."\n\
\n\
"* Actions specific to the __3D volumetric image viewer__ (command ''display'') are:"\n\
"  - `CTRL+P`: Play z-stack of frames as a movie."\n\
"  - `CTRL+V`: Show/hide 3D view on bottom right zone."\n\
"  - `CTRL+X`: Show/hide axes."\n\
"  - `CTRL+(mousewheel)`: Go up/down."\n\
"  - `SHIFT+(mousewheel)`: Go left/right."\n\
"  - `Numeric PAD`: Zoom in/out (`+`/`-`) and move through zoomed image (digits)."\n\
"  - `BACKSPACE`: Reset zoom scale."\n\
\n\
"* Actions specific to the __3D object viewer__ (command ''display3d'') are:"\n\
"  - `(mouse)+(left mouse button)`: Rotate 3D object."\n\
"  - `(mouse)+(right mouse button)`: Zoom 3D object."\n\
"  - `(mouse)+(middle mouse button)`: Shift 3D object."\n\
"  - `F1 ... F6`: Toggle between different 3D rendering modes."\n\
"  - `F7/F8`: Decrease/increase focale."\n\
"  - `F9`: Select animation mode."\n\
"  - `F10`: Select animation speed."\n\
"  - `SPACE`: Start/stop animation."\n\
"  - `CTRL+A`: Show/hide 3D axes."\n\
"  - `CTRL+B`: Switch between available background."\n\
"  - `CTRL+G`: Save 3D object, as numbered file 'gmic_xxxx.obj'."\n\
"  - `CTRL+L`: Show/hide outline."\n\
"  - `CTRL+P`: Print current 3D pose on stderr."\n\
"  - `CTRL+T`: Switch between single/double-sided 3D modes."\n\
"  - `CTRL+V`: Start animation with video output."\n\
"  - `CTRL+X`: Show/hide 3D bounding box."\n\
"  - `CTRL+Z`: Enable/disable z-buffered rendering."

  _section "Adding Custom Commands"
  _text \
"* New custom commands can be added by the user, through the use of \\G'MIC __custom commands files__."\n\
"* A command file is a simple text file, where each line starts either by "\
"\n~~~\ncommand_name: command_definition\n~~~\n or \n~~~\ncommand_definition (continuation)\n~~~\n"\n\
"* At startup, G'MIC automatically includes user's command file '$HOME/.gmic' (on __Unix__) or "\
"'%APPDATA%/user.gmic' (on __Windows__). The CLI tool 'gmic' automatically runs the command "\
"'cli_start' if defined."\n\
"* Custom command names must use character set `[a-zA-Z0-9_]` and cannot start with a number."\n\
"* Any `# comment` expression found in a custom commands file is discarded by the G'MIC parser, "\
"wherever it is located in a line."\n\
"* In a custom command, the following '$-expressions' are recognized and substituted:"\n\
"  - '$""\*' is substituted by a copy of the specified string of arguments."\n\
"  - '$\"*\"' is substituted by a copy of the specified string of arguments, each being double-quoted."\n\
"  - '$""#' is substituted by the maximum index of known arguments (either specified by the user or set to a default "\
"value in the custom command)."\n\
"  - '$""[]' is substituted by the list of selected image indices that have been specified in the command "\
"invocation."\n\
"  - '$""?' is substituted by a printable version of '$""[]' to be used in command descriptions."\n\
"  - '$i' and '${i}' are both substituted by the `i`-th specified argument. Negative indices such as '${-j}' are "\
"allowed and refer to the `j`-th latest argument. '$""0' is substituted by the custom command name."\n\
"  - '${i=default}' is substituted by the value of '$i' (if defined) or by its new value set to 'default' otherwise "\
"('default' may be a `$-expression` as well)."\n\
"  - '${subset}' is substituted by the argument values (separated by commas ',') of a specified argument subset. "\
"For instance expression '$""{2--2}' is substituted by all specified command arguments except the first and the last "\
"one. Expression '$""{^0}' is then substituted by all arguments of the invoked command (eq. to '$""*' if all "\
"arguments have been indeed specified)."\n\
"  - '$""=var' is substituted by the set of instructions that will assign each argument '$i' to the named variable "\
"'var$i' (for i in '[0...$""#]'. This is particularly useful when a custom command want to manage variable numbers "\
"of arguments. Variables names must use character set `[a-zA-Z0-9_]` and cannot start with a number."\n\
\n\
"* These particular `$-expressions` for custom commands are __always substituted__, even in "\
"double-quoted items or when the dollar sign '$' is escaped with a backslash '\\$'. To avoid substitution, place an "\
"empty double quoted string just after the '$' (as in '$\"\"1')."\n\
"* Specifying arguments may be skipped when invoking a custom command, by replacing them by commas ',' as in "\
"expression \n~~~\nflower ,,3\n~~~\n Omitted arguments are set to their default values, which must be thus explicitly "\
"defined in the code of the corresponding custom command (using default argument expressions as '$""{1=default}')."\n\
"* If one numbered argument required by a custom command misses a value, an error is thrown by the G'MIC "\
"interpreter."\n\
"* It is possible to specialize the invocation of a '+command' by defining it as "\
"\n~~~\n+command_name: command_definition\n~~~\n"\
"* A +-specialization takes priority over the regular command definition when the command is invoked with a "\
"prepended '+'."\n\
"* When only a +-specialization of a command is defined, invoking 'command' is actually equivalent to '+command'."

  _section "List of Commands"
  _text \
"All available \\G'MIC commands are listed below, by categories. An argument specified between '[]' "\
"or starting by '_' is optional except when standing for an existing image '[image]', where 'image' "\
"can be either an index number or an image name. In this case, the '[]' characters are mandatory when writing the "\
"item. Note that all images that serve as illustrations in this reference documentation are normalized in "\
"range `[0,255]` before being displayed. You may need to do this explicitly (command `normalize 0,255`) if you want "\
"to save and view images with the same aspect than those illustrated in the example codes."

  # Insert list of commands.
  l { reference_list_of_commands_$1 onfail }

  # Insert additional sections if specified.
  xfolder="$2"
  if "['$1']=='html' && ['$2']==0" xfolder=$HOME/work/src/gmic-community/reference fi

  if ['$xfolder']!=0
    files $xfolder/*.gmd files=${}
    repeat narg({/$files}) {
      arg 1+$>,$files file=${}
      l[] { it $file s={b} t={t} rm }
      _section {/$s}
      _text {/$t}
    }
  fi

  _section "Examples of Use"
  _text \
"`gmic` is a generic image processing tool which can be used in a wide variety of situations. "\
"The few examples below illustrate possible uses of this tool:"\n\
"### View a list of images: "\n\
"\n~~~\n$ gmic file1.bmp file2.jpeg\n~~~"\n\n\
"### Convert an image file: "\n\
"\n~~~\n$ gmic input.bmp output output.jpg\n~~~"\n\n\
"### Create a volumetric image from a movie sequence: "\n\
"\n~~~\n$ gmic input.mpg append z output output.hdr\n~~~"\n\n\
"### Compute image gradient norm: "\n\
"\n~~~\n$ gmic input.bmp gradient_norm\n~~~"\n\n\
"### Denoise a color image: "\n\
"\n~~~\n$ gmic image.jpg denoise 30,10 output denoised.jpg\n~~~"\n\n\
"### Compose two images using overlay layer blending: "\n\
"\n~~~\n$ gmic image1.jpg image2.jpg blend overlay output blended.jpg\n~~~"\n\n\
"### Evaluate a mathematical expression: "\n\
"\n~~~\n$ gmic echo \"cos(pi/4)^2+sin(pi/4)^2={cos(pi/4)^2+sin(pi/4)^2}\"\n~~~"\n\n\
"### Plot a 2D function: "\n\
"\n~~~\n$ gmic 1000,1,1,2 fill \"X=3*(x-500)/500;X^2*sin(3*X^2)+if(c==0,u(0,-1),cos(X*10))\" plot\n~~~"\n\
"===\n![](../img/example_plot.png)\n==="\n\n\
"### Plot a 3D elevated function in random colors: "\n\
"\n~~~\n$ gmic 128,128,1,3,\"u(0,255)\" plasma 10,3 blur 4 sharpen 10000 n 0,255 "\
"elevation3d[-1] \"'X=(x-64)/6;Y=(y-64)/6;100*exp(-(X^2+Y^2)/30)*abs(cos(X)*sin(Y))'\"\n~~~"\n\n\
"===\n![](../img/example_elevation3d.png)\n==="\n\n\
"### Plot the isosurface of a 3D volume: "\n\
"\n~~~\n$ gmic mode3d 5 moded3d 5 double3d 0 isosurface3d \"'x^2+y^2+abs(z)^abs(4*cos(x*y*z*3))'\",3\n~~~"\n\
"===\n![](../img/example_isosurface3d.png)\n==="\n\n\
"### Render a G'MIC 3D logo: "\n\
"\n~~~\n$ gmic 0 text G\\\47MIC,0,0,53,1,1,1,1 expand_xy 10,0 blur 1 normalize 0,100 +plasma 0.4 add blur 1 "\
"elevation3d -0.1 moded3d 4\n~~~"\n\
"===\n![](../img/example_logo.png)\n==="\n\n\
"### Generate a 3D ring of torii: "\n\
"\n~~~\n$ gmic repeat 20 torus3d 15,2 color3d[-1] \"{u(60,255)},{u(60,255)},{u(60,255)}\" *3d[-1] 0.5,1 if \"{$>%2}\" "\
"rotate3d[-1] 0,1,0,90 fi add3d[-1] 70 add3d rotate3d 0,0,1,18 done moded3d 3 mode3d 5 double3d 0\n~~~"\n\
"===\n![](../img/example_torii.png)\n==="\n\n\
"### Create a vase from a 3D isosurface: "\n\
"\n~~~\n$ gmic moded3d 4 isosurface3d \"'x^2+2*abs(y/2)*sin(2*y)^2+z^2-3',0\" sphere3d 1.5 sub3d[-1] 0,5 "\
"plane3d 15,15 rotate3d[-1] 1,0,0,90 center3d[-1] add3d[-1] 0,3.2 color3d[-1] 180,150,255 color3d[-2] 128,255,0 "\
"color3d[-3] 255,128,0 add3d\n~~~"\n\
"===\n![](../img/example_vase.png)\n==="\n\n\
"### Launch a set of interactive demos: "\n\
"\n~~~\n$ gmic demos\n~~~\n"

  l { reference_footer_$1 reference_end_$1 onfail }
  um _section,_text
  rm

#
# Implement output mode 'ascii' for command 'reference'.
#
reference_begin_ascii :
  use_vt100
  if !narg($_shell_cols) _shell_cols={${-shell_cols}-5} fi
  _section=0
  +e ""

reference_header_ascii :
  str=\n\
      "  "${_vt100_b}"gmic: GREYC\'s Magic for Image Computing:"$_vt100_n" command-line interface"\n\
      "        "${_vt100_c}${_vt100_b}"Version "${strver" "$_version,$_prerelease}$_vt100_n\n\
      "        "$_vt100_g$_vt100_u"(https://gmic.eu)"$_vt100_n\n\
      \n\
      "        Copyright (c) Since 2008, David Tschumperlé / GREYC / CNRS."\n\
      "        "$_vt100_g$_vt100_u"(https://www.greyc.fr)"$_vt100_n
  +e $str

reference_section_ascii :
  _section+=1
  +e ""
  ('$_section." "') ('"$*"') +f.. {'" "'} +f.. {'-'} a[-4,-3] x a[-2,-1] x
  +e "  "$_vt100_r$_vt100_b{-2,t}$_vt100_n
  +e "  "$_vt100_r{t}$_vt100_n\n
  rm[-2,-1]

reference_text_ascii :
  l[] {
    ('"$*"')
    gmd2ascii $_shell_cols,1

    # Ensure output text contains no more than two consecutive newlines.
    # Also add a 2-chars left margin on each line.
    s +,{'\n'}
    eval "repeat (l,p,
            i(#p)==_'\n' && h(#p)>2?resize(#p,1,2,1,1,0):
            (resize(#p,1,h#p + 2,1,1,0,0,0,1); copy(i[#p,0],_' ',2,1,0)))"
    a y
    +e {/{t}}
    rm
  }

reference_list_of_commands_ascii :
  l {
    if !$! it $_path_rc/update$_version.gmic fi
    parse_cli ascii
  onfail
    rm
    +e \n"  "$_vt100_r${_vt100_b}"No command descriptions available!"$_vt100_n
    +e "  "${_vt100_r}"Try updating your command files, with command "$_vt100_b"'update'."$_vt100_n
  }

reference_footer_ascii :
  +e \n"  "$_vt100_r$_vt100_b"** G\47MIC comes with ABSOLUTELY NO WARRANTY; "\
     "for details visit: https://gmic.eu **"$_vt100_n

#
# Implement output mode 'html' for command 'reference'.
#
reference_section_html :
  name="$*"
  reference_end_section_html
  ('"<!DOCTYPE html>"\n\
"<html lang=\"en\">"\n\
"  <head>"\n\
"    <meta charset=\"utf-8\">"\n\
"    <link rel=\"stylesheet\" href=\"../style.css\">"\n\
"    <title>G'MIC - GREYC's Magic for Image Computing: A Full-Featured Open-Source Framework for Image Processing "\
"- "$name"</title>"\n\
"    <script src=\"../jquery-3.5.1.min.js\"></script>"\n\
"    <script>var jQuery_3_5_1 = $.noConflict(true);</script>"\n\
"  </head>"\n\n\
"  <body>"\n\
"    <!--#include file=\"header1.html\" -->"\n\n\
"    <div class=\"section_title\"><a href=\"index.html\"><p>Reference</p></a></div><div class=\"section_content\">"\n\
"    <a name=\"top\"></a>"\n\
"<!-- ref_navigation_top -->"\n\n\
"<!-- begin_content -->"\n\n\
"      <h1 class=\"ref_h1\">"$name"</h1>"\n':y)
  => $name

reference_end_section_html :
  if $!   # End previous section
    ('"    <br/>"\n\n\
      "<!-- end_content -->"\n\n\
      "<!-- ref_navigation_bottom -->"\n\
      "    </div><div class=\"section_end\"></div>"\n\
      "    <!--#include file=\"footer.html\" -->"\n\
      "  </body>"':y)
    a[-2,-1] y
  fi

reference_text_html :
  ('"$*"':y) gmd2html. 0
  if $!>1 a[-2,-1] y fi

reference_footer_html :
  reference_end_section_html

reference_finalize_html :
