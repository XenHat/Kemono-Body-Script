#!/bin/bash
shopt -s globstar
for i in **/*.lsl; do # Whitespace-safe and recursive
	echo "$i"
	if [ "$i" = "Kemono-Body-Script.lsl" ]; then
		astyle --style=google --max-code-length=80 --indent=spaces=2 --indent-preproc-block --unpad-paren --delete-empty-lines --align-method-colon --pad-method-colon=all --close-templates --convert-tabs  --indent-col1-comments "$i" > compiled/xenhat.kemono.body.lsl
		mcpp -P "$i" > compiled/xenhat.kemono.body.lsl
	else
		astyle --style=google --max-code-length=80 --indent=spaces=2 --indent-preproc-block --unpad-paren --delete-empty-lines --align-method-colon --pad-method-colon=all --close-templates --convert-tabs  --indent-col1-comments "$i"
		astyle --style=google --max-code-length=80 --indent=spaces=2 --indent-preproc-block --unpad-paren --delete-empty-lines --align-method-colon --pad-method-colon=all --close-templates --convert-tabs  --indent-col1-comments "$i"
		mv "$i.new" "$i"
		#rm "$i.new"
	fi
done
# if [ "$i" = "compiled/xenhat.kemono.body.lsl" ]; then
	retval=$(lslint -m -i "compiled/xenhat.kemono.body.lsl")
# fi
exit $retval;
