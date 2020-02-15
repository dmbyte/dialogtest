#!/bin/bash
#Global Variables
BACKTITLE="David's SUSE Enterprise Storage Installer"
MYHOME=~
DIALOGTMP=/tmp/buildit.sh.$$
TMPLOG_FILE=/tmp/buildit.log.$$

editfile(){
        FILENAME=$1
        dialog --title "Edit" --backtitle "$BACKTITLE" --editbox $FILENAME 40 90 2> "${DIALOGTMP}"
        rm $DIALOGTMP
        cp ${DIALOGTMP} $FILENAME

}
msgbox(){
        MESSAGE=$1
        dialog --backtitle "$BACKTITLE" --msgbox "$MESSAGE" 0 0
}
inputbox(){
        MESSAGE=$1
        dialog --backtitle "$BACKTITLE" --inputbox "$MESSAGE" 0 0 2>"${DIALOGTMP}"
        response=$?
        inputboxreturn=$(<$DIALOGTMP)
        rm $DIALOGTMP

}
passwdbox(){
        MESSAGE=$1
        dialog --backtitle "$BACKTITLE" --clear --insecure --passwordbox "$MESSAGE" 0 0 2>"${DIALOGTMP}"
        response=$?
        passwdboxreturn=$(<$DIALOGTMP)
        rm $DIALOGTMP

}
outputtolog(){
touch $TMPLOG_FILE

# Close STDOUT file descriptor
exec 1<&-
# Close STDERR FD
exec 2<&-

# Open STDOUT as $TMPLOG_FILE file for read and write.
exec 1<>$TMPLOG_FILE

# Redirect STDERR to STDOUT
exec 2>&1
}

outputtoscreen(){
exec 1>&0
exec 2>&0
#rm -f $TMPLOG_FILE
}
touch $TMPLOG_FILE
dialog --backtitle "$BACKTITLE" --tailboxbg "$TMPLOG_FILE" 40 40
outputtolog
#dialog --backtitle "$BACKTITLE" --tailbox "/var/log/messages" 40 40
echo "this should be in the log"
outputtoscreen
echo "this should be on the screen"
