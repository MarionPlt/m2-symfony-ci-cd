ifndef HOST_PROJECT_PATH
override HOST_PROJECT_PATH = .
endif

install-dependencies:
	docker run --rm -v "$(HOST_PROJECT_PATH)/app:/app" composer install

lint:
	docker run --init --rm -v "$(HOST_PROJECT_PATH)/app:/project" -w /project jakzal/phpqa phpstan analyse src

tests:
	docker run --rm --volume "$(HOST_PROJECT_PATH)/app:/app" -w /app php:8.3-fpm php bin/phpunit

build-symfony:
	docker image build -t m2-ci-cd-symfony -f php-fpm.prod.dockerfile .

build-nginx:
	docker image build -t m2-ci-cd-nginx -f nginx.prod.dockerfile .