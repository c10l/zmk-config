WORKSPACE = $(shell pwd -P)

init:
	git clone https://github.com/zmkfirmware/zmk.git --depth=1 $(WORKSPACE)/zmk
	(cd $(WORKSPACE)/zmk ; west init -l app/ )
.PHONY: init

update:
	(cd $(WORKSPACE)/zmk ; git pull)
	(cd $(WORKSPACE)/zmk ; west update --narrow)
.PHONY: update

cleanup:
	rm -rf $(WORKSPACE)/zmk/zephyr
	rm -rf $(WORKSPACE)/zmk/.west
	rm -rf $(WORKSPACE)/zmk/modules
	rm -rf $(WORKSPACE)/zmk/zmk
	rm -rf $(WORKSPACE)/zmk/build
.PHONY: cleanup

build:
	( cd $(WORKSPACE)/zmk/app ; west build -d "$(WORKSPACE)/build/left" -b "nice_nano_v2" -- -DZMK_CONFIG=$(WORKSPACE)/config -DSHIELD="c48_left" -DZMK_CONFIG=$(WORKSPACE) )
	( cd $(WORKSPACE)/zmk/app ; west build -d "$(WORKSPACE)/build/right" -b "nice_nano_v2" -- -DZMK_CONFIG=$(WORKSPACE)/config -DSHIELD="c48_right" -DZMK_CONFIG=$(WORKSPACE) )
.PHONY: build

install_left:
	cp "$(WORKSPACE)/build/left/zephyr/zmk.uf2" /Volumes/NICENANO

install_right:
	cp "$(WORKSPACE)/build/right/zephyr/zmk.uf2" /Volumes/NICENANO
