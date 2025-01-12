php-lint:
	docker run --init --rm -v "$(HOST_PROJECT_PATH)/app:/project" -w /project jakzal/phpqa phpstan analyse src