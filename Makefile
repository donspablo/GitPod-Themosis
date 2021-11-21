PROJECT_NAME ?= themosis
REPO_NAME ?= themosis-docker

SERVER_NAME ?= docker.local.dev

THEMOSIS_PATH := themosis
THEMOSIS_REPO := themosis/themosis

DEV_COMPOSE_FILE := docker-compose.development.yml

CERTIFICATE_KEY_FILE := .certs/themosis.key
CERTIFICATE_CRT_FILE := .certs/themosis.pem
CERTIFICATE_DHPARAM_FILE := .certs/dhparam.pem

# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell functions
INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: setup dev

setup:
	${INFO} "Creating development database volume..."
	@ docker volume create --name db

	${INFO} "Creating development cache volume..."
	@ docker volume create --name cache

	${INFO} "Resolving certificates..."
ifeq ($(wildcard $(ROOT_DIR)/$(CERTIFICATE_KEY_FILE)),)
	@ openssl req -x509 -newkey rsa:2048 -keyout $(CERTIFICATE_KEY_FILE) -out $(CERTIFICATE_CRT_FILE) -days 30 -nodes -subj '/CN=$(SERVER_NAME)'
else
	${INFO} "Certificates exist"
endif

	${INFO} "Sorting out forward secrecy..."
ifeq ($(wildcard $(ROOT_DIR)/$(CERTIFICATE_DHPARAM_FILE)),)
	@ openssl dhparam -dsaparam -out $(CERTIFICATE_DHPARAM_FILE) 4096
else
	${INFO} "All safe"
endif

	${INFO} "Creating images..."
	@ docker-compose -f $(DEV_COMPOSE_FILE) build

dev:
	${INFO} "Launching..."
	@ docker-compose -f $(DEV_COMPOSE_FILE) up
