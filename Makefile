SHELL := bash

.PHONY: svg2png
svg2png:
	docker build -t guzo/svg2png .
