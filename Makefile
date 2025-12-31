SHELL := bash

.DEFAULT_GOAL := rula

NOME := revista_001
f := completa

OPCIONS := \
	--format pdf              \
	--root .                  \
	--pdf-standard 2.0        \
	--diagnostic-format short \
	--ignore-system-fonts     \
	--ignore-embedded-fonts   \
	--font-path=fontes        \
	--input rama=$(shell git rev-parse --abbrev-ref HEAD) \
	--input hash=$(shell git rev-parse --short HEAD) \
	--input dirt=$(shell test -z "$$(git status --porcelain)" && echo "" || echo "sucio") \
	--input formato=$(f)



# Typst non crea os diretorios auxiliares (inda)
rula: $(NOME).typ

	# Hai que asegurarse de que existe o directorio .pdf
	$(shell if [ ! -d ".pdf" ]; then mkdir .pdf; fi)

	# Compilamos o documento
	typst compile $(OPCIONS) $(NOME).typ .pdf/$(NOME).pdf

limpa:
	rm -rf .pdf/*

.PHONY: rula limpa
