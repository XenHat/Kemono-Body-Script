#!/bin/bash
shopt -s globstar
mcpp -P "Core.lsl" compiled/xenhat.kemono.body.lsl
sed -i '/^$/d' compiled/xenhat.kemono.body.lsl
for i in **/*.lsl; do # Whitespace-safe and recursive
#shellcheck disable=SC2086
		astyle --project=.astylerc "$i"
done
#shellcheck disable=SC2086
# astyle $style compiled/xenhat.kemono.body.lsl
if [[ "$do_lint" == "1" ]]; then
	lslint -w -i -z -m compiled/xenhat.kemono.body.lsl
fi
