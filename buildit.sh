#!/bin/bash
#Global Variables
BACKTITLE="David's SUSE Enterprise Storage Installer"
MYHOME=~
DIALOGTMP=/tmp/buildit.sh.$$

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

exec 3>&1 4>&2

dialog --backtitle "$BACKTITLE" --tailboxbg <(
                exec 2>&1
                echo "this should be in the log"
                echo "this should be on the screen" >&3
                for (( i=0; i<1000 ; ++i )) do
                        sleep 5
                        echo $i
                done
        ) 40 40
