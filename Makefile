all: conda-update pip-tools

# Arcane incantation to print all the other targets, from https://stackoverflow.com/a/26339924
help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

conda-create:
	conda env create -f environment.yml

conda-update:
	conda env update --prune -f environment.yml

# Compile exact pip packages
pip-tools:
	pip install pip-tools
	pip-compile requirements/prod.in && pip-compile requirements/dev.in
	pip-sync requirements/prod.txt requirements/dev.txt


pip-docker:
	pip install -r ./requirements/dev.txt
	pip install -r ./requirements/prod.txt

# Example training command
train-mnist-cnn-ddp:
	python training/run_experiment.py --max_epochs=10 --gpus='-1' --accelerator=ddp --num_workers=20 --data_class=MNIST --model_class=CNN

test-gpu:
	python ./lab1/training/run_experiment.py --max_epochs=3 --gpus='2'

# Lint
lint:
	tasks/lint.sh
