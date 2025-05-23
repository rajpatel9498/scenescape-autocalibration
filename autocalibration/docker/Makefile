# Copyright (C) 2024-2025 Intel Corporation
#
# This software and the related documents are Intel copyrighted materials,
# and your use of them is governed by the express license under which they
# were provided to you ("License"). Unless the License provides otherwise,
# you may not use, modify, copy, publish, distribute, disclose or transmit
# this software or the related documents without Intel's prior written permission.
#
# This software and the related documents are provided as is, with no express
# or implied warranties, other than those that are expressly stated in the License.

# Image and version configuration
IMAGE=scenescape-camcalibration
VERSION:=$(shell cat ../version.txt)

# Directory paths
BUILD_DIR=build
RUNTIME_DIR=runtime

# Build dependencies
BUILD_DEPS := $(BUILD_DIR)/Dockerfile.build \
              $(BUILD_DIR)/requirements-build.txt \
              $(BUILD_DIR)/install-apriltag.sh

# Runtime dependencies
RUNTIME_DEPS := $(RUNTIME_DIR)/Dockerfile.runtime \
                $(RUNTIME_DIR)/requirements-runtime.txt \
                $(RUNTIME_DIR)/install-netvlad-weights.sh \
                $(RUNTIME_DIR)/camcalibration-init

# OSPDT tracking
OSPDT_DEPS := $(shell cat $(BUILD_DIR)/requirements-build.txt $(RUNTIME_DIR)/requirements-runtime.txt | grep -v '^#' | sort -u)

# Default target
.PHONY: all
all: build runtime

# Build stage
.PHONY: build
build: $(BUILD_DEPS)
	env BUILDKIT_PROGRESS=plain \
	docker build \
		--build-arg http_proxy=$(http_proxy) \
		--build-arg https_proxy=$(https_proxy) \
		--build-arg no_proxy=$(no_proxy) \
		--build-arg USER_ID=$$UID \
		-f $(BUILD_DIR)/Dockerfile.build \
		-t $(IMAGE)-builder:$(VERSION) .

# Runtime stage
.PHONY: runtime
runtime: build $(RUNTIME_DEPS)
	env BUILDKIT_PROGRESS=plain \
	docker build \
		--build-arg http_proxy=$(http_proxy) \
		--build-arg https_proxy=$(https_proxy) \
		--build-arg no_proxy=$(no_proxy) \
		--build-arg USER_ID=$$UID \
		-f $(RUNTIME_DIR)/Dockerfile.runtime \
		-t $(IMAGE):$(VERSION) .
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest

# Clean build artifacts
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/*.whl
	docker rmi $(IMAGE)-builder:$(VERSION) $(IMAGE):$(VERSION) || true

# Force rebuild without cache
.PHONY: rebuild
rebuild: clean all

# Generate OSPDT report
.PHONY: ospdt-report
ospdt-report:
	@echo "Open Source and Third Party Dependencies:"
	@for dep in $(OSPDT_DEPS); do \
		echo "$$dep"; \
	done

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all            - Build both build and runtime stages (default)"
	@echo "  build          - Build only the build stage"
	@echo "  runtime        - Build the runtime stage (requires build stage)"
	@echo "  clean          - Remove build artifacts and images"
	@echo "  rebuild        - Clean and rebuild everything"
	@echo "  ospdt-report   - Generate OSPDT dependency report"
	@echo "  help           - Show this help message"
