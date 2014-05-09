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

# Enumerate file extensions for various programming and scripting languages and text document types
c_ext=("*.c" "*.cc" "*.cp" "*.cxx" "*.cpp" "*.c++" "*.C" "*.i" "*.ii" "*.h" "*.hh" "*.hp" "*.hxx" "*.hpp" "*.h++")
py_ext=("*.py")
pl_ext=("*.pl" "*.pm")
java_ext=("*.java")
js_ext=("*.js")
sql_ext=("*.sql")
html_ext=("*.htm" "*.html" "*.css")
xml_ext=("*.xml" "*.xsl")
json_ext=("*.json")
sc_ext=("SConstruct" "SConscript" "*.sc")
mk_ext=("Makefile" "*.mk")
src_ext=(${c_ext} ${py_ext} ${pl_ext} ${java_ext} ${js_ext} ${sql_ext} ${html_ext} ${sc_ext} ${mk_ext})
sh_ext=("*.sh" "*.zsh")
md_ext=("*.md" "*.mdown" "*.markdown")

# Turn the list of extensions into a condition string for 'find' utility
function _lang_extensions_for_find () {
  local exts=$1"_ext"
  local find_expr=""

  if [[ -z "${(P)exts}" ]]; then
    # looks like the first parameter is not the list of file extensions
    # perhaps a wildcard?
    find_expr="-name \""$1"\""
  else
    for e in ${(P)exts}; do
      if [ -z "${find_expr}" ]; then
          find_expr="-name \""$e"\""
      else
          find_expr="$find_expr -o -name \""$e"\""
      fi
    done
  fi
  echo "$find_expr"
}

# Grep for a pattern in all source files for a given language (e.g.: findgrep c <regex>)
function findgrep () {
  if [[ "$1" == "--help" || "$1" == "" ]]; then
    echo "Usage: findgrep <pattern> <c|py|pl|java|js|sql|html|xml|json|sc|mk|src|sh|md|...>"
    echo "Search for a 'regexp' in all files of a specified type starting from the current directory."
    return 1
  fi

  local ext=$1
  local pattern=$2

  # Locations to ignore when searching for symbols
  local prune_dir="-type d -name .git -prune -o -type d -name .svn -prune -o -type d -name CVS -prune"

  eval find . ${prune_dir} -o -type f \\\( $(_lang_extensions_for_find ${ext}) \\\) -print0 | xargs -0 grep --color --line-number --extended-regexp ${pattern}
}

# Define *find aliases for various programming languages
for lng in c py pl java js sql html xml json sc mk src sh md; do
  # Search recursively starting from the current directory (local)
  alias ${lng}find='findgrep '$lng' $1'
done

