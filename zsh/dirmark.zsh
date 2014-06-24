### Directory bookmarking (dirmarking) and navigation functions

# jump to a dirmark WITHOUT saving current location in the stack
# (calling it with no arguments will cycle between current and previous stack entries)
# Ex.: @ doc
function @ () {
   if [ -z $1 ]; then
      pushd
   else
      local str="\$mm_$1";
      eval "[ -n \"$str\" ] && cd $str";
   fi
}

# jump to a dirmark SAVING current location in the stack
# (use popd or + without parameters to go back)
function + () {
   if [ -z $1 ]; then
      eval popd;
   else
      local str="\$mm_$1";
      eval pushd $str;
   fi
}

# check whether a directory exists and set the dirmark if it does
function dirmark () {
   if [ -d $2 ]; then
      eval mm_$1=$2
   fi
}

# add new dirmark (or override the existing one) for the current directory
function m () {
   eval mm_$1=`pwd`;
}

# remove dirmark
function - () {
   eval unset mm_$1;
}

# preset a dirmark if the target directory exists
# (used primarily in other functions or *.zsh configs)
function _m_set() {
   if [ -d $2 ]; then
      eval mm_$1=$2;
   fi
}

