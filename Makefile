prob_completion.sh: build.sh completion.template
	./build.sh PROBCLI=$(PROBCLI)

clean:
	-rm prob_completion.sh &> /dev/null

.PHONY: clean
