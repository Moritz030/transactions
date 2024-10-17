.PHONY: build
build: ## Build docker containers
	docker-compose up --build --force-recreate

.PHONY: shell
shell: ## access to the system console
	docker-compose run --rm transactions bash