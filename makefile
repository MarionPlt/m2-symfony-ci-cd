php-lint:
	docker run --init -it --rm -v "$(HOST_PROJECT_PATH)/app:/project" -w /project jakzal/phpqa phpstan analyse src