#!/bin/bash
shopt -s globstar
# see http://astyle.sourceforge.net/astyle.html#_General_Information
style="--style=otbs --max-code-length=80 --indent=spaces=2 --convert-tabs  \
	--delete-empty-lines --indent-switches --indent-preproc-block \
	--unpad-paren --indent-preproc-define --pad-oper --close-templates \
	--break-blocks=all"
# --align-method-colon --pad-method-colon=all
for i in **/*.lsl; do # Whitespace-safe and recursive
	echo "> $i"
	if [ "$i" = "Kemono-Body-Script.lsl" ]; then
		astyle $style "$i"
		mcpp -P "$i" compiled/xenhat.kemono.body.lsl
		sed -i '/^$/d' compiled/xenhat.kemono.body.lsl
		astyle $style compiled/xenhat.kemono.body.lsl
	else 
		astyle $style "$i"
	fi
done
# if [ "$i" = "compiled/xenhat.kemono.body.lsl" ]; then
	retval=$(lslint -m -i "compiled/xenhat.kemono.body.lsl")
# fi
exit $retval;
