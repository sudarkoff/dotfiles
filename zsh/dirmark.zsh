### Directory bookmarking (dirmarking) and navigation functions

# activate a virtual env if it's present
function activate_venv () {
    if [ -d .venv ]; then
        . .venv/bin/activate
    elif [ -n $VIRTUAL_ENV ]; then
        deactivate
    fi
}

# jump to a dirmark or $SRC/directory WITHOUT saving current location in the stack
# (calling it with no arguments will cycle between current and previous stack entries)
# Ex.: @ doc
function @ () {
   if [ -z $1 ]; then
      pushd
   else
      local str="\$mm_$1";
      eval "[ -n \"$str\" ] && cd $str && activate_venv";
      # Dirmark doesn't exist?
      if [ $? -ne 0 ]; then
          # See if there is a directory with this name in $SRC
          if [ -d $SRC/$1 ]; then
              cd $SRC/$1 && activate_venv
          fi
      fi
   fi
}

# jump to a dirmark SAVING current location in the stack
# (use popd or + without parameters to go back)
function + () {
   if [ -z $1 ]; then
      eval popd;
   else
      local str="\$mm_$1";
      eval "[ -n \"$str\" ] && pushd $str && activate_venv";
      # Dirmark doesn't exist?
      if [ $? -ne 0 ]; then
          # See if there is a directory with this name in $SRC
          if [ -d $SRC/$1 ]; then
              pushd $SRC/$1 && activate_venv
          fi
      fi
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

