ifndef MKDIR
MKDIR=mkdir -p
endif
ifndef CP
CP=cp -Rfpl
endif
RM:=rm -rf

ifndef LAZBUILD
LAZBUILD=$(firstword $(wildcard ../../lazbuild) lazbuild)
endif

build: htmldocs

htmldocs: build_lcl_docs
	./$< --outfmt html

chmdocs: build_lcl_docs
	./$< --outfmt chm --arg --make-searchable

build_lcl_docs: build_lcl_docs.lpi
	${LAZBUILD} $<

clean:
	${RM} build_lcl_docs lcl

htmlinstall chminstall:
	install -d ${INSTALL_DOCDIR}
	${CP} -t ${INSTALL_DOCDIR} \
		lcl

.PHONY: build clean install htmldocs chmdocs
