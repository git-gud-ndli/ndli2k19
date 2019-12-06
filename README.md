# ndli2k1

Voici la version publié via kubernetes https://git-gud.fr

# Instructions

Pour lancer le projet il suffit de faire:

```
docker-compose up
```

Vous pouvez ensuite vous rendre à https://localhost:8080 .

## Docker

Il y a un Dockerfile pour chaque services de ce projet:
* front
* back
* notifs
* migrations

Une CI est mise en place pour contruire les images et les publiés via github action vers le registre
docker de github.

# Architecture

L'architecture du projet est une fragmentation par micro services.

## Back

Tout les services sont conteneurisé et son déployés chez digital océan.

### Docker

L'ensemble des services possèdent des manifestes docker pour leur conteneurisation.
Cela permet d'avoir une architecture flexible compatible à une montée en charge automatique.

### CI 

On utilise Github action pour construire les images docker, puis pour les publiés dans le registre
docker de github.

### k8s

Nous utilisons un cluster k8s, une db postgres pour héberger notre projet.

### postgraphile

Graphile permet de générer une API GraphQL à partir d'une base de donnée PostgreSQL.
Cela nous permet de de maintenir plus facilement la base grace à des migrations.

### notifications

Les utilisateurs peuvent s'abonnés à des tags ou des question, il recoivent ensuite des
notifications en fonctions de leurs abonnements.


## Front


