PY_FILES= find . -type f -not -path '*/\.*' | grep -i '.*[.]py$$' 2> /dev/null

entr_warn: 
	@echo "----------------------------------------------------------"
	@echo "     ! File watching functionality non-operational !      "
	@echo "                                                          "
	@echo "Install entr(1) to automatically run tasks on file change."
	@echo "See http://entrproject.org/                               "
	@echo "----------------------------------------------------------"

isort:
	poetry run isort `${PY_FILES}`

black:
	poetry run black `${PY_FILES}` --skip-string-normalization

test:
	poetry run py.test $(test)

watch_test:
	if command -v entr > /dev/null; then ${PY_FILES} | entr -c $(MAKE) test; else $(MAKE) test entr_warn; fi

build_docs:
	cd doc && $(MAKE) html

watch_docs:
	cd doc && $(MAKE) watch_docs

flake8:
	poetry run flake8 tmuxp tests

watch_flake8:
	if command -v entr > /dev/null; then ${PY_FILES} | entr -c $(MAKE) flake8; else $(MAKE) flake8 entr_warn; fi
