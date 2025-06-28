SHELL := bash

.DEFAULT_GOAL := rula

NOME := revista_001
COMPILA := typst compile \
	--format pdf \
	--root . \
	--pdf-standard 2.0,a-4f \
	--diagnostic-format short \
	$(NOME).typ \
	.pdf/$(NOME).pdf

# Typst non crea os diretorios auxiliares (inda)
rula: $(NOME).typ

	# Checkeamos se temos os directorios auxiliares
	if [ ! -d ".pdf" ]; then mkdir .pdf; fi

	# Compilamos o documento
	$(COMPILA)

limpa:
	rm -rf .pdf/* .aux/*

.PHONY: rula limpa
