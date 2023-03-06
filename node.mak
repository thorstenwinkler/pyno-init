GIT-REPO-NODEENV = https://github.com/ekalinin/nodeenv.git
GIT-REPO-NVM = https://github.com/nvm-sh/nvm.git

NODE_VERSION = 18.14.2

DIR_NODEENV = .nodeenv
DIR_NVM = .nvm
DIR_NODE_MODULES = node_modules
DIR_VIRTUAL_ENV_NODE = .virt_env_node

ifndef NODE_VERSION
$(error NODE_VERSION is not set)
endif

# - Phony Targets:
#   - "A phony target is one that is not really the name of a file"
#   - https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
PHONY: activate-node clean-node help-node install-node node update-nodeenv update

activate-node:| $(DIR_NODEENV) $(DIR_VIRTUAL_ENV_NODE)
	@echo "################################################################################"
	@echo "# Activate $(DIR_VIRTUAL_ENV_NODE) with $(NODE_VERSION) using the following command:"
	@echo "source $(DIR_VIRTUAL_ENV_NODE)/bin/activate"
	@echo ""
	@echo "(Use \"deactivate_node\" to deactivate this virtual environment for node)"

clean-node:
	@echo "################################################################################"
	@echo "# Delete $(DIR_NODEENV)"
	@rm -rf $(DIR_NODEENV)
	@echo "# ----------------------------------------"
	@echo "# Delete $(DIR_VIRTUAL_ENV_NODE)"
	@rm -rf $(DIR_VIRTUAL_ENV_NODE)
	@echo "# ----------------------------------------"
	@echo "# Delete $(DIR_NODE_MODULES)"
	@rm -rf $(DIR_NODE_MODULES)
	@echo "# ----------------------------------------"
	@echo "# Delete yarn-error.log, yarn.lock"
	@rm -rf yarn-error.log yarn.lock

help-node:
	@echo "# ______________________________________________________________________________"
	@echo "# Specific node targets:"
	@echo "# ----------------------"
	@echo "# > activate-node    - show activation instruction for virtual node"
	@echo "#                      environments"
	@echo "# > clean-node       - cleanup node virt. environment incl."
	@echo "#                      $(DIR_NODE_MODULES)"
	@echo "# > help-node        - this target list (node targets)"

node: activate-node

# Check, if $(DIR_NODEENV) exists
$(DIR_NODEENV):
	@echo "################################################################################"
	@echo "# Clone repo from $(GIT-REPO-NODEENV) to $(DIR_NODEENV)"
	@git clone $(GIT-REPO-NODEENV) $(DIR_NODEENV)

# Check, if $(DIR_NVM) exists
$(DIR_NVM):
	@echo "################################################################################"
	@echo "# Clone repo from $(GIT-REPO-NVM) to $(DIR_NVM)"
	@git clone $(GIT-REPO-NVM) $(DIR_NVM)

# Check, if $(DIR_VIRTUAL_ENV_NODE) exists
$(DIR_VIRTUAL_ENV_NODE):
	@echo "################################################################################"
	@echo "# Install new virtual Node.js environment with version $(NODE_VERSION) into $(DIR_VIRTUAL_ENV_NODE)"
	@python $(DIR_NODEENV)/nodeenv.py -n $(NODE_VERSION) $(DIR_VIRTUAL_ENV_NODE)

update update-nodeenv: $(wildcard DIR_NODEENV)
	@echo "################################################################################"
	@echo "# Update $(DIR_NODEENV)"
	git -C $(DIR_NODEENV) pull
