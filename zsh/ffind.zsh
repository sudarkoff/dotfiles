# A set of functions and aliases to aid searching symbols on source code.
#
# Examples:
#
# cfind ...
#

# Turn absolute path into relative path
# Given two absolute paths: $1 and $2 returns $2 relative to $1
function _relpath () {
   common_part=$(cd $1; pwd)/
   target=$(cd $2; pwd)
   back=
   while [ "${target#$common_part}" = "${target}" ]; do
      common_part=$(dirname $common_part)/
      back="../${back}"
   done

   echo ${back}${target#$common_part}
}

# Enumerate file extensions for various programming languages
c_ext="*.c *.cc *.cp *.cxx *.cpp *.c++ *.C *.i *.ii *.h *.hh *.hp *.hxx *.hpp *.h++"
cs_ext="*.cs"
vc_ext="*.vcproj *.sln"
py_ext="*.py"
pl_ext="*.pl *.pm"
java_ext="*.java"
js_ext="*.js"
sql_ext="*.sql"
html_ext="*.htm *.html"
scons_ext="SConstruct SConscript *.sc"
mk_ext="Makefile *.mk"
src_ext="${c_ext} ${cs_ext} ${py_ext} ${pl_ext} ${java_ext} ${js_ext} ${sql_ext} ${html_ext} ${scons_ext} ${mk_ext}"

# Turn the list of extensions into a condition string for 'find' utility
function _lang_extensions () {
    local lng_exts=${1}"_ext"
    local exts=""
    for e in ${!lng_exts}; do
        if [ -z "$exts" ]; then
            exts="-name \""$e"\""
        else
            exts="$exts -o -name \""$e"\""
        fi
    done
    echo "$exts"
}

# Locations to ignore when searching for symbols
prune_dir="-type d -name .git -prune -o -type d -name .svn -prune -o -type d -name CVS -prune"

# Grep for a pattern in all all source files for a given language (e.g.: _find_regex c <regex>)
function _find_regex () {
   if [[ "$1" == "--help" || "$1" == "" ]]; then
      echo "Usage: _find_regex <c|cs|vc|py|pl|java|js|sql|html|scons|mk|src> <regexp>"
      echo "Search for a 'regexp' in all source files of a specified language starting from the current directory."
      return 1
   fi

   eval find . ${prune_dir} -o -type f \\\( $(_lang_extensions $1) \\\) -print0 | xargs -0 grep --color --line-number --extended-regexp $2
}

# Define Xfind aliases for various programming languages
for lng in c cs vc py pl java js sql html scons mk src; do
   # Search recursively starting from the current directory (local)
   alias ${lng}find='_find_regex '$lng' $1'
done

