all:help
zentao:prepare zentaorelease
chanzhi:prepare chanzhirelease
common:prepare commonrelease
help:
	@echo "make lampp source=xxx product=zentao|chanzhi|common to build the lampp package."
	@echo make zentao to make a zentao release.
	@echo make chanzhi to make a chanzhi release.
	@echo make common to make a common release.
	@echo make lamppclean to clean lampp directory.
	@echo make releaseclean to clean zentao or chanzhi directory.
lampp:
	./buildlampp.sh $(source) $(product)
lamppclean:
	rm -fr lampp
prepare:
	sudo ./lampp stop
	sudo rm -fr logs/*
	sudo rm -fr var/mysql/*.err
	sudo rm -fr var/mysql/ib*
	sudo mkdir .package
	sudo mv * .package
	sudo mv .package lampp
	sudo mv lampp/Makefile .
	sudo chmod a+rx lampp/start*
	sudo chmod a+rx lampp/start88
zentaorelease:	
	sudo 7z a -sfx ZenTaoPMS.`head -n 1 lampp/zentao/VERSION`.linux.7z lampp
chanzhirelease:	
	sudo 7z a -sfx chanzhiEPS.`head -n 1 lampp/chanzhi/VERSION`.linux.7z lampp
commonrelease:	
	sudo 7z a -sfx zentaolamp.`lampp/lib/VERSION`.linux.7z lampp
releaseclean:
	sudo mv lampp lampp.bak
	sudo mv lampp.bak/* .
	sudo rm -fr *.7z
	sudo rm -fr lampp.bak
