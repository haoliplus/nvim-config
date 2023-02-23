######################################################################
# @author      : lihao (haoliplus@gmail.com)
# @file        : Makefile
# @created     : Thursday Feb 23, 2023 10:37:57 CST
######################################################################
ODIR=dist
PROJ=demo

uninstall:
	python -m pip uninstall $(PROJ)

install:
	python -m pip install -i https://pypi.douban.com/simple -e .

test:
	python -m unittest discover tests "*_test.py"

.PHONY: clean

clean:
	rm -f $(ODIR)/*.egg-info

