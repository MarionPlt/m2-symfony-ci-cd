# m2-symfony-ci-cd

## Team

- Somveille Quentin (skunka)
- Mathis ROME (muchu)

## Project

Vous trouverez dans ce repositiory, une application `Symfony` dans le dossier `app`.

Cette application contient une route ["/hello"](http://localhost/hello), qui exprime
tout l'amour que nous portons à Marion Playout et Damien Duportal.

Elle contient aussi un test applicatif qui vérifie que l'amour que nous portons
est toujours correctement exprimé.

Vous trouverez aussi, une tentative d'un `devcontainer`, même si celui-ci
manque encore d'un peu de maturité.

À la racine du projet vous trouverez nos images docker ainsi que le 
docker-compose de développement qui permet de lancer notre application en local.

Nous y retrouvons aussi, les images `docker` de production que nous publions dans le 
Docker Hub de `skunka` (Quentin). Vous trouverez ci-dessous les liens de repository Docker Hub :

- [Image NGINX](https://hub.docker.com/r/skunka/m2-ci-cd-nginx/tags)
- [Image Symfony](https://hub.docker.com/r/skunka/m2-ci-cd-symfony/tags)

De plus nous avons mis en place notre `workflow` Github Actions, nous avons donc 
2 fichiers `ci.yml` et `cd.yml`. Nous expliquerons ci-dessous leur contenu et leur utilité

Pour finir il y'a aussi notre `makefile` qui nous permet de lancer nos commandes dans la `ci`.

## Repository Rulesets

Nous avons mis en place une règle sur le repository GitHub: \
Forcer l'utilisation de _pull requests_ sur la branche 'main' avec approbation obligatoire d'un utilisateur 
qui n'est pas celui ayant fait le commit et bloque le tag "--force" sur les pushs. 

## CI

Pour la CI, nous faisons les étapes dans l'ordre suivant :
1. Récupération des sources du projet
2. Mise en place d'une variable permettant le bon fonctionnement de notre makefile (pas besoin en local)
3. Utilisation du `makefile` pour installer les dépendances de notre projet via composer
    ```bash
    make install-dependencies 
    ```
4. Utilisation du `makefile` pour le linter `php` grâce à l'outil `phpstan`
    ```bash
   make lint
    ```
5. Utilisation du `makefile` pour le lancement des tests avec `phpunit`
    ```bash
   make tests
   ```
6. Vérification via `hadolint/hadolint-action@v3.1.0` du `Dockerfile` utilisé pour la construction de notre image `php`. 

    En local nous pouvons, reproduire le comportement de cette `Github Action` en lançant la commande suivante :
    ```bash
   docker run --rm -i  ghcr.io/hadolint/hadolint < php-fpm.prod.dockerfile
    ```
7. Utilisation du `makefile` pour le build de notre image `php`
    ```bash
   make build-symfony
   ```
8. Vérification via `hadolint/hadolint-action@v3.1.0` du `Dockerfile` utilisé pour la construction de notre image `nginx`
   
    En local nous pouvons, reproduire le comportement de cette `Github Action` en lançant la commande suivante :
    ```bash
   docker run --rm -i  ghcr.io/hadolint/hadolint < nginx.prod.dockerfile
    ```
9. Utilisation du `makefile` pour le build de notre image `nginx`
    ```bash
   make build-nginx
   ```