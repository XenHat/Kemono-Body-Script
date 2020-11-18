#!/bin/bash
shopt -s globstar
mcpp -P "Kemono-Body-Script.lsl" compiled/xenhat.kemono.body.lsl
sed -i '/^$/d' compiled/xenhat.kemono.body.lsl
# see http://astyle.sourceforge.net/astyle.html#_General_Information
style="--style=k&r --max-code-length=80 --indent=spaces=2 --convert-tabs  \
	--delete-empty-lines --indent-switches --indent-preproc-block \
	--unpad-paren --pad-oper --close-templates \
	--break-blocks=all --indent-col1-comments --align-method-colon \
	--pad-method-colon=all --close-templates -Q"
for i in **/*.lsl; do # Whitespace-safe and recursive
#shellcheck disable=SC2086
		astyle $style "$i"
done
#shellcheck disable=SC2086
# astyle $style compiled/xenhat.kemono.body.lsl
if [[ "$do_lint" == "1" ]]; then
	lslint -w -i -z -m compiled/xenhat.kemono.body.lsl
fi
