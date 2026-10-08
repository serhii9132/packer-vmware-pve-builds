ENV_FILE   := .env
BUILDS_DIR := builds
LOG_DIR    := logs

LOG_TIMESTAMP := $(shell date +"%Y-%m-%d_%H-%M-%S")

LOAD_ENV := set -a; [ -f $(ENV_FILE) ] && . ./$(ENV_FILE); set +a

.PHONY: all clean proxmox-8 proxmox-9

define build-vm
	@mkdir -p $(LOG_DIR)
	@packer init proxmox.pkr.hcl
	@$(LOAD_ENV) && \
	export PACKER_LOG=1 && \
	export PACKER_LOG_PATH="$(LOG_DIR)/proxmox-$(1)_$(LOG_TIMESTAMP).log" && \
	packer build \
		-var 'iso_file=$(2)' \
		-var 'iso_checksum=$(3)' \
		-var 'guest_os_type=$(4)' .
endef

all: proxmox-8 proxmox-9

proxmox-8:
	$(call build-vm,8,proxmox-ve_8.4-1.iso,d237d70ca48a9f6eb47f95fd4fd337722c3f69f8106393844d027d28c26523d8,debian12-64)

proxmox-9:
	$(call build-vm,9,proxmox-ve_9.2-1.iso,4e88fe416df9b527624a175f24c9aa07c714d3332afb1ee3dbf3879573ef2c6c,debian13-64)

clean:
	rm -rf $(BUILDS_DIR) packer_cache logs